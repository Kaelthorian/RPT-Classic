Skill/Unarmed/TestingSkill
	desc="Testing Skill"

	DMGT			= DMG_TIER_1
	CDT				= CD_TIER_1
	EDT				= ED_TIER_1
	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	verb/TestingSkill()
		set category="Skills"

		//Are we allowed to hit him ?
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return

		//Targets
		for(var/mob/M in get_step(usr,usr.dir))

			//Draining and CD
			usr.Ki=(usr.Ki-EDT)
			CD=(1+Modifier(usr))/CDT
			CDTick(usr)

			//Did we hit ?
			var/Evasion=SkillAccuracy(usr,M,src)

			//If we didn't
			if(!prob(Evasion) && !M.IsBlocking)
				//Animation
				flick(M.CustomZanzokenIcon,M)
				hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)

				//msg that we dodge
				M.CombatOut("You dodge [usr].")
				usr.CombatOut("[M] dodges you.")

				//Energy Math for dodge
				M.Ki+=DodgeEnergyCalculation(M)
				if(M.MaxKi<=M.Ki)
					M.Ki=M.MaxKi

				return

			//If we did
			else
				//Anger markers
				M.LastHitter = usr.name
				M.HitterListCheck(usr.name)

				//If he block it
				if(!prob(Evasion)|| M.IsBlocking)

					//We calculate the damage
					var/Damage=DamageCalculator(usr,M,src)

					//We take the damage
					Damage = Damage
					M.TakeDamage(usr, Damage, "[src]")

					//Animation
					M.Screen_Shake()
					ShockwaveScale(M,usr.BP,1)
					hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)

					//msg that we blocked
					M.CombatOut("You block [usr].")
					usr.CombatOut("[M] blocks you.")

					//Energy Math for Block
					M.Ki+=BlockEnergyCalculation(M)
					if(M.MaxKi<=M.Ki)
						M.Ki=M.MaxKi

					return

				//If he didn't block it
				else

					//Can't move
					usr.Animation=1
					M.Animation=1

					//Animation
					flick("Attack",usr)
					animate(M, pixel_x=20, time = 0.5)
					animate(usr, pixel_x=20,time = 0.5)
					animate(M, transform = turn(matrix(), -60), time = 2)
					hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
					ImpactDust(M,usr.dir)
					sleep(2)
					animate(M, pixel_x=0,time = 0.5)
					animate(M, pixel_y=0,time = 0.5)
					animate(M, transform = turn(matrix(), 0), time = 1)
					animate(usr, pixel_x=0,time = 0.5)
					animate(M, pixel_x=20, time = 0.5)

					//Knockback
					M.KB=KBT
					M.KnockBack(usr)

					//msg for the combat chat
					M.BuffOut("[usr] used [src] on [M] ")
					usr.BuffOut("[usr] used [src] on [M] ")

					//We calculate and damage here
					var/Damage=DamageCalculator(usr,M,src)
					M.TakeDamage(usr, Damage, "[src]")

					//Limb damage from the skill
					M.Injure_Hurt(rand(10,20)*(Damage/10),LT,usr)

					//Special status

					//Can move again
					usr.Animation=0
					M.Animation=0

Skill/Unarmed/BlockStance
/*
	verb/BlockStance()
		set category="Skills"
		if(!usr.IsBlocking)
			usr<<"You are now blocking"
			usr.IsBlocking=1
			usr.overlays+='BlockHud.dmi'
			return
		if(usr.IsBlocking)
			usr<<"You are no longer blocking"
			usr.IsBlocking=0
			usr.overlays-='BlockHud.dmi'
			return
*/
Skill/Unarmed/BlockTest
	verb/BlockTest()
		set category="Skills"

		for(var/mob/M in view(5,usr))
			animate(M, pixel_y=20, time = 6)
			animate(M, transform = turn(matrix(), -360), time = 6)
			sleep(6)
			animate(M, pixel_y=0,time = 0.5)
			SmallCrater(M)

Skill/Unarmed/Smash_Heads
	desc="Testing Skill"

	DMGT			= DMG_TIER_1
	CDT				= CD_TIER_1
	EDT				= ED_TIER_1
	KBT				= KB_TIER_1
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO

	verb/Smash_Heads()
		set category="Skills"

		if(SkillSafeCheckUnarmed(usr))
			//TESTINGREPLACE
			return

		for(var/mob/E in get_step(usr,EAST))
			for(var/mob/W in get_step(usr,WEST))
				animate(E, pixel_x=-20, time = 2)
				animate(E, transform = turn(matrix(), -60), time = 2)
				E.layer=10
				animate(W, pixel_x=20, time = 2)
				animate(W, transform = turn(matrix(), 60), time = 2)
				W.layer=10
				animate(usr, pixel_y=15, time = 2)
				sleep(2)
				animate(E, pixel_x=0,time = 2)
				animate(W, pixel_x=0,time = 2)
				animate(usr, pixel_y=0,time = 2)
				animate(E, transform = turn(matrix(), 0), time = 1)
				animate(W, transform = turn(matrix(), 0), time = 1)
				W.layer=4
				E.layer=4
				Crater(usr)
				var/image/_overlay = image('Stun.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
				E.overlays += _overlay
				W.overlays += _overlay
				sleep(20)
				E.overlays -= _overlay
				W.overlays -= _overlay
				sleep(10)
				E.KO(E)
				W.KO(W)

Skill/Unarmed/Testing_Sword
	desc="Testing Skill"

	DMGT	= DMG_TIER_1
	CDT		= CD_TIER_1
	EDT		= ED_TIER_1
	KBT		= KB_TIER_1

	verb/Testing_Sword()
		set category="Skills"

//		if(SkillSafeCheckUnarmed(usr))
//			//TESTINGREPLACE
//			return

		for(var/mob/M in get_step(usr,usr.dir))
			flick("Attack",usr)
			M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
			M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
//			SkillAccuracy(usr,M)
			DamageCalculator(usr,M,src)

			HitEffect2(M)
			HitOverlay(M)
			animate(M, pixel_y=80, time = 3)
			animate(M, transform = turn(matrix(), 90), time = 5)
			animate(usr, transform = turn(matrix(), 360), time = 2)
			animate(usr, pixel_x=80, time = 2)
			sleep(10)
			Flight(usr)
			animate(usr, pixel_y=120,pixel_x=-50, time = 2)
			SlashUser2(usr,-32,70)

			sleep(10)
			animate(M, pixel_x=0,time = 0.5)
			animate(M, pixel_y=0,time = 1)
			animate(M, transform = turn(matrix(), 0), time = 1)
			animate(usr, pixel_x=0,time = 0.5)
			animate(usr, pixel_y=0,time = 0.5)
			animate(usr, transform = turn(matrix(), 0), time = 1)
			SmallCrater(M)
			Flight(usr)

Skill/Unarmed/Testing_Sword2
	desc="Testing Skill"

	DMGT	= DMG_TIER_1
	CDT		= CD_TIER_1
	EDT		= ED_TIER_1
	KBT		= KB_TIER_1

	verb/Testing_Sword2()
		set category="Skills"

//		if(SkillSafeCheckUnarmed(usr))
//			//TESTINGREPLACE
//			return

		for(var/mob/M in get_step(usr,usr.dir))
			flick("Attack",usr)
			M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
			M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
//			SkillAccuracy(usr,M)
			DamageCalculator(usr,M,src)

			HitEffect2(M)
			HitOverlay(M)
			animate(M, pixel_y=80, time = 3)
			animate(M, transform = turn(matrix(), 90), time = 5)
			animate(usr, transform = turn(matrix(), 360), time = 2)
			animate(usr, pixel_x=80, time = 2)
			sleep(10)
			Flight(usr)
			animate(usr, pixel_y=120,pixel_x=-50, time = 2)
			SlashUser2(usr,-32,70)

			sleep(10)
			animate(M, pixel_x=0,time = 0.5)
			animate(M, pixel_y=0,time = 1)
			animate(M, transform = turn(matrix(), 0), time = 1)
			animate(usr, pixel_x=0,time = 0.5)
			animate(usr, pixel_y=0,time = 0.5)
			animate(usr, transform = turn(matrix(), 0), time = 1)
			SmallCrater(M)
			Flight(usr)
proc/
	SlashUser2(atom/movable/M,pixel_x,pixel_y)
		var/Icon_Obj/Effects/StabUser/P = unpool("StabUser")
		P.dir=M.dir
		P.Target=M
		P.Target_Watch()
		P.pixel_y=pixel_y
		P.pixel_x=pixel_x
		spawn(5) pool("StabUser",P)