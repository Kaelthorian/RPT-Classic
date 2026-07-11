# Risks and unknowns

| ID | Area | Evidence / uncertainty | Consequence or next action |
| --- | --- | --- | --- |
| R-001 | Repository state | The entire `RT Classic Byond/` tree is currently untracked by the root Git repository. | Never treat it as disposable output; decide deliberately how legacy history will be captured. |
| R-002 | Project location | A tracked Godot project already exists at repository root, contrary to the initially suggested `godot/` location. | Keep one project now; revisit only through an explicit relocation plan. |
| R-003 | Godot compatibility | `project.godot` declares feature `4.7`, and the foundation is validated with Godot 4.7 stable. Compatibility with older 4.x releases is not established. | Treat 4.7 stable as the current baseline and record any future version change explicitly. |
| R-004 | Open DM types | Mob, client, world, items and skills are extended across many ordered files. | Trace declarations, overrides, callers and include order for every migrated behavior. |
| R-005 | Global coupling | `Players`, world flags/caps, loading flags and many global lists connect gameplay, UI, saves and admin. | Build explicit ownership/dependency maps; do not move these wholesale into GameState. |
| R-006 | Timing | `spawn()` loops/resets affect startup, movement, combat and world simulation. | Record timing scenarios and design deterministic clocks/timers per system. |
| R-007 | Persistence | BYOND serializes whole mobs plus separate maps, items, areas and world settings; format semantics are not portable. | Use synthetic files only; design conversion and rollback as a separate phase. |
| R-008 | Sensitive data | `Data/`, logs and databases exist; audited docs report embedded webhook/world credentials in active source. | Do not inspect real saves or reproduce credentials; perform a separate secret-remediation/security review. |
| R-009 | Maps | Eighteen wipe maps are actively included, with many backups and alternates also present. Runtime modifications are saved separately. | Select one approved slice and distinguish source map, runtime delta and inactive backups. |
| R-010 | DMI assets | 1,800+ DMI files can contain states, directions and animation metadata beyond a flat image. | Build an audited importer/manifest before bulk conversion; verify provenance and references. |
| R-011 | Audio/fonts | Multiple formats and fonts are present; ownership, actual references and Godot import behavior are not fully audited. | Inventory references and licensing before copying into Godot assets. |
| R-012 | Networking | BYOND supplies implicit client/server semantics; authority, replication and reconnect behavior are not documented as a standalone system. | Specify observable multiplayer requirements and threat model before implementation. |
| R-013 | NPC scope | Included test-server NPC/A* code exists, while `Code/Modules/NPC/NPC.dm` is not in the DME. | Determine intended production behavior with maintainers before migration. |
| R-014 | Known legacy defects | Existing audit records movement key-release, stat-cap, duplicate load, save-corruption, admin-condition and secret risks. | Preserve intended behavior, not accidental defects; each discrepancy needs an explicit decision and regression case. |
| R-015 | Validation coverage | Existing BYOND audit reports structural success but a prior compile timeout; no runtime parity harness exists. | Keep Godot validation separate and add focused recorded parity tests per vertical slice. |
| R-016 | Godot resource scan | The first Godot 4.7 editor scan traversed the untracked BYOND tree and crashed while importing legacy resources. | Keep `RT Classic Byond/.gdignore`; import only audited copies placed in Godot-owned directories. |

## Decisions still required

- Supported Godot 4 release and rendering baseline.
- Authoritative multiplayer topology and hosting constraints.
- Which BYOND behavior is normative when code, documentation and observed play differ.
- Asset ownership, conversion policy and canonical source selection.
- Save cutover, account identity mapping, rollback and retention policy.
- Production relevance of test/unreferenced modules and alternate maps.
