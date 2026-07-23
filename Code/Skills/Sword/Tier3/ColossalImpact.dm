Skill/Weapon/T3/Colossal_Impact

	UB2="High Tension"
	UB1="Bushido"
	desc="Use your weapon to unleash a gigantic shockwave underneath you."


//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= ((DMGS_TIER_3*36.5)/100)
	DMGSOURCE_END	= ((DMGS_TIER_3*63.5)/100)
	WEAPON			= NO


	verb/Colossal_Impact() //hits everyone around you //can use with sword but no bonus damage
		set category="Skills"
		var/hashit=0
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		var/Hit=0
		CD=CDCalculation(src,usr)
		CDTick(usr)
		for(var/mob/M in oview(usr,2)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) Hit=1
		if(Hit)
			Crater(usr)
			flick("Attack",usr)
			spawn(1) usr.RHK()
			usr.Ki=(usr.Ki-EDT)
			for(var/mob/M in oview(usr,2)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
				if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
//					usr.Ki=(usr.Ki-EDT)
					var/Evasion=SkillAccuracy(usr,M,src)
					var/Damage=DamageCalculator(usr,M,src)
					SmallCrater(M)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						hashit=1
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
								Damage = Damage
								hearers(10,usr)<<sound(pick('MeeleWeak1.wav','MeeleWeak2.wav'),volume=20)
							if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							//spawn M.KnockBack(usr)
							spawn M.Shockwave_Knockback(3,usr.loc)
//							DustCloud(M)
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
						M.KB=round((usr.Str/M.End)*5)
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
						//if(M&&M.Life<=0) M.Death(usr)
					sleep(-1)
	//		DustCloud(usr)
			if(hashit)
				usr.attacking=1
				spawn(usr.Refire) usr.attacking=0
		if(Hit==0)CD=0
