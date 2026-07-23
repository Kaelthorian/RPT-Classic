


mob/verb/Reset_Stat_Multipliers()
	set category=null//"Other"
	if(usr.Confirm("Remove all buffs and reset stat mults to 1x?"))
		RemoveBuffs()
		Reset_StatMultipliers()

mob/proc/Reset_StatMultipliers()
	if(src)
		animate(src, transform = null)
		RemoveBuffs()
		if(GodKiActive)
//			winset(src.client,"GODKI","is-visible=false")
			usr<<"You will now hide your God Ki from others."
			GodKiActive=0
			suffix="[usr.GodKiActive ? "\[Enabled\]":"\[Hidden\]"]"
		BPMult				=1
		KiMult				=1
		PowMult				=1
		StrMult				=1
		SpdMult				=1
		EndMult				=1
		OffMult				=1
		DefMult				=1
		StanceStr			=1
		StanceEnd			=1
		StanceForce			=1
		StanceSpd			=1
		StanceOff			=1
		StanceDef			=1
		RegenMult			=1
		RecovMult			=1
		AngerMult			=1
		BuffNumber			=0
		Pantheon			=null
		Stance				=null
		StanceLevel			=null
		StanceCore			=0
		IsThrowing			=0
		for(var/Skill/MartialArt/MA in src) MA.Using=0
		Buffs=list()
		if(Ki>MaxKi) Ki=MaxKi
		ArtifactRemove()
		isGrabbing=0
		attacking=0
		PushingRoll	=0
		PushingPunchRoll=0
		TugWarRoll=0
		if(z==0)
			usr.client.sendToSpawn(usr)

Skill/Technology/Cybernetic_Limb
	desc="Replace someone's limb with an upgraded, cybernetic version. (Limb becomes to damage. Cybernetic Eyes grant 3% Offense at the cost of 10% Regen. Cybernetic Legs give 2.5% speed at the cost of 5% Regen. Cybernetic Arms give 2.5% Strength and Force at the cost of 7.5% Regen.)"


mob/Admin1/verb/Reset_Stat_Mults(var/mob/M in Players)
	set category="Admin"
	M.RemoveBuffs()
	M.Reset_StatMultipliers()

var/BaseRefireDiv=50
mob/proc
	Available_Stats()												//	ADD HERE THINGS YOU WANT TO PASSIVLY BUFF STATS
		var/SpdOffset		=1
		var/tmp/StrAdd		=1
		var/tmp/PowAdd		=1
		var/tmp/EndAdd		=1
		var/tmp/SpdAdd		=1
		var/tmp/OffAdd		=1
		var/tmp/DefAdd		=1
		var/tmp/MaxKiAdd	=1
		var/tmp/RegenAdd	=1

		//Buff
		if(HasBoundlessStamina)
			MaxKiAdd		*=1.25

		if(HasKeyRing)
			MaxKiAdd		*=1.1

		if(HasForcefulNegotiator)
			PowAdd			*=1.13

		if(HasWayOfTheFist&&!HammerOn&&!SwordOn)
			StrAdd			*=1.1

		if(HasBeastOfBurden)
			StrAdd			*=1.03

		if(HasAgileMastery&&!ArmorOn&&!PowerArmorOn&&!HelmetOn)
			SpdAdd			*=1.25
			OffAdd			*=1.05
			DefAdd			*=1.05

		if(HasRapidDeployment)
			SpdAdd			*=1.05

		if(HasAdamantineSkeleton)
			EndAdd			*=1.08

		if(HasSturdyBuild)
			EndAdd			*=1+(HasSturdyBuild*0.03)

		if(Year>=2&&HasUsedBookOfFortitude+1>=Year)
			EndAdd			*=1.125

		if(HasRangeOfMotion&&!ArmorOn&&!PowerArmorOn&&!HammerOn&&!SwordOn&&!HelmetOn)
			OffAdd			*=1.1
			DefAdd			*=1.1

		if(IsBandaged)
			Regeneration	*=1.2

		if(Cyber_Left_Arm)
			StrAdd			*=0.025+(0.025*HasEmbraceTheFuture)
			PowAdd			*=0.025+(0.025*HasEmbraceTheFuture)
			RegenAdd		*=0.05-(0.04*HasEmbraceTheFuture)
		if(Cyber_Left_Leg)
			SpdAdd			*=0.025+(0.025*HasEmbraceTheFuture)
			RegenAdd		*=0.05-(0.04*HasEmbraceTheFuture)
		if(Cyber_Right_Leg)
			SpdAdd			*=0.025+(0.025*HasEmbraceTheFuture)
			RegenAdd		*=0.05-(0.04*HasEmbraceTheFuture)
		if(Cyber_Right_Arm)
			StrAdd			*=0.025+(0.025*HasEmbraceTheFuture)
			PowAdd			*=0.025+(0.025*HasEmbraceTheFuture)
			RegenAdd		*=0.05-(0.04*HasEmbraceTheFuture)
		if(Cyber_Sight)
			OffAdd			*=1.03+(0.03*HasEmbraceTheFuture)
			DefAdd			*=1.03+(0.03*HasEmbraceTheFuture)
			RegenAdd		*=0.05-(0.04*HasEmbraceTheFuture)
		if(Cyber_Torso)
			EndAdd			*=1.03+(0.03*HasEmbraceTheFuture)
			MaxKiAdd		*=1.03+(0.03*HasEmbraceTheFuture)
			RegenAdd		*=0.05-(0.04*HasEmbraceTheFuture)

		if(Cyborg==1)
			BP*=((((RecovMult*BaseRecovery * 12.5)/100)+1)+(((BaseRecovery*3)*HasControlOfPower)/100))
			if(locate(/Skill/Buff/Mystic/)in src) BP*=1.1


		if(HasDesperateStruggle&&Willpower<51)
			OffAdd			*=1.2
		if(HasDesperateResolve&&Willpower<51)
			EndAdd			*=1.2
		if(HasDesperateManeuvers&&Willpower<51)
			DefAdd			*=1.2
		if(HasDesperateSpeed&&Willpower<51)
			SpdAdd			*=1.2

		var/WAM=1
		if(HasWildAnimal&&Willpower<86)
			WAM+=0.05
			if(HasWildAnimal&&Willpower<71)
				WAM+=0.05
				if(HasWildAnimal&&Willpower<56)
					WAM+=0.05
					if(HasWildAnimal&&Willpower<41)
						WAM+=0.05
		StrAdd*=WAM
		PowAdd*=WAM

		if(HasThrowYourWeight)
			StrAdd			+=GeneticEndMod*0.10
		if(HasMiningExpert)
			EndAdd			*=1.02
		if(HasManaExpert)
			DefAdd			*=1.02
		if(HasFloatLike)
			DefAdd			*=1.05

		if(z==11 && ALRacePower)
			if(Race=="Kaio"||Race=="Demon"||Race=="Oni"||Race=="Demigod")
				BP			*=1.1
		if(CrystalPower>0 && z==11)
			BP				*=(((CrystalPower*5)/100)+1)

		//Nerf
		if(Blocking)
			DefAdd			*=0.8
			SpdAdd			*=0.8
			EndAdd			*=1.4

		if(PSand)
			OffAdd			*=0.9
			DefAdd			*=0.9

		if(GuardBroken)
			EndAdd			*=0.9
			DefAdd			*=0.9

		if(!IgnoresBrokenLimbs&&!HasMorphine)
			if(Critical_Torso)
				MaxKiAdd*=Injury_Max
				EndAdd*=Injury_Max
			if(Critical_Left_Leg)
				SpdAdd*=Injury_Max
			if(Critical_Right_Leg)
				SpdAdd*=Injury_Max
			if(Critical_Right_Arm)
				StrAdd*=Injury_Max
				PowAdd*=Injury_Max
			if(Critical_Left_Arm)
				StrAdd*=Injury_Max
				PowAdd*=Injury_Max
			if(Critical_Sight)
				OffAdd*=Injury_Max
				DefAdd*=Injury_Max

		if(HasBerserking)
			Regeneration	*=0.9

		if(Wing_Clipped)
			SpdOffset		=0.6

		//Weapons
		var/WepSpd=1

		if(KiHammer)
			if(HasBladeOfLight)
				SpdAdd		*=0.85
				OffAdd		*=0.85
				WepSpd		*=0.85
			else
				SpdAdd		*=0.8
				OffAdd		*=0.8
				WepSpd		*=0.8
		if(SpiritSword)
			if(HasBladeOfLight)
				OffAdd		*=1
			else
				OffAdd		*=0.9

		//Refire
		var/RefY=SpdMult*SpdOffset*WepSpd
		if(RefY<0.1)
			RefY=0.1
		if(RefY>3.5)
			RefY=3.5
		var/RefZ=sqrt((3/((SpdMod*BPMod*(((RecovMult*BaseRecovery*12.5)*Anger)+100)/100)/4.82)))
		Refire=((BaseRefireDiv/RefZ)/RefY)
		var/RefX=1+(HasFireKeeper*0.1)
		if(StanceCore==4)
			RefX+=0.1
		Refire/=RefX
		Refire=max(3,Refire)

		//Majin
		if(Majinized>0)
			BP				*=1.05																					//Majinized BP boost here.
			Regeneration	*=0.90																			//Majinized BP boost here
			if(AlignmentNumber>0)																		//If you are not a bad guy
				Majinized=0																				//You lose your majin
				src<<"After a lot of work , your mind finally find peace , you are no longer in control of no one."



		//Stats
		StrAdd*=StanceStr
		EndAdd*=StanceEnd
		PowAdd*=StanceForce
		SpdAdd*=StanceSpd
		OffAdd*=StanceOff
		DefAdd*=StanceDef

		StrMod=StrAdd*StrMult*GeneticStrMod
		PowMod=PowAdd*StrMult*GeneticPowMod
		EndMod=EndAdd*EndMult*GeneticEndMod
		SpdMod=SpdAdd*SpdMult*SpdOffset*GeneticSpdMod
		OffMod=OffAdd*OffMult*GeneticOffMod
		DefMod=DefAdd*DefMult*GeneticDefMod

		KBResist=HasSturdyBuild*2.5*2.5
		MaxKi=MaxKiAdd*KiMult*GeneticKiMod*100

//		MaxKi=BaseMaxKi*KiMult
		Regeneration=(BaseRegeneration+(HasWillOfFire*0.5))*RegenMult*RegenAdd
		Recovery=(BaseRecovery+(HasPCExpert*0.4))*RecovMult

		//Anger
		if(Anger>MaxAnger+(DeathAnger*35))
			Anger=MaxAnger+(DeathAnger*35)

		MaxAnger=100+((BaseMaxAnger-100)*AngerMult)//MaxAnger=100+((BaseMaxAnger*AngerMult)-100)


		//Random
		WeightedStats=((StrMod/StrMod)+(EndMod/EndMod)+(SpdMod/SpdMod)+(OffMod/OffMod)+(DefMod/DefMod))

		if(!Dead && z==11 && DeadReturn==1)
			if(Race!="Kaio")
				if(Race!="Demon")
					if(!AdminMode)
						z=1
						x=250
						y=250





		//base attack speed of 0.66 attacks per second @ 1.8x speed mod and 1.3x spd mult (15 refire) down to 1 attack per second w/ 4 one two punch(3 per second with combo on), about 1-1.2 attack per second at 2x mod 1.3x mult