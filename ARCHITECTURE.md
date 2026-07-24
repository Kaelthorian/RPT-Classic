# RPT-Classic architecture

## Compilation model

Dream Maker compiles the ordered include list in `Roleplay Tenkaichi.dme`. The list
begins with `RT.dmf`, shared atom/datum/helper definitions, then items, maps, mobs,
modules, and skills. This order is part of the architecture. DM permits a type to be
extended in multiple files, so the effective definition of a type or proc may be
spread across the compilation unit.

Before editing a type, search for:

- Its full type path and all child paths.
- The proc/verb name across `Code`.
- Parent calls through `..()`.
- Variables read or written by the proc.
- DME position and any later overrides.
- Save, UI, logging, admin, or network side effects.

## Runtime startup

`/world/New()` in `Code/Modules/World/WorldSettings.dm` performs early configuration,
opens logs, calls the parent implementation, schedules `Initialize()`, starts world
environment/year work, and publishes status.

`Initialize()` in `Code/Modules/World/WorldSettings/WorldStarter.dm` is guarded by
`WorldLoaded` and then loads or starts many systems, including item serials, bans,
admins, skill restrictions, scaling, year/gains/login/spawns, anti-duplication,
environment and items, timers, NPC processing, build definitions, repeated world and
player saving, areas, milestone lists, crafting lists, and automatic announcements.

Architectural consequences:

- Startup order is observable behavior.
- Duplicate initialization can corrupt global lists or start duplicate loops.
- `spawn()` means initialization is partially concurrent.
- A startup failure may leave the world only partly initialized.
- Real `Data` files are runtime dependencies but must not be used for automated tests.

## Player lifecycle and persistence

Login/new-character selection and character serialization are centered in
`Code/Modules/SaveSystem`. Save paths are derived from the player's key/ckey under
`Data/Saves`. The mob is serialized as an object, a `SAVEFILE_VERSION` value is stored,
and location/overlay state is rebuilt on load.

Compatibility rules:

- Persisted variable names and DM type paths are schema.
- Removing or renaming a serialized variable/type can break old saves.
- Save-version changes require explicit migration logic and synthetic old-version tests.
- Save, backup, disconnect, reboot, world-save, item-save, and map-save flows overlap.
- Never validate a change by opening a real save.

## Movement flow

Directional client overrides call `mob.Allow_Move(direction)`. This checks combat and
status restrictions, grabs, ships, density, doors, turf entry, flying, and edge props.
A permitted move reaches `mob.Move(NewLoc, Direct)`, which applies many additional
state gates, calculates delay from stats and conditions, mutates density, interrupts
activities, updates saved coordinates, triggers transporter/build/ship behavior, and
handles shadows.

Movement is therefore not a single proc. Review at least:

- Client direction overrides.
- `mob.Allow_Move()`.
- `mob.Move()` and inherited parent movement.
- `Bump`, turf `Enter`, doors, edges, flying, ships, knockback, clash, and status flags.
- Activity interruption and save-location side effects.

## Combat flow

The normal attack path in `Code/Skills/Attack/AttackNew.dm` performs safety checks,
starts long-range engagement or zanzoken/clash behavior, exposes invisibility,
calculates accuracy and damage, applies dodge/block/hit effects, calls `TakeDamage`,
generates energy, and starts follow-up rolls. A closely related `AttackProc()` path
duplicates substantial behavior.

Math and policy are distributed across:

- `Code/Skills/!CombatSettings`.
- Attack starter/hit/dodge/break procs.
- Weapon and armor objects.
- Buffs, traits, status, health, willpower, and movement.
- Global balance values in world settings and the DME.

A combat change must trace the whole observable sequence, not only one formula.
Do not consolidate duplicate paths during a behavior fix unless equivalence is proven.

## Items and crafting

`Code/Items/ObjectVars.dm`, `ObjectProcs.dm`, and `ObjectVerbs.dm` define broad object
behavior. Item subtype files add equipment, durability, storage, technology, magic,
weapons, and consumables. Buy/crafting lists use DM type paths to instantiate the
actual object and calculate costs or requirements.

Important contracts include:

- `suffix` is widely used as equipped-state metadata.
- Item `Savable`, serial, builder, location, durability, and type path affect persistence.
- Craft lists reference concrete type paths and may create objects dynamically.
- Equipment changes can affect overlays and combat calculations.

## Modules

`Code/Modules` contains most cross-cutting systems. High-risk modules include:

- `Admin`: privileged verbs, player mutation, server control, and logs.
- `CharacterCreation`: race/stat/type initialization and reincarnation.
- `Comms`: chat, profiles, text handling, languages, and ignore behavior.
- `Discord`: browser-mediated HTTP POST integrations.
- `Enviroment`, `World`, `Training`, `Status`: recurring loops and global state.
- `HealthSystem`: body parts, injuries, drugs, mutations, and damage consequences.
- `SaveSystem`: character, item, map, turf, and world persistence.
- `SpecialEffects`: images, pools, lighting, screens, and status bars.
- `Lib`: scheduler, events, sorting, A*, file dialogs, and imported helpers.

Use `docs/codex/SYSTEM_INDEX.md` to select the owning module before editing.

## Native and browser UI

`RT.dmf` defines native windows and controls. DM code uses string identifiers in
`winset`, `winget`, `winshow`, `output`, and `browse`. These strings are runtime API
contracts: renaming a DMF control or changing a browser window name requires all
callers to be updated together.

Browser integrations run in BYOND's embedded client environment, not a modern browser
assumption. Keep JavaScript conservative and test through the actual BYOND client.

## Maps and resources

The DME directly includes `.dmm` maps and references many icon/audio resources by
string literal. Maps, DMI files, sounds, and fonts are not ordinary text-refactor
targets. Path spelling, spaces, casing, and file names are compatibility-sensitive.

## Global state model

The game relies heavily on global variables and lists for players, admins, bans,
world time, feature toggles, item serials, portals, spawns, and server state. New
global state increases coupling. Prefer state owned by the narrowest relevant datum,
atom, subsystem, or explicit manager, while preserving legacy behavior.
