mob/var/tmp/CanDashAttack=1
Skill/Unarmed/T4/MarchOfFury
	UB2="High Tension"
	UB1="Fists of Fury"

	desc="You charge towards your target, rushing towards them no matter the obstacle. You will launch 4 melee attacks on your path, one every half second. (If you have Combo Toggle turned on, it will launch 8 attack instead. Two every half second. This is a 'smart homing' move that will avoid dense objects on the way.)"


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/March_of_Fury()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		if(usr.Target==usr)return
		CD= CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki= EnergyCalculation(src,usr)
		var/mob/B
		if(usr.Target) B =usr.Target
		else
			CD=0
			usr<<"This requires a target."
			return
		walk_to(usr,B,0,1)
		B.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
		B.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
		usr.CanDashAttack=0
		if(usr.Warp)
			spawn(4)
				usr.MeleeAttack(0)
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				spawn(4)
					usr.MeleeAttack(1)
					hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
					spawn(4)
						usr.MeleeAttack(0)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						spawn(4)
							usr.MeleeAttack(1)
							hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
							spawn(4)
								usr.MeleeAttack(0)
								hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
								spawn(4)
									usr.MeleeAttack(1)
									hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
									spawn(4)
										usr.MeleeAttack(0)
										hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
										spawn(4)
											usr.MeleeAttack(1)
											usr.CanDashAttack=1
											hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
			spawn(18)walk(usr,0)
			usr.attacking=0

		else
			spawn(4)
				usr.MeleeAttack(0)
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				spawn(4)
					usr.MeleeAttack(1)
					hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
					spawn(4)
						usr.MeleeAttack(0)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						spawn(4)
							usr.MeleeAttack(1)
							usr.CanDashAttack=1
							hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
			spawn(18)walk(usr,0)
			usr.attacking=0




