# Include order and DM type system

## Why order matters

Only paths in the single ordered DME include block compile. At the audited
baseline it contains 674 includes, from `RT.dmf` to
`Code/Skills/Sword/Tier4/SkyBreak.dm`. The structural checker found 77 `.dm`
files outside that unit; their presence is not evidence that their code runs.

Dream Maker permits a type to be reopened across files. For example,
`client/North()` is defined in `Code/Mob/MobMovement.dm:195` and extended later
by the `client` block in `Code/Mob/Verbs/MultikeyMovement.dm:46`; their DME lines
are 251 and 271 respectively. The later override uses `..()` to reach the earlier
movement gate. Removing or reordering either file changes the call chain.

## Parent calls

`..()` invokes inherited/previous behavior. Examples include `client.Move()` and
`mob/Move()` in `Code/Mob/MobMovement.dm:4,10`, `/world/New()` and `/world/Del()`
in `Code/Modules/World/WorldSettings.dm:191,215`, and mob serialization
`Write()`/`Read()` in `Code/Modules/SaveSystem/Better Saves.dm:42,49`.

## Investigation procedure

1. Search the full type path, proc name, and likely shorthand with `rg -n`.
2. Check every declaration, caller, child type, and `..()` call.
3. Locate each defining file in `Roleplay Tenkaichi.dme` and compare order.
4. Confirm the file is included; do not infer activity from its location.
5. After a source/include change, run `scripts/verify.ps1` and treat new warnings
   as defects.

Avoid moving existing includes for tidiness. Type extensions, macros, constants,
and global initialization may rely on their current predecessors.
