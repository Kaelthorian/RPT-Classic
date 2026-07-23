Skill/Unarmed/T2/MegatonThrow
	UB1="High Tension"


	desc="While grabbing an opponent, leap into the air and then throw them to the ground, causing good damage. You can't use this with a weapon."

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= ((DMGS_TIER_2*42.9)/100)
	DMGSOURCE_END	= ((DMGS_TIER_2*57.1)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Megaton_Throw()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			usr.MegatonToss(M,src)

			CD= CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki= EnergyCalculation(src,usr)

			return
		return



mob/proc/MegatonToss(mob/M,Skill/S)
	M.Frozen=1
	M.attacking=1
	attacking=1
	Frozen=1
	DoNotUnfreeze=1
	M.DoNotUnfreeze=1
	var/Evasion=SkillAccuracy(usr,M,S)
	var/Damage=DamageCalculator(usr,M,S)
	if((M.KOd==0&&M.client)&&KOd==0)

		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
//			hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
			M.CombatOut("[src] failed to throw you.")
			CombatOut("You failed to throw [GrabbedMob].")
			hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
			M.Frozen=0
			M.attacking=0
			attacking=0
			Frozen=0
			DoNotUnfreeze=0
			M.DoNotUnfreeze=0
			return
		else //Successful hit
			ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					M.attacking=0
					Frozen=0
					attacking=0
					DoNotUnfreeze=0
					M.DoNotUnfreeze=0
					return
				M.TakeDamage(src, Damage, "Megaton Throw")
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
				M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
			//	CombatOut("You throw [M]. ([round(Damage,0.1)] Damage)")
			//	M.CombatOut("[src] throws you. ([round(Damage,0.1)] Damage)")

	else
		Fight()
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		M.attacking=0
		attacking=0
		DoNotUnfreeze=0
		M.DoNotUnfreeze=0
		Frozen=0
		return
	underlays+='Shadow.dmi'
	M.underlays+='Shadow.dmi'
//	spawn()
//		var/i
//		while(i <16)
//			M.pixel_y+=6
//			pixel_y+=6
//			i++
//			sleep(1)
//	sleep(1)
//	Fight()
	spawn()
		var/i
		while(i <10)
			M.pixel_y+=9
			pixel_y+=9
			i++
			sleep(1)
	sleep(1)
	spawn()
		var/i
		while(i <10)
			M.pixel_y-=9
			pixel_y-=9
			i++
			sleep(1)
	sleep(1)
	underlays-='Shadow.dmi'
	M.underlays-='Shadow.dmi'
	M.Frozen=0
	M.attacking=0
	attacking=0
	Frozen=0
	DoNotUnfreeze=0
	M.DoNotUnfreeze=0
//	M.KB=rand(1,3)
//	M.KnockBack(src)

