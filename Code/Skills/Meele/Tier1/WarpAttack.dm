Skill/Unarmed/T1/WarpAttack
	desc="Automatically warp to your target and attack them."


//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_STR	= ((DMGS_TIER_1*14.3)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_1*71.4)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_1*14.3)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()


	verb/Warp_Attack()
		set category="Skills"
		if(usr.GrabbedMob) return
		var/mob/hitter
		if(usr.Target&& ismob(usr.Target)) if(usr.Target.z==usr.z) if(get_dist(usr,usr.Target)<=10) if(usr.Target in oviewers(10,usr))  hitter=usr.Target
		if(!hitter) return
		if(hitter==usr) return
		if(hitter.afk||hitter.KOd||!hitter.attackable||hitter.RPMode||hitter.adminDensity) return
		if(!locate(hitter) in viewers(usr)) return
		if(!locate(usr) in viewers(hitter)) return
		if(hitter.RPMode) return
		if(hitter&&hitter.Health>0)
			usr.Ki=(usr.Ki+((usr.MaxKi*10)/100))
			if(usr.Ki>=usr.MaxKi)
				usr.Ki=usr.MaxKi
			CD=CDCalculation(src,usr)
			CDTick(usr)
			usr.attacking=1
			//spawn(usr.Refire*0.2)if(usr.attacking!=3) usr.attacking=0
			var/didBlock=0
			flick(usr.CustomZanzokenIcon,usr)
			ZanzoDust(usr)
			usr.Comboz(hitter)
			flick("Attack",usr)
			var/Evasion=SkillAccuracy(usr,hitter)
			var/Damage=DamageCalculator(usr,hitter,src)

//			if(!usr.HammerOn&&!usr.SwordOn&&!usr.KiBlade)
//				if(usr.HasWayOfTheOpenPalm&&!usr.KiFists) Damage=DamageFormula(usr,hitter,Strength=1,Force=0,Speed=0.1,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
//				else if(usr.KiFists&&usr.HasWayOfTheOpenPalm)
//					Evasion=SkillAccuracy(usr,hitter,KiManip=2,Chance=WorldDefaultAcc)
//					Damage=DamageFormula(usr,hitter,Strength=0.7,Force=0.3,Speed=0.1,Offense=0,DamageType="KiFist",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
//				else if(usr.KiFists)
//					Evasion=SkillAccuracy(usr,hitter,KiManip=2,Chance=WorldDefaultAcc)
//					Damage=DamageFormula(usr,hitter,Strength=0.7,Force=0.3,Speed=0,Offense=0,DamageType="KiFist",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
//			if(usr.KiBlade)
//				Evasion=SkillAccuracy(usr,hitter)
//				Damage=DamageFormula(usr,hitter,Strength=0.2,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)


			if(!prob(Evasion))
				flick(hitter.CustomZanzokenIcon,hitter)
				hitter.CombatOut("You dodge [usr].")
				usr.CombatOut("[hitter] dodges you.")
				hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
			else //Successful hit
				if(!prob(Evasion+(hitter.HasWayOfTheTurtle*2.5)))
					ShockwaveScale(hitter,usr.BP,1)
					Damage = Damage
					hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
					didBlock=1
				if(prob(25))
					ImpactDust(hitter,usr.dir)//ShockwaveIcon(null,"Impact",hitter.loc)
				ASSERT(hitter)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
				if(hitter)
					Damage=Damage
					if(usr.HasZanzokenMaster) Damage*=1.2
					hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
					if(!isnum(hitter.Health)) return
					var/AttackOut=""
					if(didBlock==1)AttackOut="Blocked"
					else if(didBlock==2) AttackOut="(Armor) Blocked"
					hitter.TakeDamage(usr, Damage, "[AttackOut] [src]")
					usr.Comboz(hitter)
					hitter.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
					hitter.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
			spawn(usr.Refire/5)if(usr.attacking!=3) usr.attacking=0
