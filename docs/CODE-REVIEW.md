# Static code review

## Scope and methodology

Reviewed commit `2eb28271d8a9ac92e0d99013cfdc4c1e79af649b` on `main` (2026-07-11).
The review mapped the full DME include unit, searched all project DM sources for
lifecycle, overrides, persistence, external I/O, loops/spawns, admin gates, and
movement/input state, then read key implementations and consumers. Protected
runtime data and external compiler files were not opened or analyzed as project
code. This is static analysis, not proof of runtime behavior.

Initial structural validation passed: 674 includes resolved, 732 `.dm` files
inspected, 745 editable text files checked, with one warning that 77 sources are
not included. `.local-tools/BYOND/bin/dm.exe` was selected; Dream Maker emitted
no warning/error before the runner timed out at ten minutes (runner exit 124), so
the state is **Compilation could not be executed** to completion.

## Executive summary

The architecture is coherent around BYOND open types and a single DME, but the
large distributed surface makes include/order and transient-state changes risky.
The most urgent confirmed issue is committed operational credentials. The
reported intermittent movement problem remains unproven; a concrete dual-binding
state collision and several direction/movement timing edges justify focused
instrumented runtime tests.

| ID | Severity | Category | Confidence | Location |
| --- | --- | --- | --- | --- |
| SEC-001 | Critical | Security | Confirmed | Discord/admin/world settings listed below |
| MOV-001 | Medium | Correctness/input | High confidence; runtime verification needed | `RT.dmf:143-242`; `MultikeyMovement.dm:15-83` |
| PERF-001 | Medium | Performance | Confirmed behavior; impact needs profiling | `MobMovement.dm:33-53` |
| GAME-001 | Medium | Correctness | High confidence | `Better Saves.dm:118-124` |
| DATA-001 | Medium | Data integrity | Possible | `Better Saves.dm:79-97,316-335` |
| ADMIN-001 | Low | Correctness/admin | Confirmed | `MultikeyCheck.dm:6` |
| PERF-002 | Low | Performance/startup | Confirmed | `WorldStarter.dm:20-27` |
| BUILD-001 | Informational | Build/maintenance | Confirmed | DME versus `Code/**/*.dm` |

## Detailed findings

### SEC-001 — Operational credentials are committed

- **Evidence:** complete webhook endpoints occur in `Code/Updates.dm:58`,
  `Code/Modules/Admin/AdminHelpSystem.dm:60,89,108`, `Admin/Topic.dm:195,219,512`,
  `Admin/Verbs/Wipe/NarrateWorld.dm:46`, and several files under
  `Code/Modules/Discord/`. `Code/Modules/World/WorldSettings.dm:4,131` contains
  hard-coded world/hub credentials. Values are deliberately omitted here.
- **Current behavior/impact:** anyone with repository access can recover reusable
  credentials and potentially send unauthorized external messages or use a
  service credential. Exposure exists whether or not the current endpoints are
  still active.
- **Scenario:** source is shared, mirrored, logged, or published; a credential is
  replayed outside the game.
- **Recommendation:** immediately revoke/rotate every exposed credential, remove
  secrets from history where operationally appropriate, inject them from a
  protected runtime configuration, and fail closed when absent.
- **Validation:** provider-side revocation test, repository secret scan (including
  history), and mocked startup/notification tests without credentials.

### MOV-001 — Dual macro bindings collapse distinct physical key state

- **Evidence:** macro3 maps both `West+UP` and `A+UP` to `WestReleased` (and
  equivalents for all axes) in `RT.dmf:172-242`; the client stores only one
  boolean per direction and each release unconditionally sets it to zero in
  `MultikeyMovement.dm:15-83`.
- **Current behavior/impact:** when both equivalent keys are held, releasing one
  clears the shared state although the other remains physically held. A remaining
  orthogonal key can then become the computed direction, producing a surprising
  turn or pause.
- **Scenario:** macro3, hold Left and A, also hold Up, release only A during key
  repeat/lag. This is a plausible contributor to the reported intermittent issue,
  not proof of its sole cause.
- **Recommendation:** track bindings or physical-key counts independently before
  deriving logical directions; preserve the current movement gates.
- **Validation:** instrument event order/state and replay all overlapping arrow+
  WASD press/release permutations under latency.

### PERF-001 — Ordinary movement allocates and deletes a temporary object

- **Evidence:** on every `mob/Move()` while the current turf is not water,
  `MobMovement.dm:33-43` creates `/obj`, configures it, removes it from overlays,
  and deletes it. A similar temporary object is created on water entry.
- **Current behavior/impact:** per-step allocation/deletion and icon work occurs
  in a hot path for every moving player; likely allocator/GC overhead scales with
  movement rate.
- **Scenario:** many simultaneously moving players at 20 FPS.
- **Recommendation:** profile allocation cost, then cache/reuse an image or only
  update on swimming-state transitions.
- **Validation:** profiler comparison of object creation/deletion and tick usage
  at representative player counts.

### GAME-001 — `CapStats2()` cap predicates are self-cancelling

- **Evidence:** `Better Saves.dm:118-124` tests forms such as
  `StrMod > SoftStatCap * StrMod * RateOfCap`, then assigns the same expression.
- **Current behavior/impact:** for ordinary positive modifiers and positive caps,
  the comparison cannot be true; callers at migration line 161 and
  `TournamentArena.dm:13,51` do not cap those values.
- **Scenario:** a modifier exceeds the intended cap and `CapStats2()` is invoked.
- **Recommendation:** establish the intended independent baseline for each cap
  before changing the formula.
- **Validation:** table-driven tests below/at/above cap, including zero/negative/
  null legacy values and save migrations.

### DATA-001 — Canonical character saves are written without an atomic handoff

- **Evidence:** `mob.Save()` and `client.SaveChar()` directly open the canonical
  `Data/Saves/[key]/[ckey]`; the probabilistic backup in `mob.Save()` occurs only
  after serialization (`Better Saves.dm:79-97,316-335`).
- **Current behavior/impact:** no atomic temp-write/rename or verified rollback is
  visible in this path. Actual Dream Maker savefile failure semantics were not
  tested, so corruption is possible, not confirmed.
- **Scenario:** process/host interruption or I/O failure during serialization.
- **Recommendation:** design a verified staged write with last-known-good rotation
  and explicit error handling, preserving save compatibility.
- **Validation:** isolated synthetic save fault injection and recovery tests.

### ADMIN-001 — Intended multikey exclusions never exclude

- **Evidence:** `MultikeyCheck.dm:6` uses `A.ckey!="Mumit" || A.ckey!="chewyy"`.
  Any single key differs from at least one literal, so the condition is always true.
- **Current behavior/impact:** both intended exceptions remain in the admin scan;
  results can include them.
- **Scenario:** the verb scans either named account.
- **Recommendation:** confirm policy, then use the intended conjunction or
  membership test.
- **Validation:** verb test with each exception and a normal account.

### PERF-002 — Ban data is loaded twice during initialization

- **Evidence:** `WorldStarter.dm:20-27` calls `LoadBans()` at lines 22 and 26.
- **Current behavior/impact:** duplicate startup file parsing/state population;
  correctness impact depends on whether loading is idempotent.
- **Recommendation:** verify idempotence and retain one intentional load.
- **Validation:** compare ban state and startup I/O after one versus two calls.

### BUILD-001 — 77 source files are outside the compilation unit

- **Evidence:** `scripts/check.ps1` compared the 674 DME includes with 732 source
  files and warned about 77. The set includes legacy/test variants, LightSystem
  examples/stubs, the standalone NPC module, UI alternatives, and empty files.
- **Impact:** maintainers may edit code that never compiles; bulk inclusion could
  instead introduce conflicting/experimental code.
- **Recommendation:** label or retire each file only after owner review; never
  auto-include the set.
- **Validation:** `scripts/check.ps1 -Strict` for the current exact list, followed
  by individual DME and compile review for any deliberate inclusion.

## Positive observations

The official compile script isolates outputs and excludes runtime data. The
structural checker validates include resolution/casing/duplicates, conflict
markers, and protected changes. Admin Topic starts with holder and owner checks.
Movement explicitly models held cardinal keys and release recomputation. Save
serialization has a version marker and migration chain.

## Limitations and recommended order

No server was run; networking, concurrency/timing, UI behavior, save failure,
permissions, and performance need runtime verification. Real player data was not
opened. Dream Maker did not complete within ten minutes, so compiler diagnostics
are unavailable. Review depth focused on high-risk cross-system paths rather than
line-by-line proof of every content skill/item.

Recommended future order: (1) rotate/remove credentials; (2) instrument and
reproduce movement; (3) test save failure/recovery; (4) correct and test stat cap
intent; (5) profile movement allocation; (6) address the small admin/startup
logic issues; (7) classify unreferenced files.
