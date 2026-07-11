Skill/Unarmed/T1/DashAttack

	desc="Use your impressive speed to rush at your opponent and strike them as you advance. Adds 20% of your speed to your attack damage."

//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_STR	= ((DMGS_TIER_1*28.6)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_1*57.1)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_1*14.3)/100)
	WEAPON			= NO
	LT				= HEAD
	SKILLTRAIT		= list()

	verb/Dash_Attack()
		set category="Skills"
		//Are we allowed to hit him ?
		if(usr.SwordOn || usr.HammerOn)
			if(SkillSafeCheckWeapon(usr,src))
				//TESTINGREPLACE
				return
		if(!usr.SwordOn && !usr.HammerOn)
			if(SkillSafeCheckUnarmed(usr,src))
				//TESTINGREPLACE
				return
		if(usr.Flying)
			usr.Flight_Land()

		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		var/Steps=round(usr.SpdMod*2*usr.SpdMult)
		while(Steps)
			step(usr,usr.dir)
			Steps--
			for(var/mob/M in get_step(usr,usr.dir))
				Steps=0
				flick("Attack",usr)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)

				if(!prob(Evasion))
					flick(M.CustomZanzokenIcon,M)
					M.CombatOut("You dodge [usr].")
					usr.CombatOut("[M] dodges you.")
					hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
				else
					if(!prob(Evasion))
						ShockwaveScale(M,usr.BP,1)
						Damage = Damage
						hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
						ImpactDust(M,usr.dir)
					if(M)
						if(!isnum(M.Health)) return
						hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
						M.TakeDamage(usr, Damage, "[src]")
						M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
						M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
						ImpactDust(M,usr.dir)
						M.KB=round((usr.Str/M.End)*usr.SpdMult)
						M.KnockBack(usr)

			sleep(1)


