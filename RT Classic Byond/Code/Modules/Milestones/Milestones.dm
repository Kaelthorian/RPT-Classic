Milestone
	parent_type=/obj
	var/YearAcquired=0
	//var/PointsSpent=0
	var/Ranks=0
	var/MaxRanks=1
	var/PointsCost=0
	var/MPvar
	var/Refundable=1
	var/AlienMP=0
	var/UB1
	var/UB2
	desc="This is a milestone.  This one is a placeholder."

	Click()
		..()
		if(src)
			for(var/Milestone/MM in usr) if(MM.AlienMP&&AlienMP)
				usr<<"You already have an Alien MP."
				return
			if(usr.vars[MPvar]>=MaxRanks)
				usr<<"You have already bought the last rank of this."
				return
			else if(AlienMP&&usr.Race!="Alien")
				usr<<"You must be the Alien race to buy Alien MP."
				return
			if(usr.InMiles) return
			usr.InMiles=1

			var/CostUse=src.PointsCost
			/*if(istype(src,/Milestone/Intelligence))CostUse=max(1,usr.HasIntMiles*2)
			if(istype(src,/Milestone/Mysticism))CostUse=max(1,usr.HasMagicMiles*2) */

			var/Choice=alert(usr,"Buy [src] (Cost [CostUse]): [src.desc] [src.Refundable==0?"Non-Refundable!":""]","[src] [src.MaxRanks>1?"[usr.vars[src.MPvar]+1] / [src.MaxRanks]":""]","Yes","No")
			switch(Choice)
				if("Yes")
					if(usr.MilestonePoints>=CostUse)
						usr.MilestonePoints-=CostUse
						var/Milestone/C= new src.type
						if(locate(C) in usr)
							var/Milestone/newMPu = (locate(C) in usr)
							newMPu.Ranks++
							usr.vars[newMPu.MPvar]+=1
							usr.contents+=newMPu
							usr<<"You bought [newMPu] [newMPu.MaxRanks>1?"[usr.vars[newMPu.MPvar]] / [newMPu.MaxRanks]":""]!"
						else
							C.Ranks=1
							C.YearAcquired=Year
							usr.vars[C.MPvar]=1
							usr.contents+=C
							usr<<"You bought [C] [C.MaxRanks>1?"[usr.vars[C.MPvar]] / [C.MaxRanks]":""]!"
						if(istype(C,/Milestone/Pursuit_Of_Knowledge))
							usr.Int_Mod+=0.5
							usr.Magic_Potential+=0.5
							usr.magicfocus="Magical Skill"
							usr.ifocus="Intelligence"
						if(istype(C,/Milestone/Intelligence))usr.Int_Mod++
						if(istype(C,/Milestone/Mysticism))usr.Magic_Potential++
//						if(istype(C,/Milestone/Genius)) usr.Int_Mod++
//						if(istype(C,/Milestone/Mystical)) usr.Magic_Potential++
//						if(istype(C,/Milestone/I_Studied_The_Blade)) usr.contents+=new/Skill/Buff/Bound_Weapon
//						if(istype(C,/Milestone/Well_Studied))
//							usr.Int_Mod+=0.5
//							usr.Magic_Potential+=0.5
						if(istype(C,/Milestone/Resolve_Of_The_Mountain))
							usr.MaxHealth+=20
							usr.Health+=20
							usr.MaxWillpower+=20
							usr.Willpower+=20
						if(istype(C,/Milestone/Sturdy_Build))
							for(var/BodyPart/L in usr)
								L.MaxHealth+=5
//						if(istype(C,/Milestone/Matter_Absorb)) usr.contents+=new/Skill/Misc/Absorb
//						if(istype(C,/Milestone/Burning_Fists)) usr.contents+=new/Skill/Unarmed/BurningFists
						if(istype(C,/Milestone/Aim_For_The_Heart)) usr.contents+=new/Skill/Misc/AimForTheHeart
						if(istype(C,/Milestone/Icey_Grip)) usr.contents+=new/Skill/Misc/Icey_Grip
//						if(istype(C,/Milestone/Bleeding_Edge)) usr.contents+=new/Skill/Weapon/BleedingEdge
//						if(istype(C,/Milestone/Thundering_Blows)) usr.contents+=new/Skill/Weapon/ThunderingBlows
						if(istype(C,/Milestone/Chakra_Blocking)) usr.contents+=new/Skill/Melee/Chakra_Blocking
//						if(istype(C,/Milestone/Custom_Beam)) usr.contents+=new/Skill/Attacks/Beams/CustomEnergyWave
//						if(istype(C,/Milestone/Brood_Mother))
//							usr.HiveMind=usr.Signature
//							usr.contents+=new/Skill/Misc/HiveMind
						if(istype(C,/Milestone/Mana_Siphon)) usr.contents+=new/Skill/Misc/Mana_Siphon
						if(istype(C,/Milestone/Custom_Language))
							var/Language/CustomLanguage/CL = new
							CL.name=input("Name your custom language. (Adhere to all other rules when choosing this name.  Troll/Toxic names will result in punishment.)") as text
							usr.contents+=CL


//						if(istype(C,/Milestone/Imitate))
//							usr.contents+=new/Skill/Support/Invisibility
//							usr.contents+=new/Skill/Support/Imitation
//						if(istype(C,/Milestone/Time_Freeze))
//							usr.contents+=new/Skill/Attacks/Time_Freeze
//						if(istype(C,/Milestone/Death_Regeneration))
//							usr.HasDeathRegen=1
//							usr.Regenerate+=2
//							usr.BaseRegeneration+=0.4
//							usr.CanLimbRegen=1
//						if(istype(C,/Milestone/Ki_Manipulation)) usr.KiManipulation+=50
//						if(istype(C,/Milestone/Unarmed_Mastery)) usr.UnarmedSkill+=50
//						if(istype(C,/Milestone/Weapon_Training)) usr.SwordSkill+=50
//						if(istype(C,/Milestone/Evasive_Maneuvering)) usr.Athleticism+=50


						usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bought [C] for [CostUse] MP.\n")
						alertAdmins("[key_name(usr)] bought [C] for [C.PointsCost] MP.")
						usr.Reset_StatMultipliers()
						usr.InMiles=0

					else
						usr.InMiles=0
						usr.AllOut("You need [CostUse] milestone points to choose [src].")
				if("No") usr.InMiles=0
/*
	Imitate
		PointsCost=0
		Refundable=0
		AlienMP=1
		MPvar="HasImitate"
		desc="You can use this on someone to imitate them in almost every way, so much so that you may be confused with them. You can hit it again to stop imitating. Choosing this MP will also grant you the invisibility skill."
	Death_Regeneration
		PointsCost=0
		Refundable=0
		AlienMP=1
		MPvar="HasDeathRegen"
		desc="This will grant you 3 charges of death regen and a small increase to the Base Regeneration stat.  You can not get additional charges after using them."
	Precognition
		PointsCost=0
		Refundable=0
		AlienMP=1
		MPvar="HasPrecognition"
		desc="This will cause you to attempt to auto dodge projectile based attacks at the cost of a small amount of energy. This will increase the amount your Speed contributes towards Defense to 40% from 30%."
	Time_Freeze
		PointsCost=0
		Refundable=0
		AlienMP=1
		MPvar="HasTimeFreeze"
		desc="This will send paralyzing energy rings all around nearby people and they will not be able to move until it wears off."
	Matter_Absorb
		PointsCost=0
		Refundable=0
		AlienMP=1
		MPvar="HasMatterAbsorb"
		desc="This will allow you to absorb people and take a portion of their power into yourself. (Max +30% base as absorb BP)"
/*	Genius
		PointsCost=4
		Refundable=0
		AlienMP=1
		MPvar="HasGenius"
		desc="This will increase your base Int mod to 2x."
	Mystical
		PointsCost=4
		Refundable=0
		AlienMP=1
		MPvar="HasMystical"
		desc="This will increase your base Magic mod to 2x." */
	Well_Studied
		PointsCost=0
		Refundable=0
		AlienMP=1
		MPvar="HasWellStudied"
		desc="This will increase your base Magic mod to 1.5x and base Int mod to 1.5x."
	Brood_Mother
		PointsCost=0
		Refundable=0
		AlienMP=1
		MPvar="HasBroodMother"
		desc="This will increase your child limit by +4 and gives your Mate no CD as well as linking you and all offspring via hive mind."

*/
//Variable MPs
	Intelligence
		PointsCost=2
		MaxRanks=4
		Refundable=0
		MPvar="HasIntMiles"
		desc="This will increase your Int mod by +1 for each rank, it will also decrease your BP by 7.5% each rank."
		UB1="Machine Force"
		UB2="Bushido"
	Mysticism
		PointsCost=2
		MaxRanks=4
		Refundable=0
		UB1="Arcane Power"
		UB2="Shadow King"
		MPvar="HasMagicMiles"
		desc="This will increase your Magic mod by +1 for each rank, it will also decrease your BP by 5% each rank."



//	__Tier_1_Milestones
/*	Pilot_Skill
		PointsCost=1
		UB1="Machine Force"
		UB2=""
		Refundable=0
		MPvar="HasPilotSkill"
		desc="This will allow you to pilot ships." */
	Key_Ring
		PointsCost=1
		Refundable=0
		MPvar="HasKeyRing"
		UB1="Channel"
		desc="This will make it so door passes do not take inventory slots.  In addition, you will gain +10% max ki. (Backend)"
	Deep_Breathing
		PointsCost=1
		MaxRanks=2
		UB1="Fists of Fury"
		UB2="High Tension"
		MPvar="HasDeepBreathing"
		desc="This will increase you recovery ticks while hitting someone by 12.5% per rank"
	Building_Permit
		PointsCost=1
		UB1="Machine Force"
		UB2="Shadow King"
		Refundable=0
		MPvar="HasBuildingPermit"
		desc="This will allow you to build turf and objects. This will make every level you upgrade a wall/door grant 3x as much HP and make all resources and mana you put into it worth 3x the amount you invest. This will also make building free for you. This will cause you to inflict double damage to all buildings and objects."
//	Extension_Of_My_Arm
//		PointsCost=1
//		MPvar="HasEOMA"
//		UB1="Bushido"
//		UB2="Machine Force"
//		desc="This will make it so handheld weapons(Swords and Hammers) no longer take inventory space and you become immune to disarms."
	State_Of_Zen
		PointsCost=1
		MaxRanks=2
		MPvar="HasStateOfZen"
		desc="This will increase your meditation gains by 33% per rank. (Non refundable. Does not affect int/magic exp)"
	Body_Builder
		PointsCost=1
		MaxRanks=2
		UB1="High Tension"
		UB2="Kaioken"
		MPvar="HasBodyBuilder"
		desc="This will increase your self train gains by 50% per rank. "
	Practical_Learner
		PointsCost=1
		UB2="High Tension"
		UB1="Fists of Fury"
		MaxRanks=2
		MPvar="HasPracticalLearner"
		desc="This will increase your sparring gains by 50% per rank. "
	Exponential_Growth
		PointsCost=1
		MaxRanks=2
		Refundable=0
		UB1="High Tension"
		UB2="Kaioken"
		MPvar="HasExponentialGrowth"
		desc="This will increase your gain while using punching bags by 50% per rank. "
//	Unflinching
//		PointsCost=1
//		MaxRanks=2
//		UB1="Bestial Wrath"
//		UB2="Fungal Plague"
//		MPvar="HasUnflinching"
//		desc="This will increase your crowd control and knockback resistance by 2.5 per rank. "
//	Turtle_Shell
//		PointsCost=1
//		MaxRanks=2
//		UB1="Bestial Wrath"
//		UB2="Fungal Plague"
//		MPvar="HasTurtleShell"
//		desc="This will increase Endurance towards attacks from behind by 15% per rank."
	Surgical_Strikes
		PointsCost=1
		MaxRanks=5
		UB1="Fists of Fury"
		UB2="Godspeed"
		MPvar="HasSurgicalStrikes"
		desc="This will give you a flat +10% damage to your opponents limbs, rank 5 will cause you to be able to see your target's limb health."

//	__Tier_2_Milestones
	Bulls_Eye
		PointsCost=2
		MaxRanks=4
		MPvar="HasBullsEye"
		UB1="Bestial Wrath"
		UB2="Machine Force"
		desc="This will give you a flat +3% chance to hit with projectile based attacks."
	Flight_Master
		PointsCost=2
		UB2="Godspeed"
		UB1="Arcane Power"
		MPvar="HasFlightMaster"
		desc="This will reduce the cost of Flight and Super Flight to 5% its normal cost."
	Beast_Of_Burden
		PointsCost=2
		UB1="Bestial Wrath"
		UB2="High Tension"
		MPvar="HasBeastOfBurden"
		desc="This will increase your inventory space by 10 and increase your Strength by 3%. (Backend)"
	Deft_Hands
		PointsCost=2
		MaxRanks=4
		UB1="Godspeed"
		UB2="Fists of Fury"
		MPvar="HasDeftHands"
		desc="This will give you a flat +2.5% chance to hit. (Only affects melee attacks)"
	Swift_Reflexes
		PointsCost=2
		UB1="Godspeed"
		UB2="Bestial Wrath"
		MaxRanks=4
		MPvar="HasSwiftReflexes"
		desc="This will give you a flat +2.5% chance to dodge. (Only affects melee attacks)"
	Way_Of_The_Turtle
		PointsCost=2
		UB2="Fungal Plague"
		UB1="Bestial Wrath"
		MaxRanks=4
		MPvar="HasWayOfTheTurtle"
		desc="This will give you a flat +2.5% chance to block. (Only affects melee attacks)"
	Fleet_Of_Foot
		PointsCost=2
		MaxRanks=2
		UB1="Godspeed"
		UB2="Bushido"
		Refundable=0
		MPvar="HasFleetOfFoot"
		desc="This will give you a flat +5% movespeed per rank. (Does not affect flying.)"
	Auto_Driller
		PointsCost=2
		Refundable=0
		UB1="Machine Force"
		MPvar="HasAutoDriller"
		desc="This will grant you the ability to passively generate resources using your hand drill."
/*	NRA_Membership
		PointsCost=2
		UB1="Machine Force"
		MPvar="HasNRAMembership"
		desc="This will make you deal +30% damage when firing guns. Gives a 30% chance to not consume ammo when firing."
	Elite_Gun_Training
		PointsCost=2
		UB1="Machine Force"
		MPvar="HasEliteGunTraining"
		desc="This will cause any guns you fire to be modified by your BP multiplier and add 20% of your offense as accuracy." */
	The_Seed_Is_Strong
		PointsCost=2
		Refundable=0
		UB1="Fungal Plague"
		MPvar="HasTheSeedIsStrong"
		desc="This will allow you to have 2 more offspring and reduce your offspring's incline age by 3."
	Deep_Pockets
		PointsCost=2
		UB1="Shadow King"
		UB2="Machine Force"
		MaxRanks=3
		Refundable=0
		MPvar="HasDeepPockets"
		desc="This will reduce the cost of everything that costs resources or mana by 15% per rank."
	Mana_Siphon
		desc="This will cause you to constantly gain passive mana at 5% the normal rate, no matter what you are doing. This stacks with meditating for mana."
		PointsCost=2
		UB1="Fungal Plague"
		UB2="Arcane Power"
		Refundable=0
		MPvar="HasManaSiphon"
	Custom_Language
		PointsCost=2
		Refundable=0
		MPvar="HasCustomLanguage"
		desc="This will grant you a customizable language. "
	Master_Chef
		desc="This will cause food you cook to have an increased duration. (Worth +50 Cooking levels)"
		PointsCost=2
		UB1="Fungal Plague"
		MPvar="HasMasterChef"
	Sturdy_Build
		PointsCost=2
		MaxRanks=2
		UB1="High Tension"
		UB2="Bestial Wrath"
		MPvar="HasSturdyBuild"
		desc="This will increase your knockback resistance by 2.5% everytime this is taken, up to a max of +5% KB resist. This will also increase Endurance by 3% per rank up to a max of 6%. This is applied in the backend and you will not see a change in End/Res mult. Each rank also increases the Max Health of all of your body parts by 5."
//	Eat_The_Rich
//		PointsCost=2
//		UB1="Fungal Plague"
//		UB2="Kaioken"
//		MPvar="HasEatTheRich"
//		desc="Deal +5% damage to anyone with more than 50 million resources and mana on them."
//	Midas_Punch
//		PointsCost=2
//		UB1="Fists of Fury"
//		UB2="Machine Force"
//		MPvar="HasMidasPunch"
//		desc="Deal +5% damage to anyone while you have more than 50 million resources and mana on you."
	New_Type
		desc="This will you to take 0.5% less damage and deal 0.5% more damage for every space tile 10 tiles, up to 10% in each. In addition you will also be able to pilot Power Armor (But not Gundams.). Reduces the speed penalty of Power Armor from 0.8x to 0.9x"
		PointsCost=2
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasNewType"
	Energy_Movement
		PointsCost=2
		UB1="Godspeed"
		UB2="Kaioken"
		MPvar="HasEnergyMovement"
		desc="Allows you to zanzoken while charging or firing an attack."
//	__Tier_3_Milestones
	One_Two_Punch
		PointsCost=3
		MaxRanks=4
		UB1="Fists of Fury"
		UB2="High Tension"
		MPvar="HasFireKeeper"
		desc="This will give you +10% attack speed per rank."
	Mining_Expert
		PointsCost=3
		Refundable=0
		MPvar="HasMiningExpert"
		UB1="Machine Force"
		UB2="Shadow King"
		desc="This will increase your natural dig rate by 1.5x and your Endurance by 2%."
	Mana_Expert
		PointsCost=3
		UB1="Arcane Power"
		UB2="Shadow King"
		Refundable=0
		MPvar="HasManaExpert"
		desc="This will increase your natural mana rate by 1.5x and your Defense by 2%."
	Rapid_Deployment
		PointsCost=3
		UB1="Godspeed"
		UB2="Fists of Fury"
		MPvar="HasRapidDeployment"
		desc="This will cause your Lethal Combat Tracker to tick down at 2x the regular rate. In addition increases your speed by 5% backend. It will also add 2 to Flee/Chase rolls."
	Fast_Metabolism
		PointsCost=3
		UB1="Fungal Plague"
		UB2="Godspeed"
		MPvar="HasFastMetabolism"
		desc="This will cause you to take 5% less damage while you have the a food buff active."
	Salt_Of_The_Earth
		PointsCost=3
		UB1="Fungal Plague"
		UB2="Fungal Plague"
		MPvar="HasSaltOfTheEarth"
		desc="This will cause you to gain anger at 2x the normal rate. "
//	Hypermetabolic_Digestive_Enzymes
//		PointsCost=3
//		UB1="Fungal Plague"
//		UB2="Kaioken"
//		MPvar="HasHyperEnzymes"
//		desc="This will cause you to get +125% (1.25) to the food boost to regen and recov ticks, but it will only last 25% as long."
	Swordsman
		PointsCost=3
		UB1="Bushido"
		UB2="Bushido"
		desc="This will increase your Offense by 8% while using a sword."
		MPvar="HasSwordsman"
//	Hemophilia
//		UB1="Fungal Plague"
//		UB2="Fungal Plague"
//		desc="This will increase your chance to bleed.  For every pool of blood within 10 tiles, you will take 0.5% less damage and deal 0.5% more damage, up to 10% in each. (Will not work for Androids.) In addition you will gain 2.5% offense."
//		PointsCost=3
//		MPvar="HasHemophilia"
//	King_Of_The_Sea
//		desc="For every tile of water within 15 tiles, you will take 0.5% less damage and deal 0.5% more damage, up to 10% in each. (Doesn't count surf.) In addition you will gain 2.5% defense."
//		PointsCost=3
//		UB1="Shadow King"
//		UB2="Shadow King"
//		MPvar="HasKingOfTheSea"
//	Fire_Lord
//		desc="This will you to take 0.5% less damage and deal 0.5% more damage for every object/turf on fire and burning embers within 10 tiles and person on fire, up to 10% boost to damage and damage reduction. In addition you will gain 2.5% might."
//		PointsCost=3
//		UB1="War"
//		UB2="War"
//		MPvar="HasFireLord"
	Friend_Or_Foe
		PointsCost=3
		UB1="War"
		UB2="Shadow King"
		MPvar="HasFriendOrFoe"
		desc="This will make you deal -10% damage to teammates and +5% damage to enemies."
//	Side_Swipe
//		PointsCost=3
//		UB1="Fists of Fury"
//		UB2="Godspeed"
//		MPvar="HasSideSwipe"
//		desc="Attacks against an opponent's side will have +10% flat accuracy."
	Will_Unbroken
		UB1="Arcane Power"
		UB2="Kaioken"
		PointsCost=3
		MPvar="HasWillUnbroken"
		desc="This will cause your Resist skill to have no cooldown and cost 3% energy instead of 10%. In addition, each time you get up from a lethal KO, you will gain 5 WP."
	Zanzoken_Mastery
		PointsCost=3
		UB1="Godspeed"
		UB2="Godspeed"
		MPvar="HasZanzokenMaster"
		desc="This will reduce the cost of Zanzoken to 5% its normal cost. It will increase the damage of warp combo and Warp Attack by 30%. This will cause your zanzoken charges to reset quicker."




//	__Tier_4_Milestones
//	Moral_Compass
//		PointsCost=4
//		UB1="Fists of Fury"
//		UB2="Kaioken"
//		MPvar="HasMoralCompass"
//		desc="Depending on your alignment this will grant a different bonus. Good: +10% Defense, Evil +10% Offense, Neutral +5% Off and Def"
	Desperate_Struggle
		PointsCost=4
		UB1="Kaioken"
		UB2="High Tension"
		MPvar="HasDesperateStruggle"
		Refundable=0
		desc="This will increase Offense by 20% while below 50 Willpower."
	Desperate_Resolve
		PointsCost=4
		UB1="War"
		UB2="Kaioken"
		MPvar="HasDesperateResolve"
		Refundable=0
		desc="This will increase Endurance by 20% while below 50 Willpower."
	Desperate_Maneuvers
		PointsCost=4
		UB1="Fists of Fury"
		UB2="Kaioken"
		MPvar="HasDesperateManeuvers"
		Refundable=0
		desc="This will increase Defense by 20% while below 50 Willpower."
	Desperate_Speed
		PointsCost=4
		UB1="Godspeed"
		UB2="Kaioken"
		MPvar="HasDesperateSpeed"
		Refundable=0
		desc="This will increase Speed by 20% while below 50 Willpower."
	Cleanse_The_Wicked
		PointsCost=4
		UB1="Fists of Fury"
		UB2="Bushido"
		MPvar="HasCleanseWicked"
		desc="This will cause you to gain +5% damage per kill your opponent has, up to +15% at 3 kills."
	Enchant_Master
		PointsCost=4
		UB1="Arcane Power"
		UB2="Shadow King"
		MPvar="HasEnchantMaster"
		desc="This will make you able to enchant items up to 15% total stats (5 stats with 3%, 3% in one stat is the max) and reduces the cost of it by 50%."
	Endless_Expanse
		PointsCost=4
		UB1="High Tension"
		UB2="Fists of Fury"
		MPvar="HasExpand5"
		desc="This will cause your expand to give you 35% Endurance instead of 25%."
	Boundless_Stamina
		PointsCost=4
		Refundable=0
		UB1="Kaioken"
		UB2="High Tension"
		MPvar="HasBoundlessStamina"
		desc="This will increase your ki reserves by 25%. In addition, self train will cost 90% less energy."
//	Burning_Fists
//		PointsCost=4
//		UB1="Fists of Fury"
//		UB2="Kaioken"
//		MPvar="HasBurningFists"
//		desc="Gives your melee attacks a 50% chance to cause burning damage. (Does not work with swords or hammer.)"
//	Bleeding_Edge
//		PointsCost=4
//		UB1="Bushido"
//		UB2="Death"
//		MPvar="HasBleedingEdge"
//		desc="Gives your melee attacks with a weapon a 50% chance to cause bleeding damage. "
//	Thundering_Blows
//		desc="Gives your melee attacks with a weapon a 50% chance to cause an extra tick of 10% of the damage of the original attack and apply one tick of stagger OR cause a short stun. "
//		PointsCost=4
//		UB1="Bushido"
//		UB2="War"
//		MPvar="HasThunderingBlows"
	Energy_Marksmanship
		PointsCost=4
		UB1="Channel"
		UB2="Channel"
		MPvar="HasEnergyMarksmanship"
		desc="Increases the accuracy of all of your blast based attacks by a flat 10% and gives a 30% chance to ignore Precognition. In addition, all of your projectile based attacks will receive an additional 5% homing."
//	Exploit_Weakness
//		PointsCost=4
//		UB1="Bestial Wrath"
//		UB2="Fungal Plague"
//		MPvar="HasExploitWeakness"
//		desc="Attacks against an opponent's back will have +10% damage and +25% flat accuracy."
	Float_Like_A_Butterfly
		PointsCost=4
		UB1="Bestial Wrath"
		UB2="Fungal Plague"
		MPvar="HasFloatLike"
		desc="Each time you dodge an opponent's attack verb they will lose 5% of their total current energy."
	Keep_Your_Enemies_Closer
		PointsCost=4
		UB2="Shadow King"
		UB1="War"
		MPvar="HasKeepYourEnemies"
		desc="This will cause you to deal extra damage against people you have contact points with, up to +5% damage at 50 CP."
	Lone_Wolf
		PointsCost=4
		UB1="Bestial Wrath"
		UB2="Fists of Fury"
		MPvar="HasLoneWolf"
		desc="This will cause you to deal 5% extra damage and take 5% less damage as long as you have no one in your Team and are not a part of a Faction."
	Agile_Nature
		PointsCost=4
		UB1="Godspeed"
		UB2="Fists of Fury"
		MPvar="HasAgileMastery"
		desc="This will increase your Speed by 25%, your offense by 5%, and your defense by 5% while wearing no armor at all and no helmet."
	Armor_Mastery
		PointsCost=4
		UB1="War"
		UB2="Bestial Wrath"
		MPvar="HasArmorMastery"
		desc="This will cause wearing armor, power armor and Gundams to buff your Endurance by an extra 7% and will remove the Spd nerf for all normal armors."
	Shield_Mastery
		PointsCost=4
		UB1="War"
		UB2="Bestial Wrath"
		MPvar="HasShieldMaster"
		desc="This will cause your shield to increase your Endurance by an extra 5%."
	Range_Of_Motion
		PointsCost=4
		UB1="Godspeed"
		UB2="Godspeed"
		MPvar="HasRangeOfMotion"
		desc="This will increase your Offense and Defense by 10% each while wearing no armor, no helmet and not using a handheld weapon. (No Armor, Swords or Hammer.)"
	Wild_Animal
		PointsCost=4
		UB1="Bestial Wrath"
		UB2="Bestial Wrath"
		Refundable=0
		MPvar="HasWildAnimal"
		desc="This will increase your Might by 5% for every 15 Willpower you are missing, up to +20%."
	Chakra_Blocking
		PointsCost=4
		MPvar="HasChakraBlocking"
		UB1="Fungal Plague"
		UB2="Fungal Plague"
		desc="Gives you an attack that drains 1.5x its damage from the target's energy and freezes their recovery for 3 seconds."
	We_Have_The_Technology
		desc="This will allow you to cyberize other people, provided you know how to cyberize yourself already, and cyberizing yourself or others will automatically install all cyber limbs. "
		PointsCost=4
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasWeHaveTheTechnology"
		Refundable=0
	Hammer_Time
		PointsCost=4
		UB1="Bushido"
		UB2="War"
		MPvar="HasHammerTime"
		desc="This will increase your Speed and Offense by 6% while using a hammer."
	Way_Of_The_Fist
		desc="Increases Strength by 10% while not using a weapon."
		PointsCost=4
		UB1="Fists of Fury"
		UB2="High Tension"
		MPvar="HasWayOfTheFist"
	Anchor_Arms
		PointsCost=4
		UB1="High Tension"
		UB2="Fists of Fury"
		MPvar="HasThrowYourWeight"
		desc="This will grant you 10% of your Endurance as Strength."
	Pursuit_Of_Knowledge
		desc="This will cause you to gain both Int and Magic exp when focused on one or the other. This will also increase your Int and Magic mods by +0.5"
		PointsCost=4
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasPursuitOfKnowledge"
		Refundable=0
//	Refuse_To_Lose
//		desc="This will increase your chance for Refuse to Die from  2% to a 7% chance, Burning Desire for Victory by 2x, and your chances for a Decisive Blow by 10%. This will also reduce your cooldown on those from one hour to ten minutes."
//		PointsCost=4
//		Refundable=0
//		UB1="Kaioken"
//		UB2="War"
//		MPvar="HasRefuseToLose"
	Master_Blacksmith
		desc="This will cause any weapon or armor you create or infuse with metal to have +5% Max BP Add. In addition, your Mining and Smithing levels are increased by 15 (Will not show up on your character sheet.) Increases the rate at which you find Heart of the Mountain by 2x"
		PointsCost=4
		Refundable=0
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasMasterBlacksmith"
		verb/Reforge()
			set category="Other"
			var/list/L=list()
			for(var/obj/items/Sword/A in view(1,usr))L+=A
			for(var/obj/items/Hammer/A in view(1,usr))L+=A
			for(var/obj/items/Gauntlets/A in view(1,usr))L+=A
			for(var/obj/items/Armor/A in view(1,usr))L+=A
			L+="Cancel"
			var/obj/items/I=input("Reforge what?") in L
			if(L!="Cancel")
				if(istype(I,/obj/items/Armor))
					var/obj/items/Armor/AA=I
					AA.KineticBarrier=initial(AA.KineticBarrier)+5
				else I.MaxBPAdd=initial(I.MaxBPAdd)+5



//		Refundable=0
//	__Tier_5_Milestones
	Beam_Expert
		PointsCost=5
		UB1="Channel"
		UB2="Fungal Plague"
		MPvar="HasBeamExpert"
		desc="This will change your Beam to be 3 tiles wide but drain 2 times as much and do 75% damage."
	Concentrated_Fire
		PointsCost=5
		UB1="Channel"
		UB2="War"
		MPvar="HasConcentratedFire"
		desc="This will cause you to deal 10% more damage to your target, but 5% less damage to anyone that is not targeted."
//	__Tier_6_Milestones
	Embrace_The_Future
		desc="This will cause all of your cyber limbs to give 2x the benefit and reduce the regeneration penalty by 80%. "
		PointsCost=6
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasEmbraceTheFuture"
	Heavy_Armor_Training
		PointsCost=6
		UB1="War"
		MPvar="HasHeavyArmorTraining"
		desc="Allows you to wear armor and helmets at the same time."
	Resolve_Of_The_Mountain
		PointsCost=6
		UB1="Kaioken"
		UB2="High Tension"
		Refundable=0
		MPvar="HasResolveOfTheMountain"
		desc="This will increase your Max Health and Max Willpower by +20"
	A_Swift_Death
		desc="This will cause any KO you inflict in lethal to reduce the victim's willpower by an extra 10. "
		PointsCost=6
		UB1="Death"
		UB2="Arcane Power"
		Refundable=0
		MPvar="HasASwiftDeath"
	Xenophobia
		desc="This will cause you to deal 10% more damage to other races, but you will take 3% more damage from them."
		PointsCost=6
		UB1="War"
		UB2="Fungal Plague"
		MPvar="HasXenophobia"
	Grime_Reaper
		PointsCost=6
		UB1="Death"
		UB2="Arcane Power"
		MPvar="HasGrimeReaper"
		desc="This will cause you to gain +5% damage per kill, up to +15% at 3 kills."
	Forceful_Negotiator
		PointsCost=6
		UB1="Channel"
		UB2="War"
		MPvar="HasForcefulNegotiator"
		desc="This will increase your Force by 13%."
	Challengers_Mark
		PointsCost=6
		Refundable=0
		UB1="War"
		UB2="Fists of Fury"
		MPvar="HasChallengersMark"
		desc="This will cause you to take 15% less damage from your target."
	The_Best_Defense
		desc="This will cause any damage you deal to be applied as a percentage damage reduction on your next tick of damage. Stacks up to 20% DR and resets on taking damage. (i.e. you deal 5 damage, get 5% DR)"
		PointsCost=6
		UB1="High Tension"
		UB2="Bestial Wrath"
		MPvar="HasBestDefense"
	Berserking
		desc="Berserking reduces your Regeneration by 10%, increases damage by 15%."
		PointsCost=6
		UB1="Kaioken"
		UB2="Bestial Wrath"
		MPvar="HasBerserking"
	I_Like_To_See_You_Bleed
		PointsCost=6
		UB1="Fungal Plague"
		UB2="Death"
		MPvar="HasSeeYouBleed"
		desc="This will cause you to regenerate +15 Willpower whenever you knock someone out in lethal, 3 minute CD. (Event characters may not take this)"
	Way_Of_The_Open_Palm
		desc="This will add 10% of your Speed to normal attack damage calculations while not using a weapon. (Does not affect most skills and you can use gauntlets)"
		PointsCost=6
		UB1="Godspeed"
		UB2="Fists of Fury"
		MPvar="HasWayOfTheOpenPalm"

//	__Tier_8_Milestones

//	I_Studied_The_Blade
//		PointsCost=8
//		UB1="Bushido"
//		UB2="War"
//		MPvar="HasStudiedBlade"
//		desc="This will cause you to learn to summon a physical manifestation of your willpower into a weapon. Counts as all weapon types and has customizable stats. You can not use this with a regular weapon. Has 4 points to invest (Can not invest in Force) and starts with +20% Weapon BP. Drains 0.01 WP per durability loss."
	Smolder
		desc="This will cause your ki to apply burns to your target, giving them a 50% chance of burning them for 30% of the damage dealt over three ticks. Your explosive techniques to leave behind burning embers that will cause damage to those that enter their tile. Lasts for around 15 seconds and deals around 0.7 damage every second. You are not considered to be the origin of this damage, so damage % effects will not increase this."
		PointsCost=8
		UB1="Kaioken"
		UB2="Channel"
		MPvar="HasSmolder"
	Weaponized_Ki
		PointsCost=8
		UB1="Channel"
		UB2="War"
		MPvar="HasWeaponizedKi"
		desc="This will cause your Barrage and Charge attack to benefit from the +BP of your equipped weapon."
	Aim_For_The_Heart
		PointsCost=8
		UB1="Death"
		UB2="Shadow King"
		MPvar="HasAimForHeart"
		desc="This will grant you a timed buff that reduces damage to 10% but it is dealt as pure willpower damage and bypasses HP. (Event characters may not take this)"
	Icey_Grip
		PointsCost=8
		UB1="Death"
		UB2="Shadow King"
		MPvar="HasAimForHeart"
		desc="This will grant you a timed buff that causes your attack verb to apply a slow and have a chance to stun. Lasts around 10 seconds."
//	Double_Attack
//		PointsCost=8
//		UB1="Godspeed"
//		UB2="Shadow King"
//		MPvar="HasDoubleAttack"
//		desc="This will cause you to attack twice in a row 20% of the time when using basic attack."
	Cooldown_Mastery
		PointsCost=8
		UB1="Godspeed"
		UB2="High Tension"
		MPvar="HasCooldownMastery"
		desc="This will cause all of your CDs to tick at 1.5x the regular rate."
	Will_Of_Fire
		desc="This will increase your Regeneration Mod by 0.5(backend), double the rate at which limbs heal. Reduces WP loss from KO by 8."
		PointsCost=4
		UB1="Kaioken"
		UB2="Arcane Power"
		MPvar="HasWillOfFire"
		Refundable=0
	Control_Of_Power
		desc="This will increase recovery ticks by 50% and increases your power up cap. (+3% PU x Recov)"
		PointsCost=8
		UB1="Arcane Power"
		UB2="Shadow King"
		MPvar="HasControlOfPower"
	Blade_Of_Light
		UB1="Channel"
		UB2="Bushido"
		desc="This will cause your Ki Blade/Hammer and Spirit Sword to count as a weapon and cause your Ki Blade to grant 40% Weapon BP instead of 30% and causes your Ki Hammer to only reduce Offense and Speed by 15% insetad of 20%."
		PointsCost=8
		MPvar="HasBladeOfLight"
	As_Long_As_My_Heart_Beats
		desc="This will cause your HP to only reduce your BP down to 75% at 1% HP instead of 30% or 50% for someone cyberized.(Will not work for Androids)"
		PointsCost=8
		UB1="Kaioken"
		UB2="Death"
		MPvar="HasAsLongAsMyHeartBeats"
	This_Drill_Will_Pierce_The_Heavens
		desc="This will cause all of your damage to ignore 20% of your opponents Endurance. "
		PointsCost=8
		UB1="War"
		UB2="Bushido"
		MPvar="HasThisDrill"


mob/proc/MPPurgeRefund()

	for(var/Milestone/MP in src) if(MP.Refundable)
		src.vars[MP.MPvar]=0
		if(istype(MP,/Milestone/Mana_Siphon)) for(var/Skill/Misc/Mana_Siphon/BE in src) del(BE)
//		if(istype(MP,/Milestone/Burning_Fists)) for(var/Skill/Unarmed/BurningFists/BF in src) del(BF)
		if(istype(MP,/Milestone/Aim_For_The_Heart)) for(var/Skill/Misc/AimForTheHeart/BF in src) del(BF)
		if(istype(MP,/Milestone/Icey_Grip)) for(var/Skill/Misc/Icey_Grip/BF in src) del(BF)
//		if(istype(MP,/Milestone/Bleeding_Edge)) for(var/Skill/Weapon/BleedingEdge/BE in src) del(BE)
//		if(istype(MP,/Milestone/Thundering_Blows)) for(var/Skill/Weapon/ThunderingBlows/BE in src) del(BE)
		if(istype(MP,/Milestone/Chakra_Blocking)) for(var/Skill/Melee/Chakra_Blocking/BE in src) del(BE)
//		if(istype(MP,/Milestone/I_Studied_The_Blade)) for(var/Skill/Buff/Bound_Weapon/BE in usr) del(BE)
//		if(istype(MP,/Milestone/Imitate))
//			for(var/Skill/Support/Invisibility/BE in src) del(BE)
//			for(var/Skill/Support/Imitation/BE in src) del(BE)
//		if(istype(MP,/Milestone/Time_Freeze))for(var/Skill/Attacks/Time_Freeze/BE in src) del(BE)
//		if(istype(MP,/Milestone/Death_Regeneration))
//			src.HasDeathRegen=0
//			src.Regenerate=0
//			src.BaseRegeneration-=0.4
//			src.CanLimbRegen=0
		if(istype(MP,/Milestone/Pursuit_Of_Knowledge))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
			src.magicfocus=0
			src.ifocus=0
		if(istype(MP,/Milestone/Intelligence))src.Int_Mod-=1*MP.Ranks
		if(istype(MP,/Milestone/Mysticism))src.Magic_Potential-=1*MP.Ranks
//		if(istype(MP,/Milestone/Genius))src.Int_Mod--
//		if(istype(MP,/Milestone/Mystical))src.Magic_Potential--
//		if(istype(MP,/Milestone/Well_Studied))
//			src.Int_Mod-=0.5
//			src.Magic_Potential-=0.5
		if(istype(MP,/Milestone/Resolve_Of_The_Mountain))
			src.MaxHealth-=20
			src.Health=src.MaxHealth
			src.MaxWillpower-=20
			src.Willpower=src.MaxWillpower
		if(istype(MP,/Milestone/Sturdy_Build))
			for(var/BodyPart/L in usr)
				L.MaxHealth-=5
				L.Health-=5
		if(istype(MP,/Milestone/Pursuit_Of_Knowledge))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
//		if(istype(MP,/Milestone/Ki_Manipulation)) src.KiManipulation-=50*MP.Ranks
//		if(istype(MP,/Milestone/Unarmed_Mastery)) src.UnarmedSkill-=50*MP.Ranks
//		if(istype(MP,/Milestone/Weapon_Training)) src.SwordSkill-=50*MP.Ranks
//		if(istype(MP,/Milestone/Evasive_Maneuvering)) src.Athleticism-=50*MP.Ranks
		Reset_StatMultipliers()
		MilestonePoints+=MP.PointsCost*MP.Ranks
		del MP
	src.BurningFists=0
	src<<"Milestone Points corrected. You will recalculate on month tick."
	src.Reset_StatMultipliers()


mob/proc/MPPurge()

	for(var/Milestone/MP in src)
		src.vars[MP.MPvar]=0
		if(istype(MP,/Milestone/Mana_Siphon)) for(var/Skill/Misc/Mana_Siphon/BE in src) del(BE)
//		if(istype(MP,/Milestone/Burning_Fists)) for(var/Skill/Unarmed/BurningFists/BF in src) del(BF)
		if(istype(MP,/Milestone/Icey_Grip)) for(var/Skill/Misc/Icey_Grip/BF in src) del(BF)
		if(istype(MP,/Milestone/Aim_For_The_Heart)) for(var/Skill/Misc/AimForTheHeart/BF in src) del(BF)
//		if(istype(MP,/Milestone/Bleeding_Edge)) for(var/Skill/Weapon/BleedingEdge/BE in src) del(BE)
//		if(istype(MP,/Milestone/Thundering_Blows)) for(var/Skill/Weapon/ThunderingBlows/BE in src) del(BE)
		if(istype(MP,/Milestone/Chakra_Blocking)) for(var/Skill/Melee/Chakra_Blocking/BE in src) del(BE)
//		if(istype(MP,/Milestone/I_Studied_The_Blade)) for(var/Skill/Buff/Bound_Weapon/BE in usr) del(BE)
//		if(istype(MP,/Milestone/Imitate))
//			for(var/Skill/Support/Invisibility/BE in src) del(BE)
//			for(var/Skill/Support/Imitation/BE in src) del(BE)
//		if(istype(MP,/Milestone/Time_Freeze))for(var/Skill/Attacks/Time_Freeze/BE in src) del(BE)
//		if(istype(MP,/Milestone/Death_Regeneration))
//			src.HasDeathRegen=0
//			src.Regenerate=0
//			src.BaseRegeneration-=0.4
//			src.CanLimbRegen=0
		if(istype(MP,/Milestone/Pursuit_Of_Knowledge))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
			src.magicfocus=0
			src.ifocus=0
		if(istype(MP,/Milestone/Intelligence))src.Int_Mod-=1*MP.Ranks
		if(istype(MP,/Milestone/Mysticism))src.Magic_Potential-=1*MP.Ranks
//		if(istype(MP,/Milestone/Genius))src.Int_Mod--
//		if(istype(MP,/Milestone/Mystical))src.Magic_Potential--
//		if(istype(MP,/Milestone/Well_Studied))
//			src.Int_Mod-=0.5
//			src.Magic_Potential-=0.5
		if(istype(MP,/Milestone/Resolve_Of_The_Mountain))
			src.MaxHealth-=20
			src.Health=src.MaxHealth
			src.MaxWillpower-=20
			src.Willpower=src.MaxWillpower
		if(istype(MP,/Milestone/Sturdy_Build))
			for(var/BodyPart/L in usr)
				L.MaxHealth-=5
				L.Health-=5
		if(istype(MP,/Milestone/Pursuit_Of_Knowledge))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
//		if(istype(MP,/Milestone/Ki_Manipulation)) src.KiManipulation-=50*MP.Ranks
//		if(istype(MP,/Milestone/Unarmed_Mastery)) src.UnarmedSkill-=50*MP.Ranks
//		if(istype(MP,/Milestone/Weapon_Training)) src.SwordSkill-=50*MP.Ranks
//		if(istype(MP,/Milestone/Evasive_Maneuvering)) src.Athleticism-=50*MP.Ranks
		Reset_StatMultipliers()
		del MP
	src.TotalMilestonePoints=0
	src.MilestonePoints=0
	src.BurningFists=0
	src<<"Milestone Points corrected. You will recalculate on month tick."
	if(src.Race=="Alien")
		src.MilestonePoints+=4
		src<<"Alien MP added, you have one year to spend them."
	src.LastMP=0
	src.Reset_StatMultipliers()

var/list/global/Milestones = new //typesof(/Milestone) - /Milestone



proc/SetMPList()
	for(var/C in typesof(/Milestone) - /Milestone) global.Milestones+=new C
mob/verb/seeMP()
	usr<<"[Milestones.Join(", ")]"

mob/verb/Spend_Milestone_Points()
//	SetMPList()
	var/list/MPtoBuy=Milestones
	src=usr
	//SetMPList()
	winclone(src, "GenericSheet", "Milestones2")
	winshow(client,"Milestones2",1)
	winset(client,"Milestones2.Grid","cells=0x0")
	var/Row=0
	for(var/Milestone/MP in MPtoBuy)
		//var/Milestone/MP=new M
		Row++

		var/PointsC=MP.PointsCost
	/*	if(istype(MP,/Milestone/Intelligence))PointsC=max(1,usr.HasIntMiles*2)
		if(istype(MP,/Milestone/Mysticism))PointsC=max(1,usr.HasMagicMiles*2) */

		src << output(MP, "Milestones2.Grid:1,[Row]")
		src << output("[MP.MaxRanks>1?"Rank [usr.vars[MP.MPvar]]/[MP.MaxRanks]<br>":""](Cost [PointsC] MP[MP.Refundable==0?" Non-Refundable!":""])[MP.AlienMP==1?"(Alien Only)":""]", "Milestones2.Grid:2,[Row]")
		src << output("[MP.desc]","Milestones2.Grid:3,[Row]")

mob/var/tmp/InMiles=0
mob/var/LastMPRefund=-5
mob/verb/RefundMP()
	if(InMiles) return
	if(LastMPRefund+4>Year)
		usr<<"You may only refund an MP once every 5 years. Next available on year [LastMPRefund+5]."
		return
	if(usr.EnablementSlot==1)
		usr<<"You can not bring yourself to do this. (Already have an unique buff.)"
		return
	var/list/MPtoRefund=list()
	for(var/Milestone/MP in usr) if(MP.Refundable) MPtoRefund+=MP
	MPtoRefund+="Cancel"
	var/Milestone/C=input("Available Milestones to Refund") in MPtoRefund
	if(C=="Cancel")
		InMiles=0
//		LastMPRefund=0
		return
	var/Choice=alert(usr,"Refund [C] (Cost [C.PointsCost]): [C.desc]","Refund [C] [C.MaxRanks>1?"[usr.vars[C.MPvar]] / [C.MaxRanks]":""]","Yes","No")
	switch(Choice)
		if("Yes")
			usr.MilestonePoints+=C.PointsCost*C.Ranks
			C.Ranks=0
			usr.vars[C.MPvar]=0
			LastMPRefund=Year
			usr<<"You refunded [C]! [C.PointsCost] MP will be earned as catch up Milestone Points."
//			if(istype(C,/Milestone/Burning_Fists)) for(var/Skill/Unarmed/BurningFists/BF in usr)
//				BurningFists=0
//				del(BF)
			if(istype(C,/Milestone/Aim_For_The_Heart)) for(var/Skill/Misc/AimForTheHeart/BF in src) del(BF)
			if(istype(C,/Milestone/Mana_Siphon)) for(var/Skill/Misc/Mana_Siphon/BE in usr) del(BE)
			if(istype(C,/Milestone/Icey_Grip)) for(var/Skill/Misc/Icey_Grip/BF in src) del(BF)
//			if(istype(C,/Milestone/Bleeding_Edge)) for(var/Skill/Weapon/BleedingEdge/BE in usr) del(BE)
//			if(istype(C,/Milestone/Thundering_Blows)) for(var/Skill/Weapon/ThunderingBlows/BE in usr) del(BE)
			if(istype(C,/Milestone/Chakra_Blocking)) for(var/Skill/Melee/Chakra_Blocking/BE in usr) del(BE)
//			if(istype(C,/Milestone/I_Studied_The_Blade)) for(var/Skill/Buff/Bound_Weapon/BE in usr) del(BE)
			Reset_StatMultipliers()
			if(C.Ranks==0) spawn del C
			InMiles=0





mob/var
	MilestonePoints=0
	TotalMilestonePoints=0
	LastMP=0
	ElderRewards=0

mob/proc/Check_Milestones()
	if(LastMP<Year)
		EvasionTeaches=1
		WeaponTeaches=1
		UnarmedTeaches=1
		KiManipTeaches=1
		if(HasWiseMentor)
			EvasionTeaches=2
			WeaponTeaches=2
			UnarmedTeaches=2
			KiManipTeaches=2
	if(Year>LastMP)
		Rep1
		UBCheck()
		if(TotalMilestonePoints<SaveAge)
			LastMP=Year
			TotalMilestonePoints++
			src<<"Milestone Point earned."
			//UBCheck()
			MilestonePoints++
			goto Rep1
	check
	if(SaveAge>(1+ElderRewards)*4.95)
		ElderRewards++
		UBCheck()
		EXP+=50*ElderRewards
		alert(src,"You received [50*ElderRewards] EXP as part of your Elder Reward for committing to the same character.","Elder Rewards")
		goto check



mob/var
	HasBeastOfBurden=0
	HasKiManip=0
	HasStateOfZen=0
	HasBodyBuilder=0
	HasLiberalArtsDegree=0
	HasWildAnimal=0
	HasWeaponizedKi=0
	HasThrowYourWeight=0
	HasPracticalLearner=0
	HasEvasion=0
	HasGrimeReaper=0
	HasHeavyArmorTraining=0
	HasDesperateStruggle=0
	HasDesperateResolve=0
	HasDesperateManeuvers=0
	HasDesperateSpeed=0
	HasEnergyMovement=0
	HasFleetOfFoot=0
	HasSaltOfTheEarth=0
	HasWeHaveTheTechnology=0
	HasWeapon=0
	HasUnarmed=0
	HasFireKeeper=0
	HasKingOfTheSea=0
	HasControlOfPower=0
	HasBuildingPermit=0
	HasArmorMastery=0
	HasAgileMastery=0
	HasNewType=0
	HasStudiedBlade=0
	HasShieldMaster=0
	HasBeamExpert=0
	HasWellStudied=0
	HasMasterBlacksmith=0
	HasRockThrowExpert=0
	HasWayOfTheTurtle=0
	HasSmolder=0
	HasWarpAttackMaster=0
	HasCustomStance=0
	HasSturdyBuild=0
	HasSwordsman=0
	HasSeeYouBleed=0
	HasBroodMother=0
	HasZanzokenMaster=0
	HasPCExpert=0
	HasBestDefense=0
	HasFloatLike=0
	HasTurtleShell=0
	HasMiningExpert=0
	HasManaExpert=0
	HasBurningFists=0
	HasBleedingEdge=0
	HasEnergyMarksmanship=0
	HasEatTheRich=0
	HasMidasPunch=0
	HasWayOfTheFist=0
	HasFireLord=0
	HasFlightMaster=0
	HasHammerTime=0
	HasDeepPockets=0
	HasRefuseToLose=0
	HasAimForHeart=0
	HasLoneWolf=0
	HasThunderingBlows=0
	HasManaSiphon=0
	HasKeepYourEnemies=0

	HasGravityWell=0
	HasSurgeonsVision=0
	HasAutoDriller=0
	HasXenophobia=0
	HasEnchantMaster=0
	HasASwiftDeath=0
	HasHyperEnzymes=0
	HasBladeOfLight=0
	HasAsLongAsMyHeartBeats=0
	HasMasterChef=0
	HasUnflinching=0
	HasExponentialGrowth=0
	HasWayOfTheOpenPalm=0
	HasDeftHands=0
	HasSwiftReflexes=0
	HasWillOfFire=0
	HasCooldownMastery=0
	HasFastMetabolism=0
	HasIntMiles=0
	HasMagicMiles=0
	HasExploitWeakness=0
	HasSideSwipe=0
	HasCustomLanguage=0
	HasWiseMentor=0
	HasPilotSkill=0
	HasKeyRing=0
	HasBoundlessStamina=0
	HasResolveOfTheMountain=0
	HasHemophilia=0
	HasBullsEye=0
	HasSurgicalStrikes=0
	HasDeepBreathing=0
	HasBerserking=0
	HasFriendOrFoe=0
	HasForcefulNegotiator=0
	HasRangeOfMotion=0
	HasConcentratedFire=0
	HasNRAMembership=0
	HasChakraBlocking=0
	HasTheSeedIsStrong=0
	HasPursuitOfKnowledge=0
	HasRapidDeployment=0
	HasEOMA=0
	HasThisDrill=0
	HasEmbraceTheFuture=0
	HasWillUnbroken=0
	HasCleanseWicked=0
	HasTelekinesis=0
	HasDeathRegen=0
	HasInvisibility=0
	HasImitate=0
	HasMatterAbsorb=0
	HasTimeFreeze=0
	HasGenius=0
	HasMystical=0
	HasPrecognition=0
	HasEliteGunTraining=0
	HasCustomEnergyWave=0
	HasDoubleAttack=0
	HasMoralCompass=0
	HasChallengersMark=0
	list/MPs=list()


mob/var/ManaLeech=0
Skill/Misc/Mana_Siphon
	desc="This will cause your melee attacks to have a 25%  chance to leech 2.5% of your opponents mana."

	verb/Toggle_Mana_Siphon()
		set category="Other"
		usr.ManaLeech=!usr.ManaLeech
		if(usr.ManaLeech)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] begins drawing mana into their body.")
			usr.ManaLeech=1
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] stops drawing mana into their body..")
			usr.ManaLeech=0


mob/proc/LeechMana(mob/M)
	for(var/obj/Mana/T in M) if(T.Value>100)if(prob(25))
		var/Take=round(T.Value*0.025)
		if(Take<1)Take=1
		//if(Take>10000)Take=10000
		T.Value-=Take
		for(var/obj/Mana/MT in src) MT.Value+=Take
		M.CombatOut("[src] siphons some of your mana. ([Take] Mana)")
		CombatOut("You siphon some of [M]'s mana. ([Take] Mana)")
mob/var/ThunderingBlows=0

Skill/Weapon/ThunderingBlows
	desc="Gives your melee attacks with a weapon a 50% chance to slow your opponent and cause an extra tick of 10% of the damage of original attack OR cause a short stun, but reduces Speed by 10% due to the concentration required."

	New()
		..()
		icon+=rgb(100,0,20)
	verb/Toggle_Thundering_Blows()
		set category="Other"
		usr.ThunderingBlows=!usr.ThunderingBlows
		if(usr.ThunderingBlows)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] swings their weapon with thunderous blows!")
		//	usr.SpdMult*=1
			usr.ThunderingBlows=1
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] swings their weapon normally.")
		//	usr.SpdMult/=1
			usr.ThunderingBlows=0


mob/var/BleedingEdge=0
Skill/Weapon/BleedingEdge
	desc="Gives your melee attacks with a weapon a 50% chance to cause bleeding damage."

	verb/Toggle_Bleeding_Edge()
		set category="Other"
		usr.BleedingEdge=!usr.BleedingEdge
		if(usr.BleedingEdge)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] adjusts their aim, seeking to draw blood with their weapon.")
			//usr.SpdMult*=1
			usr.BleedingEdge=1
			usr.overlays+=src
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] holds their weapon normally.")
		//	usr.SpdMult/=1
			usr.BleedingEdge=0
			usr.overlays-=src

mob/var/Calculated_Strikes=0
mob/var/Calculated_Target="Body"
Skill/Technology/Calculated_Strikes

	desc="Allows you to choose which area to concentrate your body part damage on. (Has a 60% chance to hit the targetted area instead of random)"
	verb/Toggle_Calculated_Strikes()
		set category="Other"
		usr.Calculated_Strikes=!usr.Calculated_Strikes
		if(usr.Calculated_Strikes) for(var/mob/player/M in view(usr)) M.BuffOut("[usr] seems to be aiming for their opponent's [usr.Calculated_Target] now.")
		else for(var/mob/player/M in view(usr)) M.BuffOut("[usr] stops aiming for their opponent's [usr.Calculated_Target].")
	verb/Set_Calculate_Strikes()
		set category="Other"
		var/list/BPChoices=list("Head","Arms","Body","Legs")
		usr.Calculated_Target=input("Select which area of the body to target with your body part damage.") in BPChoices
		usr.BuffOut("Calculated Strikes set to [usr.Calculated_Target].")

Skill/Unarmed/BurningFists

	icon='Flaming fists.dmi'
	desc="Gives your attacks a 50% chance to cause burning damage. (Does not work with swords or hammers. Works with ki blade and ki fists but reduces chance to occur by 20%.)"
	verb/Toggle_Burning_Fists()
		set category="Other"
		usr.BurningFists=!usr.BurningFists
		if(usr.BurningFists)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s fists light ablaze!")
			usr.overlays += image(src,layer=MOB_LAYER+EFFECTS_LAYER+1)
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr]s hands stop burning.")
			usr.overlays -= image(src,layer=MOB_LAYER+EFFECTS_LAYER+1)

mob/var/HasKiFists=0//remove me

mob/var/KiFists=0

mob/var/BurningFists=0
