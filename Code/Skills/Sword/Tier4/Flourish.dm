Skill/Weapon/T4/Flourish
	UB1="Bushido"
	UB2="Godspeed"

	desc="Swing at your opponent with an elaborate strike. After a half second delay you will attack using 33% of your speed as extra damage."



//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= ((DMGS_TIER_4*74.6)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_4*25.4)/100)
	WEAPON			= NO

	verb/Flourish()
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in view(usr)) M.BuffOut("[usr] flourishes their weapon.")
		sleep(5)
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			flick("Attack",usr)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki=(usr.Ki-EDT)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
//				var/didBlock=0
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
//							hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
						hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
					else //Successful hit
						M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
						M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage
							hearers(10,usr)<<sound(pick('MeeleWeak1.wav','MeeleWeak2.wav'),volume=20)
//								hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//								M.BPDamage(usr,Damage,3)
//								hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.TakeDamage(usr, Damage, "[src]")
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//						M.BPDamage(usr,Damage,3)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					hearers(10,usr)<<sound('Sword.mp3',volume=20)
					M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
					M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
