Skill/Unarmed/T3/Kickback_Combo

	UB1="High Tension"
	UB2="Fists of Fury"
	desc="Launch a two part attack, the first part hits with guaranteed knockback and the second one warps to your opponent for a follow up attack. The follow up attack will be cancelled if the opponent is blocking."

//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= (((DMGS_TIER_3*61.9)/100)/2)
	DMGSOURCE_SPD	= (((DMGS_TIER_3*25.6)/100)/2)
	DMGSOURCE_OFF	= (((DMGS_TIER_3*12.8)/100)/2)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Kickback_Combo()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			flick("Attack",usr)
			CD= CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki= EnergyCalculation(src,usr)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						ShockwaveScale(M,usr.BP,1)
						Damage = Damage
					if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
					M.KB=max(3,Damage*5)
					if(M.KB>10) M.KB=10
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					spawn() M.KnockBack(usr)
					if(M)
						if(!isnum(M.Health)) return
						M.TakeDamage(usr, Damage, "[src]")
						ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
						spawn(M.KB)
							usr.AfterImage("Dash Attack")
							usr.AfterImage("Dash Attack")
							usr.Comboz(M)
							if(M.Blocking)
								for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] blocks [usr]s [src]!")
								ShockwaveScale(usr,usr.BP,1)
								Crater(M)
							else
								Evasion=SkillAccuracy(usr,M)
								Damage=DamageCalculator(usr,M,src)
								if(!prob(Evasion))
									flick(M.CustomZanzokenIcon,M)
									M.CombatOut("You dodge [usr].")
									usr.CombatOut("[M] dodges you.")
									hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
								else //Successful hit
									if(!prob(Evasion))
										ShockwaveScale(M,usr.BP,1)
										Damage = Damage
										hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
									if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
									M.KB=round(Damage*0.5)
									if(M.KB>5) M.KB=5
									ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
									spawn() M.KnockBack(usr)
									if(M)
										if(!isnum(M.Health)) return
										hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
										M.TakeDamage(usr, Damage, "[src]")
										M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
										M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
										ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)

				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage,3)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*2)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
