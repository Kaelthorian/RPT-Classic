Skill/Weapon/T2/SwordStab
	desc="Use your sword to stab your enemy and the tile behind them. Scaling bonus damage with strength mod and increased damage to armor, with a higher chance power armor to hit than normal."

	UB1="Bushido"
	UB2="War"


//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_1
	DMGSOURCE_STR	= ((DMGS_TIER_2*61.9)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_2*38.1)/100)
	WEAPON			= NO


	verb/Sword_Stab()//hits directly in front of you, piercing two tiles, and with bonus damage
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[usr] prepares to [usr.SwordOn?"stab with their sword":"swing with their hammer"].")
//		sleep(usr.Refire)
		var/Pen=0
		var/didHit=0
		StabUser(usr)
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable)
			if(M.CatchBladeActive)
				for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] catches [usr]s weapon.")
				M.dir=get_dir(M,src)
				usr.GetDisarmed(M,8)
				Stun(usr,0.5)
				M.CatchBladeActive=0
				return
			if(usr.client)
				usr.Ki=(usr.Ki-EDT)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode) //
				didHit=1
				CD=(1+Modifier(usr))/CDT
				flick("Attack",usr)
				SlashUser(usr)//ShockwaveIcon(null,"Stab",M.loc)//new/Icon_Obj/StabV2(usr.loc)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)

//				var/didBlock=0
				if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
					usr.attacking=1
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
//						hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
						hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.35
//							hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage*2,5)
							hearers(10,usr)<<sound('Sword.mp3',volume=20)
							M.Injure_Hurt(rand(10,20)/10*Damage,"Body",usr)
							M.TakeDamage(usr, Damage, "[src]")
							M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
							M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage*2,2)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//if(M&&M.Life<=0) M.Death(usr)
		for(var/turf/T in view(0,get_step(usr,usr.dir))) if(!T.density) Pen=1
		if(Pen)
			for(var/mob/M in get_step(get_step(usr,usr.dir),usr.dir)) if(!M.adminDensity&&M.attackable)
				if(M.CatchBladeActive)
					for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] catches [usr]s weapon.")
					M.dir=get_dir(M,src)
					usr.GetDisarmed(M,8)
					Stun(usr,0.75)
					M.CatchBladeActive=0
					return
				if(usr.client)
//					usr.Ki=(usr.Ki-EDT)
					if(!CD)
						CD=(1+Modifier(usr))/CDT
						CDTick(usr)
				if(M.afk == 0&&!M.RPMode) //
					didHit=1
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
				//CD=CD*1.2
		if(didHit) spawn(usr.Refire) usr.attacking=0
		else CD=5
