# RPT-Classic

RPT-Classic is a legacy multiplayer role-playing game implemented in BYOND's
Dream Maker (DM) language. The compilation entry point is
`Roleplay Tenkaichi.dme`; the game interface is declared in `RT.dmf`.

## Requirements and verification

The project targets BYOND 515-era clients (the login code names build 515.1621
in `Code/Mob/LogInOut.dm:5-11`). A Dream Maker `dm.exe` is required. The
repository can use `.local-tools/BYOND/bin/dm.exe`, `BYOND_DM_PATH`, a compiler
on `PATH`, or a standard BYOND installation; the selection logic is in
`scripts/compile.ps1`.

From the repository root, run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\verify.ps1"
```

This first runs structural checks and then compiles a temporary mirror of
`Roleplay Tenkaichi.dme`, excluding runtime `Data/` and generated outputs. See
`docs/DEVELOPMENT.md` for details.

## Repository at a glance

- `Code/Items/`: item bases, equipment, money, and item interactions.
- `Code/Mob/`: player state, lifecycle, movement, verbs, and windows.
- `Code/Skills/`: combat, buffs, ki, support, melee, and weapon skills.
- `Code/Modules/`: world, saving, admin, communications, character creation,
  health, maps, and larger subsystems.
- `Code/_Atom/`, `Code/_Datums/`, `Code/_HELPERS/`: shared extensions and helpers.
- `assets/`: tooltip and map-size browser assets used from the BYOND interface.
- `scripts/`: repository checks and isolated Dream Maker compilation.

The ordered `#include` block in `Roleplay Tenkaichi.dme` is the real compilation
unit. A `.dm` file merely present under `Code/` is not necessarily active.

## Documentation

Use [`docs/README.md`](docs/README.md) as the task-oriented index. It links the
architecture, repository map, include/type guide, development workflow, system
guides, and the technical review. The audited baseline is commit
`2eb28271d8a9ac92e0d99013cfdc4c1e79af649b` on `main` (2026-07-11).

The initial structural check passed with 674 resolved includes and reported 77
unreferenced `.dm` files. Dream Maker was selected successfully but did not
return within a ten-minute external timeout, so compilation success is not
established by this audit.
