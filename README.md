# RPT-Classic

RPT-Classic is a legacy multiplayer role-playing game built with BYOND and Dream
Maker. The active project is the BYOND codebase at the repository root.

## Entry points

- `Roleplay Tenkaichi.dme` is the authoritative compilation entry point and include list.
- `RT.dmf` defines the native BYOND interface.
- `/world/New()` in `Code/Modules/World/WorldSettings.dm` starts the runtime and calls
  the broader initialization flow.
- `Initialize()` in `Code/Modules/World/WorldSettings/WorldStarter.dm` loads server
  state, maps, world objects, timers, admins, bans, spawns, and saving systems.

## Main source areas

| Path | Responsibility |
| --- | --- |
| `Code/_Atom`, `Code/_Datums`, `Code/_HELPERS` | Shared foundations and helpers |
| `Code/Items` | Items, equipment, crafting, resources, and item behavior |
| `Code/Map` | Maps, turfs, building, and map-save code |
| `Code/Mob` | Player state, lifecycle, movement, verbs, and windows |
| `Code/Modules` | Cross-cutting gameplay and server systems |
| `Code/Skills` | Combat, attacks, buffs, ki, melee, support, and sword skills |
| `assets` | Browser UI assets used by BYOND controls |
| `Data` | Runtime saves/logs/databases; never use as test fixtures |
| `Icons`, `Fonts`, audio | Binary resources; edit only for an explicit asset task |

The DME currently contains more than 650 ordered include entries. Do not infer that a
file compiles merely because it exists under `Code`.

## Codex setup

Place the supplied files at the exact paths shown in `CODEX_SETUP.md`. Codex reads
`AGENTS.md` automatically and inherits nested `AGENTS.md` rules for the subtree it is
editing. The complete package also supplies search filters and safe verification
scripts; the markdown-only package supplies context but cannot enforce compilation.

## Build and verification

On Windows with BYOND installed:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\verify.ps1"
```

Manual compiler fallback:

```powershell
& "C:\Program Files\BYOND\bin\dm.exe" -full_paths ".\Roleplay Tenkaichi.dme"
```

Prefer the supplied verification script because it compiles a temporary staging copy
and avoids overwriting tracked outputs or touching runtime data.

## Documentation

- `AGENTS.md`: binding instructions for Codex.
- `ARCHITECTURE.md`: runtime flows and subsystem boundaries.
- `DEVELOPMENT.md`: workflow, commands, and verification.
- `SECURITY.md`: credentials, webhooks, player data, and network rules.
- `KNOWN_RISKS.md`: current technical hazards and review hotspots.
- `docs/codex/SYSTEM_INDEX.md`: detailed codebase index.
- `docs/codex/DM_PATTERNS.md`: Dream Maker-specific review guidance.
- `docs/codex/VERIFICATION_MATRIX.md`: required checks by change type.

## Security notice

The public source contains credentials and Discord webhook endpoints that look usable.
They must be revoked or rotated and moved out of source control. Do not test them or
repeat their values in issues, prompts, logs, documentation, or generated patches.
