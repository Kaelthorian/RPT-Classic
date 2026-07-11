# Migration status

Statuses describe evidence in this repository, not estimated completion.

| System | BYOND analyzed | Godot base | Functional migration | Validated |
| --- | ---: | ---: | ---: | ---: |
| Startup/project foundation | Investigating | Verified | Not started | Verified |
| Data definitions | Investigating | In progress | Not started | Verified |
| Maps/world | Investigating | Verified | Not started | Verified |
| Player lifecycle/entity | Investigating | In progress | Not started | In progress |
| Movement/input | Investigating | In progress | Not started | In progress |
| Interaction | Not started | Planned | Not started | Not started |
| Inventory/items | Investigating | Planned | Not started | Not started |
| Combat/skills | Investigating | Planned | Not started | Not started |
| Character creation/progression | Investigating | Planned | Not started | Not started |
| NPC/navigation | Investigating | Planned | Not started | Not started |
| Persistence | Investigating | In progress | Not started | Not started |
| UI/communication | Investigating | In progress | Not started | Not started |
| Networking | Investigating | Planned | Not started | Not started |
| Administration/operations | Investigating | Planned | Not started | Not started |
| Assets/audio | Investigating | Planned | Not started | Not started |

`In progress` for persistence means only the safe Godot interface exists; no
BYOND format or production save behavior has been migrated. UI likewise means
only the temporary startup/status and test-map overlay exist. Map validation
covers the synthetic 50×50 grass test map and its 2,500 runtime cells, not BYOND
map conversion. Player/movement parse and start successfully, but interactive
input and BYOND behavioral parity are not yet verified.
