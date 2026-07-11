mob/var/BaseBuffCounter
/*
mob/verb/SkillPurchase()
	set category=null
	var/list/ListOfSkills=list()
	if(locate(/obj/items/Artifact) in usr)
		usr<<"You can not open the EXP window while holding an artifact."
		return

//Magic Skills

//Tier 2
	if(!(locate(/Skill/Attacks/T2/Barrage)in usr)&&(locate(/Skill/Attacks/T1/Blast)in usr)) ListOfSkills+="Blast -> Barrage (220 EXP)(Force)"

	if(!(locate(/Skill/Attacks/T2/GuideBomb)in usr)&&(locate(/Skill/Attacks/T1/Charge)in usr)) ListOfSkills+="Charge -> Guide Bomb (220 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T2/SpiritBall)in usr)&&(locate(/Skill/Attacks/T1/Charge)in usr)) ListOfSkills+="Charge -> Spirit Ball (220 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T2/ExplosiveWave)in usr)&&(locate(/Skill/Attacks/T1/Charge)in usr)) ListOfSkills+="Charge -> Explosive Wave (220 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T2/Mortar_Charge)in usr)&&(locate(/Skill/Attacks/T1/Charge)in usr)) ListOfSkills+="Charge -> Mortar Charge (220 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T2/DestructoDisc)in usr)&&(locate(/Skill/Attacks/T1/Charge)in usr)) ListOfSkills+="Charge -> Destructo Disc (220 EXP)(Force)"
	if(!(locate(/Skill/Unarmed/T2/RoundhouseKick)in usr)&&(locate(/Skill/Unarmed/T1/QuickJab)in usr)) ListOfSkills+="QuickJab -> RoundhouseKick (220 EXP)"

	if(!(locate(/Skill/Weapon/T2/Riposte)in usr)&&(locate(/Skill/Weapon/T1/Slice)in usr)) ListOfSkills+="Slice -> Riposte (220 EXP)"
	if(!(locate(/Skill/Unarmed/T2/CatchTheBlade)in usr)&&(locate(/Skill/Unarmed/T1/QuickJab)in usr)) ListOfSkills+="QuickJab -> Catch The Blade (220 EXP)(Unarmed)"


	if(!(locate(/Skill/Attacks/T1/RockSlide)in usr)&&(locate(/Skill/Attacks/T1/RockThrow)in usr)) ListOfSkills+="Rock Throw -> Rock Slide (220 EXP)(Strength)"

	if(!(locate(/Skill/Misc/T2/KiBlade)in usr)&&(locate(/Skill/Misc/T1/KiFists)in usr)) ListOfSkills+="Ki Fists -> Ki Blade (220 EXP)(Force)"
//	if(!(locate(/Skill/Misc/KiBow)in usr)&&(locate(/Skill/Misc/T1/KiFists)in usr)) ListOfSkills+="Ki Fists -> Ki Bow (220 EXP)(Force)"

	if(!(locate(/Skill/Unarmed/T2/Headbutt)in usr)&&(locate(/Skill/Weapon/T1/Bash)in usr)) ListOfSkills+="Bash -> Headbutt (220 EXP)(Strength)"

	if(!(locate(/Skill/Unarmed/T2/PressurePunch)in usr)&&(locate(/Skill/Attacks/T1/Shockwave)in usr)) ListOfSkills+="Shockwave -> Pressure Punch (220 EXP)(Strength)"

	if(!(locate(/Skill/Weapon/T2/SwordStab)in usr)&&(locate(/Skill/Weapon/T1/Slice)in usr)) ListOfSkills+="Slice -> Sword Stab (220 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T2/CleaveAttack)in usr)&&(locate(/Skill/Weapon/T1/Slice)in usr)) ListOfSkills+="Slice -> Cleave Attack (220 EXP)(Weapon)"
	if(!(locate(/Skill/Attacks/T2/EchoingSlash)in usr)&&(locate(/Skill/Weapon/T1/Slice)in usr)) ListOfSkills+="Slice -> Echoing Slash (220 EXP)(Weapon)"

	if(!(locate(/Skill/Unarmed/T2/UppercutCombo)in usr)&&(locate(/Skill/Unarmed/DashAttack)in usr)) ListOfSkills+="Dash Attack -> Uppercut Combo (220 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T2/PressurePunch)in usr)&&(locate(/Skill/Zanzoken)in usr)) ListOfSkills+="Zanzoken -> Pressure Punch (220 EXP)(Strength)"
	if(!(locate(/Skill/Unarmed/T2/MegatonThrow)in usr)&&(locate(/Skill/Zanzoken)in usr)) ListOfSkills+="Zanzoken -> Megaton Throw (220 EXP)(Unarmed)"

	if(!(locate(/Skill/Unarmed/T2/TelekineticPull)in usr)&&(locate(/Skill/Unarmed/T1/WarpAttack)in usr)) ListOfSkills+="Warp Attack -> Telekinetic Pull (220 EXP)(Strength)"
	if(!(locate(/Skill/Zanzoken)in usr)&&(locate(/Skill/Unarmed/T1/WarpAttack)in usr)) ListOfSkills+="Warp Attack -> Zanzoken (220 EXP)"

	if(!(locate(/Skill/Support/Heal)in usr)&&(locate(/Skill/Buff/Power_Control)in usr)) ListOfSkills+="Power Control -> Heal (220 EXP)"



//Tier 3
	if(!(locate(/Skill/Attacks/T3/Homing_Finisher)in usr)&&(locate(/Skill/Attacks/T2/Barrage)in usr)) ListOfSkills+="Barrage -> Homing Finisher (440 EXP)(Force)"

	if(!(locate(/Skill/Attacks/T3/MegaBurst)in usr)&&(locate(/Skill/Attacks/T2/GuideBomb)in usr)) ListOfSkills+="Guide Bomb -> MegaBurst (440 EXP)(Force)"
//	if(!(locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)&&(locate(/Skill/Attacks/T2/GuideBomb)in usr)) ListOfSkills+="Guide Bomb -> Custom Beam (440 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T3/SolarFlare)in usr)&&(locate(/Skill/Attacks/T2/GuideBomb)in usr)) ListOfSkills+="Guide Bomb -> Solar Flare (440 EXP)"

	if(!(locate(/Skill/Attacks/T3/MegaBurst) in usr)&&(locate(/Skill/Attacks/T2/SpiritBall)in usr)) ListOfSkills+="Spirit Ball -> MegaBurst (440 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T3/SolarFlare) in usr)&&(locate(/Skill/Attacks/T2/SpiritBall)in usr)) ListOfSkills+="Spirit Ball -> Solar Flare (440 EXP)"
//	if(!(locate(/Skill/Attacks/Beams/Ray) in usr)&&(locate(/Skill/Attacks/T2/SpiritBall)in usr)) ListOfSkills+="Spirit Ball -> Ray (440 EXP)(Force)"

	if(!(locate(/Skill/Attacks/T3/MegaBurst) in usr)&&(locate(/Skill/Attacks/T2/ExplosiveWave)in usr)) ListOfSkills+="Explosive Wave -> MegaBurst (440 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T3/Explosion) in usr)&&(locate(/Skill/Attacks/T2/ExplosiveWave)in usr)) ListOfSkills+="Explosive Wave -> Explosion (440 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T3/Self_Destruct) in usr)&&(locate(/Skill/Attacks/T2/ExplosiveWave)in usr)) ListOfSkills+="Explosive Wave -> Self Destruct (440 EXP)(Offense)"

	if(!(locate(/Skill/Attacks/T3/MegaBurst) in usr)&&(locate(/Skill/Attacks/T2/Mortar_Charge)in usr)) ListOfSkills+="Mortar Charge -> MegaBurst (440 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T3/Explosion) in usr)&&(locate(/Skill/Attacks/T2/Mortar_Charge)in usr)) ListOfSkills+="Mortar Charge -> Explosion (440 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T3/SolarFlare) in usr)&&(locate(/Skill/Attacks/T2/Mortar_Charge)in usr)) ListOfSkills+="Mortar Charge -> Solar Flare (440 EXP)"

	if(!(locate(/Skill/Attacks/T3/MegaBurst) in usr)&&(locate(/Skill/Attacks/T2/DestructoDisc)in usr)) ListOfSkills+="Destructo Disc -> MegaBurst (440 EXP)(Force)"
	if(!(locate(/Skill/Attacks/T3/SolarFlare) in usr)&&(locate(/Skill/Attacks/T2/DestructoDisc)in usr)) ListOfSkills+="Destructo Disc -> Solar Flare (440 EXP)"
//	if(!(locate(/Skill/Attacks/Beams/Ray) in usr)&&(locate(/Skill/Attacks/T2/DestructoDisc)in usr)) ListOfSkills+="Destructo Disc -> Ray (440 EXP)(Force)"


	if(!(locate(/Skill/Unarmed/T3/Guard_Break) in usr)&&(locate(/Skill/Unarmed/T2/CatchTheBlade)in usr)) ListOfSkills+="Catch The Blade -> Guard Break (440 EXP)(Melee)"
	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Unarmed/T2/CatchTheBlade)in usr)) ListOfSkills+="Catch The Blade -> Expand (440 EXP)"
	if(!(locate(/Skill/Unarmed/T3/Guard_Break) in usr)&&(locate(/Skill/Weapon/T2/Riposte)in usr)) ListOfSkills+="Riposte -> Guard Break (440 EXP)(Melee)"
	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Weapon/T2/Riposte)in usr)) ListOfSkills+="Riposte -> Expand (440 EXP)"

	if(!(locate(/Skill/Unarmed/T2/PileDriver) in usr)&&(locate(/Skill/Weapon/T2/SwordStab)in usr)) ListOfSkills+="Sword Stab -> Pile Driver (440 EXP)(Unarmed)"
	if(!(locate(/Skill/Weapon/T3/Iai_Slash) in usr)&&(locate(/Skill/Weapon/T2/SwordStab)in usr)) ListOfSkills+="Sword Stab -> Iai Slash (440 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T3/Colossal_Impact)in usr)&&(locate(/Skill/Weapon/T2/SwordStab)in usr)) ListOfSkills+="Sword Stab -> Colossal Impact (440 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T3/Overhead_Smash)in usr)&&(locate(/Skill/Weapon/T2/SwordStab)in usr)) ListOfSkills+="Sword Stab -> Overhead Smash (440 EXP)(Weapon)"

	if(!(locate(/Skill/Weapon/T3/Wind_Howl) in usr)&&(locate(/Skill/Weapon/T2/CleaveAttack)in usr)) ListOfSkills+="Cleave Attack -> Wind Howl (440 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T3/Colossal_Impact)in usr)&&(locate(/Skill/Weapon/T2/CleaveAttack)in usr)) ListOfSkills+="Cleave Attack -> Colossal Impact (440 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T3/Overhead_Smash)in usr)&&(locate(/Skill/Weapon/T2/CleaveAttack)in usr)) ListOfSkills+="Cleave Attack -> Overhead Smash (440 EXP)(Weapon)"

	if(!(locate(/Skill/Weapon/T3/Colossal_Impact)in usr)&&(locate(/Skill/Attacks/T2/EchoingSlash)in usr)) ListOfSkills+="Echoing Slash -> Colossal Impact (440 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T3/Wind_Howl) in usr)&&(locate(/Skill/Attacks/T2/EchoingSlash)in usr)) ListOfSkills+="Echoing Slash -> Wind Howl (440 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T3/Overhead_Smash)in usr)&&(locate(/Skill/Attacks/T2/EchoingSlash)in usr)) ListOfSkills+="Echoing Slash -> Overhead Smash (440 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T3/Iai_Slash) in usr)&&(locate(/Skill/Attacks/T2/EchoingSlash)in usr)) ListOfSkills+="Echoing Slash -> Iai Slash (440 EXP)(Weapon)"

	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Attacks/T1/RockSlide)in usr)) ListOfSkills+="Rock Slide -> Expand (440 EXP)"
	if(!(locate(/Skill/Attacks/T3/RockTomb) in usr)&&(locate(/Skill/Attacks/T1/RockSlide)in usr)) ListOfSkills+="Rock Slide -> Rock Tomb (440 EXP)(Strength)"

	if(!(locate(/Skill/Unarmed/T2/PileDriver) in usr)&&(locate(/Skill/Unarmed/T2/UppercutCombo)in usr)) ListOfSkills+="Uppercut Combo -> Pile Driver (440 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T3/Kickback_Combo) in usr)&&(locate(/Skill/Unarmed/T2/UppercutCombo)in usr)) ListOfSkills+="Uppercut Combo -> Kickback Combo (440 EXP)(Melee)"
	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Unarmed/T2/UppercutCombo)in usr)) ListOfSkills+="Uppercut Combo -> Expand (440 EXP)"

	if(!(locate(/Skill/Attacks/T3/Earthquake) in usr)&&(locate(/Skill/Unarmed/T2/MegatonThrow)in usr)) ListOfSkills+="Megaton Throw -> Earthquake (440 EXP)(Strength)"
	if(!(locate(/Skill/Unarmed/T2/PileDriver) in usr)&&(locate(/Skill/Unarmed/T2/MegatonThrow)in usr)) ListOfSkills+="Megaton Throw -> Pile Driver (440 EXP)(Unarmed)"
	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Unarmed/T2/MegatonThrow)in usr)) ListOfSkills+="Megaton Throw -> Expand (440 EXP)"

	if(!(locate(/Skill/Unarmed/T3/Wing_Clip) in usr)&&(locate(/Skill/Unarmed/T2/TelekineticPull)in usr)) ListOfSkills+="Telekinetic Pull -> Wing Clip (440 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T3/Wing_Clip) in usr)&&(locate(/Skill/Unarmed/T2/PressurePunch)in usr)) ListOfSkills+="Pressure Punch -> Wing Clip (440 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T3/Kickback_Combo) in usr)&&(locate(/Skill/Unarmed/T2/PressurePunch)in usr)) ListOfSkills+="Pressure Punch -> Kickback Combo (440 EXP)(Melee)"

	if(!(locate(/Skill/Support/Splitform) in usr)&&(locate(/Skill/Support/Heal)in usr)) ListOfSkills+="Heal -> Splitform (440 EXP)"
	if(!(locate(/Skill/Support/Send_Energy) in usr)&&(locate(/Skill/Support/Heal)in usr)) ListOfSkills+="Heal -> Send Energy (440 EXP)"



	if(!(locate(/Skill/Misc/T3/KiHammer)in usr)&&(locate(/Skill/Misc/T2/KiBlade)in usr)) ListOfSkills+="Ki Blade -> Ki Hammer (440 EXP)(Force)"
//	if(!(locate(/Skill/Misc/KiBow2)in usr)&&(locate(/Skill/Misc/KiBow)in usr)) ListOfSkills+="Ki Bow -> Ki Bow 2 (440 EXP)(Force)"
//	if(!(locate(/Skill/Attacks/Block_The_Sky)in usr)&&(locate(/Skill/Misc/KiBow)in usr)) ListOfSkills+="Ki Bow -> Block The Sky (440 EXP)(Ki Bow)"
//	if(!(locate(/Skill/Attacks/Exploding_Bolt)in usr)&&(locate(/Skill/Misc/KiBow)in usr)) ListOfSkills+="Ki Bow -> Exploding Bolt (440 EXP)(Ki Bow)"


//Tier 4

	if(!(locate(/Skill/Attacks/T1/Blaster_Meteor) in usr)&&(locate(/Skill/Attacks/T3/Homing_Finisher)in usr)) ListOfSkills+="Homing Finisher -> Blaster Meteor (880 EXP)(Force)"
	if(!(locate(/Skill/Attacks/Genocide) in usr)&&(locate(/Skill/Attacks/T3/Homing_Finisher)in usr)) ListOfSkills+="Homing Finisher -> Genocide (880 EXP)(Force)"
//	if(!(locate(/Skill/Attacks/Hellzone_Grenade) in usr)&&(locate(/Skill/Attacks/T3/Homing_Finisher)in usr)) ListOfSkills+="Homing Finisher -> Hellzone Grenade (880 EXP)(Force)"
	if(!(locate(/Skill/Attacks/ExplosiveDemonWave) in usr)&&(locate(/Skill/Attacks/T3/Homing_Finisher)in usr)) ListOfSkills+="Homing Finisher -> Explosive Demon Wave (880 EXP)(Force)"


	if(!(locate(/Skill/Attacks/Dragon_Nova) in usr)&&(locate(/Skill/Attacks/T3/MegaBurst)in usr)) ListOfSkills+="MegaBurst -> Dragon Nova (880 EXP)(Force)"
	if(!(locate(/Skill/Attacks/Death_Ball) in usr)&&(locate(/Skill/Attacks/T3/MegaBurst)in usr)) ListOfSkills+="MegaBurst -> Death Ball (880 EXP)(Force)"
	if(!(locate(/Skill/Attacks/SpiritBomb) in usr)&&(locate(/Skill/Attacks/T3/MegaBurst)in usr)) ListOfSkills+="MegaBurst -> Spirit Bomb (880 EXP)(Offense)"
	if(!(locate(/Skill/Attacks/WallofFlame) in usr)&&(locate(/Skill/Attacks/T3/MegaBurst)in usr)) ListOfSkills+="MegaBurst -> Wall Of Flame (880 EXP)"

	if(!(locate(/Skill/Attacks/WallofFlame) in usr)&&(locate(/Skill/Attacks/T3/SolarFlare)in usr)) ListOfSkills+="Solar Flare -> Wall Of Flame (880 EXP)"
	if(!(locate(/Skill/Unarmed/T4/PocketSand) in usr)&&(locate(/Skill/Attacks/T3/SolarFlare)in usr)) ListOfSkills+="Solar Flare -> Pocket Sand (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/Exploding_Heart_Strike) in usr)&&(locate(/Skill/Attacks/T3/SolarFlare)in usr)) ListOfSkills+="Solar Flare -> Exploding Heart Strike (880 EXP)(Unarmed)"


	if(!(locate(/Skill/Attacks/TriBeam) in usr)&&(locate(/Skill/Attacks/T3/Explosion)in usr)) ListOfSkills+="Explosion -> TriBeam (880 EXP)(Force)"
	if(!(locate(/Skill/Attacks/SuperExplosiveWave) in usr)&&(locate(/Skill/Attacks/T3/Explosion)in usr)) ListOfSkills+="Explosion -> Super Explosive Wave (880 EXP)(Offense)"
	if(!(locate(/Skill/Attacks/ExplosiveDemonWave) in usr)&&(locate(/Skill/Attacks/T3/Explosion)in usr)) ListOfSkills+="Explosion -> Explosive Demon Wave (880 EXP)(Force)"
//	if(!(locate(/Skill/Attacks/Hellzone_Grenade) in usr)&&(locate(/Skill/Attacks/T3/Explosion)in usr)) ListOfSkills+="Explosion -> Hellzone Grenade (880 EXP)(Force)"

	if(!(locate(/Skill/Unarmed/T4/WolfFangFist) in usr)&&(locate(/Skill/Unarmed/T3/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Wolf Fang Fist (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/ConsecutiveNormalPunches) in usr)&&(locate(/Skill/Unarmed/T3/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Consecutive Normal Punches (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/Texas_Smash) in usr)&&(locate(/Skill/Unarmed/T3/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Texas Smash (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/AxeKick) in usr)&&(locate(/Skill/Unarmed/T3/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Axe Kick (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/Lions_Roar) in usr)&&(locate(/Skill/Unarmed/T3/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Lions Roar (880 EXP)(Unarmed)"


	if(!(locate(/Skill/Attacks/TriBeam) in usr)&&(locate(/Skill/Attacks/T3/Self_Destruct)in usr)) ListOfSkills+="Self Destruct -> TriBeam (880 EXP)(Force)"
	if(!(locate(/Skill/Unarmed/T4/Lions_Roar) in usr)&&(locate(/Skill/Attacks/T3/Self_Destruct)in usr)) ListOfSkills+="Self Destruct -> Lions Roar (880 EXP)(Unarmed)"


	if(!(locate(/Skill/Unarmed/T4/ConsecutiveNormalPunches) in usr)&&(locate(/Skill/Unarmed/T3/Guard_Break)in usr)) ListOfSkills+="Guard Break -> Consecutive Normal Punches (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/Texas_Smash) in usr)&&(locate(/Skill/Unarmed/T3/Guard_Break)in usr)) ListOfSkills+="Guard Break -> Texas Smash (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/CriticalEdge) in usr)&&(locate(/Skill/Unarmed/T3/Guard_Break)in usr)) ListOfSkills+="Guard Break -> Critical Edge (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/AxeKick) in usr)&&(locate(/Skill/Unarmed/T3/Guard_Break)in usr)) ListOfSkills+="Guard Break -> Axe Kick (880 EXP)(Melee)"


	if(!(locate(/Skill/Unarmed/T4/Texas_Smash) in usr)&&(locate(/Skill/Buff/Expand)in usr)) ListOfSkills+="Expand -> Texas Smash (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/CriticalEdge) in usr)&&(locate(/Skill/Buff/Expand)in usr)) ListOfSkills+="Expand -> Critical Edge (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/AxeKick) in usr)&&(locate(/Skill/Buff/Expand)in usr)) ListOfSkills+="Expand -> Axe Kick (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/Lions_Roar) in usr)&&(locate(/Skill/Buff/Expand)in usr)) ListOfSkills+="Expand -> Lions Roar (880 EXP)(Unarmed)"

	if(!(locate(/Skill/Unarmed/T4/BurningShot) in usr)&&(locate(/Skill/Unarmed/T2/PileDriver)in usr)) ListOfSkills+="Pile Driver -> Burning Shot (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/WolfFangFist) in usr)&&(locate(/Skill/Unarmed/T2/PileDriver)in usr)) ListOfSkills+="Pile Driver -> Wolf Fang Fist (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/MarchOfFury) in usr)&&(locate(/Skill/Unarmed/T2/PileDriver)in usr)) ListOfSkills+="Pile Driver -> March Of Fury (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/Exploding_Heart_Strike) in usr)&&(locate(/Skill/Unarmed/T2/PileDriver)in usr)) ListOfSkills+="Pile Driver -> Exploding Heart Strike (880 EXP)(Unarmed)"


	if(!(locate(/Skill/Attacks/T4/SkyBreak) in usr)&&(locate(/Skill/Weapon/T3/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> Sky Break (880 EXP)(Weapon)"
	if(!(locate(/Skill/Unarmed/T4/MarchOfFury) in usr)&&(locate(/Skill/Weapon/T3/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> March Of Fury (880 EXP)(Melee)"
	if(!(locate(/Skill/Weapon/T4/Flourish) in usr)&&(locate(/Skill/Weapon/T3/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> Flourish (880 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T4/BurningSlash) in usr)&&(locate(/Skill/Weapon/T3/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> Burning Slash (880 EXP)(Weapon)"


	if(!(locate(/Skill/Attacks/T4/SkyBreak) in usr)&&(locate(/Skill/Weapon/T3/Colossal_Impact)in usr)) ListOfSkills+="Colossal Impact -> Sky Break (880 EXP)(Weapon)"
	if(!(locate(/Skill/Attacks/HyperTornado) in usr)&&(locate(/Skill/Weapon/T3/Colossal_Impact)in usr)) ListOfSkills+="Colossal Impact -> Hyper Tornado (880 EXP)(Speed)"
	if(!(locate(/Skill/Weapon/T4/Flourish) in usr)&&(locate(/Skill/Weapon/T3/Colossal_Impact)in usr)) ListOfSkills+="Colossal Impact -> Flourish (880 EXP)(Weapon)"


	if(!(locate(/Skill/Attacks/KillDriver) in usr)&&(locate(/Skill/Unarmed/T3/Wing_Clip)in usr)) ListOfSkills+="Wing Clip  -> Kill Driver (880 EXP)"
	if(!(locate(/Skill/Attacks/HyperTornado) in usr)&&(locate(/Skill/Unarmed/T3/Wing_Clip)in usr)) ListOfSkills+="Wing Clip -> Hyper Tornado (880 EXP)(Speed)"
	if(!(locate(/Skill/Unarmed/T4/CriticalEdge) in usr)&&(locate(/Skill/Unarmed/T3/Wing_Clip)in usr)) ListOfSkills+="Wing Clip -> Critical Edge (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/PocketSand) in usr)&&(locate(/Skill/Unarmed/T3/Wing_Clip)in usr)) ListOfSkills+="Wing Clip -> Pocket Sand (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/Exploding_Heart_Strike) in usr)&&(locate(/Skill/Unarmed/T3/Wing_Clip)in usr)) ListOfSkills+="Wing Clip -> Exploding Heart Strike (880 EXP)(Unarmed)"


	if(!(locate(/Skill/Unarmed/T4/MarchOfFury) in usr)&&(locate(/Skill/Attacks/T3/Earthquake)in usr)) ListOfSkills+="Earthquake -> March Of Fury (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/WolfFangFist) in usr)&&(locate(/Skill/Attacks/T3/Earthquake)in usr)) ListOfSkills+="Earthquake -> Wolf Fang Fist (880 EXP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/T4/PocketSand) in usr)&&(locate(/Skill/Attacks/T3/Earthquake)in usr)) ListOfSkills+="Earthquake -> Pocket Sand (880 EXP)(Unarmed)"

	if(!(locate(/Skill/Attacks/T4/SkyBreak) in usr)&&(locate(/Skill/Weapon/T3/Wind_Howl)in usr)) ListOfSkills+="Wind Howl -> Sky Break (880 EXP)(Weapon)"
	if(!(locate(/Skill/Attacks/HyperTornado) in usr)&&(locate(/Skill/Weapon/T3/Wind_Howl)in usr)) ListOfSkills+="Wind Howl -> Hyper Tornado (880 EXP)(Speed)"
	if(!(locate(/Skill/Weapon/T4/Flourish) in usr)&&(locate(/Skill/Weapon/T3/Wind_Howl)in usr)) ListOfSkills+="Wind Howl -> Flourish (880 EXP)(Weapon)"
	if(!(locate(/Skill/Weapon/T4/BurningSlash) in usr)&&(locate(/Skill/Weapon/T3/Wind_Howl)in usr)) ListOfSkills+="Wind Howl -> Burning Slash (880 EXP)(Weapon)"


	if(!(locate(/Skill/Attacks/SuperGhostKamikazeAttack) in usr)&&(locate(/Skill/Support/Splitform)in usr)) ListOfSkills+="Splitform -> Super Ghost Kamikaze (880 EXP)(Strength)"
	if(!(locate(/Skill/Attacks/BlueCometSpecial) in usr)&&(locate(/Skill/Support/Splitform)in usr)) ListOfSkills+="Splitform -> Blue Comet Special (880 EXP)(Speed)"

	if(!(locate(/Skill/Support/PlantSenzu) in usr)&&(locate(/Skill/Support/Send_Energy)in usr)) ListOfSkills+="Send Energy -> Plant Senzu Bean (880 EXP)"
	if(!(locate(/Skill/Support/Give_Power) in usr)&&(locate(/Skill/Support/Send_Energy)in usr)) ListOfSkills+="Send Energy -> Give Power (880 EXP)"

	if(!(locate(/Skill/Misc/SpiritSword) in usr)&&(locate(/Skill/Misc/T3/KiHammer)in usr)) ListOfSkills+="Ki Hammer -> Spirit Sword (880 EXP)(Force)"
//	if(!(locate(/Skill/Misc/KiBow3)in usr)&&(locate(/Skill/Misc/KiBow2)in usr)) ListOfSkills+="Ki Bow 2 -> Ki Bow 3 (880 EXP)(Force)"
//	if(!(locate(/Skill/Attacks/IceArrow)in usr)&&(locate(/Skill/Misc/KiBow2)in usr)) ListOfSkills+="Ki Bow 2 -> Ice Arrow (880 EXP)(Ki Bow/Slows)"


	if(!(locate(/Skill/Unarmed/T4/Torrential_Strike) in usr)&&(locate(/Skill/Unarmed/T3/Wing_Clip)in usr)) ListOfSkills+="Wing Clip  -> Torrential Strike (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/Torrential_Strike) in usr)&&(locate(/Skill/Weapon/T3/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> Torrential Strike (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/Torrential_Strike) in usr)&&(locate(/Skill/Unarmed/T2/PileDriver)in usr)) ListOfSkills+="Pile Driver -> Torrential Strike (880 EXP)(Melee)"
	if(!(locate(/Skill/Unarmed/T4/Torrential_Strike) in usr)&&(locate(/Skill/Attacks/T3/SolarFlare)in usr)) ListOfSkills+="Solar Flare -> Torrential Strike (880 EXP)(Melee)"




//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Dodompa (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Dodompa (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Final Flash (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Final Flash (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Galic Gun (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Galic Gun (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Kamehameha (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Kamehameha (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Masenko (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Masenko (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Piercer (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Piercer (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Double Sunday (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Double Sunday (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Photon Flash (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Photon Flash (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Tyrant Lancer (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Tyrant Lancer (880 EXP)(Force)"

//	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Buster Cannon (880 EXP)(Force)"
//	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Buster Cannon (880 EXP)(Force)"


	ListOfSkills+="Cancel"
	var/Choice=input("Which skill would you like to purchase?") in ListOfSkills
	var/Cost=220
	if(Choice=="Cancel") return
	if(findtext(Choice,"220")) Cost=220
	if(findtext(Choice,"440")) Cost=440
	if(findtext(Choice,"880")) Cost=880

	var/SkillChoice
	if(findtext(Choice,"> Barrage")) SkillChoice=/Skill/Attacks/T2/Barrage

	if(findtext(Choice,"> Guide Bomb")) SkillChoice=/Skill/Attacks/T2/GuideBomb
	if(findtext(Choice,"> Spirit Ball")) SkillChoice=/Skill/Attacks/T2/SpiritBall
	if(findtext(Choice,"> Explosive Wave")) SkillChoice=/Skill/Attacks/T2/ExplosiveWave
	if(findtext(Choice,"> Mortar Charge")) SkillChoice=/Skill/Attacks/T2/Mortar_Charge
	if(findtext(Choice,"> Destructo Disc")) SkillChoice=/Skill/Attacks/T2/DestructoDisc
	if(findtext(Choice,"> RoundhouseKick")) SkillChoice=/Skill/Unarmed/T2/RoundhouseKick

//	if(findtext(Choice,"> Ki Bow")) SkillChoice=/Skill/Misc/KiBow
//	if(findtext(Choice,"> Ki Bow 2")) SkillChoice=/Skill/Misc/KiBow2
//	if(findtext(Choice,"> Ki Bow 3")) SkillChoice=/Skill/Misc/KiBow3

//	if(findtext(Choice,"> Block The Sky")) SkillChoice=/Skill/Attacks/Block_The_Sky
//	if(findtext(Choice,"> Ice Arrow")) SkillChoice=/Skill/Attacks/IceArrow
//	if(findtext(Choice,"> Exploding Bolt")) SkillChoice=/Skill/Attacks/Exploding_Bolt

	if(findtext(Choice,"> Torrential Strike")) SkillChoice=/Skill/Unarmed/T4/Torrential_Strike



	if(findtext(Choice,"> Ki Blade")) SkillChoice=/Skill/Misc/T2/KiBlade
	if(findtext(Choice,"> Ki Hammer")) SkillChoice=/Skill/Misc/T3/KiHammer

	if(findtext(Choice,"> Texas Smash")) SkillChoice=/Skill/Unarmed/T4/Texas_Smash

	if(findtext(Choice,"> Iai Slash")) SkillChoice=/Skill/Weapon/T3/Iai_Slash

	if(findtext(Choice,"> Spirit Sword")) SkillChoice=/Skill/Misc/SpiritSword

	if(findtext(Choice,"> Burning Slash")) SkillChoice=/Skill/Weapon/T4/BurningSlash

	if(findtext(Choice,"> Kickback Combo")) SkillChoice=/Skill/Unarmed/T3/Kickback_Combo

	if(findtext(Choice,"> Headbutt")) SkillChoice=/Skill/Unarmed/T2/Headbutt

	if(findtext(Choice,"> Consecutive Normal Punches")) SkillChoice=/Skill/Unarmed/T4/ConsecutiveNormalPunches
	if(findtext(Choice,"> Flourish")) SkillChoice=/Skill/Weapon/T4/Flourish


	if(findtext(Choice,"> Catch The Blade")) SkillChoice=/Skill/Unarmed/T2/CatchTheBlade
	if(findtext(Choice,"> Riposte")) SkillChoice=/Skill/Weapon/T2/Riposte

	if(findtext(Choice,"> Sword Stab")) SkillChoice=/Skill/Weapon/T2/SwordStab
	if(findtext(Choice,"> Overhead Smash")) SkillChoice=/Skill/Weapon/T3/Overhead_Smash
	if(findtext(Choice,"> Colossal Impact")) SkillChoice=/Skill/Weapon/T3/Colossal_Impact
	if(findtext(Choice,"> Cleave Attack")) SkillChoice=/Skill/Weapon/T2/CleaveAttack
	if(findtext(Choice,"> Echoing Slash")) SkillChoice=/Skill/Attacks/T2/EchoingSlash

	if(findtext(Choice,"> Rock Slide")) SkillChoice=/Skill/Attacks/T1/RockSlide
	if(findtext(Choice,"> Rock Tomb")) SkillChoice=/Skill/Attacks/T3/RockTomb

	if(findtext(Choice,"> Pressure Punch")) SkillChoice=/Skill/Unarmed/T2/PressurePunch
	if(findtext(Choice,"> Uppercut Combo")) SkillChoice=/Skill/Unarmed/T2/UppercutCombo
	if(findtext(Choice,"> Megaton Throw")) SkillChoice=/Skill/Unarmed/T2/MegatonThrow

	if(findtext(Choice,"> Telekinetic Pull")) SkillChoice=/Skill/Unarmed/T2/TelekineticPull

	if(findtext(Choice,"> Zanzoken")) SkillChoice=/Skill/Zanzoken

	if(findtext(Choice,"> Heal")) SkillChoice=/Skill/Support/Heal

	if(findtext(Choice,"> Homing Finisher")) SkillChoice=/Skill/Attacks/T3/Homing_Finisher

	if(findtext(Choice,"> MegaBurst")) SkillChoice=/Skill/Attacks/T3/MegaBurst

//	if(findtext(Choice,"> Custom Beam")) SkillChoice=/Skill/Attacks/Beams/CustomEnergyWave

	if(findtext(Choice,"> Solar Flare")) SkillChoice=/Skill/Attacks/T3/SolarFlare

//	if(findtext(Choice,"> Ray")) SkillChoice=/Skill/Attacks/Beams/Ray

	if(findtext(Choice,"> Explosion")) SkillChoice=/Skill/Attacks/T3/Explosion

	if(findtext(Choice,"> Self Destruct")) SkillChoice=/Skill/Attacks/T3/Self_Destruct

	if(findtext(Choice,"> Guard Break")) SkillChoice=/Skill/Unarmed/T3/Guard_Break
	if(findtext(Choice,"> Critical Edge")) SkillChoice=/Skill/Unarmed/T4/CriticalEdge

	if(findtext(Choice,"> Pile Driver")) SkillChoice=/Skill/Unarmed/T2/PileDriver

	if(findtext(Choice,"> Expand")) SkillChoice=/Skill/Buff/Expand

	if(findtext(Choice,"> Earthquake")) SkillChoice=/Skill/Attacks/T3/Earthquake

	if(findtext(Choice,"> Wind Howl")) SkillChoice=/Skill/Weapon/T3/Wind_Howl

	if(findtext(Choice,"> Wing Clip")) SkillChoice=/Skill/Unarmed/T3/Wing_Clip

	if(findtext(Choice,"> Splitform")) SkillChoice=/Skill/Support/Splitform

	if(findtext(Choice,"> Send Energy")) SkillChoice=/Skill/Support/Send_Energy

	if(findtext(Choice,"> Give Power")) SkillChoice=/Skill/Support/Give_Power

	if(findtext(Choice,"> Blaster Meteor")) SkillChoice=/Skill/Attacks/T1/Blaster_Meteor

	if(findtext(Choice,"> Genocide")) SkillChoice=/Skill/Attacks/Genocide

//	if(findtext(Choice,"> Hellzone Grenade")) SkillChoice=/Skill/Attacks/Hellzone_Grenade

	if(findtext(Choice,"> Dragon Nova")) SkillChoice=/Skill/Attacks/Dragon_Nova

	if(findtext(Choice,"> Death Ball")) SkillChoice=/Skill/Attacks/Death_Ball

	if(findtext(Choice,"> Spirit Bomb")) SkillChoice=/Skill/Attacks/SpiritBomb

	if(findtext(Choice,"> Wall Of Flame")) SkillChoice=/Skill/Attacks/WallofFlame

	if(findtext(Choice,"> TriBeam")) SkillChoice=/Skill/Attacks/TriBeam

	if(findtext(Choice,"> Explosive Demon Wave")) SkillChoice=/Skill/Attacks/ExplosiveDemonWave

	if(findtext(Choice,"> Super Explosive Wave")) SkillChoice=/Skill/Attacks/SuperExplosiveWave

	if(findtext(Choice,"> Burning Shot")) SkillChoice=/Skill/Unarmed/T4/BurningShot

	if(findtext(Choice,"> Wolf Fang Fist")) SkillChoice=/Skill/Unarmed/T4/WolfFangFist

	if(findtext(Choice,"> Kill Driver")) SkillChoice=/Skill/Attacks/KillDriver

	if(findtext(Choice,"> March Of Fury")) SkillChoice=/Skill/Unarmed/T4/MarchOfFury

	if(findtext(Choice,"> Hyper Tornado")) SkillChoice=/Skill/Attacks/HyperTornado

	if(findtext(Choice,"> Super Ghost Kamikaze")) SkillChoice=/Skill/Attacks/SuperGhostKamikazeAttack

	if(findtext(Choice,"> Blue Comet Special")) SkillChoice=/Skill/Attacks/BlueCometSpecial

	if(findtext(Choice,"> Plant Senzu")) SkillChoice=/Skill/Support/PlantSenzu

	if(findtext(Choice,"> Sky Break")) SkillChoice=/Skill/Attacks/T4/SkyBreak

//	if(findtext(Choice,"> Dodompa")) SkillChoice=/Skill/Attacks/Beams/Dodompa
//	if(findtext(Choice,"> Final Flash")) SkillChoice=/Skill/Attacks/Beams/Final_Flash
//	if(findtext(Choice,"> Galic Gun")) SkillChoice=/Skill/Attacks/Beams/Galic_Gun
//	if(findtext(Choice,"> Kamehameha")) SkillChoice=/Skill/Attacks/Beams/Kamehameha
//	if(findtext(Choice,"> Masenko")) SkillChoice=/Skill/Attacks/Beams/Masenko
//	if(findtext(Choice,"> Piercer")) SkillChoice=/Skill/Attacks/Beams/Piercer
//	if(findtext(Choice,"> Double Sunday")) SkillChoice=/Skill/Attacks/Beams/Double_Sunday
//	if(findtext(Choice,"> Photon Flash")) SkillChoice=/Skill/Attacks/Beams/Photon_Flash
//	if(findtext(Choice,"> Tyrant Lancer")) SkillChoice=/Skill/Attacks/Beams/Tyrant_Lancer
//	if(findtext(Choice,"> Buster Cannon")) SkillChoice=/Skill/Attacks/Beams/Buster_Cannon


	if(findtext(Choice,"> Pocket Sand")) SkillChoice=/Skill/Unarmed/T4/PocketSand

	if(findtext(Choice,"> Axe Kick")) SkillChoice=/Skill/Unarmed/T4/AxeKick
	if(findtext(Choice,"> Exploding Heart Strike")) SkillChoice=/Skill/Unarmed/T4/Exploding_Heart_Strike
	if(findtext(Choice,"> Lions Roar")) SkillChoice=/Skill/Unarmed/T4/Lions_Roar



/*

exp tiers and it slowly goes lower and lower


*/
	if(EXP<Cost)
		usr<<"You need [Cost] for [Choice]."
		return
	if(usr.Confirm("[Choice]?"))
		EXP-=Cost
		contents+=new SkillChoice
		BuffOut("You spent [Cost] experience on [Choice].")
		saveToLog("| [usr] spent [Cost] experience on [Choice]. |")
		alertAdmins("[key_name(usr)] spent [Cost] experience on [Choice]!")

	//INT Menu
mob/verb/IntSkills()
	set category=null
	var/list/ListOfIntSkills=list()

	//Intelligence Skills
	if(!(locate(/Skill/Buff/Combat_Mathematics)in usr)&&usr.Int_Mod==2&&usr.Int_Level>=38) ListOfIntSkills+="Combat Mathematics (660 EXP)"
	if(!(locate(/Skill/Buff/Combat_Mathematics)in usr)&&usr.Int_Mod==3&&usr.Int_Level>=38) ListOfIntSkills+="Combat Mathematics (440 EXP)"
	if(!(locate(/Skill/Buff/Combat_Mathematics)in usr)&&usr.Int_Mod==4&&usr.Int_Level>=38) ListOfIntSkills+="Combat Mathematics (220 EXP)"

	if(!(locate(/Skill/Technology/Nanite_Burst)in usr)&&usr.Int_Mod==2&&usr.Int_Level>=55) ListOfIntSkills+="Nanite Burst (660 EXP)"
	if(!(locate(/Skill/Technology/Nanite_Burst)in usr)&&usr.Int_Mod==3&&usr.Int_Level>=55) ListOfIntSkills+="Nanite Burst (440 EXP)"
	if(!(locate(/Skill/Technology/Nanite_Burst)in usr)&&usr.Int_Mod==4&&usr.Int_Level>=55) ListOfIntSkills+="Nanite Burst (220 EXP)"

	if(!(locate(/Skill/Technology/Calculated_Strikes)in usr)&&usr.Int_Mod==2&&usr.Int_Level>=57) ListOfIntSkills+="Calculated Strikes (660 EXP)"
	if(!(locate(/Skill/Technology/Calculated_Strikes)in usr)&&usr.Int_Mod==3&&usr.Int_Level>=57) ListOfIntSkills+="Calculated Strikes (440 EXP)"
	if(!(locate(/Skill/Technology/Calculated_Strikes)in usr)&&usr.Int_Mod==4&&usr.Int_Level>=57) ListOfIntSkills+="Calculated Strikes (220 EXP)"

	if(!(locate(/Skill/Technology/Energy_Infusion)in usr)&&usr.Int_Mod==2&&usr.Int_Level>=68) ListOfIntSkills+="Energy Infusion (660 EXP)"
	if(!(locate(/Skill/Technology/Energy_Infusion)in usr)&&usr.Int_Mod==3&&usr.Int_Level>=68) ListOfIntSkills+="Energy Infusion (440 EXP)"
	if(!(locate(/Skill/Technology/Energy_Infusion)in usr)&&usr.Int_Mod==4&&usr.Int_Level>=68) ListOfIntSkills+="Energy Infusion (220 EXP)"

	if(!(locate(/Skill/Technology/Stungun)in usr)&&usr.Int_Mod==2&&usr.Int_Level>=61) ListOfIntSkills+="Stungun (660 EXP)"
	if(!(locate(/Skill/Technology/Stungun)in usr)&&usr.Int_Mod==3&&usr.Int_Level>=61) ListOfIntSkills+="Stungun (440 EXP)"
	if(!(locate(/Skill/Technology/Stungun)in usr)&&usr.Int_Mod==4&&usr.Int_Level>=61) ListOfIntSkills+="Stungun (220 EXP)"

	ListOfIntSkills+="Cancel"
	var/IntChoice=input("Which Intelligence Skill would you like to purchase?") in ListOfIntSkills
	var/IntCost=220
	if(IntChoice=="Cancel") return
	if(findtext(IntChoice,"220")) IntCost=220
	if(findtext(IntChoice,"440")) IntCost=440
	if(findtext(IntChoice,"660")) IntCost=660

	var/IntSkillChoice
	if(findtext(IntChoice,"Combat Mathematics")) IntSkillChoice=/Skill/Buff/Combat_Mathematics
	if(findtext(IntChoice,"Nanite Burst")) IntSkillChoice=/Skill/Technology/Nanite_Burst
	if(findtext(IntChoice,"Calculated Strikes")) IntSkillChoice=/Skill/Technology/Calculated_Strikes
	if(findtext(IntChoice,"Stungun")) IntSkillChoice=/Skill/Technology/Stungun

	if(EXP<IntCost)
		usr<<"You need [IntCost] for [IntChoice]."
		return
	if(usr.Confirm("[IntChoice]? Warning, this cannot be refunded."))
		EXP-=IntCost
		contents+=new IntSkillChoice
		BuffOut("You spent [IntCost] experience on [IntChoice].")
		saveToLog("| [usr] spent [IntCost] experience on [IntChoice]. |")
		alertAdmins("[key_name(usr)] spent [IntCost] experience on [IntChoice]!")

	//MAG menu
mob/verb/MagSkills()
	set category=null
	var/list/ListOfMagSkills=list()

	//Magic Skills
	if(!(locate(/Skill/Buff/Adaptive)in usr)&&usr.Magic_Potential==2&&usr.Magic_Level>=38) ListOfMagSkills+="Adaptive (660 EXP)"
	if(!(locate(/Skill/Buff/Adaptive)in usr)&&usr.Magic_Potential==3&&usr.Magic_Level>=38) ListOfMagSkills+="Adaptive (440 EXP)"
	if(!(locate(/Skill/Buff/Adaptive)in usr)&&usr.Magic_Potential==4&&usr.Magic_Level>=38) ListOfMagSkills+="Adaptive (220 EXP)"

	if(!(locate(/Skill/Spell/Frost_Bolt)in usr)&&usr.Magic_Potential==2&&usr.Magic_Level>=43) ListOfMagSkills+="Frost Bolt (660 EXP)"
	if(!(locate(/Skill/Spell/Frost_Bolt)in usr)&&usr.Magic_Potential==3&&usr.Magic_Level>=43) ListOfMagSkills+="Frost Bolt (440 EXP)"
	if(!(locate(/Skill/Spell/Frost_Bolt)in usr)&&usr.Magic_Potential==4&&usr.Magic_Level>=43) ListOfMagSkills+="Frost Bolt (220 EXP)"

	if(!(locate(/Skill/Spell/Fireball)in usr)&&usr.Magic_Potential==2&&usr.Magic_Level>=53) ListOfMagSkills+="Fireball (660 EXP)"
	if(!(locate(/Skill/Spell/Fireball)in usr)&&usr.Magic_Potential==3&&usr.Magic_Level>=53) ListOfMagSkills+="Fireball (440 EXP)"
	if(!(locate(/Skill/Spell/Fireball)in usr)&&usr.Magic_Potential==4&&usr.Magic_Level>=53) ListOfMagSkills+="Fireball (220 EXP)"

	if(!(locate(/Skill/Spell/Empowered_Defenses)in usr)&&usr.Magic_Potential==2&&usr.Magic_Level>=58) ListOfMagSkills+="Empowered Defenses (660 EXP)"
	if(!(locate(/Skill/Spell/Empowered_Defenses)in usr)&&usr.Magic_Potential==3&&usr.Magic_Level>=58) ListOfMagSkills+="Empowered Defenses (440 EXP)"
	if(!(locate(/Skill/Spell/Empowered_Defenses)in usr)&&usr.Magic_Potential==4&&usr.Magic_Level>=58) ListOfMagSkills+="Empowered Defenses (220 EXP)"

	if(!(locate(/Skill/Spell/Seance)in usr)&&usr.Magic_Potential==2&&usr.Magic_Level>=60) ListOfMagSkills+="Seance (660 EXP)"
	if(!(locate(/Skill/Spell/Seance)in usr)&&usr.Magic_Potential==3&&usr.Magic_Level>=60) ListOfMagSkills+="Seance (440 EXP)"
	if(!(locate(/Skill/Spell/Seance)in usr)&&usr.Magic_Potential==4&&usr.Magic_Level>=60) ListOfMagSkills+="Seance (220 EXP)"

	if(!(locate(/Skill/Spell/Empowered_Attacks)in usr)&&usr.Magic_Potential==2&&usr.Magic_Level>=62) ListOfMagSkills+="Empowered Attacks (660 EXP)"
	if(!(locate(/Skill/Spell/Empowered_Attacks)in usr)&&usr.Magic_Potential==3&&usr.Magic_Level>=62) ListOfMagSkills+="Empowered Attacks (440 EXP)"
	if(!(locate(/Skill/Spell/Empowered_Attacks)in usr)&&usr.Magic_Potential==4&&usr.Magic_Level>=62) ListOfMagSkills+="Empowered Attacks (220 EXP)"

	if(!(locate(/Skill/Spell/Frost_Nova)in usr)&&usr.Magic_Potential==2&&usr.Magic_Level>=75) ListOfMagSkills+="Frost Nova (660 EXP)"
	if(!(locate(/Skill/Spell/Frost_Nova)in usr)&&usr.Magic_Potential==3&&usr.Magic_Level>=75) ListOfMagSkills+="Frost Nova (440 EXP)"
	if(!(locate(/Skill/Spell/Frost_Nova)in usr)&&usr.Magic_Potential==4&&usr.Magic_Level>=75) ListOfMagSkills+="Frost Nova (220 EXP)"

	if(!(locate(/Skill/Spell/Advanced_Seance)in usr)&&usr.Magic_Potential==2&&usr.Magic_Level>=90) ListOfMagSkills+="Advanced Seance (660 EXP)"
	if(!(locate(/Skill/Spell/Advanced_Seance)in usr)&&usr.Magic_Potential==3&&usr.Magic_Level>=90) ListOfMagSkills+="Advanced Seance (440 EXP)"
	if(!(locate(/Skill/Spell/Advanced_Seance)in usr)&&usr.Magic_Potential==4&&usr.Magic_Level>=90) ListOfMagSkills+="Advanced Seance (220 EXP)"

	ListOfMagSkills+="Cancel"
	var/MagChoice=input("Which Magic Skill would you like to purchase?") in ListOfMagSkills
	var/MagCost=220
	if(MagChoice=="Cancel") return
	if(findtext(MagChoice,"220")) MagCost=220
	if(findtext(MagChoice,"440")) MagCost=440
	if(findtext(MagChoice,"660")) MagCost=660

	var/MagSkillChoice
	if(findtext(MagChoice,"Adaptive")) MagSkillChoice=/Skill/Buff/Adaptive
	if(findtext(MagChoice,"Frost Bolt")) MagSkillChoice=/Skill/Spell/Frost_Bolt
	if(findtext(MagChoice,"Fireball")) MagSkillChoice=/Skill/Spell/Fireball
	if(findtext(MagChoice,"Empowered Defenses")) MagSkillChoice=/Skill/Spell/Empowered_Defenses
	if(findtext(MagChoice,"Seance")) MagSkillChoice=/Skill/Spell/Seance
	if(findtext(MagChoice,"Empowered Attacks")) MagSkillChoice=/Skill/Spell/Empowered_Attacks
	if(findtext(MagChoice,"Frost Nova")) MagSkillChoice=/Skill/Spell/Frost_Nova
	if(findtext(MagChoice,"Advanced Seance")) MagSkillChoice=/Skill/Spell/Advanced_Seance

	if(EXP<MagCost)
		usr<<"You need [MagCost] for [MagChoice]."
		return
	if(usr.Confirm("[MagChoice]? Warning, this cannot be refunded."))
		EXP-=MagCost
		contents+=new MagSkillChoice
		BuffOut("You spent [MagCost] experience on [MagChoice].")
		saveToLog("| [usr] spent [MagCost] experience on [MagChoice]. |")
		alertAdmins("[key_name(usr)] spent [MagCost] experience on [MagChoice]!")
*/

mob/proc/UBCheck(showme=0)
	var/list/rrL=list()
	var/list/rL=list()
	for(var/Skill/S in src)
		if(S.Tier==2)
			if(S.UB2) rrL[S.UB2]+=1
			if(S.UB1) rrL[S.UB1]+=2
		if(S.Tier==3)
			if(S.UB2) rrL[S.UB2]+=2
			if(S.UB1) rrL[S.UB1]+=4
		if(S.Tier==4)
			if(S.UB2) rrL[S.UB2]+=4
			if(S.UB1) rrL[S.UB1]+=8
//		if(showme) src<<"[S] tier [S.Tier] [S.UB1] is the UB1 and it is at [rrL[S.UB1]] points"
	for(var/Milestone/M in src)
		if(M.PointsCost==1)
			if(M.UB2) rrL[M.UB2]+=0.5*M.Ranks
			if(M.UB1) rrL[M.UB1]+=1*M.Ranks
		if(M.PointsCost==2)
			if(M.UB2) rrL[M.UB2]+=1*M.Ranks
			if(M.UB1) rrL[M.UB1]+=2*M.Ranks
		if(M.PointsCost==3)
			if(M.UB2) rrL[M.UB2]+=1.5*M.Ranks
			if(M.UB1) rrL[M.UB1]+=3*M.Ranks
		if(M.PointsCost==4)
			if(M.UB2) rrL[M.UB2]+=2*M.Ranks
			if(M.UB1) rrL[M.UB1]+=4*M.Ranks
		if(M.PointsCost==5)
			if(M.UB2) rrL[M.UB2]+=2.5*M.Ranks
			if(M.UB1) rrL[M.UB1]+=5*M.Ranks
		if(M.PointsCost==6)
			if(M.UB2) rrL[M.UB2]+=3*M.Ranks
			if(M.UB1) rrL[M.UB1]+=6*M.Ranks
		if(M.PointsCost==7)
			if(M.UB2) rrL[M.UB2]+=3.5*M.Ranks
			if(M.UB1) rrL[M.UB1]+=7*M.Ranks
		if(M.PointsCost==8)
			if(M.UB2) rrL[M.UB2]+=4*M.Ranks
			if(M.UB1) rrL[M.UB1]+=8*M.Ranks
	if(WitnessedDeath)rrL["Death"]+=5
	if(BeenDeathAngry)rrL["Bestial Wrath"]+=15
	if(AteCorpse)rrL["Death"]+=min(10,5*AteCorpse)
	if(AteRottenCorpse)rrL["Fungal Plague"]+=min(10,5*AteCorpse)
	if(ControledCP)rrL["Shadow King"]+=min(10,5*ControledCP)
	if(DeadZoneBeen)rrL["Shadow King"]+=5
	if(UsedDrugs)rrL["Fungal Plague"]+=min(7,1*ShownMercy)
	if(ShownMercy)rrL["Shadow King"]+=min(7,1*ShownMercy)
	if(Humiliated)rrL["War"]+=min(7,1*Humiliated)
	if(CausedInjury)rrL["Fists of Fury"]+=min(7,1*CausedInjury)
	if(HasBurnedForVictory)rrL["Kaioken"]+=7
	if(HasRefusedToDie)rrL["Kaioken"]+=7
	if(HasRobbed)rrL["Fungal Plague"]+=min(10,5*HasRobbed)
	if(MadeAnAndroid)rrL["Machine Force"]+=min(15,MadeAnAndroid*5)
	if(MadeADoll)rrL["Arcane Power"]+=min(15,MadeADoll*5)
	if(HasStruggled)rrL["Bestial Wrath"]+=10
	if(HasStruggled)rrL["High Tension"]+=5
	if(HasStruggled)rrL["Death"]+=10
	if(Total_Stats_Energy>=5)rrL["Arcane Power"]+=5
	if(Total_Stats_Strength>=5)rrL["High Tension"]+=5
	if(Total_Stats_Endurance>=5)rrL["Bestial Wrath"]+=5
	if(Total_Stats_Speed>=5)rrL["Godspeed"]+=5
	if(Total_Stats_Off>=5)rrL["Fists of Fury"]+=5
	if(Total_Stats_Def>=5)rrL["Fungal Plague"]+=5
	if(Kills)rrL["Death"]+=min(15,3*Kills)
	if(Kills)rrL["War"]+=min(5,Kills)
	if(TotalDeaths)rrL["Death"]+=min(10,5*TotalDeaths)
	for(var/obj/Faction/F in src)
		rrL["Shadow King"]+=2
		break
	if(HammerOn||SwordOn) rrL["Bushido"]+=5
	if(ArmorOn) rrL["Bushido"]+=5
	if(GlovesOn) rrL["Fists of Fury"]+=5
	if(Weight>100)rrL["High Tension"]+=5
	if(HasUsedEmpowerment)rrL["High Tension"]+=5
	if(Cyber_Left_Arm) rrL["Machine Force"]+=1
	if(Cyber_Left_Leg) rrL["Machine Force"]+=1
	if(Cyber_Right_Leg) rrL["Machine Force"]+=1
	if(Cyber_Right_Arm) rrL["Machine Force"]+=1
	if(Cyber_Sight) rrL["Machine Force"]+=1
	if(Cyber_Torso) rrL["Machine Force"]+=1
	if(Z1ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z2ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z3ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z4ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z5ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z6ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z7ControllingRuler==name)rrL["Shadow King"]+=7
	if(MadeBio)rrL["Machine Force"]+=10
	if(MadeMajin)rrL["Arcane Power"]+=10
	if(PowerArmorOn)rrL["Machine Force"]+=5
	if(AndroidLevel)rrL["Machine Force"]+=5
	if(MadeSSj4)rrL["Machine Force"]+=5



	for(var/L in rrL) rL+="[L]([5600-(min(25,rrL[L])*220)])"

//	src<<"Checked Unique Buff eligibility."


	UBList= rL/*
mob/verb/ForceUBCheck()
	UBCheck()*/

/*
Bushido
Godspeed
Machine Force
Shadow King
Arcane Power
Bestial Wrath
Kaioken
Death
War
Pestilence
Channel
High Tension
Fists of Fury
*/
mob/var/list/UBList=list()
/*
mob/verb/Spend_Experience_Points()
	set category=null//"Other"
	if(usr)
		var/list/L = list("Unlock A Skill","Earn A Milestone Point(660)")

		if(!HasCustomStance && usr.EXPLifetime>330)L+="Custom Stance(Free)"

		for(var/Skill/MartialArt/MA in usr) if(MA.MasteryLevel!="Master")
			L+="Train Martial Art(200)"
			break
/*
		for(var/Skill/Weapon/Bound_Weapon/MA in usr) if(MA.PointsCan<4)
			L+="Deepen Weapon Bond(100)"
			break
*/
		if(usr.Int_Mod>=4) L+="Revive Someone(550)"
		else if(usr.Magic_Potential>=4) L+="Revive Someone(550)"

		if(usr.Int_Mod>=2) L+="Purchase an Intelligence Skill"
		if(usr.Magic_Potential>=2) L+="Purchase a Magic Skill"

		if(usr.Int_Mod>=4&&WipeDay>=41) L+="Create an SSJ4(750)"
		else if(usr.Magic_Potential>=4&&WipeDay>=41) L+="Create an SSJ4(750)"

		if(usr.Int_Mod>=4&&WipeDay>=19) L+="Story Alteration(???) (Send Ahelp)"
		else if(usr.Magic_Potential>=4&&WipeDay>=19) L+="Story Alteration(???) (Send Ahelp)"

		if(usr.Int_Mod>=2) L+="Purchase an Intelligence Skill"
		if(usr.Magic_Potential>=2) L+="Purchase a Magic Skill"

		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MuscleForce)in usr)&&(usr.BaseBuffCounter<2)) L+="Muscle Force(0)"
		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MuscleForce)in usr)&&(usr.BaseBuffCounter>=2)) L+="Muscle Force(275)"

		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MassForce)in usr)&&(usr.BaseBuffCounter<2)) L+="Mass Force(0)"
		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MassForce)in usr)&&(usr.BaseBuffCounter>=2)) L+="Mass Force(275)"

		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MirageForce)in usr)&&(usr.BaseBuffCounter<2)) L+="Mirage Force(0)"
		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MirageForce)in usr)&&(usr.BaseBuffCounter>=2)) L+="Mirage Force(275)"

		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MangleForce)in usr)&&(usr.BaseBuffCounter<2)) L+="Mangle Force(0)"
		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MangleForce)in usr)&&(usr.BaseBuffCounter>=2)) L+="Mangle Force(275)"

		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MagicForce)in usr)&&(usr.BaseBuffCounter<2)) L+="Magic Force(0)"
		if((WipeDay>=7)&&!(locate(/Skill/Buff/T1/MagicForce)in usr)&&(usr.BaseBuffCounter>=2)) L+="Magic Force(275)"



//		if(locate(/obj/Faction) in usr&&(!locate(/Skill/Misc/FactionLeaderCommands) in usr)) L+="Faction Charter(300) (Faction Leader Commands)"


		if(!(locate(/Skill/Buff/LimitBreaker) in usr)&&!usr.EnablementSlot) L+="Limit Breaker(500)"

		if(usr.Int_Mod>=5 && WipeDay>=10) L+="Create a Bio-Android(500)"
		if(usr.Magic_Potential>=5 && WipeDay>=10) L+="Majinize(500)"
		if(usr.Int_Mod>=1) L+="Become LSSJ (15'000)"
//		if(usr.Magic_Potential>=4) L+="Create a Majin(1000)"

	//	if(!(locate(/Skill/Buff/Ascend) in usr)&&FBMAchieved) L+="Ascend(1200)"

//		if(!(locate(/Skill/FusionDance) in usr)) L+="Fusion Dance(2000)"


		L+=UBList


		L+="Cancel"
		var/C=input("Spend your experience on what? [CustomEXPOptions]") in L
		if(C=="Cancel") return

		if(C in UBList)
			if (WipeDay<31)
				usr<<"This can be purchased on wipe day 31+."
				return
			if (usr.EnablementSlot==1)
				usr<<"You already have a unique buff."
				return
			if(usr.Confirm("[C]")) if(C in UBList)
				var/cost=text2num(copytext(C,findtext(C,"(")+1,findtext(C,")")))
				var/buff=copytext(C,1,findtext(C,"("))
				//usr<<"DEBUG: cost [cost] buff [buff]"
				switch(buff)

					if("Bushido")buff=/Skill/Buff/Bushido
					if("Godspeed")buff=/Skill/Buff/Godspeed
					if("Machine Force")buff=/Skill/Buff/MachineForce
					if("Shadow King")buff=/Skill/Buff/Shadow_King
					if("Arcane Power")buff=/Skill/Buff/ArcanePower
					if("Bestial Wrath")buff=/Skill/Buff/BestialWrath
					if("Kaioken")buff=/Skill/Buff/Kaioken
					if("Death")buff=/Skill/Buff/Death
					if("War")buff=/Skill/Buff/War
					if("Fungal Plague")buff=/Skill/Buff/FungalPlague
					if("Channel")buff=/Skill/Buff/Channel
					if("High Tension")buff=/Skill/Buff/High_Tension
					if("Fists of Fury")buff=/Skill/Buff/FistsOfFury

				if(EXP<cost)
					usr<<"This requires [cost] EXP"
					return
				usr.EXP-=cost
				usr.BuffOut("You spent [cost] experience on [buff].")
				usr.saveToLog("| [usr] spent [cost] experience on [buff]. |")
				alertAdmins("[key_name(usr)] spent [cost] experience on [buff]!")
				usr.contents+= new buff ///Skill/FusionDance
				usr.EnablementSlot=1

		else switch(C)





			if("Fusion Dance(2000)")
				if(EXP<2000)
					usr<<"This requires 2000 EXP"
					return
				usr.EXP-=2000
				usr.BuffOut("You spent 2000 experience on Fusion Dance.")
				usr.saveToLog("| [usr] spent 2000 experience on Fusion Dance. |")
				alertAdmins("[key_name(usr)] spent 2000 experience on Fusion Dance!")
				usr.contents+= new/Skill/FusionDance


			if("Revive Someone(550)")
				var/list/deadfolk=list()
				for(var/mob/player/MM in Players) if(MM.Dead&&MM!=usr&&Year>=MM.Died+Dead_Time) deadfolk+=MM
				deadfolk+="Cancel"
				var/mob/M=input("Revive who for 550 EXP?") in deadfolk
				if(M=="Cancel") return
				else if(M.Dead)
					if(EXP<550)
						usr<<"This requires 550 EXP"
						return
					usr.EXP-=550
					M.Revive()
					if(M.KOd) M.Un_KO()
					M.Health = M.MaxHealth
					M.Calm()
					M.loc=usr.loc
					M.Ki = M.MaxKi
					alertAdmins("[key_name(usr)] has revived [M] for 550 exp!")




//			if("Unlock A Skill")
//				usr.SkillPurchase()
//			if("Purchase an Intelligence Skill")
//				if(usr.Confirm("Please Note - The skills displayed in this window will DECREASE in cost the more INT Mod you have. If you plan to purchase additional INT milestones it's suggested that you hold off on spending EXP here. Do you wish to continue?"))
//					usr.IntSkills()
//			if("Purchase a Magic Skill")
//				if(usr.Confirm("Please Note - The skills displayed in this window will DECREASE in cost the more MAG Mod you have. If you plan to purchase additional MAG milestones it's suggested that you hold off on spending EXP here. Do you wish to continue?"))
//					usr.MagSkills()

		/*	if("Create a Majin(1000)")
				if(usr.Confirm("Create a Majin for 1000 EXP?"))
					if(EXP<1000)
						usr<<"This requires 1000 EXP"
						return
					usr.EXP-=1000
					view(src)<<"[usr] begins to create a majin!"
					var/obj/Baby/A=new
					A.Race="Majin"
					A.loc=usr.loc
					A.icon='fx.dmi'
					A.icon_state="chaos gate"
					A.name="Majin ([usr])"
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Majin",null) as text
					alertAdmins("[key_name(usr)] has made a Majin for 1000 exp!") */

			if("Revive Someone(550)")
				var/list/DeadP=list()
				for(var/mob/player/P in Players) if(P.Dead) DeadP+=P
				DeadP+="Cancel"
				var/mob/CC=input("Revive someone for 550 EXP") in DeadP
				if(CC=="Cancel") return
				if(EXP<550)
					usr<<"This requires 550 EXP"
					return
				usr.EXP-=550
				if(Year<CC.Died+Dead_Time)
					usr<<"This can't be used on someone not attuned to the realm of the dead, their incorporeal form hasn't been deceased long enough. This process usually takes [Dead_Time] years."
					return
				CC.Revive()
				if(CC.KOd) CC.Un_KO()
				CC.Health = CC.MaxHealth
				CC.Calm()
				CC.Ki = CC.MaxKi
				CC.loc=usr.loc



			if("Create a Bio-Android(500)")																			//If they pick bio android
				if(usr.Confirm("Create a Bio-Android for 500 EXP?"))												//Are you sure about it ?
					if(EXP<500)																						//Do you have 500 EXP to buy it?
						usr<<"This requires 500 EXP"																//
						return																						//Then go back
					if(usr.MadeBio ==1)																				//Did you already make a bio android?
						usr<<"You can't make more than one of this proyects in your life time."						//
						return																						//Go back then
					if(usr.EXPLifetime <1430)																		//Do you have 1430 EXP life time ?
						usr<<"You need more experience in this field to make a bio android."						//
						return																						//Go back then
					usr.EXP-=500																					//We remove 500 exp from them
					view(src)<<"[usr] begins to create an biological android!"										//
					var/obj/Baby/A=new																				//Make a new baby
					A.Race="Bio-Android"																			//Set race as bio android
					A.loc=usr.loc																					//Make it spawn at the usr location
					A.icon=pick('CellPod.dmi','CellPodR.dmi')														//Change icon
					A.Builder=usr.name																				//This man made this baby
					A.name="Bio-Android proyect made by[usr]"														//Name for it
					A.AntiPowerGameKey = usr.computer_id															//Anty power game system
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Bio-Android",null) as text
					usr.MadeBio= 1																					//This man here already made a bio , flag it
					alertAdmins("[key_name(usr)] has made a Bio Android for 500 exp!")								//Alert!
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Made a bio-android")			//Log save


			if("Majinize(500)")																						//If they pick Majinize
				if(usr.Confirm("Want to learn Majinize for 500 EXP?"))												//Are you sure about it ?
					if(EXP<500)																						//Do you have 500 EXP to buy it?
						usr<<"This requires 500 EXP"																//
						return																						//Then go back
					if((locate(/Skill/Majinize)) in usr) 															//Did you already have Majinize?
						usr<<"You already have the skill."															//
						return																						//Go back then
					if(usr.EXPLifetime <1430)																		//Do you have 1430 EXP life time ?
						usr<<"You need more experience in this field to learn how to majineze persons."				//
						return																						//Go back then
					usr.EXP-=500																					//We remove 500 exp from them
					usr.contents += new/Skill/Majinize																//We give the skill
					alertAdmins("[key_name(usr)] got Majinize for 500 exp!")										//Alert!
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] got Majinize")					//Log save


			if("Custom Stance(Free)")
//				if(EXP<330)
//					usr<<"This requires 330 EXP"
//					return
//				usr.EXP-=0
				usr.BuffOut("You buy Martial Art.")
				usr.saveToLog("| [usr] spent bought Martial Art.. |")
				var/Skill/MartialArt/MA=new
				MA.Builder="[usr.ckey] ([usr.real_name])"
				MA.YearDeveloped=round(Year)
				contents+=MA
				MA.desc += "You learned this at year [Year] from using your EXP."
//HasCustomStance

			if("Faction Charter(300) (Faction Leader Commands)")
				if(EXP<300)
					usr<<"This requires 300 EXP"
					return
				usr.EXP-=300
				usr.BuffOut("You spent 300 experience on a Faction Charter.")
				usr.saveToLog("| [usr] spent 300 experience on a Faction Charter. |")
				usr.contents+= new/Skill/Misc/FactionLeaderCommands

			if("Limit Breaker(500)")
				if (WipeDay<=30)
					usr<<"This can be purchased on wipe day 31+."
					return
				if(EXP<500)
					usr<<"This requires 500 EXP"
					return
				usr.EXP-=500
				usr.BuffOut("You spent 500 experience on Limit Breaker.")
				usr.saveToLog("| [usr] spent 500 experience on Limit Breaker. |")
				usr.contents+= new/Skill/Buff/LimitBreaker
				alertAdmins("[key_name(usr)] spent 500 experience on Limit Breaker!")
				usr.EnablementSlot=1

			if("Muscle Force(0)")
				if(usr.Confirm("Purchase Muscle Force? This buff is geared towards boosting your Strength."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<0)
						usr<<"This requires 0 EXP"
						return
					usr.EXP-=0
					usr.BuffOut("You spent 0 experience on Muscle Force.")
					usr.saveToLog("| [usr] spent 0 experience on Muscle Force. |")
					alertAdmins("[key_name(usr)] spent 0 experience on Muscle Force!")
					usr.contents+= new/Skill/Buff/T1/MuscleForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1
					if(usr.BaseBuffCounter==1)
						usr.BuffOut("You can buy one more of the basic tier buffs for free.")
					if(usr.BaseBuffCounter==2)
						usr.BuffOut("You have purchased your last free basic tier buff. The next purchase will cost 275 EXP.")

			if("Muscle Force(275)")
				if(usr.Confirm("Purchase Muscle Force? This buff is geared towards boosting your Strength."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<275)
						usr<<"This requires 275 EXP"
						return
					usr.EXP-=275
					usr.BuffOut("You spent 275 experience on Muscle Force.")
					usr.saveToLog("| [usr] spent 275 experience on Muscle Force. |")
					alertAdmins("[key_name(usr)] spent 275 experience on Muscle Force!")
					usr.contents+= new/Skill/Buff/T1/MuscleForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1

				//

			if("Mass Force(0)")
				if(usr.Confirm("Purchase Mass Force? This buff is geared towards boosting your Endurance."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<0)
						usr<<"This requires 0 EXP"
						return
					usr.EXP-=0
					usr.BuffOut("You spent 0 experience on Mass Force.")
					usr.saveToLog("| [usr] spent 0 experience on Mass Force. |")
					alertAdmins("[key_name(usr)] spent 0 experience on Mass Force!")
					usr.contents+= new/Skill/Buff/T1/MassForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1
					if(usr.BaseBuffCounter==1)
						usr.BuffOut("You can buy one more of the basic tier buffs for free.")
					if(usr.BaseBuffCounter==2)
						usr.BuffOut("You have purchased your last free basic tier buff. The next purchase will cost 275 EXP.")

			if("Mass Force(275)")
				if(usr.Confirm("Purchase Mass Force? This buff is geared towards boosting your Endurance."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<275)
						usr<<"This requires 275 EXP"
						return
					usr.EXP-=275
					usr.BuffOut("You spent 275 experience on Mass Force.")
					usr.saveToLog("| [usr] spent 275 experience on Mass Force. |")
					alertAdmins("[key_name(usr)] spent 275 experience on Mass Force!")
					usr.contents+= new/Skill/Buff/T1/MassForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1

				//

			if("Mirage Force(0)")
				if(usr.Confirm("Purchase Mirage Force? This buff is geared towards boosting your Defense."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<0)
						usr<<"This requires 0 EXP"
						return
					usr.EXP-=0
					usr.BuffOut("You spent 0 experience on Mirage Force.")
					usr.saveToLog("| [usr] spent 0 experience on Mirage Force. |")
					alertAdmins("[key_name(usr)] spent 0 experience on Mirage Force!")
					usr.contents+= new/Skill/Buff/T1/MirageForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1
					if(usr.BaseBuffCounter==1)
						usr.BuffOut("You can buy one more of the basic tier buffs for free.")
					if(usr.BaseBuffCounter==2)
						usr.BuffOut("You have purchased your last free basic tier buff. The next purchase will cost 275 EXP.")

			if("Mirage Force(275)")
				if(usr.Confirm("Purchase Mirage Force? This buff is geared towards boosting your Defense."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<275)
						usr<<"This requires 275 EXP"
						return
					usr.EXP-=275
					usr.BuffOut("You spent 275 experience on Mirage Force.")
					usr.saveToLog("| [usr] spent 275 experience on Mirage Force. |")
					alertAdmins("[key_name(usr)] spent 275 experience on Mirage Force!")
					usr.contents+= new/Skill/Buff/T1/MirageForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1

				//

			if("Mangle Force(0)")
				if(usr.Confirm("Purchase Mangle Force? This buff is geared towards boosting your Offense."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<0)
						usr<<"This requires 0 EXP"
						return
					usr.EXP-=0
					usr.BuffOut("You spent 0 experience on Mangle Force.")
					usr.saveToLog("| [usr] spent 0 experience on Mangle Force. |")
					alertAdmins("[key_name(usr)] spent 0 experience on Mangle Force!")
					usr.contents+= new/Skill/Buff/T1/MangleForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1
					if(usr.BaseBuffCounter==1)
						usr.BuffOut("You can buy one more of the basic tier buffs for free.")
					if(usr.BaseBuffCounter==2)
						usr.BuffOut("You have purchased your last free basic tier buff. The next purchase will cost 275 EXP.")

			if("Mangle Force(275)")
				if(usr.Confirm("Purchase Mangle Force? This buff is geared towards boosting your Offense."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<275)
						usr<<"This requires 275 EXP"
						return
					usr.EXP-=275
					usr.BuffOut("You spent 275 experience on Mangle Force.")
					usr.saveToLog("| [usr] spent 275 experience on Mangle Force. |")
					alertAdmins("[key_name(usr)] spent 275 experience on Mangle Force!")
					usr.contents+= new/Skill/Buff/T1/MangleForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1

				//

			if("Magic Force(0)")
				if(usr.Confirm("Purchase Magic Force? This buff is geared towards boosting your Force."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<0)
						usr<<"This requires 0 EXP"
						return
					usr.EXP-=0
					usr.BuffOut("You spent 0 experience on Magic Force.")
					usr.saveToLog("| [usr] spent 0 experience on Magic Force. |")
					alertAdmins("[key_name(usr)] spent 0 experience on Magic Force!")
					usr.contents+= new/Skill/Buff/T1/MagicForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1
					if(usr.BaseBuffCounter==1)
						usr.BuffOut("You can buy one more of the basic tier buffs for free.")
					if(usr.BaseBuffCounter==2)
						usr.BuffOut("You have purchased your last free basic tier buff. The next purchase will cost 275 EXP.")

			if("Magic Force(275)")
				if(usr.Confirm("Purchase Magic Force? This buff is geared towards boosting your Force."))
					if (Base/BPMod>=GenericReq)
						usr<<"You aren't strong enough to purchase this yet."
					if(EXP<275)
						usr<<"This requires 275 EXP"
						return
					usr.EXP-=275
					usr.BuffOut("You spent 275 experience on Magic Force.")
					usr.saveToLog("| [usr] spent 275 experience on Magic Force. |")
					alertAdmins("[key_name(usr)] spent 275 experience on Magic Force!")
					usr.contents+= new/Skill/Buff/T1/MagicForce
					usr.BaseBuffCounter = usr.BaseBuffCounter+1


			if("Ascend(1200)")
				if (WipeDay<=20)
					usr<<"This can't be purchased until wipe day 20+"
				if(EXP<1200)
					usr<<"This requires 1200 EXP"
					return
				usr.EXP-=1200
				usr.BuffOut("You spent 1200 experience on Ascend.")
				usr.saveToLog("| [usr] spent 1200 experience on Ascend. |")
				alertAdmins("[key_name(usr)] spent 1200 experience on Ascend!")
				usr.contents+= new/Skill/Buff/Ascend


			if("Create an SSJ4(750)") if(usr.Confirm("Do you really want to create an SSJ4 for 750 EXP?"))
				if(EXP<750)
					usr<<"This requires 750 EXP"
					return
				var/list/Saiyans=list()
				for(var/mob/player/P in view(usr)) if(P.Race=="Saiyan"&&P.HasSSj>=2&&P.HasSSj4==0) Saiyans+=P
				Saiyans+="Cancel"
				var/mob/player/SS = input("Who do you want to make an SSJ4?") in Saiyans
				if(SS=="Cancel") return
				else SS.HasSSj4=1
				usr.MadeSSj4++
				usr.EXP-=750
				usr.BuffOut("You spent 750 experience on making [SS] an SSJ4.")
				usr.saveToLog("| [usr] spent 750 experience on making [SS] an SSJ4. |")
				SS<<"[usr] has made you an SSJ4!"
				alertAdmins("[key_name(usr)] has made [SS] an SSj4 using 750 EXP!")
/*

			if("Master a Skill")
				if(EXP<75)
					usr<<"This requires 75 EXP"
					return
				var/list/PC=list()
				for(var/Skill/S in usr) if(S.Experience<100) PC+=S
				PC+="Cancel"
				var/Skill/Align=input("Which skill would you like to master? (This will master a skill at the cost of 75 EXP)") in PC
				if(Align=="Cancel")return
				Align.Experience=100
				usr.EXP-=75
				usr.BuffOut("You spent 75 experience on [Align]. (Mastered [Align])")
				usr.saveToLog("| [usr] spent 75 experience on [Align]. (Mastered [Align]) |")*/
			if("Earn A Milestone Point(660)") if(usr.Confirm("Earn a Milestone point for 660 EXP?"))
				if(usr.EXP>=660)
					usr.EXP-=660
					usr.MilestonePoints++
					usr.BuffOut("You spent 660 experience on +1 MP.")
					usr.saveToLog("| [usr] spent 660 experience on +1 MP. |")
				else usr<<"You need 660 EXP to earn a milestone point."
			if("Increase Passive Skill")
				var/Align=input("Which passive? (EXP Invested x max(1,Year/30) = Passive Bonus)") in list("Weapon Skill","Ki Manipulation","Unarmed Skill","Evasion","Cancel")
				if(Align=="Cancel")return
				var/Incr=input("Invest how much experience into [Align]? (0-[EXP]) (EXP Invested x max(1,Year/40) = Passive Bonus)") as num
				if(Incr>EXP) Incr=EXP
				if(Incr<0) Incr=0
				Incr=round(Incr)
				if(Incr)
					switch(Align)
						if("Weapon Skill") usr.SwordSkillAdd+=(Incr)
						if("Ki Manipulation") usr.KiManipulationAdd+=(Incr)
						if("Unarmed Skill") usr.UnarmedSkillAdd+=(Incr)
						if("Evasion") usr.AthleticismAdd+=(Incr)
					usr.EXP-=Incr
					usr.BuffOut("You spent [Incr] experience on [Align]. (+ [Incr*max(0.025,Year/30)] [Align])")
					usr.saveToLog("| [usr] spent [Incr] experience on [Align]. (+ [Incr*max(0.025,Year/30)] [Align]) |")
			if("Magic/Int/Profession Experience (Up to Cap)")
				var/Align=input("Increase which?") in list("Magic","Intelligence","Mining","Smithing","Fishing","Cooking","Cancel")
				if(Align=="Cancel")return
				if(Align=="Magic") if(usr.Magic_Level>TechCap)
					usr<<"Your Magic is already at the cap."
					return
				if(Align=="Intelligence") if(usr.Int_Level>TechCap)
					usr<<"Your Intelligence is already at the cap."
					return
				var/Incr=input("Buy how many levels of [Align]? (0-[round(EXP/100)] 100 EXP : 1 level) Only do Mining/Smithing/Fishing/Cooking 1 level at a time or you will miss out on EXP.") as num
				if(Incr>EXP/100) Incr=EXP/100
				if(Incr<0) Incr=0
				Incr=round(Incr)
				if(Incr)
					switch(Align)
						if("Magic") usr.medrewardmagic+=Incr
						if("Intelligence") usr.medreward+=Incr
						if("Mining")
							usr.Mining_XP+=Mining_Next*Incr
							MiningLevelCheck()
						if("Smithing")
							usr.Smithing_XP+=Smithing_Next*Incr
							SmithingLevelCheck()
						if("Fishing")
							usr.Fishing_XP+=Fishing_Next*Incr
							FishingLevelCheck()
						if("Cooking")
							usr.Cooking_XP+=Cooking_Next*Incr
							CookingLevelCheck()
					usr.EXP-=Incr*100
					usr.BuffOut("You spent [Incr*100] experience on [Align]. (+ [Incr] levels)")
					usr.saveToLog("| [usr] spent [Incr*100] experience on [Align]. (+ [Incr] levels) |")
		/*	if("Energy (Up to Hard Cap)")
				if(BaseMaxKi/KiMod>=EnergyHardCap*0.9)
					usr<<"You have already hit the energy hard cap."
					return
				var/Incr=input("Invest how much experience into Energy? (0-[EXP])") as num
				if(Incr>EXP) Incr=EXP
				if(Incr<0) Incr=0
				Incr=round(Incr)
				if(Incr)
					usr.BaseMaxKi+=Incr
					usr.EXP-=Incr
					usr.BuffOut("You spent [Incr] experience on Energy. (+ [Incr] Max Energy)")
					usr.saveToLog("| [usr] spent [Incr] experience on Energy. (+ [Incr] Max Energy) |")*/

			if("Train Martial Art(200)") if(usr.Confirm("Train Martial Art for 200 EXP?"))
				if(usr.EXP >= 200)
					var/list/Clist=list()
					usr.EXP -= 200
					for(var/Skill/MartialArt/MA in usr) if(MA.MasteryLevel!="Master") Clist+=MA
					Clist+="Cancel"
					var/Skill/MartialArt/MAC=input("Train in which martial art?") in Clist
					if(MAC=="Cancel")
						usr.EXP += 200
						return
					else
						if(MAC.MasteryLevel=="Novice")
							MAC.PointsCan=4
							MAC.MasteryLevel="Intermediate"
						else if(MAC.MasteryLevel=="Intermediate")
							MAC.PointsCan=5
							MAC.MasteryLevel="Master"
					usr << "<font color = teal>You have been rewarded mastery in the [MAC] martial art for 200 EXP, congratulations!"
				else usr<<"You need 200 EXP to train a stance."

			if("Deepen Weapon Bond(100)") if(usr.Confirm("Deepen Weapon Bond for 100 EXP?"))
				if(usr.EXP >= 100)
					var/list/Clist=list()
					usr.EXP -= 100
					for(var/Skill/Weapon/Bound_Weapon/MA in usr) if(MA.PointsCan<4) Clist+=MA
					Clist+="Cancel"
					var/Skill/MartialArt/MAC=input("Bond with which bound weapon?") in Clist
					if(MAC=="Cancel")
						usr.EXP += 100
						return
					else
						if(MAC.PointsCan<3)
							MAC.PointsCan=3
						else if(MAC.PointsCan<4)
							MAC.PointsCan=4
					usr << "<font color = teal>You have been rewarded mastery in [MAC] 100 EXP, congratulations!"
				else usr<<"You need 100 EXP to bond with a weapon."


	else usr<<"You have no rewarded experience to spend. You can earn this by interacting with ranks and RPing or completing quests, participating in events and defeating event villains and by participating in the Roleplay Rewards quota."

*/
mob/var
	EvasionTeaches=1
	WeaponTeaches=1
	UnarmedTeaches=1
	KiManipTeaches=1
/*
var/list
	HumanLearnList=list("Third Eye","Post Human","Humanism")
	SaiyanLearnList=list("False Moon")
	NamekianLearnList=list("Counterpart","Super Namekian") // removed "Namekian Fusion" on 10/13/21
	AncientNamekianLearnList=list("Super Namekian")
	AndroidLearnList=list("Shield","Grand Explosion")
	AlienLearnList=list("Heal")
	DemonLearnList=list("Majin","Imitate","Invisibility","Veil Travel","Revive","Keep Body","Dispel")
	HeranLearnList=list("Shield")
	KaioLearnList=list("Mystic","Heal","Veil Travel","Revive","Keep Body","Dispel")
	KanassaLearnList=list("Heal")
	MakyoLearnList=list("Makyo Transform")
	OniLearnList=list("Giant Mode","Dispel")
	TuffleLearnList=list("Physics Simulation","Super Tuffle")
	YardratLearnList=list("Shunkan Ido","Super Maximum Light Speed Mode")
	DollLearnList=list("Heal","Soul")
	ChangelingLearnList=list("Shield")
	DemiLearnList=list("Pantheon","Dispel")
	MasterLearnList=list("Jump","Block","BlockStance","Zanzoken","Magic Force","Ki Fists","Slash","Bash","Muscle Force","Fly","Blast","Charge","Beam","Rock Throw","Warp Attack","Dash Attack","Kiai","Focus","Power Control","Quick Jab")
//"Adaptive",,"Ki Fists","Shield"
	//MasterLearnList=list("Blast","Charge","Beam","Fly","Rock Throw","Power Conctrol","Magic Force","Muscle Force","Focus","Zanzoken","Dash Attack","Roundhouse Kick","Warp Attack","Cleave Attack","Sword Stab","Kiai")

mob/proc/FixLearnList()
	LearnList=MasterLearnList+GeneticLearnList
	switch(Race)
		if("Human") LearnList=MasterLearnList+HumanLearnList
		if("Saiyan") LearnList=MasterLearnList+SaiyanLearnList
		if("Namekian")LearnList=MasterLearnList+NamekianLearnList
		if("Android")LearnList=MasterLearnList+AndroidLearnList
		if("Alien")LearnList=MasterLearnList+AlienLearnList
		if("Demon")LearnList=MasterLearnList+DemonLearnList
		if("Heran")LearnList=MasterLearnList+HeranLearnList
		if("Kaio")LearnList=MasterLearnList+KaioLearnList
		if("Kanassa")LearnList=MasterLearnList+KanassaLearnList
		if("Makyojin")LearnList=MasterLearnList+MakyoLearnList
		if("Oni")LearnList=MasterLearnList+OniLearnList
		if("Tuffle")LearnList=MasterLearnList+TuffleLearnList
		if("Yardrat")LearnList=MasterLearnList+YardratLearnList
		if("Spirit Doll")LearnList=MasterLearnList+DollLearnList
		if("Changeling") LearnList=MasterLearnList+ChangelingLearnList
		if("Demigod")LearnList=MasterLearnList+DemiLearnList
//	src<<"Learn List: [LearnList.Join(", ")]"


mob/verb/LearnListCheck()
	set hidden=1
	src<<"[LearnList.Join(", ")]"

mob/var/CustomLearn1
mob/proc/CustomLearn1()  if(!CustomLearn1)
	var/list/CanChoose=list()
	if(UnarmedSkill>400)CanChoose.Add(/Skill/Attacks/T3/RockTomb,/Skill/Unarmed/T2/UppercutCombo,/Skill/Attacks/T1/RockSlide,/Skill/Melee/PressurePunch,/Skill/Unarmed/T2/MegatonThrow,/Skill/Unarmed/T2/CatchTheBlade)
	if(SwordSkill>400)CanChoose.Add(/Skill/Weapon/T2/CleaveAttack,/Skill/Weapon/T2/Riposte,/Skill/Weapon/T2/SwordStab,/Skill/Weapon/T3/Overhead_Smash,/Skill/Weapon/T3/Colossal_Impact,/Skill/Attacks/T2/EchoingSlash)
	if(KiManipulation>400)CanChoose.Add(/Skill/Attacks/T2/SpiritBall,/Skill/Attacks/T2/Barrage,/Skill/Attacks/T2/Mortar_Charge,/Skill/Attacks/T2/DestructoDisc,/Skill/Attacks/T2/GuideBomb)

	for(var/Skill/S in src) CanChoose-=S

	var/UA=input(src,"Choose a skill to learn","You've Developed a Skill!") in CanChoose
	if(!CustomLearn1)
		var/Skill/UAA = new UA
		contents+=UAA
		CustomLearn1="[UAA]"
		src<<"You learned [UAA]!"

mob/var/CustomLearn2
mob/proc/CustomLearn2() if(!CustomLearn2)
	var/list/CanChoose=list(/Skill/Support/Heal,/Skill/Attacks/T3/Self_Destruct,/Skill/Support/Splitform,/Skill/Support/Send_Energy,/Skill/Melee/TelekineticPull,/Skill/Buff/Expand)
	if(UnarmedSkill>1500)CanChoose.Add(/Skill/Unarmed/T2/PileDriver,/Skill/Melee/Kickback_Combo,/Skill/Attacks/T3/Earthquake)
	if(SwordSkill>1500)CanChoose.Add(/Skill/Weapon/T3/Wind_Howl,/Skill/Weapon/T3/Iai_Slash,/Skill/Attacks/T3/Earthquake)
	if(KiManipulation>1500)CanChoose.Add(/Skill/Attacks/T3/Explosion,/Skill/Attacks/T3/MegaBurst,/Skill/Attacks/T3/Homing_Finisher,/Skill/Attacks/T2/ExplosiveWave,/Skill/Misc/T2/KiBlade)

	for(var/Skill/S in src) CanChoose-=S

	var/UA=input(src,"Choose a skill to learn","You've Developed a Skill!") in CanChoose
	if(!CustomLearn2)
		var/Skill/UAA = new UA
		contents+=UAA
		CustomLearn2="[UAA]"
		src<<"You learned [UAA]!"
*/


mob/proc/Learn() //if(world.maxz!=1) while(src)
	set background=1
//	set waitfor=0
//	sleep(200)
	FBMCheck()
	var/Lrned=0

//	if(!CustomLearn1) if(MaxKi>=1500&&KiManipulation+UnarmedSkill+SwordSkill>1500&&SaveAge>=5) CustomLearn1()
//	if(!CustomLearn2) if(MaxKi>=3500&&KiManipulation+UnarmedSkill+SwordSkill>4000&&SaveAge>=10) CustomLearn2()


/*
//Racial Skills
	if(Race=="Demon"&&!(locate(/Skill/Misc/Absorb)in src)) contents+=new/Skill/Misc/Absorb
	if("Invisibility" in LearnList)
		if(WipeDay>=4&&!(locate(/Skill/Support/Invisibility) in src))
			src<<"You acquired the invisibility skill"
			contents+=new/Skill/Support/Invisibility
			Lrned++
	if("Imitate" in LearnList)
		if(WipeDay>=7&&!(locate(/Skill/Support/Imitation)in src))
			contents+=new/Skill/Support/Imitation
			Lrned++
			src<<"<span class=announce>You have learned how to imitate another person's physical features through the usage of your ki and dark magic!"
	if("Veil Travel" in LearnList)
		if(WipeDay>=10&&!(locate(/Skill/Support/Veil_Travel)in src))
			contents+=new/Skill/Support/Veil_Travel
			Lrned++
			src<<"<span class=announce>You have learned how to travel to your summoner and back to the afterlife!"
	if("Revive" in LearnList)
		if(WipeDay>=15&&!(locate(/Skill/Support/Revive)in src))
			contents+=new/Skill/Support/Revive
			Lrned++
			src<<"<span class=announce>You have learned how to revive souls with your inner ki!"
	if("Dispel" in LearnList)
		if(WipeDay>=18&&!(locate(/Skill/Support/Dispel)in src))
			contents+=new/Skill/Support/Dispel
			Lrned++
			src<<"<span class=announce>You have learned how to send souls back to the afterlife with your inner ki!"
	if("Keep Body" in LearnList)
		if(WipeDay>=10&&!(locate(/Skill/Support/Keep_Body)in src))
			contents+=new/Skill/Support/Keep_Body
			Lrned++
			src<<"<span class=announce>You have learned how to keep souls body!"
	if("False Moon" in LearnList)
		if(WipeDay>=3&&!(locate(/Skill/Buff/False_Moon) in src))
			src<<"You acquired the False Moon skill"
			contents+=new/Skill/Buff/False_Moon
			Lrned++
	if("Counterpart" in LearnList)
		if(WipeDay>=1&&!(locate(/Skill/Support/Counterpart) in src))
			contents+=new/Skill/Support/Counterpart
			Lrned++
			src<<"<span class=announce>You automatically learned how to designate another of your race as your counterpart."
	if("Grand Explosion" in LearnList)
		if(WipeDay>=7&&!(locate(/Skill/Attacks/Grand_Explosion) in src))
			contents+=new/Skill/Attacks/Grand_Explosion
			Lrned++
			src<<"<span class=announce>You have learned to harness your power and unleash a massive explosion!"
/*	if("Namekian Fusion" in LearnList||Race=="Namekian")
		if(Base/BPMod>Tier2Req&&!(locate(/Skill/Support/NamekianFusion) in src)&&SaveAge>=10)
			src<<"You have awakened your race's hidden technique... Use it wisely."
			Lrned++
			contents+=new/Skill/Support/NamekianFusion */
	if("Shunkan Ido" in LearnList)
		if(WipeDay>=1&&!(locate(/Skill/Support/InstantTransmission) in src))
			contents+=new/Skill/Support/InstantTransmission
			Lrned++
			usr<<"<span class=announce>You have unlocked your race's natural gift of teleportation."
/*	if("Expand" in LearnList)
		if(Base/BPMod>15000&&Year>=15&&MaxKi>=3500&&!(locate(/Skill/Buff/Expand)in src))
			contents+=new/Skill/Buff/Expand
			Lrned++
			src<<"<span class=announce>Through strength and ki training, you have learned how to expand your body to a gargantuan size!"*/

//Generic Learns
	if("Telekinesis" in LearnList)
		if(!(locate(/Skill/Support/Telekinesis) in src))
			src << "Through dedicated study of the arcane, you have unlocked the ability to move objects via your energy. Click and drag items and people to move them."
			contents+=new/Skill/Support/Telekinesis
			Lrned++



	if("Heal" in LearnList)
		if(WipeDay>=3&&!(locate(/Skill/Support/Heal)in src)&&Year>=2)
			contents+=new/Skill/Support/Heal
			Lrned++
			src<<"<span class=announce>Through intensive ki training you have learned to Heal others!"
	if("Focus" in LearnList)
		if(WipeDay>=7&&!(locate(/Skill/Buff/Focus)in src))
			contents+=new/Skill/Buff/Focus
			Lrned++
			src<<"<span class=announce>Through intensive ki training, force training, and luck, you have learned to use Focus.  By doing so, you take your senses to a super-human level! Check out the EXP window in order to purchase two more Tier 1 Buffs for Free."
/*	if("Magic Force" in LearnList)
		if(Base/BPMod>=GenericReq&&!(locate(/Skill/Buff/T1/MagicForce) in src))
			contents+=new/Skill/Buff/T1/MagicForce
			Lrned++
			src<<"<span class=announce>Your utter devotion to the arcane arts has awakened a newfound power within you!</span>" */
/*	if("Muscle Force" in LearnList)
		if(Base/BPMod>=GenericReq&&!(locate(/Skill/Buff/T1/MuscleForce)in src))
			contents+=new/Skill/Buff/T1/MuscleForce
			Lrned++
			src<<"<span class=announce>Through intensive endurance training, strength training, and luck, you have learned to use Muscle Force.  By doing so, you take your strength to a super-human level!" */
	if("Power Control" in LearnList)
		if(WipeDay>=3&&!(locate(/Skill/Buff/Power_Control) in src))
			contents+=new/Skill/Buff/Power_Control
			Lrned++
			src<<"<span class=announce>You automatically learned Power Control on your own because of your immense energy and ki manipulation."
	if("Shield" in LearnList)
		if(WipeDay>=10&&!(locate(/Skill/Buff/Shield) in src)&&Year>=5)
			contents+=new/Skill/Buff/Shield
			Lrned++
			src<<"<span class=announce>You automatically learned Shield on your own because of your immense energy"
/*	if(!(locate(/Skill/Zanzoken) in src))
		if(Zanzoken>=1000&&MaxKi>3000&&Year>=20)
			contents+=new/Skill/Zanzoken
			Lrned++
			src<<"<span class=announce>Your speed rivals that of sound! You can now zanzoken to another tile!</span>"
*/
*/
/*
//Unarmed
	if("Dash Attack" in LearnList)
		if(WipeDay>=2&&!locate(/Skill/Unarmed/T1/DashAttack) in src)
			contents+=new/Skill/Unarmed/T1/DashAttack
			Lrned++
			src<<"<span class=announce>You have learned to use your incredible speed in combat. As such, you can now dash at your opponent and strike several times!</span>"
	if("Warp Attack" in LearnList)
		if(WipeDay>=2&&!locate(/Skill/Unarmed/T1/WarpAttack) in src)
			contents+=new/Skill/Unarmed/T1/WarpAttack
			Lrned++
			src<<"<span class=announce>Your impressive speed has lead to the ability to perform high-paced follow up attacks!</span>"
//	if("Block" in LearnList)
//		if(MaxKi>=1500&&UnarmedSkill>=75&&!locate(/Skill/Misc/Block) in src)
//			contents+=new/Skill/Misc/Block
//			src<<"<span class=announce>You feel as though you can reliably block an attack with your hands!</span>"
	if("Quick Jab" in LearnList)
		if(WipeDay>=2&&!locate(/Skill/Unarmed/T1/QuickJab) in src)
			contents+=new/Skill/Unarmed/T1/QuickJab
			src<<"<span class=announce>Your use of your fists in combat has helped you to learn to launch a fast attack!</span>"

//Ki Manip
	if("Blast" in LearnList)
		if(WipeDay>=1&&!(locate(/Skill/Attacks/T1/Blast) in src))
			contents+=new/Skill/Attacks/T1/Blast
			Lrned++
			src<<"<span class=announce>You automatically learned Blast on your own because of your immense energy"
	if("Charge" in LearnList)
		if(WipeDay>=2&&!(locate(/Skill/Attacks/T1/Charge) in src))
			contents+=new/Skill/Attacks/T1/Charge
			Lrned++
			src<<"<span class=announce>You automatically learned Charge on your own because of your immense energy"
	if("Beam" in LearnList)
		if(WipeDay>=3&&!(locate(/Skill/Attacks/Beams/Beam) in src))
			contents+=new/Skill/Attacks/Beams/Beam
			Lrned++
			src<<"<span class=announce>You automatically learned Beam on your own because of your immense energy"
	if("Ki Fists" in LearnList)
		if(WipeDay>=4&&!(locate(/Skill/Misc/T1/KiFists) in src))
			contents+=new/Skill/Misc/T1/KiFists
			Lrned++
			src<<"<span class=announce>You automatically learned Ki Fists on your own because of your immense energy"

//Weapon
//	if("Block" in LearnList)
//		if(WipeDay>=1&&SwordSkill>=75&&!locate(/Skill/Misc/Block) in src)
//			contents+=new/Skill/Misc/Block
//			src<<"<span class=announce>You feel as though you can reliably block an attack with your weapon!</span>"
	if("Slash" in LearnList)
		if(WipeDay>=2&&!locate(/Skill/Weapon/T1/Slice) in src)
			contents+=new/Skill/Weapon/T1/Slice
			src<<"<span class=announce>Your use of a weapon in combat has helped you to learn to launch a fast attack!</span>"
	if("Bash" in LearnList)
		if(WipeDay>=1&&!locate(/Skill/Weapon/T1/Bash) in src)
			contents+=new/Skill/Weapon/T1/Bash
			src<<"<span class=announce>Your use of a weapon in combat has helped you to learn to launch an attack that will stun your opponent!</span>"

//No Passive
	if("Kiai" in LearnList)
		if(WipeDay>=0&&!(locate(/Skill/Attacks/T1/Shockwave) in src))
			contents+=new/Skill/Attacks/T1/Shockwave
			Lrned++
			src<<"<span class=announce>You automatically learned Shockwave on your own because of your immense energy"
	if("Fly" in LearnList)
		if(WipeDay>=4&&!(locate(/Skill/Misc/Fly) in src)&&WipeDay>=4)
			contents+=new/Skill/Misc/Fly
			Lrned++
			src<<"<span class=announce>You automatically learned Fly on your own because of your immense energy"
	if("Rock Throw" in LearnList)
		if(WipeDay>=0&&!(locate(/Skill/Attacks/T1/RockThrow) in src))
			contents+=new/Skill/Attacks/T1/RockThrow
			Lrned++
			src<<"<span class=announce>You automatically learned Rock Throw because you can lift rocks and throw them."
	if("Jump" in LearnList)
		if(WipeDay>=0&&!(locate(/Skill/Misc/Jump_Backwards) in src))
			contents+=new/Skill/Misc/Jump_Backwards
			Lrned++
			src<<"<span class=announce>You automatically learned to Jump Backwards in combat to evade an attack."
	if(WipeDay>=0&&!(locate(/Skill/Support/Sense_Energy) in src))
		contents+=new/Skill/Support/Sense_Energy
		Lrned++
		src<<"<span class=announce>You automatically learned to sense energy on your own because of your immense energy"

	if(WipeDay>=1&&!(locate(/Skill/Misc/Resist) in src))
		contents+=new/Skill/Misc/Resist
		Lrned++
		src<<"<span class=announce>You automatically learned to resist control effects on your own."

//	if(WipeDay>=0&&!(locate(/Skill/Unarmed/BlockStance) in src))
//		contents+=new/Skill/Unarmed/BlockStance
//		Lrned++
//		src<<"<span class=announce>You automatically learned to block attacks on your own."

	if(WipeDay>=0&&!(locate(/Skill/Zanzoken) in src))
		contents+=new/Skill/Zanzoken
		Lrned++
		src<<"<span class=announce>You automatically learned to move faster than a normal person!."

*/
//Magic
	if(Magic_Level>=12&&!(locate(/Skill/Spell/Rejuvenate) in src))
		src << "You have learned Rejuvenate due to your magical skill."
		contents+=new/Skill/Spell/Rejuvenate
		Lrned++
	if(Magic_Level>=25&&!(locate(/Skill/Spell/Lightning_Bolt) in src))
		src << "You have learned Lightning Bolt due to your magical skill."
		contents+=new/Skill/Spell/Lightning_Bolt
		Lrned++
	if(Magic_Level>=35&&Magic_Potential>=2&&!(locate(/Skill/Support/Materialization) in src))
		src << "Through hard work and practice you have managed to learn to materialize weighted clothing before you!"
		contents+=new/Skill/Support/Materialization
		Lrned++
	if(Magic_Level>=38&&Magic_Potential>=5&&!(locate(/Skill/Buff/Adaptive) in src))
		src<<"You have learned to use your magic to help you improve your defensiveness. (Adaptive)"
		contents+=new/Skill/Buff/Adaptive
		Lrned++
	if(Magic_Level>=38&&Race=="Makyojin"&&!(locate(/Skill/Buff/Adaptive) in src))
		src<<"You have learned to use your magic to help you improve your defensiveness. (Adaptive)"
		contents+=new/Skill/Buff/Adaptive
		Lrned++
	if(Magic_Level>=43&&Magic_Potential>=5&&!(locate(/Skill/Spell/Frost_Bolt) in src))
		src << "You have learned Frost Bolt due to your magical skill."
		contents+=new/Skill/Spell/Frost_Bolt
		Lrned++
	if(Magic_Level>=45&&Magic_Potential>=2&&!(locate(/Skill/Support/Telepathy) in src))
		src << "You have learned telepathy due to your magical skill."
		contents+=new/Skill/Support/Telepathy
		Lrned++
	if(Magic_Level>=50&&!(locate(/Skill/Spell/Telekinesis_Magic) in src))
		src << "Through dedicated study of the arcane, you have unlocked the ability to move objects via magic. Click and drag items and people to move them. Each movement will cost mana."
		contents+=new/Skill/Spell/Telekinesis_Magic
		Lrned++
	if(Magic_Level>=53&&!(locate(/Skill/Spell/Enchant) in src)&&Magic_Potential>2)
		src << "You have learned how to enchant equipment due to your magical skill."
		contents+=new/Skill/Spell/Enchant
		Lrned++
	if(Magic_Level>=53&&!(locate(/Skill/Spell/Fireball) in src)&&Magic_Potential>=5)
		src << "You have learned how to cast Fireball due to your magical skill."
		contents+=new/Skill/Spell/Fireball
		Lrned++

	if(Magic_Level>=25&&!(locate(/Skill/Spell/Construct_Doll) in src)&&Magic_Potential>2)
		src << "You have learned how to create Dolls you can control remotely with your magic."
		contents+=new/Skill/Spell/Construct_Doll
		Lrned++
	if(Magic_Level>=58&&!(locate(/Skill/Spell/Empowered_Defenses) in src)&&Magic_Potential>=5)
		src << "You have learned how to empower your allies defenses due to your magical skill."
		contents+=new/Skill/Spell/Empowered_Defenses
		Lrned++
	if(Magic_Level>=58&&!(locate(/Skill/Spell/Empowered_Defenses) in src)&&Race=="Makyojin")
		src << "You have learned how to empower your allies defenses due to your magical skill."
		contents+=new/Skill/Spell/Empowered_Defenses
		Lrned++
	if(Magic_Level>=58&&!(locate(/Skill/Technology/MakeStatue) in src)&&Magic_Potential>2)
		src << "You have learned how to make statues of people."
		contents+=new/Skill/Technology/MakeStatue
		Lrned++
/*	if(Magic_Level>=59&&!(locate(/Skill/Spell/DeadZone) in src)&&Magic_Potential>2)
		src << "You have learned how to open a portal to the Dead Zone."
		contents+=new/Skill/Spell/DeadZone
		Lrned++*/
	if(Magic_Level>=60&&!(locate(/Skill/Spell/Gravity_Well) in src)&&Magic_Potential>2.5)
		src << "You have learned how to make wells of gravity using magic."
		contents+=new/Skill/Spell/Gravity_Well
		Lrned++
	if(Magic_Level>=60&&Magic_Potential>=5&&!(locate(/Skill/Spell/Seance) in src))
		src << "You have learned Seance due to your magical skill."
		contents+=new/Skill/Spell/Seance
		Lrned++
	if(Magic_Level>=60&&Race=="Makyojin"&&!(locate(/Skill/Spell/Seance) in src))
		src << "You have learned Seance due to your magical skill."
		contents+=new/Skill/Spell/Seance
		Lrned++
	if(Magic_Level>=62&&!(locate(/Skill/Spell/Empowered_Attacks) in src)&&Magic_Potential>=5)
		src << "You have learned how to empower your allies attacks due to your magical skill."
		contents+=new/Skill/Spell/Empowered_Attacks
		Lrned++
	if(Magic_Level>=65&&!(locate(/Skill/Spell/Ritual_Of_Power) in src)&&HasMagicMiles>1)
		src << "You now have the ability to perform a ritual of power."
		contents+=new/Skill/Spell/Ritual_Of_Power
		Lrned++
/*	if(Magic_Level>=65&&!(locate(/Skill/Spell/Accelerate) in src)&&Magic_Potential>=5)
		src << "You now have the ability to perform a ritual of acceleration."
		contents+=new/Skill/Spell/Accelerate
		Lrned++ */

	if(Magic_Level>=70&&!(locate(/Skill/Spell/Earth_Prison) in src)&&Magic_Potential>2)
		src << "You have learned Earth Prison due to your magical skill."
		contents+=new/Skill/Spell/Earth_Prison
		Lrned++
	if(Magic_Level>=75&&!(locate(/Skill/Spell/Frost_Nova) in src)&&Magic_Potential>=5)
		src << "You have learned Frost Nova due to your magical skill."
		contents+=new/Skill/Spell/Frost_Nova
		Lrned++
	if(Magic_Level>=75&&!(locate(/Skill/Spell/Frost_Nova) in src)&&Race=="Makyojin")
		src << "You have learned Frost Nova due to your magical skill."
		contents+=new/Skill/Spell/Frost_Nova
		Lrned++
	if(Magic_Level>=40&&Magic_Potential>3.5&&!(locate(/Skill/Spell/Summon_Demon) in src)&& src.EXPLifetime>=990)
		src << "You have learned Conjure due to your magical skill."
		contents+=new/Skill/Spell/Summon_Demon
		Lrned++
	if(Magic_Level>=80&&!(locate(/Skill/Spell/Create_Portal) in src)&&Magic_Potential>3)
		src << "You have learned Create Portal due to your magical skill."
		contents+=new/Skill/Spell/Create_Portal
		Lrned++
/*	if(Magic_Level>=85&&!(locate(/Skill/Attacks/T3/MegaBurst) in src)&&Magic_Potential>2)
		contents+=new/Skill/Attacks/T3/MegaBurst
		Lrned++
		src<<"<span class=announce>Congratulations! Through mastery of the arcane and a masssive energy store, you have learned to produce a mighty beam!</span>"*/
	if(Magic_Level>=90&&Magic_Potential>=5&&!(locate(/Skill/Spell/Advanced_Seance) in src))
		src << "You have learned Advanced Seance due to your magical skill."
		contents+=new/Skill/Spell/Advanced_Seance
		Lrned++
//	if(Magic_Level>=125&&Magic_Potential>5&&!(locate(/Skill/Spell/Dark_Bargain) in src))
//		src << "You have learned Dark Bargain due to your magical skill."
//		contents+=new/Skill/Spell/Dark_Bargain
//		Lrned++
	if(Magic_Level>=60&&!(locate(/Skill/Spell/Alter_Perception) in src)&&Magic_Potential>2)
		contents+=new/Skill/Spell/Alter_Perception
		Lrned++
		src<<"<span class=announce>Congratulations! You can now assist someone in crafting a new identity!</span>"


//Tech
	if(Int_Level>=40&&Int_Mod>2&&!(locate(/Skill/Technology/MakeWeights) in src))
		src << "You can now create weighted clothing."
		contents+=new/Skill/Technology/MakeWeights
		Lrned++
	if(Int_Level>=49&&Int_Mod>1&&!(locate(/Skill/Technology/Replace_Limb)in src))
		contents+=new/Skill/Technology/Replace_Limb
		Lrned++
		src<<"You learned how to use your technology to replace someone's limb."
	if(Int_Level>=55&&!(locate(/Skill/Technology/Construct_Robot)in src)&&Int_Mod>2)
		contents+=new/Skill/Technology/Construct_Robot
		Lrned++
		src<<"Your intelligence has lead to you discovering the process needed to create an automated drone."
	if(Int_Level>=55&&Int_Mod>=5&&!(locate(/Skill/Technology/Nanite_Burst)in src))
		contents+=new/Skill/Technology/Nanite_Burst
		Lrned++
		src<<"You learned how to use Nanites to heal those around you."
	if(Int_Level>=55&&Race=="Tuffle"&&!(locate(/Skill/Technology/Nanite_Burst)in src))
		contents+=new/Skill/Technology/Nanite_Burst
		Lrned++
		src<<"You learned how to use Nanites to heal those around you."
	if(Int_Level>=57&&!(locate(/Skill/Technology/Calculated_Strikes)in src)&&Int_Mod>=5)
		contents+=new/Skill/Technology/Calculated_Strikes
		Lrned++
		src<<"You have awoken your race's natural ability to analyze the paces of combat and target specific points."
	if(Int_Level>=57&&!(locate(/Skill/Technology/Calculated_Strikes)in src)&&Race=="Tuffle")
		contents+=new/Skill/Technology/Calculated_Strikes
		Lrned++
		src<<"You have awoken your race's natural ability to analyze the paces of combat and target specific points."
	if(Int_Level>=58&&!(locate(/Skill/Technology/MakeStatue) in src)&&Int_Mod>2)
		src << "You have learned how to make statues of people."
		contents+=new/Skill/Technology/MakeStatue
		Lrned++
	if(Int_Level>=25&&!(locate(/Skill/Technology/Upgrade_Android) in src)&&Int_Mod>2)
		src << "You now have the ability to upgrade Androids."
		contents+=new/Skill/Technology/Upgrade_Android
		Lrned++
	if(Int_Level>=38&&!(locate(/Skill/Buff/Combat_Mathematics)in src)&&Int_Mod>=5)
		contents+=new/Skill/Buff/Combat_Mathematics
		Lrned++
		src<<"You have awoken your race's natural ability to analyze the paces of combat and respond accordingly."
	if(Int_Level>=38&&!(locate(/Skill/Buff/Combat_Mathematics)in src)&&Race=="Tuffle")
		contents+=new/Skill/Buff/Combat_Mathematics
		Lrned++
		src<<"You have awoken your race's natural ability to analyze the paces of combat and respond accordingly."
	if(Int_Level>=65&&!(locate(/Skill/Technology/Cyborize) in src)&&HasIntMiles>1)
		src << "You now have the ability to cyberize people."
		contents+=new/Skill/Technology/Cyborize
		Lrned++
	if(Int_Level>=68&&Int_Mod>2&&!(locate(/Skill/Technology/Energy_Infusion)in src))
		contents+=new/Skill/Technology/Energy_Infusion
		Lrned++
		src<<"You learned how to use an Energy Infusion to empower someone."
	if(Int_Level>=78&&Int_Mod>3&&!(locate(/Skill/Technology/Cybernetic_Limb)in src))
		contents+=new/Skill/Technology/Cybernetic_Limb
		Lrned++
		src<<"You learned how to use your technology to replace someone's limb with an upgraded version!"
	if(Int_Level>=52&&!(locate(/Skill/Technology/Cosmetic_Surgery) in src)&&HasIntMiles>1)
		src << "You now have the ability to perform cosmetic surgery on someone."
		contents+=new/Skill/Technology/Cosmetic_Surgery
		Lrned++
	if(Int_Level>=61&&!(locate(/Skill/Technology/Stungun) in src)&&Int_Mod>=5)
		src << "You have learned how to stun people with your tech."
		contents+=new/Skill/Technology/Stungun
		Lrned++
	if(Int_Level>=61&&!(locate(/Skill/Technology/Stungun) in src)&&Race=="Tuffle")
		src << "You have learned how to stun people with your tech."
		contents+=new/Skill/Technology/Stungun
		Lrned++
	if(Int_Level>=40&&Int_Mod>3.5&&!(locate(/Skill/Technology/Pray) in src)&& EXPLifetime>=990)
		src << "You have learned to create an artificial divine being."
		contents+=new/Skill/Technology/Pray
		Lrned++



//	if(Mining_Level>=2&&!(locate(/obj/Sense_Exit)in src))
//		contents+= new/obj/Sense_Exit
//		src<<"You have learned how to sense the ki comming from the exit caves!"


	if(FBMAchieved&&!(locate(/Skill/Misc/Leave_Planet)in src))
		contents+=new/Skill/Misc/Leave_Planet
		src<<"Your great power and energy have lead to you developing the power to leave a planet's orbit by flight alone, though it will have a cooldown."

	if(Lrned)
		Remove_Duplicate_Moves()
/*
Skill/proc/Teachify(mob/use,mob/A,var/Passive=null)
	if(Tier==5&&!use.Rank)
		use<<"Only a rank may teach this skill."
		return
	if(Tier==5&&A.EnablementSlot)
		use<<"They can only learn one tier 5 buff."
		return
	if(Tier>3&&Tier!=5)
		usr<<"Tier 3 and 4 skills may no longer be taught directly and instead the person must develop it on their own using EXP."
		return
	if(use.TeachCD>=use.TeachLimit&&!use.Rank)
		use<<"You have already taught everyone you can this month and must wait."
		return 0
	if(TeachYear>Year)
		use<<"You may not teach this until year [TeachYear]."
		return 0
	for(var/Skill/SS in A) if(SS.type==type)
		use<<"They already have this ability."
		return 0
	switch(Tier)
		if(1)

			if(Passive)switch(Passive)
				if("Melee")
					if(A.UnarmedSkill<50)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Unarmed Skill. (50)"
						return 0
				if("Weapon")
					if(A.SwordSkill<50)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Weapon Skill. (50)"
						return 0
				if("Ki")
					if(A.KiManipulation<50)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Ki Manipulation. (50)"
						return 0

		if(2)
			if(A.Age<5)
				view(use)<<"[use] tried to teach [A] the [src] ability, but [A] was too young. (5+)"
				return 0
			if(Passive)switch(Passive)
				if("Melee")
					if(A.UnarmedSkill<250)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Unarmed Skill. (250)"
						return 0
				if("Weapon")
					if(A.SwordSkill<250)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Weapon Skill. (250)"
						return 0
				if("Ki")
					if(A.KiManipulation<250)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Ki Manipulation. (250)"
						return 0

		if(3)
			usr<<"Tier 3 skills are no longer teachable and must be developed on their own by spending EXP."
			return
		if(4)
			usr<<"Tier 4 skills are no longer teachable and must be developed on their own by spending EXP."
			return
		if(5)
			if(!use.Rank)
				usr<<"You must be a rank in order to teach this."
				return
			if(A.Age<5)
				view(use)<<"[use] tried to teach [A] the [src] ability, but [A] was too young. (5+)"
				return 0
			if(A.EnablementSlot)
				usr<<"They already possess great skill."
				return 0
	if(src.Teach < 1)
		view(use)<<"[use] tried to teach [A] the [src] ability, but [use] is not able to teach it yet. ([round(10/usr.TeachLimit)] Months per recharge)"
		return 0
	if(RequiresApproval&&usr.Rank)
		if(HasApproval["[A.real_name]"]&&HasApproval["[A.real_name]"]<=Year)
			TeachingHook(use,A,src)
			HasApproval.Remove("[A.real_name]")
		else
			use<<"You must first mark this person as a student of [src] 1 day before teaching."
			return 0
	src.Teach --
	if(src.Teach<0) src.Teach = 0
	TeachYear=Year+TeachCD
	use.TeachCD+=1
	if(A.AlignmentNumber>1&&use.AlignmentNumber>1) use.AlignmentNumber+=0.3
	view(use)<<"[use] taught [A] the [src] ability."
	//("[key_name(use)] taught [key_name(A)] [src]")
	A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was taught [src] by [key_name(use)]")
	usr.saveToLog("| ([use.x], [use.y], [use.z]) | [key_name(use)] taught [key_name(A)] [src]")
	var/Skill/NA=new type(A)
	A.contents+=NA
	NA.desc += "<br>You were taught this at year [Year] from [use]."
	//NA.LearnedYear=Year
	logAndAlertAdmins("[key_name(use)] successfully taught [key_name(A)] the [src] ability.",2)
	if(Tier==5) A.EnablementSlot=1
	return 1


	for(var/Activity/O in use) if(O.Subtype=="Teach")
		O.CheckProgress(1,0,use)
		use<<"You have gained progress on your daily activity. ([O])"
	for(var/Activity/O in A) if(O.Subtype=="Learn")
		O.CheckProgress(1,0,A)
		A<<"You have gained progress on your daily activity. ([O])"
*/





