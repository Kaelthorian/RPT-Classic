mob
	proc
		SmashCheck(var/add=1)
			var/tellthem=0
			if(Smashing<5)tellthem=1
			Smashing+=add
			if(Smashing>20)Smashing=20
			if(Smashing>=5&&tellthem) BuffOut("Your Texas Smash is now ready to fire.")

		TexasSmash(mob/MM,Skill/S)
			if(src.Smashing<1) src.Smashing=1
			if(src.Smashing>49||src.BurningDesireAttacks) for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: <span style='color:#FF0000;'>U</span><span style='color:#FF1717;'>n</span><span style='color:#FF2E2E;'>i</span><span style='color:#FF4545;'>t</span><span style='color:#FF5C5C;'>e</span><span style='color:#FF7373;'>d</span> <span style='color:#FFA2A2;'>S</span><span style='color:#FFB9B9;'>t</span><span style='color:#FFD0D0;'>a</span><span style='color:#FFE7E7;'>t</span><span style='color:#FFFFFF;'>e</span><span style='color:#E7E7FF;'>s</span> <span style='color:#B9B9FF;'>o</span><span style='color:#A2A2FF;'>f</span> <span style='color:#7373FF;'>S</span><span style='color:#5C5CFF;'>m</span><span style='color:#4545FF;'>a</span><span style='color:#2E2EFF;'>s</span><span style='color:#1717FF;'>h</span><span style='color:#0000FF;'>!</span>")
			else for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: Texas Smash!")
			if(src.Smashing>50)src.Smashing=50
//			var/SmashDamage=min(10,max(1,src.Smashing/5))
			src.SmashHole()
			for(var/mob/M in get_step(src,src.dir)) if(!M.adminDensity&&M.attackable)
				if(!src.attacking) if(M.afk == 0&&!M.RPMode) //
					flick("Attack",src)
					var/Evasion=SkillAccuracy(src,M,S)
					var/Damage=DamageCalculator(usr,MM,S)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						src.attacking=1
						flick("Attack",src)
						if(M.attacking==1) src.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [src].")
							src.CombatOut("[M] dodges you.")
							hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,src.BP,1)
								Damage = Damage * 0.35
								hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
							if(prob(75))ImpactDust(M,src.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(src, Damage, "Texas Smash")
								M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
								if(M.KB>20) M.KB=20
								if(Warp&&M.KB) M.KB=M.KB/2
								if(HammerOn) if(prob(max(25,SwordSkill/25))) SmallCrater(M)
								hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
								M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
								M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
								//ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						/*		if(prob(25))
									if(UnarmedSkill>1500&&!SwordOn&&!HammerOn) DustCloud(M)
									if(SwordSkill>1500&&SwordOn) DustCloud(M)
									if(SwordSkill>1500&&HammerOn) DustCloud(M) */
								if(SwordOn||HammerOn)
									if(prob(50)) StabUser(src)
									else SlashUser(src)
								spawn M.KnockBack(src)

					else
						flick("Attack",src)
						if(!isnum(M.Life)) return
						M.Life-=3*((src.BP*src.Str)/(M.Base*M.Body*M.End))
						//src.CombatOut("You attack [M]. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[src] attacks you. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//if(M&&M.Life<=0) M.Death(src)
			for(var/turf/T in view(0,get_step(src,src.dir))) if(!T.density)
				for(var/mob/M in get_step(get_step(src,src.dir),src.dir)) if(!M.adminDensity&&M.attackable)
					if(M.afk == 0&&!M.RPMode) //
						var/Evasion=SkillAccuracy(src,M,S)
						var/Damage=DamageCalculator(usr,MM,S)
						if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
							flick("Attack",src)

							if(M.attacking==1) src.Opp(M)
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
								M.CombatOut("You dodge [src].")
								src.CombatOut("[M] dodges you.")
							else //Successful hit
								if(!prob(Evasion))
									ShockwaveScale(M,src.BP,1)
									Damage = Damage * 0.35
								if(prob(75))ImpactDust(M,src.dir)//ShockwaveIcon(null,"Impact",M.loc)
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(M)
									if(!isnum(M.Health)) return
									M.TakeDamage(src, Damage, "Texas Smash")
									M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
									if(M.KB>20) M.KB=20
									if(Warp&&M.KB) M.KB=M.KB/2
									if(HammerOn) if(prob(max(25,SwordSkill/25))) SmallCrater(M)
									//ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								/*	if(prob(25))
										if(UnarmedSkill>1500&&!SwordOn&&!HammerOn) DustCloud(M)
										if(SwordSkill>1500&&SwordOn) DustCloud(M)
										if(SwordSkill>1500&&HammerOn) DustCloud(M) */
									if(SwordOn||HammerOn)
										if(prob(50)) StabUser(src)
										else SlashUser(src)
									spawn M.KnockBack(src)
						else
							flick("Attack",src)
							if(!isnum(M.Life)) return
							M.Life-=3*((src.BP*src.Str)/(M.Base*M.Body*M.End))
							//src.CombatOut("You attack [M]. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//M.CombatOut("[src] attacks you. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//if(M&&M.Life<=0) M.Death(src)
			for(var/turf/T in view(0,get_step(get_step(src,src.dir),src.dir))) if(!T.density)
				for(var/mob/M in get_step(get_step(get_step(src,src.dir),src.dir),src.dir)) if(!M.adminDensity&&M.attackable)
					if(M.afk == 0&&!M.RPMode) //
						var/Evasion=SkillAccuracy(usr,M,S)
						var/Damage=DamageCalculator(usr,MM,S)
						if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
							flick("Attack",src)

							if(M.attacking==1) src.Opp(M)
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
								M.CombatOut("You dodge [src].")
								src.CombatOut("[M] dodges you.")
							else //Successful hit
								if(!prob(Evasion))
									ShockwaveScale(M,src.BP,1)
									Damage = Damage * 0.35
								if(prob(75))ImpactDust(M,src.dir)//ShockwaveIcon(null,"Impact",M.loc)
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(M)
									if(!isnum(M.Health)) return
									M.TakeDamage(src, Damage, "Texas Smash")
									M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
									if(M.KB>20) M.KB=20
									if(Warp&&M.KB) M.KB=M.KB/2
									if(HammerOn) if(prob(max(25,SwordSkill/25))) SmallCrater(M)
									//ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							/*		if(prob(25))
										if(UnarmedSkill>1500&&!SwordOn&&!HammerOn) DustCloud(M)
										if(SwordSkill>1500&&SwordOn) DustCloud(M)
										if(SwordSkill>1500&&HammerOn) DustCloud(M) */
									if(SwordOn||HammerOn)
										if(prob(50)) StabUser(src)
										else SlashUser(src)
									spawn M.KnockBack(src)

						else
							flick("Attack",src)
							if(!isnum(M.Life)) return
							M.Life-=3*((src.BP*src.Str)/(M.Base*M.Body*M.End))
							//src.CombatOut("You attack [M]. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//M.CombatOut("[src] attacks you. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//if(M&&M.Life<=0) M.Death(src)
			src.Smashing=0
			spawn(src.Refire) src.attacking=0


Skill/Unarmed/T4/Texas_Smash
	UB1="High Tension"
	UB2="Shadow King"

	desc="This attack is a two cast attack. The first cast has you begin to charge the attack, it takes a minimum time but it becomes more powerful the more damage you take. The second cast will actually fire the attack. This attack has +50% extra strength added to the damage."


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Texas_Smash()//hits directly in front of you, piercing two tiles, and with bonus damage
		set category="Skills"
		if(usr.Smashing>=5)
			usr.TexasSmash(usr,src)
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		if(!usr.Smashing)
//			if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
			CD= CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki= EnergyCalculation(src,usr)
			for(var/mob/M in range(20,usr))M.CombatOut("[usr] begins to charge a [src]!")
			usr.Smashing=1


