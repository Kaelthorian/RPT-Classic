# BYOND system map

This map uses active DME includes and the audited BYOND documentation. `Unknown`
means the behavior or future boundary has not yet been verified deeply enough.

| Original system | Primary files | Responsibility | Dependencies | Future Godot destination |
| --- | --- | --- | --- | --- |
| Compilation/startup | `Roleplay Tenkaichi.dme`; `Code/Modules/World/WorldSettings.dm`; `WorldSettings/WorldStarter.dm` | Ordered compilation and world initialization | DMF, globals, persistence, maps, loops | Boot scene plus explicit startup services |
| Player lifecycle | `Code/Mob/LogInOut.dm`; `Code/Modules/Mind/Mind.dm` | Login/logout, character selection, player registration | Saves, maps/items readiness, `Players`, UI | Session service and composed player scene |
| Character creation | `Code/Modules/CharacterCreation/new_character.dm`; `Assign Race Stats.dm`; `Better Races - No Size.dm`; `Stat Points.dm` | Race, stats, appearance, spawn, savable player creation | DMF dialogs, mob variables, items, maps, saves | Character creation flow with Resource definitions |
| Player state/stats | `Code/Mob/MobVars.dm`; `Code/Skills/StatMults.dm`; `Code/Modules/HealthSystem/` | Player variables, modifiers, limbs, injuries, willpower | Creation, combat, buffs, persistence, UI | Actor components and typed stat/health Resources |
| Movement/input | `RT.dmf`; `Code/Mob/MobMovement.dm`; `Code/Mob/Verbs/MultikeyMovement.dm` | Held-key input, movement gates, facing, collision | Mob state, turfs, ships, skills, map edges | Input adapter, movement component, world collision |
| Combat | `Code/Skills/Attack/AttackNew.dm`; `Attack.dm`; `AttackProcs/`; `Code/Skills/!CombatSettings/` | Attack gating, hit/dodge/damage, KO, cooldown | Stats, movement, health, skills, effects, messages | Deterministic combat domain plus presentation adapters |
| Skills/buffs | `Code/Skills/!CombatSettings/Skills.dm`; skill family directories | Skill definitions, costs, cooldowns, buffs and attacks | Combat, stats, mob contents, UI, progression | Resource definitions and composable runtime effects |
| Inventory/items/economy | `Code/Items/ObjectVars.dm`; `ObjectProcs.dm`; `ObjectVerbs.dm`; `Code/Modules/Tabs/Inventory System.dm` | Items, equipment, inventory capacity, currencies | Mob contents, overlays, crafting, saves, DMF UI | Inventory component, item Resources, inventory UI |
| Maps/world building | Active `.dmm` includes in the DME; `Code/Map/`; `Code/Map/build_system/` | 18 active z-level maps, turfs/areas, building | DME paths, icons, movement, environment, saves | World scenes/TileMaps and audited import tooling |
| Environment/time | `Code/Modules/Enviroment/`; `Code/Modules/World/DayBook.dm`; `YearBook.dm`; `Years.dm` | Environment updates, calendar and timed world work | Maps, globals, events, saves, announcements | World simulation systems with explicit clocks |
| Persistence | `Code/Modules/SaveSystem/Better Saves.dm`; `Save Load Procs.dm`; map/item save files | Character, world, area, map and item serialization | Whole mob state, versions, serials, startup/lifecycle | Versioned Godot persistence; BYOND conversion is separate |
| UI | `RT.dmf`; `Code/Mob/Windows/`; `Code/Modules/Tabs/`; `assets/`; `Tooltips/` | Windows, controls, browser content and HUD-like tabs | Named DMF controls, most gameplay systems | Godot Control scenes and presentation adapters |
| Communication | `Code/Modules/Comms/`; `Code/Mob/Verbs/Say.dm`; `OOC.dm`; `Whisper.dm` | IC/OOC/admin output, contacts, language/filtering | `Players`, mute/ignore, UI, logs, admin | Chat domain, channels, moderation and UI |
| Administration | `Code/Modules/Admin/`; `Code/Modules/BanSystem/BanSystem.dm` | Ranks, verbs, panels, bans and server operations | Holder/rank state, Topic links, saves, comms | Server-authoritative admin services and tools |
| Networking | BYOND runtime; `client`/`world`; `Code/Modules/World/WorldSettings.dm` `Import`; Discord HTTP modules | Client/server transport is largely implicit in BYOND; HTTP notifications are separate | Runtime semantics and authority rules are not yet specified | `systems/networking/`; transport and authority model Unknown |
| NPC/pathfinding | `Code/Modules/TestServer/TestServerNPC.dm`; `Code/Modules/Lib/AStar.dm` | Included test-server NPC behavior and A* helper | Maps, movement; production NPC module is not included | NPC components and navigation; intended production behavior Unknown |
| Graphics/assets | `Icons/` (`.dmi`); `Fonts/`; image files; DME resource directories | Sprites, tiles, effects, fonts and UI imagery | DMI states/directions, map and type resource paths | Audited asset conversion pipeline; reuse rights/coverage Unknown |
| Audio | `.ogg`, `.wav`, `.mp3`, `.mid` resources under the BYOND tree | Music and effects referenced by DM/resource paths | Calling systems and BYOND sound semantics | Godot audio resources after reference/license audit |
| Static/configuration data | DME defines; world globals; DM source constants; `.bdb` runtime files | Balance, toggles, caps and persisted server configuration | Broad global consumers and save formats | Typed Resources/JSON schemas; exact split Unknown |

## Coupling observations

DM open types spread `/mob/player`, `/obj/items`, `/Skill`, `client`, and `/world`
across many files. Global `Players`, loading flags, world toggles, spawn data and
caps connect otherwise separate features. Persistence serializes whole mobs and
rebuilds derived equipment/overlay state. UI calls named DMF controls directly,
while asynchronous `spawn()` timing affects movement, combat, startup and loops.
These relationships must become explicit boundaries rather than be reproduced as
one global Godot object.
