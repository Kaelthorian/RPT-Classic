# RPT Classic migration overview

## Objective

RPT Classic will move incrementally from BYOND/Dream Maker to Godot 4 while
preserving verified gameplay behavior. The existing implementation under
`RT Classic Byond/` remains the behavioral reference and must stay runnable
throughout the migration.

The Godot project already existed at the repository root when this work began.
Its `project.godot`, `Testing.tscn`, and imported icon were tracked, so the new
foundation is integrated there instead of creating a second project under
`godot/`. The two implementations remain separated by directory boundaries.

## Incremental strategy

Each system moves through audit, behavioral specification, dependency design,
one minimal vertical slice, comparison with BYOND, and documentation. A feature
is not migrated merely because equivalent classes or data files exist in Godot.
Content conversion follows the system that owns and validates that content.

BYOND sources, maps, resources, and runtime data are not moved to `legacy/` in
this phase. The DME relies on hundreds of ordered relative includes, resource
directories, a DMF interface, and local verification scripts. Moving the tree
would add risk without improving the migration boundary.

## Rules

- Read the active DME includes and all relevant open-type extensions first.
- Record observable behavior, dependencies, persistence effects, and unknowns.
- Prefer composition, typed GDScript, Resources, local signals, and small scenes.
- Use Autoloads only for true application-wide lifetime or coordination.
- Do not translate DM line by line or silently change balance and timing.
- Do not consume real player saves during development or tests.
- Keep BYOND and Godot validation results separate and explicit.
- Update the system map, status, risks, and architecture with each slice.

## Completion criteria

The migration is complete only when all in-scope behavior and content have a
documented Godot owner, automated or repeatable parity checks pass, production
save migration has a reversible and tested plan, multiplayer and administration
requirements are verified, and operators approve retiring BYOND. Until then,
BYOND remains the reference rather than disposable legacy code.
