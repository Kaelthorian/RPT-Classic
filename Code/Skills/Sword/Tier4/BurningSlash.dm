mob/proc/WCombo1(mob/M,Skill/S)
	M.Frozen=1
	var/Damage=DamageCalculator(src,M,S)
	var/Evasion=SkillAccuracy(src,M)


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
				hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
				M.TakeDamage(src, Damage, "Burning Slash 2")
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
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
	src.WCombo2(M,S)
	spawn(6)
		animate(src,pixel_z=0,time=3)
		animate(M,pixel_z=0,time=3)
mob/proc/WCombo2(mob/M,Skill/S)
	sleep(5)
	loc=M.loc
	step_away(src,M)
	dir=get_dir(loc,M.loc)
	var/Damage=DamageCalculator(src,M,S)
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
				hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
				M.TakeDamage(src, Damage, "Burning Slash 3")
				hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
				M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
				M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
				src.BurningBlast(S)
	else
		src.Fight()
//		M.BPDamage(src,Damage,5)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	M.Frozen=0

mob/proc/BurningBlast(Skill/S)
	flick(usr,"Blast")
	var/obj/ranged/Blast/A=unpool("Blasts")
	A.Belongs_To=src
	A.name=S.name
	A.icon=S.icon
	A.pixel_x=S.pixel_x
	A.pixel_y=S.pixel_y
	var/MaskDamage=0
	var/MaxSwordPercent
	for(var/obj/items/Sword/SS in usr) if(SS.suffix&&SS.Durability>0)
		MaskDamage=SS.Health
		MaxSwordPercent=SS.MaxBPAdd
		SS.DurabilityCheck(usr)
		break
	for(var/obj/items/Hammer/SS in usr) if(SS.suffix&&SS.Durability>0)
		MaskDamage=SS.Health
		MaxSwordPercent=SS.MaxBPAdd
		SS.DurabilityCheck(usr)
		break
	for(var/obj/items/Gauntlets/SS in usr) if(SS.suffix&&SS.Durability>0)
		MaskDamage=SS.Health
		MaxSwordPercent=SS.MaxBPAdd
		SS.DurabilityCheck(usr)
		break
	if(MaskDamage>(MaxSwordPercent/100)*usr.BP) MaskDamage=(MaxSwordPercent/100)*usr.BP
	A.Damage=3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
	A.Power=(usr.BP+MaskDamage)*Ki_Power
	A.Offense=usr.Off
	A.Explosive=0
	A.dir=usr.dir
	A.loc=usr.loc
	step(A,A.dir)
	if(A) walk(A,A.dir,1)


Skill/Weapon/T4/BurningSlash

	UB1="Bushido"
	UB2="War"
	desc="Launches a 2 hit combo attack followed by a blast. (First hit gets +25% Force added to your Strength, second gets +25% Force added to Strength and the third gets +50%. The blast deals bonus weapon damage.)"



//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= (((DMGS_TIER_4*68.8)/100)/3)
	DMGSOURCE_SPD	= (((DMGS_TIER_4*38.1)/100)/3)
	WEAPON			= NO

	verb/Burning_Slash()
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki=(usr.Ki-EDT)
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
						hearers(10,usr)<<sound(pick('MeeleWeak1.wav','MeeleWeak2.wav'),volume=20)
					if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",loc)
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					if(!M.KOd)
						if(!isnum(M.Health)) return
						M.TakeDamage(src, Damage, "[src] 1")
						VerticalDust(M)
						usr.WCombo1(M,src)
					else
						usr.Fight()
//						M.BPDamage(usr,Damage,5)
						M.KB=round((usr.Str/M.End)*5)
						hearers(10,usr)<<sound('Sword.mp3',volume=20)
						M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
						M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
			spawn(usr.Refire*2) usr.attacking=0
