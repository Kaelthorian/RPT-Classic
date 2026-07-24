# Dream Maker patterns for this repository

## Open type definitions

DM allows the same type path to be extended in multiple files. A search hit is not a
complete class definition. Search the full path and relevant proc name across `Code`.
Later definitions in DME order can alter effective behavior.

## `src` and `usr`

- `src` is the object whose proc/verb is executing.
- `usr` is implicit interaction context and may be null or unexpected outside direct
  verb/click flows.
- Delayed callbacks, server startup, admin tools, and reusable procs should not assume
  a stable `usr`.

For new reusable code, pass a typed actor/client explicitly. Preserve legacy behavior
unless the task is specifically correcting context handling.

## Parent behavior

`..()` invokes parent implementation. Removing it may suppress engine or inherited
behavior; adding it may duplicate work. Inspect parent/child definitions before change.

## Delays and liveness

After `sleep()` or within `spawn()`:

- The mob/client/target/object may have disconnected or been deleted.
- Location, target, equipment, and flags may have changed.
- A global list may no longer contain the same members.

Re-check liveness and required state before applying effects. Ensure lock flags are
cleared on success, failure, interruption, deletion, and cancellation paths.

## Iterating the world

Patterns such as `for(var/mob/M in Players)` are preferable to unrestricted world
scans when a maintained list exists. Do not add repeated scans to movement, combat,
status loops, or per-tick callbacks without measuring cost and bounding frequency.

When deleting while iterating, confirm DM iteration semantics and avoid using the
reference afterward.

## Savefiles

The project serializes mobs/items and also writes named entries. Treat these as schema:

- Type path.
- Variable names and types.
- List contents.
- Location coordinates.
- Equipment/overlay state.
- Version marker.

A migration must be idempotent, version-gated, and safe on missing/null legacy fields.
Use synthetic savefiles representing the oldest supported version and the current one.

## UI strings

`winset`, `winget`, `winshow`, `output`, and `browse` use string IDs. Verify IDs in
`RT.dmf` and browser window names. Compilation often cannot detect a wrong ID.
Escape user content and respect existing length/sanitization helpers.

## Resource literals

DMI/audio/map paths are compile/runtime contracts. Preserve exact spelling and quote
paths containing spaces. Confirm a new resource exists before referencing it.

## Numbers and probability

DM numeric values are frequently used as booleans, counters, multipliers, and state
levels. Do not replace a numeric flag with strict boolean logic without checking all
comparisons. `prob()`, `rand()`, timing values, and formulas are gameplay behavior.

## Dynamic type creation

Crafting and admin systems may instantiate type paths dynamically. Renaming or moving
a type can break code even when direct textual callers are not obvious. Search lists,
input menus, save data code, and `new Creates`-style patterns.

## HTML and network output

DM strings may contain HTML sent to the BYOND client or Discord. Sanitize user text,
limit length, avoid unsafe interpolation, and keep endpoints out of source.
