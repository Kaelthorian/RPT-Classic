Skill/Unarmed/T4/ConsecutiveNormalPunches
	UB2="Godspeed"
	UB1="Fists of Fury"


	desc="You will launch six attacks simultaneously after a 0.5 second delay."


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_4/5
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Consecutive_Normal_Punches()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		if(usr.Target==usr)return
		CD= CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki= EnergyCalculation(src,usr)
		for(var/mob/P in view(usr)) P.BuffOut("[usr] prepares a powerful attack.")
		spawn(5)
			var/mob/M=null
			for(var/mob/MN in oview(src,1)) if(MN==usr.LastAttacked&&usr.Warp) M=MN
			if(!M)
				for(var/mob/MM in get_step(usr,usr.dir))
					M=MM
			if(M)
				if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) //if(!ghostDens_check(M)&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
					if(M.RPMode) return
					if(usr)
//						usr.CanDashAttack=0
						usr.FreeAttack(M,src)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						usr.FreeAttack(M,src)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						usr.FreeAttack(M,src)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						usr.FreeAttack(M,src)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						usr.FreeAttack(M,src)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						usr.FreeAttack(M,src)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
//						usr.CanDashAttack=1
			else
				usr.BuffOut("You missed the target with [src].")
				hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
				CD*=0.5