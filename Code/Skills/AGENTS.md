# Instructions for `Code/Skills`

- Combat behavior spans `!CombatSettings`, `Attack`, item equipment, buffs, health,
  status, movement, and global settings. Trace the complete action sequence.
- `Attack()` and `AttackProc()` contain parallel behavior. Do not patch only one without
  proving the other is intentionally different or updating both consistently.
- Treat damage, accuracy, resistance, energy gain, cooldowns, RNG, drain, and trait
  multipliers as balance. No incidental changes.
- Validate zero/null/near-zero inputs, equipment breakage, block/dodge/hit, interruption,
  cooldown reset, repeated activation, target deletion, and disconnect.
- Preserve combat/admin logs and player-facing output unless the requested behavior
  includes messaging.
- Avoid calling calculators multiple times for logging when they contain RNG or side
  effects. Store a value once and log that value.
- Compile and run deterministic synthetic scenarios where possible.
