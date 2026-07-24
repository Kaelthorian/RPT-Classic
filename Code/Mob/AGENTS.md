# Instructions for `Code/Mob`

- Player state is distributed across `MobVars.dm`, lifecycle, movement, status, verbs,
  windows, modules, and skills. Search every variable touched by a change.
- Movement changes require review of client direction overrides, `Allow_Move`, `Move`,
  `Bump`, turf entry, density, flying, ships, grabs, knockback, clash, and activity
  interruption.
- Lifecycle changes require new/load/login/logout/reconnect/AFK/deletion checks.
- Do not assume `usr == src` or that `src.client` exists. Guard server/NPC/disconnect paths.
- After delays, re-check mob, client, target, location, and state flags.
- Preserve saved coordinates, UI macro selection, and overlay rebuilding behavior unless
  the task explicitly changes them.
- Test with a player, NPC/no-client mob, disconnected client, and deleted target where
  relevant.
