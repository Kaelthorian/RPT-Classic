Skill/Weapon/T1/Slice

	desc="You slash at your opponent with your sword or swing with your hammer in a fast attack. (Regular attack damage, but doesnt trigger attack CD. Short cooldown.)"


//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= 0
//	KBT				= KB_TIER_1
	DMGSOURCE_STR	= DMGS_TIER_1
	WEAPON			= YES

	verb/Slice()
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		var/mob/M=null
		for(var/mob/MN in oview(src,1)) if(MN==usr.LastAttacked&&usr.Warp) M=MN
		if(!M)
			for(var/mob/MM in get_step(usr,usr.dir))
				M=MM
		if(M)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) //if(!ghostDens_check(M)&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
				if(M.RPMode) return
				for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
				if(usr)
					if(usr.Ki<1+(usr.KiBlade+usr.KiFists+usr.BurningFists)) return
					usr.Ki=(usr.Ki-EDT)
					usr.FreeAttack(M,src)

			hearers(10,usr)<<sound('Sword.mp3',volume=20)
			M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
			M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
