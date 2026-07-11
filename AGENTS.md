# Codex guide for RPT-Classic

## Project overview

RPT-Classic is a BYOND game written in Dream Maker (DM). The project entry point is
`Roleplay Tenkaichi.dme`; its ordered `#include` block defines the compilation unit.
Most source code lives under `Code/`. Images, sounds, fonts, maps, saves, databases,
and compiled BYOND artifacts are large or binary and should not be scanned unless a
task explicitly requires them.

## Where to look

- `Code/Items`: items, equipment, money, and item UI.
- `Code/Mob`: mob/player behavior and verbs.
- `Code/Skills`: combat and non-combat skills.
- `Code/Modules`: larger systems (world, map, lighting, libraries, and UI).
- `Code/_Atom`, `Code/_Datums`, `Code/_HELPERS`: shared foundations and helpers.
- `Roleplay Tenkaichi.dme`: compile flags, resource directories, and include order.
- `RT.dmf`: BYOND interface definition.
- `assets/`: browser-based HTML/CSS/JavaScript UI assets.
- `Icons/`, `Fonts/`, `Data/`: mostly binary assets or mutable runtime data.

## Efficient workflow

1. Start with `rg -n "term" Code "Roleplay Tenkaichi.dme" RT.dmf assets` rather
   than searching the entire repository.
2. Inspect the relevant type hierarchy and callers before editing. DM definitions
   are frequently extended across several files.
3. Keep a new `.dm` file focused on one system and add it to the ordered include
   block in `Roleplay Tenkaichi.dme`. A file that exists but is not included does
   not compile.
4. Run `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/check.ps1`
   after source or project-file changes.
5. If Dream Maker is installed and available on `PATH`, also compile with
   `DreamMaker "Roleplay Tenkaichi.dme"`. Treat new compiler warnings as defects.

## Editing rules

- Preserve the surrounding DM style. This is a legacy codebase with mixed casing,
  spacing, and naming; avoid unrelated formatting or broad modernization.
- Prefer narrow changes. Do not rename paths or types only for consistency because
  resources and save data may refer to them by name.
- Preserve the order of the DME include list unless dependency order requires a
  deliberate change.
- Do not hand-edit generated/compiled files (`*.dmb`, `*.rsc`, `*.dyn.rsc`) or
  runtime logs and databases. Do not change saves, maps, icons, audio, or fonts
  unless the task specifically calls for it.
- Never expose or overwrite player data under `Data/Saves`.
- Quote paths in commands: the project name and many asset paths contain spaces.
- Do not assume a test framework exists. The repository check validates project
  structure; a Dream Maker compile is the authoritative source check.
- Some legacy `.dm` files are intentionally absent from the DME. The default check
  reports their count; use `scripts/check.ps1 -Strict` only when auditing orphans.

## Completion checklist

- The change is limited to the requested system.
- Every DME include resolves and new source files are included exactly once.
- `scripts/check.ps1` passes.
- Dream Maker compilation was run when the executable was available; otherwise,
  state clearly that compilation could not be performed.
- No compiled output, logs, saves, or unrelated binary assets were changed.
