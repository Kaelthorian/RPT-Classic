# Codex instructions for RPT-Classic

## Authority and scope

This file is the root instruction set for every task in this repository. More specific
`AGENTS.md` files below a working directory add or override rules for that subtree.
Read the root file first, then every applicable nested file before editing.

RPT-Classic is a legacy multiplayer role-playing game built with BYOND and Dream
Maker (DM). The authoritative project entry point is `Roleplay Tenkaichi.dme`.
Its ordered `#include` block defines the actual compilation unit: a `.dm` file that
is not included does not compile, and include order can affect inheritance,
overrides, globals, and proc resolution.

## Mandatory read order

Before changing code, read only the documents relevant to the task:

1. `README.md` for project orientation.
2. `ARCHITECTURE.md` for system boundaries and high-risk flows.
3. `DEVELOPMENT.md` for commands and verification.
4. `SECURITY.md` for protected data, credentials, and network integrations.
5. The nearest nested `AGENTS.md` files for the files being changed.
6. `KNOWN_RISKS.md` when touching movement, combat, saves, world startup, admin,
   Discord, maps, or global state.

Do not load every document or scan the entire repository when a narrow task can be
resolved from a subsystem, its callers, and its dependencies.

## Repository map

- `Roleplay Tenkaichi.dme`: compile flags, resource directories, and ordered includes.
- `RT.dmf`: BYOND interface definition. Window/control identifiers are API contracts.
- `Code/_Atom`, `Code/_Datums`, `Code/_HELPERS`: shared foundations, variables,
  constants, and helpers.
- `Code/Items`: objects, equipment, money, crafting/buy lists, durability, and item UI.
- `Code/Map`: world/map source, build systems, map savers, and included `.dmm` maps.
- `Code/Mob`: player lifecycle, variables, movement, behavior, verbs, and windows.
- `Code/Modules`: world, admin, saving, communication, health, character creation,
  environment, UI, libraries, and other cross-cutting systems.
- `Code/Skills`: combat rules, attacks, buffs, ki, melee, support, sword, and MP skills.
- `assets`: browser HTML/CSS/JavaScript used through BYOND browse controls.
- `Data`: runtime state, saves, logs, databases, and server configuration. Protected.
- `Icons`, `Fonts`, audio, maps, compiled artifacts: binary or resource-heavy areas.

Use `docs/codex/SYSTEM_INDEX.md` for a more detailed subsystem index.

## Task execution contract

For every implementation task:

1. Inspect `git status --short`. Never overwrite unrelated user changes.
2. Restate the requested behavior as observable acceptance criteria.
3. Identify the smallest owning subsystem and applicable nested instructions.
4. Search narrowly for the full DM type path, proc/verb name, variables, callers,
   children, overrides, `..()` calls, UI identifiers, save fields, and DME include.
5. Read enough surrounding code to understand state transitions and side effects.
6. Make the smallest coherent patch. Avoid unrelated cleanup or balance changes.
7. Add a new `.dm` file to the DME exactly once and at a dependency-correct location.
8. Run the required checks from `DEVELOPMENT.md`.
9. Review `git diff --check`, `git status --short`, and the complete final diff.
10. Report what changed, evidence, verification status, and remaining uncertainty.

Do not commit, push, merge, rebase, create releases, install tools, or modify remote
branches unless explicitly requested.

## Efficient search rules

Start with targeted searches instead of repository-wide indexing:

```powershell
rg -n --glob '*.dm' 'ExactProcOrType' Code
rg -n --glob '*.dm' '/mob/player|proc/Name|verb/Name' Code
rg -n '#include .*RelevantFile' 'Roleplay Tenkaichi.dme'
rg -n 'window_name|control_name' RT.dmf Code assets
```

Default searches must exclude `Data`, `Icons`, `Fonts`, maps, audio, compiled output,
and local tools. Search a protected/resource path only when the task explicitly
requires it. Never inspect real player saves to infer a schema; infer the schema from
save/load code and use synthetic fixtures.

## Dream Maker engineering rules

- Preserve tabs and the local legacy style in `.dm` files. Do not reformat unrelated
  lines, normalize the repository, or rename types/files merely for consistency.
- DM type definitions are open and may be extended across many files. Search the full
  type hierarchy before assuming a definition is complete.
- Treat `src`, `usr`, and implicit global context carefully. New reusable procs should
  prefer explicit typed arguments. Do not mechanically replace legacy `usr` usage.
- Preserve required parent calls (`..()`) and verify whether parent behavior is
  intentionally suppressed before adding or removing one.
- `spawn`, `sleep`, `set waitfor=0`, delayed callbacks, and mutable flags create
  concurrency. Revalidate referenced atoms after delays and reset flags on every exit.
- Avoid changing `world.tick_lag`, `world.fps`, timing constants, RNG probabilities,
  damage formulas, stat gains, costs, cooldowns, or caps unless balance changes are
  explicitly requested.
- Never assume deletion is deferred. After `del()` or a delay, check that referenced
  atoms still exist before accessing them.
- Do not introduce unbounded world scans or loops in hot paths. Movement, combat,
  status loops, world initialization, and save loops are performance-sensitive.
- Resource paths, type paths, variable names, DME include spelling, and DMF control
  IDs may be persisted or referenced dynamically. Treat them as compatibility APIs.

## Protected data and secrets

The repository contains production-like credentials and Discord webhook URLs in
source. Never quote, print, copy, test, or propagate their values. Treat every such
value as compromised and replace it only through a dedicated security task using a
runtime configuration mechanism. See `SECURITY.md`.

Never read, summarize, edit, delete, copy, or generate content under real
`Data/Saves`, runtime logs, databases, bans, or admin data. Tests must use a temporary
directory and synthetic records.

## Verification requirement

For source, project, UI, map-code, or include changes, use the official verification
workflow in `DEVELOPMENT.md`. A structural check is not compilation. Do not claim the
change works unless Dream Maker compiled successfully and task-relevant behavior was
validated. Final status must use one of these exact outcomes:

- `Verification passed`
- `Structural check passed; compilation failed`
- `Structural check failed`
- `Compilation could not be executed`
- `Documentation-only change; code verification not required`

## Definition of done

A task is complete only when:

- The patch is limited to the requested behavior.
- Relevant hierarchy, callers, state, persistence, UI, and network effects were checked.
- New source is included exactly once in the DME.
- No unrelated formatting, gameplay balance, binary resources, real data, logs,
  credentials, or compiled artifacts changed.
- Verification was run at the level required by `docs/codex/VERIFICATION_MATRIX.md`.
- The final report is precise about what was and was not proven.
