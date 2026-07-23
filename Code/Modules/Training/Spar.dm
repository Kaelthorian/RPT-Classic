mob/verb/Sparring()
	set category="Skills"

	//All Checks previous to punching
	if(usr.SwordOn || usr.HammerOn)
		if(SkillSafeCheckWeapon(usr,src))
			return
	if(!usr.SwordOn && !usr.HammerOn)
		if(SkillSafeCheckUnarmed(usr,src))
			return
	if(CheckStopClash(usr,usr.Target))
		return

	//Consequences of trying to punch
	if(src.invisibility)
		src.invisibility=0
		src.see_invisible=0
		for(var/Skill/Support/Invisibility/A in src) if(A.Using) spawn(45){A.Using=0;src<<"You feel your body relax again."}
	//punching bag
	for(var/obj/T in get_step(src,dir))
		if(istype(T,/obj/TrainingEq/Punching_Bag/) && !attacking)
			if(T.dir==1 && usr.dir==2 || T.dir==2 && usr.dir==1 || T.dir==8 && usr.dir==4 || T.dir==4 && usr.dir==8)
				src.PunchingBag= 1
				src.attacking=1
				flick("hit",T)
				flick("Attack",src)
				spawn(Refire/6) usr.attacking=0
				return

	//Starting of the normal attack
	if(!attacking && Target && (Target in get_step(src,dir)) && !ClashRoll && !src.client.ClashRoll)
		src.attacking=1
		src.Sparring= 1

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
				Damage = Damage / 25

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
			if(prob(0))
				HitRoll(src,src.Target)

		spawn(Refire/6) usr.attacking=0
		src.ClashRoll				= FALSE
		src.Target.ClashRoll		= FALSE
		return

	return



proc/SparringTimer()
	set background = 1
	while(1)
		for(var/mob/R in Players)
			if(R.Sparring || R.PunchingBag)
				R.FBMCheck()
				HighestBPCheck()

				MaxBP=TrueBPCap*(400000/150)**(Year/40)
				TrainingTic = ((MaxBP - (R.Base/R.BPMod)) * 0.0003)

				if((R.Base/R.BPMod) < (HighestBP * 0.95))
					TrainingTic *= 1.5
				if((R.Base/R.BPMod) < (HighestBP * 0.9))
					TrainingTic *= 2
				if((R.Base/R.BPMod) < (HighestBP * 0.8))
					TrainingTic *= 2
				if(RaceEraCurrent == R.Race)
					TrainingTic *= 1.05
				if(R.EXPLifetime > MaxEXPReward- 50)
					TrainingTic *= 0.8
				if((R.Base/R.BPMod) >= MaxBP)
					TrainingTic *= 0
				if(R.Sparring)
					TrainingTic *= 1.1
				if(R.PunchingBag)
					TrainingTic *= 1.05
				if(R.Gravity>1)
					TrainingTic *= 1.15

				if(R.Weight)
					for(var/obj/items/Weights/E in R)
						if(E.suffix)
							TrainingTic *= ((7*(E.Weight*100)/((R.BPMod)*round(R.Base))/100)/100)+1
							if(prob(50))
								E.Health--
								if(E.Health<=0)
									R.Weight--
									if(R.Weight<=0)
										R.Weight=0
									R<<"Your weights break and desintegrate after being used for too long."
									R.overlays -= E
									del(E)

//				TrainingTic *= ((15*(R.Gravity*100)/((R.BPMod)*round(R.Base))/100)/100)+1


				R.Base= R.Base + (TrainingTic * R.BPMod )
				R.Sparring = 0
				R.PunchingBag=0


		sleep(50)