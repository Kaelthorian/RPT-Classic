# Repository map

| System | Primary locations and symbols | Useful searches | Related systems |
| --- | --- | --- | --- |
| Startup/world | `Code/Modules/World/WorldSettings.dm` `/world/New`, globals; `WorldSettings/WorldStarter.dm` `Initialize` | `rg -n "world/New|Initialize|WorldLoaded" Code` | persistence, maps, time |
| Character lifecycle | `Code/Mob/LogInOut.dm` `Login`, `Logout`; `Code/Modules/CharacterCreation/new_character.dm` `New_Character`, `Race`, `Location` | `rg -n "HasCreated|New_Character|LoadChar" Code` | saves, stats, UI |
| Movement/input | `Code/Mob/MobMovement.dm` `Move`, `Allow_Move`; `Code/Mob/Verbs/MultikeyMovement.dm` `ApplyMovementKeys`; `RT.dmf` macros | `rg -n "ApplyMovementKeys|Allow_Move|client/North|mob/Move" Code RT.dmf` | combat states, ships, maps |
| Combat/damage | `Code/Skills/Attack/AttackNew.dm` `Attack`; `Attack.dm` `KO`; `Code/Skills/!CombatSettings/CombatProcs.dm`; `CombatMathFormulas.dm` | `rg -n "Attack\(|KO\(|Damage|Refire|attacking" Code/Skills Code/Mob` | stats, buffs, health |
| Skills/buffs/ki | `Code/Skills/!CombatSettings/Skills.dm` `/Skill`, `/Skill/Attacks`, `/Skill/Buff`; family directories | `rg -n "^Skill|Using|InCD|CDTick" Code/Skills` | combat, teaching, UI |
| Character stats/health | `Code/Mob/MobVars.dm`; `Code/Skills/StatMults.dm`; `Code/Modules/HealthSystem/BodyParts.dm`, `LimbSystem.dm` | `rg -n "BPMod|StrMod|MaxHealth|BodyPart" Code` | creation, saves, combat |
| Items/inventory/economy | `Code/Items/ObjectVars.dm`, `ObjectProcs.dm`, `ObjectVerbs.dm`; `Code/Modules/Tabs/Inventory System.dm`; `Code/Items/Money/` | `rg -n "^obj/items|Equipped|suffix|cost|Resources" Code/Items Code/Modules/Tabs` | saves, crafting, UI |
| Persistence | `Code/Modules/SaveSystem/Better Saves.dm` `Save`, `LoadChar`; `Save Load Procs.dm`; `worldsave.dm`; map/item save files | `rg -n "savefile|Save\(|Load|Data/" Code/Modules/SaveSystem` | lifecycle, world, items |
| Maps/environment | `Code/Map/`; `Code/Modules/Enviroment/`; `Code/Modules/World/icon_defs/`; included `.dmm` paths in DME | `rg -n "MapEnviromentLoad|MapSave|turf/|area/" Code/Map Code/Modules` | movement, world saves |
| UI | `RT.dmf`; `Code/Mob/Windows/`; `Code/Modules/Tabs/`; `assets/`; `Code/Modules/Tooltips/` | `rg -n "winset|winshow|browse\(|output\(" Code` | all player/admin flows |
| Communication | `Code/Modules/Comms/`; `Code/Mob/Verbs/Say.dm`, `OOC.dm`, `Whisper.dm`; `Code/Mob/Topic.dm` | `rg -n "ICOut|OOCOut|AdminOut|LanguageSay" Code` | UI, admin, logging |
| Administration | `Code/Modules/Admin/`, especially `AdminUpdateVerb.dm`, `Topic.dm`, `Verbs/` | `rg -n "client.holder|holder.level|Admin[1-5]" Code/Modules/Admin` | persistence, comms, Discord |
| External notifications | `Code/Modules/Discord/` `HttpPost`; callers in admin/help/update paths | `rg -n "HttpPost|api/webhooks" Code` | UI, admin, security |
| NPC/pathfinding | Included `Code/Modules/TestServer/TestServerNPC.dm`; `Code/Modules/Lib/AStar.dm`. `Code/Modules/NPC/NPC.dm` is not in the DME | `rg -n "AStar|NPC|Path" Code` | maps, test server |
| Time/events | `Code/Modules/World/DayBook.dm`, `YearBook.dm`, `Years.dm`; `Code/Modules/Lib/Events/` | `rg -n "DayBook|YearBook|EventScheduler" Code` | world, saves, announcements |

The 77 unreferenced sources include test/legacy skill variants, the standalone
NPC module, LightSystem example/stub code, unused UI variants, and several empty
files. Audit them individually before inclusion; do not bulk-add them.
