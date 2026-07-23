mob/var/SkillPointsT1			=0
mob/var/SkillPointsT2			=0
mob/var/SkillPointsT3			=0
mob/var/SkillPointsT4			=0
mob/var/SkillPointsBuff			=0

mob/var/SkillPointsT1Total		=0
mob/var/SkillPointsT2Total		=0
mob/var/SkillPointsT3Total		=0
mob/var/SkillPointsT4Total		=0
mob/var/SkillPointsBuffTotal	=0

mob/var/ExtraStat				=0
mob/var/ExtraStatStance			=0

var/list/ListSkillT1 		= (typesof(/Skill/Unarmed/T1) - /Skill/Unarmed/T1 + typesof(/Skill/Attacks/T1) - /Skill/Attacks/T1 +typesof(/Skill/Weapon/T1) - /Skill/Weapon/T1 + "Cancel")
var/list/ListSkillT2 		= (typesof(/Skill/Unarmed/T2) - /Skill/Unarmed/T2 + typesof(/Skill/Attacks/T2) - /Skill/Attacks/T2 +typesof(/Skill/Weapon/T2) - /Skill/Weapon/T2 + "Cancel")
var/list/ListSkillT3 		= (typesof(/Skill/Unarmed/T3) - /Skill/Unarmed/T3 + typesof(/Skill/Attacks/T3) - /Skill/Attacks/T3 +typesof(/Skill/Weapon/T3) - /Skill/Weapon/T3 + "Cancel")
var/list/ListSkillT4 		= (typesof(/Skill/Unarmed/T4) - /Skill/Unarmed/T4 + typesof(/Skill/Attacks/T4) - /Skill/Attacks/T4 +typesof(/Skill/Weapon/T4) - /Skill/Weapon/T4 + "Cancel")
var/list/BuffSkillList		= (typesof(/Skill/Buff/T1) - /Skill/Buff/T1 + "Cancel")

proc/StancePoints(mob/W)
	var/Skill/MartialArt/SS=locate(/Skill/MartialArt)in W
	W.ExtraStatStance++
	switch(input("What stat you want to increase your stance?(is going to be permanent)") in list("Strength","Force","Endurance","Speed","Offense","Defense"))
		if("Strength")		SS.StrMult	+=0.1
		if("Force")			SS.PowMult	+=0.1
		if("Endurance")		SS.EndMult	+=0.1
		if("Speed") 		SS.SpdMult	+=0.1
		if("Offense") 		SS.OffMult	+=0.1
		if("Defense")		SS.DefMult	+=0.1

proc/ExtraStatPoint(mob/W)
	W.ExtraStat++
	switch(input("What stat you want to increase?(is going to be permanent)") in list("Strength","Endurance","Speed","Offense","Defense"))
		if("Strength")
			if(W.Total_Stats_Strength == 0)
				W.GeneticStrMod	*=1.1
			if(W.Total_Stats_Strength == 1)
				W.GeneticStrMod	*=1.09
			if(W.Total_Stats_Strength == 2)
				W.GeneticStrMod	*=1.08
			if(W.Total_Stats_Strength == 3)
				W.GeneticStrMod	*=1.07
			if(W.Total_Stats_Strength == 4)
				W.GeneticStrMod	*=1.06
			if(W.Total_Stats_Strength == 5)
				W.GeneticStrMod	*=1.05
			if(W.Total_Stats_Strength == 6)
				W.GeneticStrMod	*=1.04
		if("Endurance")
			if(W.Total_Stats_Endurance == 0)
				W.GeneticEndMod	*=1.1
			if(W.Total_Stats_Endurance == 1)
				W.GeneticEndMod	*=1.09
			if(W.Total_Stats_Endurance == 2)
				W.GeneticEndMod	*=1.08
			if(W.Total_Stats_Endurance == 3)
				W.GeneticEndMod	*=1.07
			if(W.Total_Stats_Endurance == 4)
				W.GeneticEndMod	*=1.06
			if(W.Total_Stats_Endurance == 5)
				W.GeneticEndMod	*=1.05
			if(W.Total_Stats_Endurance == 6)
				W.GeneticEndMod	*=1.04
		if("Speed")
			if(W.Total_Stats_Speed == 0)
				W.GeneticSpdMod	*=1.1
			if(W.Total_Stats_Speed == 1)
				W.GeneticSpdMod	*=1.09
			if(W.Total_Stats_Speed == 2)
				W.GeneticSpdMod	*=1.08
			if(W.Total_Stats_Speed == 3)
				W.GeneticSpdMod	*=1.07
			if(W.Total_Stats_Speed == 4)
				W.GeneticSpdMod	*=1.06
			if(W.Total_Stats_Speed == 5)
				W.GeneticSpdMod	*=1.05
			if(W.Total_Stats_Speed == 6)
				W.GeneticSpdMod	*=1.04
		if("Offense")
			if(W.Total_Stats_Off == 0)
				W.GeneticOffMod	*=1.1
			if(W.Total_Stats_Off == 1)
				W.GeneticOffMod	*=1.09
			if(W.Total_Stats_Off == 2)
				W.GeneticOffMod	*=1.08
			if(W.Total_Stats_Off == 3)
				W.GeneticOffMod	*=1.07
			if(W.Total_Stats_Off == 4)
				W.GeneticOffMod	*=1.06
			if(W.Total_Stats_Off == 5)
				W.GeneticOffMod	*=1.05
			if(W.Total_Stats_Off == 6)
				W.GeneticOffMod	*=1.04
		if("Defense")
			if(W.Total_Stats_Def == 0)
				W.GeneticDefMod	*=1.1
			if(W.Total_Stats_Def == 1)
				W.GeneticDefMod	*=1.09
			if(W.Total_Stats_Def == 2)
				W.GeneticDefMod	*=1.08
			if(W.Total_Stats_Def == 3)
				W.GeneticDefMod	*=1.07
			if(W.Total_Stats_Def == 4)
				W.GeneticDefMod	*=1.06
			if(W.Total_Stats_Def == 5)
				W.GeneticDefMod	*=1.05
			if(W.Total_Stats_Def == 6)
				W.GeneticDefMod	*=1.04


proc/LevelCheck(mob/Q)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=0 && Q.SkillPointsT1Total==0)
		if(!(locate(/Skill/Buff/Power_Control)in src))
			Q.contents+=new/Skill/Buff/Power_Control
		if(!(locate(/Skill/Support/Sense_Energy)in src))
			Q.contents+=new/Skill/Support/Sense_Energy

		Q.SkillPointsT1++
		Q.SkillPointsT1Total=1

	if(Q.EXPLifetime>=MaxEXPReward && Year>=1 && Q.SkillPointsT1Total==1)
		Q.SkillPointsT1++
		Q.SkillPointsT1Total=2

	if(Q.EXPLifetime>=MaxEXPReward && Year>=2 && Q.SkillPointsT2Total==0)
		if(!(locate(/Skill/Misc/Fly)in src))
			Q.contents+=new/Skill/Misc/Fly

		Q.SkillPointsT2++
		Q.SkillPointsT2Total=1

	if(Q.EXPLifetime>=MaxEXPReward && Year>=3)
		if(!(locate(/Skill/MartialArt)in Q))
			Q.contents+=new/Skill/MartialArt

	if(Q.EXPLifetime>=MaxEXPReward && Year>=4 && Q.ExtraStat==0)
		ExtraStatPoint(Q)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=5 && Q.SkillPointsBuffTotal==0)
		Q.SkillPointsBuff++
		Q.SkillPointsBuffTotal=1

	if(Q.EXPLifetime>=MaxEXPReward && Year>=6 && Q.SkillPointsT1Total==2)
		Q.SkillPointsT1++
		Q.SkillPointsT1Total=3

	if(Q.EXPLifetime>=MaxEXPReward && Year>=7 && Q.SkillPointsT2Total==1)
		Q.SkillPointsT2++
		Q.SkillPointsT2Total=2

	if(Q.EXPLifetime>=MaxEXPReward && Year>=8 && Q.ExtraStatStance==0)
		if((locate(/Skill/MartialArt)in Q))
			StancePoints(Q)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=9 && Q.ExtraStat==1)
		ExtraStatPoint(Q)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=10 && Q.SkillPointsBuffTotal==1)
		Q.SkillPointsBuff++
		Q.SkillPointsBuffTotal=2

	if(Q.EXPLifetime>=MaxEXPReward && Year>=11 && Q.SkillPointsT1Total==4)
		Q.SkillPointsT1++
		Q.SkillPointsT1Total=4

	if(Q.EXPLifetime>=MaxEXPReward && Year>=12 && Q.SkillPointsT3Total==0)
		Q.SkillPointsT3++
		Q.SkillPointsT3Total=1

	if(Q.EXPLifetime>=MaxEXPReward && Year>=13 && Q.SkillPointsT2Total==2)
		Q.SkillPointsT2++
		Q.SkillPointsT2Total=3

	if(Q.EXPLifetime>=MaxEXPReward && Year>=14 && Q.ExtraStat==2)
		ExtraStatPoint(Q)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=15 && Q.SkillPointsBuffTotal==2)
		Q.SkillPointsBuff++
		Q.SkillPointsBuffTotal=3

	if(Q.EXPLifetime>=MaxEXPReward && Year>=16 && Q.SkillPointsT2Total==3)
		Q.SkillPointsT2++
		Q.SkillPointsT2Total=4

	if(Q.EXPLifetime>=MaxEXPReward && Year>=17 && Q.SkillPointsT3Total==1)
		Q.SkillPointsT3++
		Q.SkillPointsT3Total=2

	if(Q.EXPLifetime>=MaxEXPReward && Year>=18 && Q.ExtraStatStance==1)
		if((locate(/Skill/MartialArt)in Q))
			StancePoints(Q)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=19 && Q.ExtraStat==3)
		ExtraStatPoint(Q)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=20 && Q.SkillPointsT3Total==2)
		Q.SkillPointsT3++
		Q.SkillPointsT3Total=3

	if(Q.EXPLifetime>=MaxEXPReward && Year>=21 && Q.SkillPointsT4Total==0)
		Q.SkillPointsT4++
		Q.SkillPointsT4Total=1

	if(Q.EXPLifetime>=MaxEXPReward && Year>=22 && Q.ExtraStatStance==2)
		if((locate(/Skill/MartialArt)in Q))
			StancePoints(Q)

//	if(Year>=23 && Q.SlotTier1Total<0)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=26 && Q.ExtraStat==4)
		ExtraStatPoint(Q)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=26 && Q.SkillPointsT4Total==1)
		Q.SkillPointsT4++
		Q.SkillPointsT4Total=2

//	if(Year>=26 && Q.SlotTier1Total<0)

//	if(Year>=27 && Q.SlotTier1Total<0)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=28 && Q.SkillPointsT3Total==3)
		Q.SkillPointsT3++
		Q.SkillPointsT3Total=4

	if(Q.EXPLifetime>=MaxEXPReward && Year>=29 && Q.ExtraStat==5)
		ExtraStatPoint(Q)

//	if(Year>=30 && Q.SlotTier1Total<0)

//	if(Year>=31 && Q.SlotTier1Total<0)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=32 && Q.SkillPointsT4Total==2)
		Q.SkillPointsT4++
		Q.SkillPointsT4Total=3

//	if(Year>=33 && Q.SlotTier1Total<0)

	if(Q.EXPLifetime>=MaxEXPReward && Year>=34 && Q.ExtraStat==6)
		ExtraStatPoint(Q)

//	if(Year>=35 && Q.SlotTier1Total<0)

//	if(Year>=36 && Q.SlotTier1Total<0)

//	if(Year>=37 && Q.SlotTier1Total<0)

//	if(Year>=38 && Q.SlotTier1Total<0)

//	if(Year>=39 && Q.SlotTier1Total<0)
