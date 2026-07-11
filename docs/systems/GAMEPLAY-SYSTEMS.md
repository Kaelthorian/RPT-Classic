# Gameplay systems: combat, skills, characters, and items

## Purpose and scope

This guide groups tightly coupled gameplay type families: character/stat state,
combat and damage, skills/buffs/resources, health/body parts, and inventory.
Balance values are intentionally not summarized.

## Main flows and key code

- Character creation: `New_Character`, race/stat/appearance selection, and
  `Location()` are distributed across `Code/Modules/CharacterCreation/`, chiefly
  `new_character.dm`, `Assign Race Stats.dm`, `Better Races - No Size.dm`, and
  `Stat Points.dm`. Inputs are DMF dialogs/verbs; output is a savable
  `/mob/player` with contents, stats, location, and `HasCreated` state.
- Combat: `mob/verb/Attack()` in `Code/Skills/Attack/AttackNew.dm:1` enters attack
  logic built from `Attack.dm` and `AttackProcs/`; formulas and shared gates live
  in `Code/Skills/!CombatSettings/`. Outputs mutate health, ki, attack/cooldown,
  KO/knockback, combat messages, and effects.
- Skills: `/Skill`, `/Skill/Attacks`, and `/Skill/Buff` in
  `!CombatSettings/Skills.dm` provide the base. Tier/family files specialize
  costs, cooldowns, requirements, and behavior. `CombatSettings.dm` holds much
  shared mob/skill state; `StatMults.dm` manages multipliers.
- Health: `/BodyPart` and limb/injury logic live in
  `Code/Modules/HealthSystem/`; willpower and drugs extend the player state.
- Items: `/obj/items` variables/procs/verbs start in `Code/Items/Object*.dm`.
  Inventory display is `Code/Modules/Tabs/Inventory System.dm`; equipment is
  commonly represented by `suffix=="*Equipped*"` and reconstructed on load by
  `rebuildOverlays()` in `Better Saves.dm:66`.

## Interfaces, dependencies, and invariants

Inputs are player verbs, skill objects in mob contents, item verbs, targets,
world time, and admin grants. Outputs include persistent mob/item state, overlays,
combat/UI messages, spawned projectiles/effects, and logs. These systems depend
on `Players`, world caps/toggles, movement gates, save serialization, body parts,
and named DMF controls.

Important invariants include one coherent `attacking`/cooldown state; valid
positive stat modifiers; buffs reversing the same multipliers they apply;
equipped contents matching overlays; and save migrations running once according
to `SAVEFILE_VERSION`. Because types are reopened widely, inspect every override
and consumer before edits.

## Risks and validation

`CapStats2()` in `Better Saves.dm:118-124` compares each positive modifier to a
multiple of itself, making intended caps unreachable under normal positive
values (GAME-001). Numerous asynchronous `spawn()` resets mean combat changes
need runtime overlap/disconnect tests. Validate attack hit/dodge/KO, resource
drain, cooldown release, buff apply/remove, limb injury/healing, equip/drop/load,
and migration from representative synthetic save versions—never real saves.

Search terms: `Attack(`, `attacking`, `Refire`, `KO(`, `Damage`, `Skill/Attacks`,
`Skill/Buff`, `Using`, `InCD`, `BodyPart`, `Reset_StatMultipliers`, `obj/items`,
`*Equipped*`, `Inventory`, `New_Character`, `SAVEFILE_VERSION`.
