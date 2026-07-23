proc/StarterRoll(mob/M,mob/Target)
	if(M.StrMod >= M.SpdMod)
		DashRoll(M,Target)
	if(M.SpdMod >= M.StrMod)
		ZanzoInRoll(M,Target)

proc/HitRoll(mob/M,mob/Target)
	if(M.StrMod >= M.SpdMod)
//		pick(PushingPunchRoll(M,Target),TugWarRoll(M,Target),FistRoll(M,Target))
		pick(PushingPunchRoll(M,Target),TugWarRoll(M,Target))
//		PushingPunchRoll(M,Target)
//		TugWarRoll(M,Target)
	if(M.SpdMod >= M.StrMod)
		pick(ZanzoComboRoll(M,Target),PushingRoll(M,Target))
//		ZanzoComboRoll(M,Target)
	if(prob(30))
		BreakerRoll(M,Target)

proc/DodgeRoll(mob/M,mob/Target)
	if(M.StrMod >= M.SpdMod)
		pick(TotalBlockRoll(M,Target),SimpleDodgeRoll(M,Target))
	if(M.SpdMod >= M.StrMod)
		pick(ZanzoDodgeRoll(M,Target),ZappingRoll(M,Target))
	if(prob(10))
		BreakerRoll(M,Target)

proc/BreakerRoll(mob/M,mob/Target)
	if(M.StrMod >= M.SpdMod)
		pick(KockbackRoll(M,Target),JumpOutRoll(M,Target))
	if(M.SpdMod >= M.StrMod)
		pick(ZanzoOutRoll(M,Target),JumpOutRoll(M,Target))






proc/ClashHitDodge(mob/M,mob/Target)
//	world<<"HitRoll"
//Calculations Before fight
	var/tmp/Evasion			= SkillAccuracy(M,Target)
	var/tmp/Damage			= AutoAttackDamageCalculator(M,Target)
	if(M.KiFists)
		Damage				=DamageCalculatorKiWeapon(M,Target,src)
	if(M.KiBlade)
		Damage				=DamageCalculatorKiWeapon(M,Target,src)
	if(M.KiHammer)
		Damage				=DamageCalculatorKiWeapon(M,Target,src)
	if(M.SpiritSword)
		Damage				=DamageCalculatorKiWeapon(M,Target,src)
	if(prob(5))
		Damage				*=1.25

//DODGE
	if(!prob(Evasion))

		//Combat Icon
		flick(Target.CustomZanzokenIcon,Target)

		//Energy Math
		M.Target.Ki+=DodgeEnergyCalculation(M.Target,M)
		if(M.Target.MaxKi<=M.Target.Ki)
			M.Target.Ki=M.Target.MaxKi

		//Combat logs
		M.Target.CombatOut("You dodge [M].")
		M.CombatOut("[M.Target] dodges you.")

	//HIT
	else

		//Combat Icon
		HitEffect(M)
		flick("Attack",M)

		//Combat Anger log
		M.Target.LastHitter = Target.name
		M.Target.HitterListCheck(Target.name)

		//If he block it
		if(!prob(Evasion))
			//Animation
			Target.Screen_Shake(2,8)
			ShockwaveScale(Target,M.BP,1)
			if(prob(10)) ShockwaveScale(Target,M.BP)
			hearers(10,M)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)

			//We take the damage
			Damage = Damage * 0.5

			//msg that we blocked
			Target.CombatOut("You block [M].")
			M.CombatOut("[Target] blocks you.")

			//Energy Math for Block
			Target.Ki+=BlockEnergyCalculation(Target)
			if(Target.MaxKi<=Target.Ki)
				Target.Ki=Target.MaxKi

		//Animation
		hearers(10,M)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

		//Math the dmg on the Target
		Target.TakeDamage(M, (Damage)) //Review the TakeDamage Proc!!!!!!!!!!

		//Energy Math
		if(!M.SwordOn&&!M.HammerOn)
			M.Ki+=UnarmedEnergyCalculation(M,M.Target)
			if(M.MaxKi<=M.Ki)
				M.Ki=M.MaxKi
		if(M.SwordOn)
			M.Ki+=SwordEnergyCalculation(M,M.Target)
			if(M.MaxKi<=M.Ki)
				M.Ki=M.MaxKi
		if(M.HammerOn)
			M.Ki+=HammerEnergyCalculation(M,M.Target)
			if(M.MaxKi<=M.Ki)
				M.Ki=M.MaxKi

proc/CheckStopClash(mob/M,mob/Target)

	if(M == Target)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1
	if(M.KOd)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1
	if(Target.KOd)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1
	if(!M.Target)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1

//Training/Meditation
	if(M.Meditate)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1

	if(M.Training)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1

//	if(M.Sparring)
//		M.ClashRoll		= FALSE
//		Target.ClashRoll= FALSE
//		return 1

	if(M.Study)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1

//	if(M.TrainingEquipment)
//		M.ClashRoll		= FALSE
//		Target.ClashRoll= FALSE
//		return 1

	if(M.RPMode)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1




	if(Target.Meditate)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1

	if(Target.Training)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1

//	if(Target.Sparring)
//		M.ClashRoll		= FALSE
//		Target.ClashRoll= FALSE
//		return 1

	if(Target.Study)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1

//	if(Target.TrainingEquipment)
//		M.ClashRoll		= FALSE
//		Target.ClashRoll= FALSE
//		return 1

	if(Target.RPMode)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE
		return 1