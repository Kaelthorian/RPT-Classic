Skill/Unarmed/T2/PileDriver
	UB1="High Tension"
	desc="This move requires you to have the opponent grabbed. Deals 2x the damage of a regular attack. Always hits."



//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= ((DMGS_TIER_3*61.9)/100)
	DMGSOURCE_END	= ((DMGS_TIER_3*38.1)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Pile_Driver()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking)
				usr.Ki= EnergyCalculation(src,usr)
				CD= CDCalculation(src,usr)
				CDTick(usr)
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
				M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
				M.InFullNelson=1
				spawn usr.fullnelson(M,src)


mob/var/tmp/InFullNelson=0
mob/proc/fullnelson(mob/M,Skill/S)
	if(KOd)
		view()<<"[usr] is forced to release [GrabbedMob]!"
		if(ismob(GrabbedMob)) GrabbedMob.grabberSTR=null
		attacking=0
		src.isGrabbing=null
	else if(!M.KOd)
		var/Damage=DamageCalculator(usr,M,S)
		animate(M, transform = turn(matrix(), 180), time = 2)
		M.TakeDamage(src, Damage, "Pile Driver")
		M.Injure_Hurt(rand(15,25)/10*Damage,"Head",src)
		M.InFullNelson--
		spawn(2)
			animate(M, transform = null)
			M.grabberSTR=null
