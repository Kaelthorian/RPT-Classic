mob/verb/Attack()
	set category="Skills"
//	world<<"Attack start"
/*
	//Objs and Wall dmg
	for(var/obj/T in get_step(src,dir))
		if(src.attacking == 1)
			return
		src.attacking = 1
		T.EnvironmentHealth -= usr.StrMod*5
		flick("Attack",src)
		hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
		if(T.EnvironmentHealth<=0)
			usr<<"You break [T]"
			SmallCrater(T)
			DeleteSaveItem(T)
			del(T)
		spawn(Refire) src.attacking=0
		return

	if(istype(TurfInFront(usr),/turf/Upgradeable))
		var/turf/T=TurfInFront(usr)
		if(src.attacking == 1)
			return
		src.attacking = 1
		T.EnvironmentHealth -= usr.StrMod*5
		flick("Attack",src)
		hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
		if(T.EnvironmentHealth<=0)
			var/turf/atom/Ground/Dirt/S		= new(T)
			usr<<"You break [T]"
			Turfs+=S
		spawn(Refire/3) src.attacking=0
		return
*/
	//All Checks previous to punching
	if(usr.SwordOn || usr.HammerOn)
		if(SkillSafeCheckWeapon(usr,src))
			return
	if(!usr.SwordOn && !usr.HammerOn)
		if(SkillSafeCheckUnarmed(usr,src))
			return
	if(CheckStopClash(usr,usr.Target))
		return
//	world<<"HERE 2"
	//Fight starters
	if(!attacking && Target && !AutoAim && !(Target in get_step(src,dir)) && !ClashRoll && !src.client.ClashRoll && !CheckStopClash(usr,usr.Target))
		if(get_dist(usr,usr.Target) > 5)
			AutoAim=1
			StarterRoll(usr,usr.Target)
			spawn(Refire)AutoAim=0
			return
//	world<<"HERE 3"
	//AutoFace/zanzo
	if(!attacking && Target && !AutoAim && !(Target in get_step(src,dir)) && !ClashRoll && !src.client.ClashRoll && !CheckStopClash(usr,usr.Target))
		AutoAim=1
		src.dir=get_dir(src,src.Target)
		if(!src.ClashRoll)
			if(!Target.ClashRoll)
				ZanzoInRoll(src,src.Target)


		spawn(Refire)AutoAim=0
		return

//	if(client&&client&&!TestServerOn) if(client.computer_id==client.computer_id) if(!TournamentOn) // Based on computer ID instead of IP.
//		src<<"Do not interact with alternate keys"
//		alertAdmins("|| ([src.x], [src.y], [src.z]) | [key_name(src)] has been forced off the server for attempted alt interaction with [key_name(Target)].\n")
//		src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] has been forced off the server for attempted alt interaction with [key_name(Target)].\n")
//		Logout()
//	world<<"HERE 4"
	//Consequences of trying to punch
	if(src.invisibility)
		src.invisibility=0
		src.see_invisible=0
		for(var/Skill/Support/Invisibility/A in src) if(A.Using) spawn(45){A.Using=0;src<<"You feel your body relax again."}

//	Bandages()
//	world<<"HERE 5"
	//Starting of the normal attack
	if(!attacking && Target && (Target in get_step(src,dir)) && !ClashRoll && !src.client.ClashRoll)
		src.attacking=1


//		world<<"HERE 6"
	//Calculations Before fight
		var/tmp/Evasion			= SkillAccuracy(src,Target)
		var/tmp/Damage			= AutoAttackDamageCalculator(src,src.Target)
		if(KiFists)
			Damage				=DamageCalculatorKiWeapon(src,Target,src)
		if(KiBlade)
			Damage				=DamageCalculatorKiWeapon(src,Target,src)
		if(KiHammer)
			Damage				=DamageCalculatorKiWeapon(src,Target,src)
		if(SpiritSword)
			Damage				=DamageCalculatorKiWeapon(src,Target,src)
		if(prob(5))
			Damage				*=1.25

	//DODGE
//		world<<"HERE 7"
		if(!prob(Evasion))

			//Combat Icon
			flick(src.CustomZanzokenIcon,src)

			//Energy Math
			src.Target.Ki+=DodgeEnergyCalculation(src.Target,src)
			if(src.Target.MaxKi<=src.Target.Ki)
				src.Target.Ki=src.Target.MaxKi

			//Combat Rolls
			DodgeRoll(src,src.Target)

			//Combat logs
			src.Target.CombatOut("You dodge [src].")
			CombatOut("[src.Target] dodges you.")

	//HIT
		else
//			world<<"HERE 8"
			//DMG Regulator


			//Combat Icon
			HitEffect(src)
			flick("Attack",src)

			//Combat Anger log
			src.Target.LastHitter = Target.name
			src.Target.HitterListCheck(Target.name)

			//If he block it
			if(!prob(Evasion-(Target.HasWayOfTheTurtle*2.5)))
				//Animation
				Target.Screen_Shake(2,8)
				ShockwaveScale(Target,usr.BP,1)
				if(prob(10)) ShockwaveScale(Target,BP)
				hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)

				//We take the damage
				Damage = Damage * 0.5

				//msg that we blocked
				Target.CombatOut("You block [usr].")
				CombatOut("[Target] blocks you.")

				//Energy Math for Block
				Target.Ki+=BlockEnergyCalculation(Target)
				if(Target.MaxKi<=Target.Ki)
					Target.Ki=Target.MaxKi

			//Animation
			hearers(10,usr)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

			//Math the dmg on the Target
			Target.TakeDamage(src, (Damage)) //Review the TakeDamage Proc!!!!!!!!!!

			//Energy Math
			if(!SwordOn&&!HammerOn)
				Ki+=UnarmedEnergyCalculation(src,src.Target)
				if(MaxKi<=Ki)
					Ki=MaxKi
			if(SwordOn)
				Ki+=SwordEnergyCalculation(src,src.Target)
				if(MaxKi<=Ki)
					Ki=MaxKi
			if(HammerOn)
				Ki+=HammerEnergyCalculation(src,src.Target)
				if(MaxKi<=Ki)
					Ki=MaxKi

			//Combat Rolls
			if(prob(75))
//				world<<"prob(75)"
				HitRoll(src,src.Target)

//		world<<"HERE 9"
		spawn(Refire/6) usr.attacking=0
		src.ClashRoll				= FALSE
		src.Target.ClashRoll		= FALSE
		return
	return




mob/proc/AttackProc()
	//All Checks previous to punching
	if(usr.SwordOn || usr.HammerOn)
		if(SkillSafeCheckWeapon(usr,src))
			return
	if(!usr.SwordOn && !usr.HammerOn)
		if(SkillSafeCheckUnarmed(usr,src))
			return
	if(CheckStopClash(usr,usr.Target))
		return
	//Fight starters
	if(!attacking && Target && !AutoAim && !(Target in get_step(src,dir)) && !ClashRoll && !src.client.ClashRoll && !CheckStopClash(usr,usr.Target))
		if(get_dist(usr,usr.Target) > 5)
			AutoAim=1
			StarterRoll(usr,usr.Target)
			spawn(Refire)AutoAim=0
			return
	//AutoFace/zanzo
	if(!attacking && Target && !AutoAim && !(Target in get_step(src,dir)) && !ClashRoll && !src.client.ClashRoll && !CheckStopClash(usr,usr.Target))
		AutoAim=1
		src.dir=get_dir(src,src.Target)
		if(!src.ClashRoll)
			if(!Target.ClashRoll)
				ZanzoInRoll(src,src.Target)


		spawn(Refire)AutoAim=0
		return

	//Consequences of trying to punch
	if(src.invisibility)
		src.invisibility=0
		src.see_invisible=0
		for(var/Skill/Support/Invisibility/A in src) if(A.Using) spawn(45){A.Using=0;src<<"You feel your body relax again."}

//	Bandages()
	//Starting of the normal attack
	if(!attacking && Target && (Target in get_step(src,dir)) && !ClashRoll && !src.ClashRoll)
		src.attacking=1

//	if(!Target.Target)
//		Target.Target=src

	//Calculations Before fight
		var/tmp/Evasion			= SkillAccuracy(src,Target)
		var/tmp/Damage			= AutoAttackDamageCalculator(src,src.Target)
		if(KiFists)
			Damage				=DamageCalculatorKiWeapon(src,Target,src)
		if(KiBlade)
			Damage				=DamageCalculatorKiWeapon(src,Target,src)
		if(KiHammer)
			Damage				=DamageCalculatorKiWeapon(src,Target,src)
		if(SpiritSword)
			Damage				=DamageCalculatorKiWeapon(src,Target,src)
		if(prob(5))
			Damage				*=1.25

	//DODGE
		if(!prob(Evasion))

			//Combat Icon
			flick(src.CustomZanzokenIcon,src)

			//Energy Math
			src.Target.Ki+=DodgeEnergyCalculation(src.Target,src)
			if(src.Target.MaxKi<=src.Target.Ki)
				src.Target.Ki=src.Target.MaxKi

			//Combat Rolls
			DodgeRoll(src,src.Target)

			//Combat logs
			src.Target.CombatOut("You dodge [src].")
			CombatOut("[src.Target] dodges you.")

	//HIT
		else
			//Combat Icon
			HitEffect(src)
			flick("Attack",src)

			//Combat Anger log
			src.Target.LastHitter = Target.name
			src.Target.HitterListCheck(Target.name)

			//If he block it
			if(!prob(Evasion-(Target.HasWayOfTheTurtle*2.5)))
				//Animation
				Target.Screen_Shake(2,8)
				ShockwaveScale(Target,usr.BP,1)
				if(prob(10)) ShockwaveScale(Target,BP)
				hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)

				//We take the damage
				Damage = Damage * 0.5

				//msg that we blocked
				Target.CombatOut("You block [usr].")
				CombatOut("[Target] blocks you.")

				//Energy Math for Block
				Target.Ki+=BlockEnergyCalculation(Target)
				if(Target.MaxKi<=Target.Ki)
					Target.Ki=Target.MaxKi

			//Animation
			hearers(10,usr)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

			//Math the dmg on the Target
			Target.TakeDamage(src, (Damage)) //Review the TakeDamage Proc!!!!!!!!!!

			//Energy Math
			if(!SwordOn&&!HammerOn)
				Ki+=UnarmedEnergyCalculation(src,src.Target)
				if(MaxKi<=Ki)
					Ki=MaxKi
			if(SwordOn)
				Ki+=SwordEnergyCalculation(src,src.Target)
				if(MaxKi<=Ki)
					Ki=MaxKi
			if(HammerOn)
				Ki+=HammerEnergyCalculation(src,src.Target)
				if(MaxKi<=Ki)
					Ki=MaxKi

			//Combat Rolls
			if(prob(75))
//				world<<"prob(75)"
				HitRoll(src,src.Target)

		spawn(Refire/6) usr.attacking=0
		src.ClashRoll				= FALSE
		src.Target.ClashRoll		= FALSE
		return
	return