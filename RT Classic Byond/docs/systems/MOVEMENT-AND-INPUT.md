# Movement and input

## Purpose and scope

This system converts DMF arrow/WASD macro events into held-key state, direction,
collision checks, and BYOND movement. It does not cover combat knockback beyond
the gates that movement observes.

## Main flow

`RT.dmf:1-248` defines three macro sets. Cardinal `+REP` commands invoke BYOND
direction verbs and `+UP` invokes `NorthReleased`/etc. The later overrides in
`Code/Mob/Verbs/MultikeyMovement.dm:15-83` set four client booleans,
`ApplyMovementKeys()` combines axes, and a guard calls the earlier cardinal
overrides in `Code/Mob/MobMovement.dm:195-234`. Those call
`mob.Allow_Move(D)` (line 239), then BYOND eventually invokes `mob/Move()` (line
10), which applies state/speed gates and calls `..()`.

## Key references

- Types: `client`, `mob/player`, ship/control objects referenced by `S`.
- State: `client.north/east/south/west`, `applying_movement_keys`; mob `move`,
  `Spinning`, `Frozen`, `KB`, `KOd`, `RPMode`, `Flying`, `dir`.
- Inputs: DMF `+REP` and `+UP`; direct BYOND directional calls.
- Outputs: `dir`, location, saved coordinates, interruption of fishing/mining/
  cooking/creation, transporter and shadow follow effects.
- Dependencies: turf `Enter`, `Bump`, `ghostDens_check`, `EdgeMovementCheck`,
  skills, ships, and map edge props.

## Invariants and important behavior

Opposite keys cancel one axis; orthogonal keys produce diagonals. A release
immediately reapplies a remaining direction. `Allow_Move` assigns `dir` before
several later checks (`MobMovement.dm:239-284`), so visual facing may change even
when actual movement is rejected. `mob/Move` sets `move=0` and re-enables it via
`spawn(round(Delay,0.1))`.

## Known risks and validation

Macro set `macro3` maps arrows and WASD onto the same four booleans. Releasing
one physical key clears the boolean even if its equivalent remains held; this is
MOV-001 in `CODE-REVIEW.md` and is a plausible contributor to intermittent wrong
direction, not a confirmed root cause. Movement also allocates/deletes a water
overlay object on ordinary steps (PERF-001).

Runtime validation should log ordered press/release events, booleans, combined
direction, `dir`, attempted `Direct`, and final coordinates for rapid cardinal
switches, opposites, diagonals, both bindings in macro3, blocked movement, lag,
and key-repeat timing. Search with `ApplyMovementKeys`, `NorthReleased`,
`Allow_Move`, `mob/Move`, `dir=`, `move=0`, `Spinning`, and `+REP`.
