proc/CDCalculation(Skill/S,mob/M)
	var/CDCalculation

	CDCalculation=(1+Modifier(M))/S.CDT
	DebugLogs("-CDCalculation-","Combat")
	DebugLogs("Offender: [M]","Combat")
	DebugLogs("Skill: [S]","Combat")
	DebugLogs("SkillTraitCooldownReduce: ((1+Modifier [Modifier(M)])/CDT [S.CDT])","Combat")
	DebugLogs("<font color=purple> CDCalculation: [CDCalculation]","Combat")
	for(var/R in S.SKILLTRAIT)
		DebugLogs("Trait: [R]","Combat")
	DebugLogs("----------------------------------------","Combat")

	return CDCalculation

proc/AutoAttackDamageCalculator(mob/Offender,mob/Defender)

	if(Offender&&Defender)
		var/Sword_Damage=0
		var/MaxSwordPercent=0
		var/IgnoresEnd=0
		if(Offender)
			if(!Offender.KiFists&&!Offender.Disarmed) for(var/obj/items/Sword/A in Offender) if(A.suffix&&A.Durability>0)
				Sword_Damage=A.Health
				MaxSwordPercent=A.MaxBPAdd
				break

			if(!Offender.KiFists&&!Offender.Disarmed) for(var/obj/items/Artifact/Weapon/A in Offender) if(A.suffix)
				Sword_Damage=A.Health
				MaxSwordPercent=A.MaxBPAdd
				A.DurabilityCheck(Offender)
				break

			if(!Sword_Damage&&!Offender.KiFists&&!Offender.Disarmed) for(var/obj/items/Hammer/A in Offender) if(A.suffix&&A.Durability>0)
				Sword_Damage=A.Health
				MaxSwordPercent=A.MaxBPAdd
				A.DurabilityCheck(Offender)
				break

		if(!Sword_Damage) for(var/obj/items/Gauntlets/A in Offender) if(A.suffix&&A.Durability>0)
			Sword_Damage=A.Health
			MaxSwordPercent=A.MaxBPAdd
			A.DurabilityCheck(Offender)
			break

		if(!Sword_Damage) for(var/obj/items/Artifact/Guantlet/A in Offender) if(A.suffix)
			Sword_Damage=A.Health
			MaxSwordPercent=A.MaxBPAdd
			A.DurabilityCheck(Offender)
			break

		if(Defender.ArmorOn) for(var/obj/items/Armor/A in Defender) if(A.suffix&&A.Durability>0)
			A.DurabilityCheck(Defender)
			break

		if(Sword_Damage>Offender.BP*(MaxSwordPercent/100)) Sword_Damage=Offender.BP*(MaxSwordPercent/100)

		var/EMPBP=0

		if(Defender.ArmorOn)
			for(var/obj/items/Armor/A in Defender)
				if(A.suffix&&A.Durability>0)
					if(A.KineticBarrier)
						EMPBP=Defender.BP*(A.KineticBarrier/100)

		if(Defender.EmpoweredDefenseTicks)
			EMPBP=Defender.BP*0.35
		if(Offender.HasThisDrill)
			IgnoresEnd=20
		DebugLogs("-AutoAttackDamageCalculator-","Combat")
		DebugLogs("Offender : [Offender] Vs Defender : [Defender]","Combat")
		DebugLogs("<font color=white>Skill: Auto-Attack","Combat")
		DebugLogs("Dam Calc=(([Offender.BP]+([Sword_Damage]))*([Offender.StrMod])","Combat")
		var/Dam=((Offender.BP+(Sword_Damage))*(Offender.StrMod))*2
		DebugLogs("<font color=yellow>Dam=[Dam]","Combat")
		var/Res=((Defender.BP+(EMPBP))*(Defender.EndMod-(Defender.EndMod*(IgnoresEnd/100))))
		DebugLogs("Res Calc=(([Defender.BP]+([EMPBP]))*([Defender.EndMod]-([Defender.EndMod]*([IgnoresEnd]/100))))","Combat")
		DebugLogs("<font color=yellow>Res=[Res]","Combat")


		var/TotalDamage=((1*((rand(75,100)/100)))*(((Dam)/max(Res,0.01))))
		DebugLogs("TotalDamage Cal =((1*((rand(75,100)=[rand(75,100)]/100)))*((([Dam])/max(Res,0.01)=[max(Res,0.01)])))","Combat")
		DebugLogs("<font color=red>TotalDamage=[TotalDamage]","Combat")
		for(var/obj/items/Boxing_Gloves/G in usr) if(G.suffix)
			TotalDamage /= 20
			break
		DebugLogs("Defender HP=[Defender.Health]","Combat")
		DebugLogs("----------------------------------------","Combat")

		return TotalDamage

proc/DamageCalculator(mob/Offender,mob/Defender,Skill/S)
	if(Offender&&Defender)
		var/Sword_Damage=0
		var/MaxSwordPercent=0
		var/IgnoresEnd=0
		if(S.WEAPON)
			if(!Offender.KiFists&&!Offender.Disarmed) for(var/obj/items/Sword/A in Offender) if(A.suffix&&A.Durability>0)
				Sword_Damage=A.Health
				MaxSwordPercent=A.MaxBPAdd
				A.DurabilityCheck(Offender)
				break

			if(!Offender.KiFists&&!Offender.Disarmed) for(var/obj/items/Artifact/Weapon/A in Offender) if(A.suffix)
				Sword_Damage=A.Health
				MaxSwordPercent=A.MaxBPAdd
				A.DurabilityCheck(Offender)
				break

			if(!Sword_Damage&&!Offender.KiFists&&!Offender.Disarmed) for(var/obj/items/Hammer/A in Offender) if(A.suffix&&A.Durability>0)
				Sword_Damage=A.Health
				MaxSwordPercent=A.MaxBPAdd
				A.DurabilityCheck(Offender)
				break

		if(!Sword_Damage) for(var/obj/items/Gauntlets/A in Offender) if(A.suffix&&A.Durability>0)
			Sword_Damage=A.Health
			MaxSwordPercent=A.MaxBPAdd
			A.DurabilityCheck(Offender)
			break

		if(!Sword_Damage) for(var/obj/items/Artifact/Guantlet/A in Offender) if(A.suffix)
			Sword_Damage=A.Health
			MaxSwordPercent=A.MaxBPAdd
			A.DurabilityCheck(Offender)
			break

		if(Defender.ArmorOn) for(var/obj/items/Armor/A in Defender) if(A.suffix&&A.Durability>0)
			A.DurabilityCheck(Defender)
			break

		if(Sword_Damage>Offender.BP*(MaxSwordPercent/100)) Sword_Damage=Offender.BP*(MaxSwordPercent/100)

		var/EMPBP=0

		if(Defender.ArmorOn)
			for(var/obj/items/Armor/A in Defender)
				if(A.suffix&&A.Durability>0)
					if(A.KineticBarrier)
						EMPBP=Defender.BP*(A.KineticBarrier/100)

		if(Defender.EmpoweredDefenseTicks)
			EMPBP=Defender.BP*0.35
		if(Offender.HasThisDrill)
			IgnoresEnd=20
		DebugLogs("-DamageCalculator-","Combat")
		DebugLogs("Offender : [Offender] Vs Defender : [Defender]","Combat")
		DebugLogs("<font color=white>Skill: [S]","Combat")
		DebugLogs("Dam Calc=(([Offender.BP]+([Sword_Damage]*[S.WEAPON]))*(([Offender.StrMod]*[S.DMGSOURCE_STR])+([Offender.SpdMod]*[S.DMGSOURCE_SPD])+([Offender.PowMod]*[S.DMGSOURCE_POW])+([Offender.OffMod]*[S.DMGSOURCE_OFF])+([Offender.DefMod]*[S.DMGSOURCE_DEF])+([Offender.EndMod]*[S.DMGSOURCE_END])))","Combat")
		var/Dam=((Offender.BP+(Sword_Damage*S.WEAPON))*((Offender.StrMod*S.DMGSOURCE_STR)+(Offender.SpdMod*S.DMGSOURCE_SPD)+(Offender.PowMod*S.DMGSOURCE_POW)+(Offender.OffMod*S.DMGSOURCE_OFF)+(Offender.DefMod*S.DMGSOURCE_DEF)+(Offender.EndMod*S.DMGSOURCE_END)))
		DebugLogs("<font color=yellow>Dam=[Dam]","Combat")
		var/Res=((Defender.BP+(EMPBP))*(Defender.EndMod-(Defender.EndMod*(IgnoresEnd/100))))
		DebugLogs("Res Calc=(([Defender.BP]+([EMPBP]))*([Defender.EndMod]-([Defender.EndMod]*([IgnoresEnd]/100))))","Combat")
		DebugLogs("<font color=yellow>Res=[Res]","Combat")



		var/TotalDamage=((1*((rand(75,100)/100)*S.DMGT))*(((Dam)/max(Res,0.01)))) * (SkillTraitDamage(S))
		DebugLogs("TotalDamage Cal =((1*((rand(75,100)=[rand(75,100)]/100)*[S.DMGT]))*((([Dam])/max(Res,0.01)=[max(Res,0.01)]))) * ([SkillTraitDamage(S)])","Combat")
		DebugLogs("<font color=red>TotalDamage=[TotalDamage]","Combat")
		for(var/obj/items/Boxing_Gloves/G in usr) if(G.suffix)
			TotalDamage /= 20
			break
		DebugLogs("Defender HP=[Defender.Health]","Combat")
		DebugLogs("----------------------------------------","Combat")
		return TotalDamage

proc/DamageCalculatorKiWeapon(mob/Offender,mob/Defender)
	if(Offender&&Defender)
		var/Sword_Damage	=0
		var/IgnoresEnd		=0
		var/DMGSOURCE_STR	=0
		var/DMGSOURCE_POW	=0
		var/DMGSOURCE_SPD	=0
		var/WEAPON			=0

		if(Offender.BoundWeaponOn)
			Offender.BWWillpowerDrain()
			Sword_Damage=Offender.BP*0.2 + Offender.BP*((Offender.BoundWeaponOn-1)*0.1)
			WEAPON=1
			DMGSOURCE_STR=0
			DMGSOURCE_POW=1

		if(Offender.SpiritSword)
			Sword_Damage=Offender.BP*0.6
			WEAPON=1
			DMGSOURCE_STR=0
			DMGSOURCE_POW=1

		if(Offender.KiBlade)
			if(Offender.HasBladeOfLight)
				Sword_Damage=Offender.BP*0.4
			else
				Sword_Damage=Offender.BP*0.3

			WEAPON=1
			DMGSOURCE_STR=0.30
			DMGSOURCE_POW=0.70

		if(Offender.KiHammer)
			Sword_Damage=Offender.BP*1
			WEAPON=1
			DMGSOURCE_STR=0
			DMGSOURCE_POW=1

		if(Offender.KiFists)
			if(Sword_Damage<=Offender.BP*0.18)
				Sword_Damage=Offender.BP*0.18
				WEAPON=1
				DMGSOURCE_STR=0.7
				DMGSOURCE_POW=0.3
				if(Offender.HasWayOfTheFist)
					DMGSOURCE_SPD=0.1

		var/EMPBP=0

		if(Defender.ArmorOn)
			for(var/obj/items/Armor/A in Defender)
				if(A.suffix&&A.Durability>0)
					if(A.KineticBarrier)
						EMPBP=Defender.BP*(A.KineticBarrier/100)

		if(Defender.EmpoweredDefenseTicks)
			EMPBP=Defender.BP*0.35

		if(Offender.HasThisDrill)
			IgnoresEnd=20

		var/Dam=((Offender.BP+(Sword_Damage*WEAPON))*((Offender.StrMod*DMGSOURCE_STR)+(Offender.PowMod*DMGSOURCE_POW)+(Offender.SpdMod*DMGSOURCE_SPD)))

		var/Res=((Defender.BP+(EMPBP))*(Defender.EndMod-(Defender.EndMod*(IgnoresEnd/100))))






		var/TotalDamage=((1*((rand(75,100)/100)))*(((Dam)/max(Res,0.01))))

		DebugLogs("-DamageCalculatorKiWeapon-","Combat")
		DebugLogs("Offender : [Offender] Vs Defender : [Defender]","Combat")
		DebugLogs("<font color=white>Skill: Ki Weapon","Combat")
		DebugLogs("<font color=yellow>Dam=[Dam]","Combat")
		DebugLogs("Dam= (([Offender.BP]+([Sword_Damage]*[WEAPON]))*(([Offender.StrMod]*[DMGSOURCE_STR])+([Offender.PowMod]*[DMGSOURCE_POW])+([Offender.SpdMod]*[DMGSOURCE_SPD])))","Combat")
		DebugLogs("Def= (([Defender.BP]+([EMPBP]))*([Defender.EndMod]-([Defender.EndMod]*([IgnoresEnd]/100))))","Combat")
		DebugLogs("<font color=yellow>Res=[Res]","Combat")
		DebugLogs("<font color=red>TotalDamage=[TotalDamage]","Combat")
		DebugLogs("Defender HP=[Defender.Health]","Combat")
		DebugLogs("----------------------------------------","Combat")

		for(var/obj/items/Boxing_Gloves/G in usr) if(G.suffix)
			TotalDamage /= 20
			break

		return TotalDamage

//Energy
proc/
	BlockEnergyCalculation(mob/Attacker)
		var/BLOCKENERGY
		BLOCKENERGY=(Attacker.MaxKi*DEFAULT_BLOCK_ENERGY)
		DebugLogs("-BlockEnergyCalculation-","Combat")
		DebugLogs("Offender: [Attacker]","Combat")
		DebugLogs("Style: Block","Combat")
		DebugLogs("<font color=blue>Energy Gained: [BLOCKENERGY]","Combat")
		DebugLogs("----------------------------------------","Combat")
		return BLOCKENERGY

	DodgeEnergyCalculation(mob/Attacker,mob/Defender)
		var/DODGEENERGY
		DODGEENERGY=(Attacker.MaxKi*DEFAULT_DODGE_ENERGY)
		Attacker.Ki=(Attacker.Ki-Attacker.Ki*(Defender.HasFloatLike*0.05))
		if(Defender.HasFloatLike)
			Defender.CombatOut("[(Attacker)] Lost energy")

		DebugLogs("-DodgeEnergyCalculation-","Combat")
		DebugLogs("Attacker : [Attacker] Vs Defender : [Defender]","Combat")
		DebugLogs("Style: Dodge","Combat")
		DebugLogs("<font color=blue>Energy Gained: [DODGEENERGY]","Combat")
		DebugLogs("----------------------------------------","Combat")
		return DODGEENERGY

	UnarmedEnergyCalculation(mob/Attacker,mob/Defender)
		var/UNARMEDENERGY
		if(Attacker.ChakraBlocked)
			return 0
		UNARMEDENERGY=(((Attacker.MaxKi*DEFAULT_UNARMED_ENERGY)*Attacker.StrMod*Attacker.BP)/(Defender.EndMod*Defender.BP)*(1 -(0.1*Attacker.Shielding)))+(Attacker.HasDeepBreathing*2)
		DebugLogs("-UnarmedEnergyCalculation-","Combat")
		DebugLogs("Attacker : [Attacker] Vs Defender : [Defender]","Combat")
		DebugLogs("Style: Unarmed","Combat")
		DebugLogs("<font color=blue>Energy Gained: [UNARMEDENERGY]","Combat")
		DebugLogs("----------------------------------------","Combat")
		if(Attacker.Warp)
			UNARMEDENERGY=UNARMEDENERGY/5
		return UNARMEDENERGY

	SwordEnergyCalculation(mob/Attacker,mob/Defender)
		var/SWORDENERGY
		if(Attacker.ChakraBlocked)
			return 0
		SWORDENERGY=(((Attacker.MaxKi*DEFAULT_SWORD_ENERGY)*Attacker.StrMod*Attacker.BP)/(Defender.EndMod*Defender.BP)*(1 -(0.1*Attacker.Shielding)))+(Attacker.HasDeepBreathing*2)
		DebugLogs("-SwordEnergyCalculation-","Combat")
		DebugLogs("Attacker : [Attacker] Vs Defender : [Defender]","Combat")
		DebugLogs("Style: Sword","Combat")
		DebugLogs("<font color=blue>Energy Gained: [SWORDENERGY]","Combat")
		DebugLogs("----------------------------------------","Combat")
		if(Attacker.Warp)
			SWORDENERGY=SWORDENERGY/5
		return SWORDENERGY

	HammerEnergyCalculation(mob/Attacker,mob/Defender)
		var/HAMMERENERGY
		if(Attacker.ChakraBlocked)
			return 0
		HAMMERENERGY=(((Attacker.MaxKi*DEFAULT_HAMMER_ENERGY)*Attacker.StrMod*Attacker.BP)/(Defender.EndMod*Defender.BP)*(1 -(0.1*Attacker.Shielding)))+(Attacker.HasDeepBreathing*2)
		DebugLogs("-HammerEnergyCalculation-","Combat")
		DebugLogs("Attacker : [Attacker] Vs Defender : [Defender]","Combat")
		DebugLogs("Style: Hammer","Combat")
		DebugLogs("<font color=blue>Energy Gained: [HAMMERENERGY]","Combat")
		DebugLogs("----------------------------------------","Combat")
		if(Attacker.Warp)
			HAMMERENERGY=HAMMERENERGY/5
		return HAMMERENERGY

	EnergyCalculation(Skill/S,mob/M)
		var/EnergyCalculation

		EnergyCalculation=(M.Ki-(S.EDT*SkillTraitEnergy(S)))
		DebugLogs("-EnergyCalculation-","Combat")
		DebugLogs("Offender: [M]","Combat")
		DebugLogs("<font color=white>Skill: [S]","Combat")
		DebugLogs("EnergyCalculationEquation: M.Ki[M.Ki]-(S.EDT[S.EDT]*SkillTraitEnergy[SkillTraitEnergy(S)])","Combat")
		DebugLogs("<font color=blue> EnergyCalculation: [(M.Ki-(S.EDT*SkillTraitEnergy(S)))]","Combat")
		DebugLogs("----------------------------------------","Combat")


		return EnergyCalculation

//Accuracy
proc/SkillAccuracy(mob/Offender,mob/Defender,Skill/S)
	if(Offender&&Defender)
		var/Offense=(Offender.BP*((Offender.OffMod)+(Offender.SpdMod*(0.3+(max(Offender.HasPrecognition,Offender.Precognition)*0.1)))))
		var/Defense=(Defender.BP*((Defender.DefMod)+(Defender.SpdMod*(0.3+(max(Defender.HasPrecognition,Defender.Precognition)*0.1)))))
		var/TotalAccuracy= DEFAULTACC*(((Offense/max(Defense,0.01))))
		DebugLogs("-SkillAccuracy-","Combat")

		DebugLogs("Offender : [Offender] Vs Defender : [Defender]","Combat")
		DebugLogs("<font color=white>Skill: [S]","Combat")
//		DebugLogs("Energy Drain: [S.EDT]","Combat")
		DebugLogs("Offense:(Offender.BP [Offender.BP]*((Offender.Off [Offender.OffMod])+(Offender.Spd [Offender.SpdMod]*(0.3+(Offender.Precognition [Offender.Precognition]*0.05)))))","Combat")
		DebugLogs("Defense:(Defender.BP [Defender.BP]*((Defender.Def [Defender.DefMod])+(Defender.Spd [Defender.SpdMod]*(0.3+(Defender.Precognition [Defender.Precognition]*0.05)))))","Combat")
		DebugLogs("Offense: [Offense]","Combat")
		DebugLogs("Defense: [Defense]","Combat")
		DebugLogs("DEFAULTACC: [DEFAULTACC]","Combat")
		DebugLogs("TotalAccuracy: DEFAULTACC [DEFAULTACC]*((([Offense]/[max(Defense,0.01)])))","Combat")
		DebugLogs("TotalAccuracy: [TotalAccuracy]","Combat")

		//Modifiers for your accuracy
		if(Offender.dir==Defender.dir)
			DebugLogs("Offender.dir==Defender.dir		+25","Combat")
			TotalAccuracy+=25





			if(Offender.dir==turn(Defender.dir,90))
				TotalAccuracy+=10


			if(Offender.dir==turn(Defender.dir,-90))
				TotalAccuracy+=10


		if(Defender.attacking)
			TotalAccuracy+=10
			DebugLogs("Defender.attacking: 				+10","Combat")

		if(Defender.Slow)
			TotalAccuracy+=Defender.Slow
			DebugLogs("Defender.Slow: +[Defender.Slow]","Combat")

		if(Offender.Slow)
			TotalAccuracy-=Offender.Slow
			DebugLogs("Offender.Slow: -[Offender.Slow]","Combat")

		if(Offender.BonusSpeed)
			TotalAccuracy+=Offender.BonusSpeed
			DebugLogs("Offender.BonusSpeed: +[Offender.BonusSpeed]","Combat")

		if(Defender.BonusSpeed)
			TotalAccuracy-=Defender.BonusSpeed
			DebugLogs("Defender.BonusSpeed: -[Defender.BonusSpeed]","Combat")

		if(Offender.StanceCore==1)
			TotalAccuracy+=3
			DebugLogs("Offender.StanceCore: +3","Combat")

		if(Defender.StanceCore==1)
			TotalAccuracy-=3
			DebugLogs("Defender.StanceCore: -3","Combat")

		if(Offender.HasDeftHands)
			TotalAccuracy+=2.5*Offender.HasDeftHands
			DebugLogs("Offender.HasDeftHands: +2.5*[Offender.HasDeftHands]","Combat")

		if(Defender.HasSwiftReflexes)
			TotalAccuracy-=2.5*Defender.HasSwiftReflexes
			DebugLogs("Defender.HasSwiftReflexes: -2.5*[Defender.HasSwiftReflexes]","Combat")

		if(TotalAccuracy>=99)
			TotalAccuracy=99
			DebugLogs("TotalAccuracy>=99 = 99","Combat")

		if(TotalAccuracy<=1)
			TotalAccuracy=1
			DebugLogs("TotalAccuracy<=1  = 1","Combat")

		if(Defender.icon_state=="Meditate"||Defender.KOd)
			TotalAccuracy=100
			DebugLogs("Meditate: = 100","Combat")

		if(Defender.AdminMode==1)
			TotalAccuracy=0
			DebugLogs("TotalAccuracy: [TotalAccuracy]","Combat")


		if(!S)
			TotalAccuracy= TotalAccuracy
			DebugLogs("TotalAccuracy: [TotalAccuracy]","Combat")
		else
			TotalAccuracy= TotalAccuracy*SkillTraitHit(S)
			for(var/SR in S)
				DebugLogs("SkillTraits: [SR]","Combat")
			DebugLogs("SkillTraitHit(S): [SkillTraitHit(S)]","Combat")
			DebugLogs("TotalAccuracy with trait: [TotalAccuracy]*[SkillTraitHit(S)]","Combat")

		DebugLogs("<font color=blue>TotalAccuracy: [TotalAccuracy]","Combat")
		DebugLogs("----------------------------------------","Combat")

		return TotalAccuracy

proc/KiAccuracyFormula(obj/ranged/Blast/BB,mob/Offender,mob/Defender,Skill/S)
	if(Offender&&Defender)
		DebugLogs("-KiAccuracyFormula-","Combat")
		DebugLogs("Offender : [Offender] Vs Defender : [Defender]","Combat")
		DebugLogs("<font color=white>Skill: [S]","Combat")
		var/Offense=(Offender.BP*((Offender.OffMod)+(Offender.SpdMod*(0.3+(Offender.Precognition*0.05)))))
		var/Defense=(Defender.BP*((Defender.DefMod)+(Defender.SpdMod*(0.3+(Defender.Precognition*0.05))))) //changed from 0.15 to .25 by trashman
		DebugLogs("Offense:(Offender.BP [Offender.BP]*((Offender.Off [Offender.OffMod])+(Offender.Spd [Offender.SpdMod]*(0.3+(Offender.Precognition [Offender.Precognition]*0.05)))))","Combat")
		DebugLogs("Defense:(Defender.BP [Defender.BP]*((Defender.Def [Defender.DefMod])+(Defender.Spd [Defender.SpdMod]Mod*(0.3+(Defender.Precognition [Defender.Precognition]*0.05)))))","Combat")
		DebugLogs("Offense: [Offense]","Combat")
		DebugLogs("Defense: [Defense]","Combat")
		DebugLogs("DEFAULTACC: [DEFAULTACC]","Combat")

		if(Offender.HasEnergyMarksmanship)
			DEFAULTACC+=10
			DebugLogs("HasEnergyMarksmanship		+10","Combat")

		if(Offender.HasBullsEye)
			DEFAULTACC+=Offender.HasBullsEye*3
			DebugLogs("HasBullsEye					+[Offender.HasBullsEye]*3","Combat")

		var/TotalAccuracy= DEFAULTACC*(((Offense/max(Defense,0.01))))
		DebugLogs("TotalAccuracy: [DEFAULTACC]*((([Offense]/[max(Defense,0.01)])))","Combat")
		DebugLogs("TotalAccuracy: [TotalAccuracy]","Combat")

		if(Offender.dir==Defender.dir)
			TotalAccuracy+=25
			DebugLogs("Offender.dir==Defender.dir	+25","Combat")

		if(Offender.StanceCore==1)
			TotalAccuracy+=3
			DebugLogs("Offender.StanceCore==1 		+3","Combat")

		if(Defender.StanceCore==1)
			TotalAccuracy-=3
			DebugLogs("Defender.StanceCore==1 		+3","Combat")

		if(TotalAccuracy>=99)
			TotalAccuracy=99
			DebugLogs("TotalAccuracy>=99			=99","Combat")

		if(TotalAccuracy<=1)
			TotalAccuracy=1
			DebugLogs("TotalAccuracy<=1				=1","Combat")

		if(Defender.icon_state=="Meditate"||Defender.KOd)
			TotalAccuracy=100
			DebugLogs("Meditate						=100","Combat")

		if(!S)
			TotalAccuracy= TotalAccuracy
			DebugLogs("TotalAccuracy= TotalAccuracy","Combat")

		else
			TotalAccuracy= TotalAccuracy*SkillTraitHit(S)
			for(var/SR in S)
				DebugLogs("SkillTraits: [SR]","Combat")
			DebugLogs("SkillTraitHit(S): [SkillTraitHit(S)]","Combat")
			DebugLogs("TotalAccuracy*SkillTraitHit(S)=[TotalAccuracy]*[SkillTraitHit(S)]","Combat")

		DebugLogs("<font color=blue>TotalAccuracy: [TotalAccuracy]","Combat")

		DebugLogs("----------------------------------------","Combat")
		return TotalAccuracy
