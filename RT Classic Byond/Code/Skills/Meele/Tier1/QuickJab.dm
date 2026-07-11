Skill/Unarmed/T1/QuickJab

	desc="You swipe at your opponent with your fist in a fast attack. (Regular attack damage, but doesnt trigger attack CD. Short cooldown.)"


//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_STR	= DMGS_TIER_1
	WEAPON			= NO
	SKILLTRAIT		= list()

	verb/Quick_Jab()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		var/mob/M=null
		for(var/mob/MN in oview(src,1)) if(MN==usr.LastAttacked&&usr.Warp) M=MN
		if(!M)
			for(var/mob/MM in get_step(usr,usr.dir))
				M=MM
				//break
		if(M)
			if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) //if(!ghostDens_check(M)&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
				if(M.RPMode) return
				for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
				if(usr)
				//	if(usr.Ki<1+(usr.KiBlade+usr.KiFists+usr.BurningFists)) return
					usr.Ki=EnergyCalculation(src,usr)
					CD=CDCalculation(src,usr)
					CDTick(usr)
					usr.FreeAttack(M,src)

			M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
			M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.

