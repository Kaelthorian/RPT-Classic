# Persistence, world, maps, and time

## Purpose and scope

This system initializes global state and maps, saves/loads characters and world
objects, and runs calendar/save loops. Runtime data itself is out of scope and
must not be inspected.

## Main flow and key code

`/world/New()` (`WorldSettings.dm:191`) opens logs and starts `Initialize()`.
`WorldStarter.dm:1-57` loads serials, bans/admins, scaling, year, gains, login and
spawn settings; schedules environment/map/item loading; adds builds; starts
`SaveWorldRepeat`, `Save_Loop`, `DayBook`, and `AutoAnnounce`; then enables saves.

Character selection uses `client.Choose_Login()` in
`Code/Modules/SaveSystem/Better Saves.dm:9`. `mob.Save()` writes the whole mob to
`Data/Saves/[key]/[ckey]`; `client.LoadChar()` reads it, restores location and
runs version migrations (`SAVEFILE_VERSION=16`, lines 39 and 128-315). Separate
files in `Save Load Procs.dm` persist scaling, rankings, activation, year, gains,
admins, hub text, spawns, login, and areas. Other SaveSystem files handle maps,
turfs, objects, items, and periodic world saving.

## Types, state, inputs, and outputs

Principal types are `/world`, `/mob/player`, `client`, saveable `/obj/items`,
turfs/areas, and `savefile`. State includes `WorldLoaded`, `ItemsLoaded`,
`MapsLoaded`, `Allow_Save`, `CanSave`, saved coordinates, serial lists, year/
month, and version. Inputs are startup, login choice, logout/manual/periodic save,
admin world commands, and runtime object changes. Outputs are savefiles beneath
`Data/`, reconstructed mobs/objects/maps, logs, and global lists.

Dependencies include character creation, item serials, bans/admin, maps and
environment, `Players`, time loops, and DM serialization `Write`/`Read`.
Invariants: no save before required loading; stable key/ckey identity; valid
coordinates; unique item serials; migrations aligned with the saved version;
and backups that never replace the only good copy.

## Risks and validation

`Initialize()` calls `LoadBans()` twice (`WorldStarter.dm:22,26`), a confirmed
duplicate load (PERF-002). Character saves overwrite the canonical path directly
and backups are probabilistic/afterward (`Better Saves.dm:79-97,316-335`), so a
crash or write failure warrants corruption testing (DATA-001; not confirmed).

Validate only with synthetic isolated data: cold startup order, maps/items gates,
new/load/logout/reconnect, each save migration, interrupted writes, backup
rotation, serial uniqueness, periodic saves, reboot, and map/object restoration.
Search `Initialize`, `Save_Loop`, `SaveWorldRepeat`, `savefile`, `LoadChar`,
`SAVEFILE_VERSION`, `MapEnviromentLoad`, `ItemSerial`, `WorldLoaded`, and
`Allow_Save`.
