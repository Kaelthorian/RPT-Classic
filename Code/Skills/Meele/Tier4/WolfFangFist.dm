mob/proc/WFF(mob/M,Skill/S)
	M.Frozen=1
	var/Evasion=SkillAccuracy(usr,M,S)
	var/Damage=DamageCalculator(usr,M,S)
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion))
				Damage = Damage
				hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
//				didBlock=1
			if(prob(25))ImpactDust(M,dir)//
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
//				M.BPDamage(src,Damage,2)
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
				M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
				M.TakeDamage(src, Damage, "Wolf Fang Fist")
				WolfFangFist(src)
				for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: Wolf!")
	else
		src.Fight()
//		M.BPDamage(src,Damage,2)
//		M.KB=round((src.Str/M.End)*5)
//		if(M.KB>5) M.KB=5
//		M.KnockBack(src)
		M.Frozen=0
		return
	src.WFF2(M,S)

mob/proc/WFF2(mob/M,Skill/S)
	sleep(5)
	loc=M.loc
	step_away(src,M)
	dir=get_dir(loc,M.loc)
	var/Evasion=SkillAccuracy(usr,M,S)
	var/Damage=DamageCalculator(usr,M,S)
//	var/didBlock=0
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion))
				Damage = Damage
				hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
			if(prob(25))ImpactDust(M,dir)//
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				M.TakeDamage(src, Damage, "Wolf Fang Fist")
				M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
				M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
				WolfFangFist(src)
				for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: Fang!")
	else
		src.Fight()
//		M.BPDamage(src,Damage,3)
//		M.KB=round((src.Str/M.End)*5)
//		if(M.KB>5) M.KB=5
//		M.KnockBack(src)
		M.Frozen=0
		return
	src.WFF3(M,S)

mob/proc/WFF3(mob/M,Skill/S)
	sleep(5)
	loc=M.loc
	step_away(src,M)
	dir=get_dir(loc,M.loc)
	var/Evasion=SkillAccuracy(usr,M,S)
	var/Damage=DamageCalculator(usr,M,S)
//	var/didBlock=0
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion))
				hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
				Damage = Damage
			if(prob(25))ImpactDust(M,dir)//
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
				M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
				M.TakeDamage(src, Damage, "Wolf Fang Fist")
				WolfFangFist(src)
				for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: Fist!")
	else
		src.Fight()
//		M.BPDamage(src,Damage,5)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	M.Frozen=0



Skill/Unarmed/T4/WolfFangFist
	UB1="Bestial Wrath"
	UB2="Fists of Fury"

	desc="Dashes three tiles and attempts to attack anyone you collide with. If you hit someone you will begin a three hit combo against them. First two attacks get +20% speed towards damage and the final attack gets 30% while the dash gets +50% from speed."


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= (((DMGS_TIER_4*36.4)/100)/3)
	DMGSOURCE_SPD	= (((DMGS_TIER_4*63.6)/100)/3)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Wolf_Fang_Fist()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		CD= CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki= EnergyCalculation(src,usr)
		var/Distance=3
		if(usr.Ki>usr.MaxKi*0.05)
			usr.DashAttacking=1
			usr.attacking=1
			while(src&&usr&&Distance&&usr.Health>0)
				for(var/mob/M in get_step(usr,usr.dir)) if(M!=usr) if(!M.adminDensity&&M.attackable)
					if(M.afk==0&&!M.RPMode)
						usr.Fight()
						var/Evasion=SkillAccuracy(usr,M,src)
						var/Damage=DamageCalculator(usr,M,src)
						if((M.KOd==0&&M.client))
							if(M.attacking==1) usr.Opp(M)
							Distance--
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
								hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
								M.CombatOut("You dodge [usr].")
								usr.CombatOut("[M] dodges you.")
								if(prob(65))
									M.dir=turn(M.dir,pick(-45,45))
									step(M,M.dir)
							else //Successful hit
								if(!prob(Evasion))
									Damage = Damage
									hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
//									didBlock=1
									if(prob(65))
										M.dir=turn(M.dir,pick(-45,45))
										step(M,M.dir)
								if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(M)
									if(!isnum(M.Health)) return
//									M.BPDamage(usr,Damage,3)
									hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
									M.TakeDamage(src, Damage, "Wolf Fang Fist")
									M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
									M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
									usr.WFF(M,src)
									Distance=0
						else
							usr.Fight()
//							M.BPDamage(usr,Damage,5)
//							M.KB=round((usr.Str/M.End)*5)
//							if(M.KB>5) M.KB=5
//							M.KnockBack(usr)
				step(usr,usr.dir)
				Distance--
				if(Distance<=0) break
				sleep(rand(1,2))
			spawn(usr.Refire*3)
				usr.attacking=0
				usr.DashAttacking=0
			if(Distance<=0)
				usr.DashAttacking=0
				usr.attacking=0

