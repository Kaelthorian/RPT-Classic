mob/proc/SmashHole()
	for(var/turf/T in get_step(usr,usr.dir)) if(!T.density)
		KBHole2(T,usr.dir,1)
	for(var/turf/T in get_step(get_step(usr,usr.dir),usr.dir)) if(!T.density)
		KBHole2(T,usr.dir)
	for(var/turf/T in get_step(get_step(get_step(usr,usr.dir),usr.dir),usr.dir)) if(!T.density)
		KBHole2(T,usr.dir,2)
Skill/Weapon/T3/Overhead_Smash

	UB2="High Tension"
	UB1="Bushido"
	desc="Use your weapon to smash the three tiles in front of your character. This attack has good damage but lower than normal accuracy."



//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= ((DMGS_TIER_3*61.9)/100)
	DMGSOURCE_END	= ((DMGS_TIER_3*38.1)/100)
	WEAPON			= NO
	SKILLTRAIT		= list("Strong")

	verb/Overhead_Smash()//hits directly in front of you, piercing two tiles, and with bonus damage
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable)
			if(usr.client)
				usr.Ki=EnergyCalculation(src,usr)
				CD=CDCalculation(src,usr)
				CDTick(usr)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode) //
				flick("Attack",usr)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
//				var/didBlock=0
				if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
					usr.attacking=1
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
						hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.35
							hearers(10,usr)<<sound(pick('MeeleWeak1.wav','MeeleWeak2.wav'),volume=20)
						if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						if(M)
							if(!isnum(M.Health)) return
							M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
							hearers(10,usr)<<sound('Sword.mp3',volume=20)
							M.TakeDamage(usr, Damage, "[src]")
							M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
							M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//if(M&&M.Life<=0) M.Death(usr)
		for(var/turf/T in view(0,get_step(usr,usr.dir))) if(!T.density)
			for(var/mob/M in get_step(get_step(usr,usr.dir),usr.dir)) if(!M.adminDensity&&M.attackable)
				if(usr.client)
//					usr.Ki=(usr.Ki-EDT)
					CD=(1+Modifier(usr))/CDT
					CDTick(usr)
				if(M.afk == 0&&!M.RPMode) //
					var/Evasion=SkillAccuracy(usr,M,src)
					var/Damage=DamageCalculator(usr,M,src)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						flick("Attack",usr)

						if(M.attacking==1) usr.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [usr].")
							usr.CombatOut("[M] dodges you.")
							hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,usr.BP,1)
								Damage = Damage * 0.35
							if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(usr, Damage, "[src]")
								hearers(10,usr)<<sound('Sword.mp3',volume=20)
								M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
								M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//if(M&&M.Life<=0) M.Death(usr)
		for(var/turf/T in view(0,get_step(get_step(usr,usr.dir),usr.dir))) if(!T.density)
			for(var/mob/M in get_step(get_step(get_step(usr,usr.dir),usr.dir),usr.dir)) if(!M.adminDensity&&M.attackable)
				if(usr.client)
//					usr.Ki=(usr.Ki-EDT)
					CD=(1+Modifier(usr))/CDT
					CDTick(usr)
				if(M.afk == 0&&!M.RPMode) //
					var/Evasion=SkillAccuracy(usr,M,src)
					var/Damage=DamageCalculator(usr,M,src)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						flick("Attack",usr)

						if(M.attacking==1) usr.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [usr].")
							usr.CombatOut("[M] dodges you.")
							hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,usr.BP,1)
								Damage = Damage * 0.35
							if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(usr, Damage, "[src]")
								hearers(10,usr)<<sound('Sword.mp3',volume=20)
								M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
								M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//if(M&&M.Life<=0) M.Death(usr)
		usr.SmashHole()
		spawn(usr.Refire) usr.attacking=0
