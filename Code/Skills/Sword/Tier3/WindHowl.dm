Skill/Weapon/T3/Wind_Howl//AoE for Swords that uses a circle effect that just expands outward to look pretty
	desc="Unleash a devastating slicing attack that hits all of those around you."



//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= ((DMGS_TIER_2*61.9)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_2*38.1)/100)
	WEAPON			= NO

	verb/Wind_Howl() //hits everyone around you //can use with sword but no bonus damage
		set category="Skills"
		UB1="Bushido"
		UB2="Bestial Wrath"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		var/hashit=0
		CD=CDCalculation(src,usr)
		CDTick(usr)
		var/Hit=0
		for(var/mob/M in oview(usr,2)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) Hit=1
		if(Hit)
			flick("Attack",usr)
			usr.Ki=EnergyCalculation(src,usr)
			ShockwaveScale(usr,usr.BP,1)
			LargeDust(usr)
			for(var/mob/M in oview(usr,2)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
				if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
//					CD=(1+Modifier(usr))/CDT
//					usr.Ki=(usr.Ki-EDT)
					var/Evasion=SkillAccuracy(usr,M,src)
					var/Damage=DamageCalculator(usr,M,src)
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
							if(prob(25))
								ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							M.KB=round(Damage*0.5)
							if(M.KB>10) M.KB=10
							if(prob(50)) M.KB++
							if(prob(50)) M.KB++
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							spawn M.KnockBack(usr)
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
		//	DustCloud(usr)
			if(hashit)
				usr.attacking=1
				spawn(usr.Refire) usr.attacking=0
			if(!hashit)CD/=2
