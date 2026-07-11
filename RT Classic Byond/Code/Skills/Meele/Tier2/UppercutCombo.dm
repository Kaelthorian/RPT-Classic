mob/proc/Combo1(mob/M,Skill/S)
	M.Frozen=1
	var/Damage=DamageCalculator(usr,M,S)
	var/Evasion=SkillAccuracy(src,M,S)


	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion))
				Damage = Damage
				hearers(10,usr)<<sound(pick('MeeleWeak1.wav','MeeleWeak2.wav'),volume=20)
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				M.TakeDamage(src, Damage, "Uppercut Punch 2")
				M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
				M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
	else
		src.Fight()
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	animate(src,pixel_z=9,time=3)
	animate(M,pixel_z=9,time=3)
	src.Combo2(M,S)
	spawn(6)
		animate(src,pixel_z=0,time=3)
		animate(M,pixel_z=0,time=3)
mob/proc/Combo2(mob/M,Skill/S)
	sleep(5)
	loc=M.loc
	step_away(src,M)
	dir=get_dir(loc,M.loc)
	var/Damage=DamageCalculator(usr,M,S)
	var/Evasion=SkillAccuracy(src,M,S)
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion))
				Damage = Damage
				hearers(10,usr)<<sound(pick('MeeleWeak1.wav','MeeleWeak2.wav'),volume=20)
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				M.TakeDamage(src, Damage, "Uppercut Punch 3")
				M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
				M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
	else
		src.Fight()
//		M.BPDamage(src,Damage,5)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	M.Frozen=0




Skill/Unarmed/T2/UppercutCombo
	UB1="Godspeed"
	UB2="Fists of Fury"

	desc="Launches a 3 hit combo attack. (Second hit gets +15% Speed added to your Strength, third gets +30% Speed added to Strength)"

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= (((DMGS_TIER_2*28.6)/100)/3)
	DMGSOURCE_SPD	= (((DMGS_TIER_2*57.1)/100)/3)
	DMGSOURCE_OFF	= (((DMGS_TIER_2*14.3)/100)/3)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Uppercut_Combo()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)

			CD= CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki= EnergyCalculation(src,usr)

			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				UppercutUser(usr)
				usr.Fight()
				var/Damage=DamageCalculator(usr,M,src)
				var/Evasion=SkillAccuracy(usr,M,src)

				if(!prob(Evasion))
					flick(M.CustomZanzokenIcon,M)
					M.CombatOut("You dodge [usr].")
					usr.CombatOut("[M] dodges you.")
					hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
					if(prob(65))
						M.dir=turn(M.dir,pick(-45,45))
						step(M,M.dir)
				else //Successful hit
					if(!prob(Evasion))
						ShockwaveScale(M,usr.BP,1)
						Damage = Damage
						hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
					if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",loc)
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					if(!M.KOd)
						if(!isnum(M.Health)) return
						M.TakeDamage(src, Damage, "Uppercut Punch 1")
						VerticalDust(M)
						usr.Combo1(M,src)
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
						M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
					else
						usr.Fight()
//						M.BPDamage(usr,Damage,5)
						M.KB=round((usr.Str/M.End)*5)
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
			spawn(usr.Refire*2) usr.attacking=0
