# Verification matrix

All code changes require structural checks and Dream Maker compilation. Add the
focused checks below.

| Change area | Required focused verification |
| --- | --- |
| Documentation only | Link/path review; no code compilation required |
| New/removed/renamed `.dm` | DME include resolution, duplicate/orphan audit, full compile |
| Shared atom/datum/helper | Full compile; search all callers; startup/login smoke test |
| Movement/collision | Blocked/free movement in all directions; flying/water/doors/edges; activity interruption; knockback/clash; location save |
| Login/player lifecycle | New character, load, reconnect, logout, AFK, invalid/missing save using synthetic data |
| Save schema | Current + old synthetic versions; backup; missing fields; repeated load/save; no real `Data` access |
| Combat formula | Deterministic synthetic inputs where possible; hit/dodge/block; equipment; buffs; zero/near-zero resistance; logs; both attack paths |
| Skill/buff | Acquire/use/cancel/cooldown; resource cost; interruption; repeated activation; deletion/disconnect; save/load if persistent |
| Item/equipment | Create/equip/unequip/destroy; durability; overlays; crafting list; save/load; combat interaction |
| Admin | Lowest allowed and highest denied ranks; audit logs; target deletion/disconnect; no privilege widening |
| Discord/HTTP | Stub endpoint only; no real network; sanitization; missing config/client; rate/failure path |
| World startup/global loop | Clean startup once; duplicate-init guard; test/prod flags; graceful missing synthetic data; no duplicate loops |
| Map/building | Disposable test map; bounds/density; save/load synthetic map; no broad `.dmm` diff |
| Native/browser UI | Actual BYOND client; every changed control/window ID; open/close/focus/input; escaped text |
| Resource path | Full compile and actual client load/render/playback |

## Baseline commands

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\check.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\verify.ps1"
git diff --check
git status --short
git diff
```

## Reporting evidence

State exactly which rows were exercised. Do not write “tested” when only source was
read or compiled. A compile does not prove runtime UI, networking, save migration, or
balance behavior.
