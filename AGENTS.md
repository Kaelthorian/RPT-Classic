# Codex guide for RPT Classic migration

## Repository layout

- The Godot 4 project is rooted at `project.godot` in this directory.
- `RT Classic Byond/` is the original project and behavioral reference.
- Read `RT Classic Byond/AGENTS.md` before any work in the BYOND tree.
- Start migration work with `docs/migration/MIGRATION_OVERVIEW.md`, then read the
  system map, architecture, roadmap, status and risks in the same directory.

## Godot migration

RPT Classic is being migrated incrementally from BYOND to Godot 4. The original
BYOND implementation remains the behavioral reference. Do not remove, relocate,
rewrite or bulk-format legacy systems unless explicitly requested.

Before migrating a system:

1. Read its active BYOND implementation and DME includes.
2. Document observable behavior and invariants.
3. Identify data, UI, persistence, timing and global dependencies.
4. Define a small Godot boundary using composition and typed data.
5. Implement one minimal vertical slice with synthetic fixtures.
6. Verify expected behavior against BYOND evidence.
7. Update migration status, risks and architectural documentation.

Do not bulk-translate `.dm` files or copy BYOND globals into Autoloads. Prefer
small scenes/components, typed GDScript, Resource definitions, local signals and
explicit dependencies. Do not inspect real saves, databases, logs or secrets.

## Running and validation

Open this directory in the supported Godot 4 editor or run:

```powershell
godot --path . --editor --quit
godot --headless --path . --quit-after 5
```

Use the actual executable name installed on the machine. A successful import is
not runtime validation: inspect parse errors, Autoload configuration, missing
resources, scene routing and startup output. Run BYOND's own verification only
when BYOND source/project files change, following its nested `AGENTS.md`.

Never commit, push, install dependencies, move the legacy tree or delete assets
unless the user explicitly requests it.
