# System index

This index reflects the active BYOND project and the ordered DME include structure.
Use it to narrow searches; it is not a replacement for reading current code.

## Foundations

- `Code/_Atom`: base atom variables, procs, and shared atom behavior.
- `Code/_Datums`: shared datum variables and foundational data types.
- `Code/_HELPERS`: defines, confirmation/input windows, and general helpers.
- `Code/Updates.dm`: update/version-related source loaded early.

Changes here can affect the entire game. Search all references and compile after every
change.

## Items

- `Code/Items/ObjectVars.dm`, `ObjectProcs.dm`, `ObjectVerbs.dm`: broad object base.
- `BuyItemSystem`: technology/magic creation lists and UI.
- `Magic`: books, elixirs, portals, scanners, pylons, spell books, and magic objects.
- `Money`: mana and resources.
- `Other`: storage, food, mining, furnaces, weights, keys, warpers, and utilities.
- `Tech`: devices, machines, armor, ships, drones, security, stations, and structures.
- `Weapons`: armor, swords, hammers, gauntlets, masks, and shared weapon procs.

Search craft-list type paths whenever adding, removing, or renaming an item.

## Map and building

- `Code/Map`: turf/area definitions, maps, icon code, building window, and map logic.
- `Code/Map/build_system`: build lists, upgrades, and grid placement.
- Included `.dmm` maps: primary world content. Do not hand-edit broadly.
- `Code/Modules/World/icon_defs`: object/turf resource definitions.

## Mob and player

- `MobVars.dm`: broad player state.
- `MobProcs.dm`: shared player behavior.
- `MobMovement.dm`, `MobBump.dm`: movement and collision.
- `LogInOut.dm`: connection lifecycle.
- `StatusLoop.dm`: repeated player status work.
- `Topic.dm`: BYOND topic handling.
- `Verbs`: player commands and UI macros.
- `Windows`: information/profile browser output.

## Modules

- `Admin`: ranks, privileged verbs, logging, server control, jumps, heals, and wipe tools.
- `Afterlife`, `Anger`, `Artifacts`, `DragonBalls`, `EC`, `FBM`, `GodKi`, `KarmaSystem`,
  `Milestones`, `Mind`: progression and setting-specific systems.
- `BanSystem`: bans and related persisted state.
- `CharacterCreation`: races, stats, body/icon choices, mating, reincarnation.
- `Clicking`: click and double-click behavior.
- `Cloth`, `ItemsPlus`, `Tooltips`: item presentation and durability/tooltips.
- `Comms`: OOC/IC communication, contacts, profiles, languages, text handling.
- `CookingSystem`, `Farming`, `Fishing`, `MiningSystem`, `Training`, `Learning`:
  gathering, crafting, training, and progression loops.
- `Debug`, `TestServer`: diagnostic/test-only behavior; keep isolated from production.
- `Discord`: HTTP posting and webhook integrations.
- `Enviroment`: world objects/turfs, regeneration, nature, water, and update loops.
- `Gravity`: gravity variables and procs.
- `HealthSystem`: limbs, injuries, drugs, mutations, and willpower.
- `Lib`: A*, sorting, file dialogs, events, and scheduler infrastructure.
- `NPC`: NPC behavior and loops.
- `SaveSystem`: character, item, turf, map, and world persistence.
- `Sense`: sensing updates.
- `spam_filter`: filtering and muting.
- `SpecialEffects`: image effects/pools, lighting, screens, destruction, status bars.
- `Status`: RP mode, crowd control, and debuffs.
- `Tabs`: inventory and stats UI.
- `Taxes`, `Teams&Factions`: economy and group state.
- `World`: global settings, startup, years, story, logging, areas, and world procs.

## Skills

- `!CombatSettings`: safety checks, formulas, traits, cooldowns, and base skill model.
- `Attack`: normal attacks, grabs, and attack stages/rolls.
- `Buffs/Others`: general combat modes and stat modifiers.
- `Buffs/Racials`: race forms and transformations.
- `Buffs/UniqueBuffs`: named high-impact buffs/forms.
- `Ki`: projectiles, beams, and tiered energy attacks.
- `Meele`: tiered melee skills. Preserve the existing directory spelling.
- `MPSkills`: milestone-point skills.
- `Support`: general, magic, tech, and tiered support skills.
- `Sword`: tiered sword skills.

## UI and resources

- `RT.dmf`: native UI definition and macro/control IDs.
- `assets`: browser-facing HTML/CSS/JS.
- `Icons`, `Fonts`, sound files: binary resources referenced by source literals.

## Runtime data

- `Data/Saves`: serialized player state and backups.
- `Data/Logs`: runtime logs.
- Other `Data` files: bans, admins, world settings, serials, and databases.

Runtime data is not source and must not be inspected by default.
