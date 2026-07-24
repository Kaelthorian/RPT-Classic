# Known risks and review hotspots

These are review warnings, not proof that every listed behavior is defective.

## Critical

### Exposed credentials and webhooks

Production-like credentials are committed in world and Discord source. Rotate/revoke
them and externalize configuration. Never repeat the values.

### Real player data in the repository tree

Save/load code reads and writes under `Data/Saves`, while other modules use runtime
logs and databases. Broad tests, cleanup commands, or repository-wide transformations
can expose or destroy data.

## High

### Save schema is implicit

The serialized mob, persisted variable names, type paths, location, overlays, items,
and `SAVEFILE_VERSION` form a schema without a formal migration framework. Renames
and deletions can silently break existing characters.

### Global mutable state

World settings and modules share many global flags/lists. Initialization order,
reboots, test-server toggles, admin changes, and recurring loops can produce state that
is difficult to isolate.

### Asynchronous state machines

`spawn`, `sleep`, `set waitfor=0`, cooldown flags, movement locks, attacks, crafting,
training, saving, and initialization overlap. Early returns or deleted atoms can leave
flags stuck or callbacks operating on invalid state.

### Movement is highly coupled

Movement combines client direction overrides, `Allow_Move`, `Move`, density, doors,
turfs, flying, ships, grabs, knockback, clash, activity interruption, and saving.
A local change can alter combat or persistence.

### Combat has parallel and duplicated paths

Normal attack behavior is duplicated between a verb and proc, while formulas depend
on equipment, traits, buffs, health, willpower, RNG, and globals. Fix both paths only
when their intended equivalence is established.

### Privileged admin surface

The admin module exposes broad player/server mutation. Permission and logging
regressions have severe impact.

## Medium

### `usr` in reusable procs

Several modules derive the acting client from global `usr`. Delayed, indirect, admin,
or server-triggered calls may not have the expected `usr`. Prefer explicit actors in
new code and audit context before changing legacy behavior.

### Hard-coded world assumptions

Z-levels, spawn coordinates, server names, feature flags, caps, and timing values are
embedded in source. Treat changes as gameplay/configuration migrations, not cleanup.

### DME include order

A source file outside the include list is dead code. Reordering can change effective
definitions and overrides.

### Native UI string contracts

DMF window/control names are referenced by strings across DM and browser UI. Typos or
renames generally compile but fail at runtime.

### Resource path sensitivity

Icon/audio/map paths include spaces, mixed casing, and legacy names. Mass renames or
case normalization can break compilation or runtime loading.

### Hot-path world iteration

Movement, status, cleanup, environment, NPC, item, and save loops may iterate many
atoms. Avoid introducing extra world scans inside frequent callbacks.

## Review rule

When a task touches one hotspot, inspect connected systems before editing and select
additional checks from `docs/codex/VERIFICATION_MATRIX.md`.
