Skill/Weapon/T2/CleaveAttack

	UB1="Bushido"
	desc="Use a sword or hammer to attack the three tiles in front of your character. This attack has increased damage compared to a normal attack."


//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_STR	= ((DMGS_TIER_2*42.9)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_2*57.1)/100)
	WEAPON			= NO

	verb/Cleave_Attack()
		set category="Skills"
		var/hashit=0
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
//		CD=(1+Modifier(usr))/CDT
//		CDTick(usr)
		for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
		for(var/mob/M in get_step(usr,usr.GetCleave(usr.dir,0))) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			flick("Attack",usr)
			SweepingBlade(usr)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki=(usr.Ki-EDT)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)  //
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
//				var/didBlock=0
				if((M.KOd==0&&M.client))
					hashit=1
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
							Damage = Damage
							hearers(10,usr)<<sound(pick('MeeleWeak1.wav','MeeleWeak2.wav'),volume=20)
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
							hearers(10,usr)<<sound('Sword.mp3',volume=20)
							M.Injure_Hurt(rand(10,20)/10*Damage,"Body",usr)
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
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)

		for(var/mob/M in get_step(usr,usr.GetCleave(usr.dir,1))) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(usr.client&&!usr.attacking)
				if(usr.Ki<1) return
				usr.Ki-=1
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
				if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
					hashit=1
					//attacking=1
					flick("Attack",usr)
					CD=(1+Modifier(usr))/CDT
					CDTick(usr)
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
							Damage = Damage
							hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
//							hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
//							hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.TakeDamage(usr, Damage, "[src]")
							hearers(10,usr)<<sound('Sword.mp3',volume=20)
							M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
							M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage,2)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
		for(var/mob/M in get_step(usr,usr.GetCleave(usr.dir,2))) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(usr.client&&!usr.attacking)
				if(usr.Ki<1) return
				usr.Ki-=1
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
				if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
					hashit=1
					//attacking=1
					flick("Attack",usr)
					CD=(1+Modifier(usr))/CDT
					CDTick(usr)
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
							Damage = Damage
//							hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
							hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
//							didBlock=1
						if(prob(25))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5

						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
////							hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.TakeDamage(usr, Damage, "[src]")
							hearers(10,usr)<<sound('Sword.mp3',volume=20)
							M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
							M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage,2)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
		if(hashit)
			usr.attacking=1
			spawn(usr.Refire) usr.attacking=0
		else CD=5

