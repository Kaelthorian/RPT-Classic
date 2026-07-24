# Instructions for `Code/Items`

- Read `ObjectVars.dm`, `ObjectProcs.dm`, and `ObjectVerbs.dm` when changing shared item
  behavior; subtype behavior may depend on those broad definitions.
- Search buy/crafting lists for every concrete type path that is added, renamed,
  disabled, or removed.
- Treat type paths, `Savable`, item serials, builder fields, location, cost, durability,
  equipment `suffix`, and overlay state as persistence/compatibility contracts.
- Verify create, equip, unequip, use, interrupt, destroy, durability, and save/load paths.
- Check combat formulas when changing weapons, armor, gauntlets, barriers, or equipment
  multipliers.
- Do not rebalance cost, stats, limits, or crafting time during a bug/maintenance task.
- Use synthetic owners and savefiles; never inspect real item/player data.
