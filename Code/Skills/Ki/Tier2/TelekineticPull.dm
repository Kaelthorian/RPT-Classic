Skill/Unarmed/T2/TelekineticPull
	desc="Summons your target into the tile in front of you, or the nearest available, and launches a melee attack."


	UB1="Shadow King"
	UB2="Arcane Power"
	//var/HasCharge=1
	//var/MaxCharge=2

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_STR	= DMGS_TIER_2
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Telekinetic_Pull()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		usr.Ki=(usr.Ki-EDT)
		var/mob/hitter
		if(usr.Target&& ismob(usr.Target)) if(usr.Target.z==usr.z) if(get_dist(usr,usr.Target)<=10) if(usr.Target in oviewers(10,usr))  hitter=usr.Target
		if(!hitter) return
		if(hitter==usr) return
		if(hitter.afk||hitter.KOd||!hitter.attackable||hitter.RPMode||hitter.adminDensity) return
		if(!locate(hitter) in viewers(usr)) return
		if(hitter.RPMode) return
		if(hitter.Flying!=usr.Flying) return
		//if(hitter.attacking==1) usr.Opp(hitter)
		if(hitter&&hitter.Health>0)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			usr.attacking=1
			var/didBlock=0
			flick(hitter.CustomZanzokenIcon,hitter)
			ZanzoDust(hitter)
			hitter.Comboz(usr)
			flick("Attack",usr)
			var/Evasion=SkillAccuracy(usr,hitter)
			var/Damage=DamageCalculator(usr,hitter,src)
			if(!prob(Evasion))
				flick(hitter.CustomZanzokenIcon,hitter)
//				hearers(6,hitter) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
				hitter.CombatOut("You dodge [usr].")
				usr.CombatOut("[hitter] dodges you.")
				hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
			else //Successful hit
				if(!prob(Evasion+(hitter.HasWayOfTheTurtle*2.5)))
					Damage = Damage
//					hearers(6,hitter)<<pick('Melee_Block1.wav','Melee_Block2.wav')
					didBlock=1
				if(prob(25)) ImpactDust(hitter,usr.dir)//ShockwaveIcon(null,"Impact",hitter.loc)
				ASSERT(hitter)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
				if(hitter)
					Damage=Damage
					if(!isnum(hitter.Health)) return
					var/AttackOut=""
					if(didBlock==1)AttackOut="Blocked"
					else if(didBlock==2) AttackOut="(Armor) Blocked"
					hitter.TakeDamage(usr, Damage, "[AttackOut] [src]")
					hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
					hitter.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
					hitter.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
			//Learnable=1
			//spawn(60) Learnable=0
			spawn(usr.Refire*0.5)if(usr.attacking!=3) usr.attacking=0

