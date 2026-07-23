mob/proc/Update_Player() // Only called for a new character and a returning character logging in.
	set waitfor=0
	set background=1
	ASSERT(src)
	if(NewVersion>LastVersionPlayed)src << browse(New_Stuff,"window=updates;size=700x600")
	GiveBodyParts()
	MakyoStar()
	StatRank()
	Check_Milestones()
	CatchUpMPCheck()
	Status()
	Contacts()
	Learn()
	if(Race=="Android") ScouterOn=99999999999999
	Age_Update()
	BodyHUD()
//	UpdateStats("All")
	LastVersionPlayed=NewVersion

	if(KOd)
		Un_KO()
		KO("(logged in KO'd)")
	if(!lan) for(var/Language/L in src)
		lan=L
		break
	if(client)
		client.view="[ViewX]x[ViewY]"
		client.show_verb_panel=1
		client.show_map=1
		ScreenConfigure()
	if(Oozaru)
		Oozaru_Revert()
		Oozaru()
	if(Werewolf)
		Werewolf_Revert()
		Werewolf()
	AlignmentCalibrate()
	if(Reincarnated) for(var/obj/ReincarnationObj/R in Reincarnations) if(R.name==key) del(R)
	if(usr.Lethality == 1) winset(src.client,"LETHAL","is-visible=true")
	if(usr.invisibility == 1) winset(usr.client,"INVIS","is-visible=true")
	for(var/obj/items/Boxing_Gloves/BG in usr) if(BG.suffix=="*Equipped*") winset(usr.client,"GLOVES","is-visible=true")
	for(var/Skill/S in src) S.CDTick(src)
	overlays+=HealthBar
	overlays+=EnergyBar
	if(!first_player)
		first_player = TRUE
		src << "<b>You are the first player to log in! Congrats!</b>"
		world.log << "Updating world..."
		sleep(150)
		LoadUpdates()


mob/proc/Invisibility_Check()
	if(invisibility>0)
		for(var/Skill/Support/Invisibility/A in src)
			if(A.Using) A.Using=0
			invisibility = 0
			see_invisible = 0
			winset(client,"INVIS","is-visible=false")


mob/proc/Regenerate()
	loc=locate(335,135,9)
	for(var/BodyPart/P in src) Injure_Heal(200,P,1)
	spawn(3000/Regenerate) if(src)
		loc=locate(savedX,savedY,savedZ)
		for(var/mob/A in view(src)) if(A.name=="Body of [src]") del(A)
		if(Race=="Alien") Willpower=50
		else Willpower=70
		LethalCombatTracker=0
		src<<"[src] regenerates back to life!"
		Regenerating=0
		TotalDeaths--
		Regenerate=max(0,Regenerate-0.5)
		flick("Regenerate",src)

mob/proc/IsInSpace()
	var/turf/Turf=loc
	if(istype(Turf,/turf/Other/Stars)&&!BreathInSpace) if(src.z==12&&!Dead) if(istype(Turf,/turf/Other/Stars)) return 1
	else return 0

mob/proc/Steroid_Wearoff() while(src&&(client||adminObserve))
	sleep(1200)

mob/proc/Power_Giving_Reset()// while(src&&(client||adminObserve))
	if(GavePower)
		sleep(9000)
		GavePower=0

mob/proc/Drains()
	if(energydraining) DrainKi("Drains", "Percent", energydraining)
	if(healthdraining) TakeDamage(src, healthdraining, "Drains")
	if(GodKiActive) DrainGodKi()

mob/proc/Healing() if(!Dead||(Dead&&!Check_Dead_Location())) if(!RPMode)
	if(BindPower&&!CheckBind()) return
	if(KOd==0)
		var/AbsorbReduction=1
		if(src)if(!DisableRegen) //if(!OverdrivePower)
			var/HH=0.07*Regeneration*(3+Senzu+(HealthPotion/3))*(MaxHealth/100) //var/HH=0.07*Regeneration*(3+Senzu+(HealthPotion/3))*(MaxHealth/100)
			var/LH=0.002*Regeneration*(25+Senzu+(HealthPotion/3))*(HasWillOfFire+1)
			if(locate(/obj/items/Philosophers_Stone) in src)
				HH=0.07*(Regeneration+0.5)*(3+Senzu+(HealthPotion/3))*(MaxHealth/100)
				LH=0.002*(Regeneration+0.5)*(25+Senzu+(HealthPotion/3))*(HasWillOfFire+1)
			var/WH=1
			if(HasFoodRegen)
				HH=0.07*Regeneration*(3+Senzu+(HealthPotion/3))*(MaxHealth/100)*(1.1)
				if(HasHyperEnzymes>0) HH=0.07*Regeneration*(3+Senzu+(HealthPotion/3))*(MaxHealth/100)
			if(HasFoodWP) WH*=1.1
			if(HasCialis) HH*=0.7
			if(TicksOfReplenish) WH=4
			if(locate(/Skill/Buff/Sin_Force) in src) HH+=0.1
			if(locate(/obj/items/Medicine_Cabinet) in oview(2,src))
				LH*=1.5
				HH*=1.5
			if(icon_state=="Meditate")
				LH*=1.5
				HH*=3
			if(icon_state == "Train")
				LH*=0.2
				HH*=0.2
			if(GodKiActive)
				LH*=1.3
				HH*=1.3
			if(Vampire)HH*=0.8
			HH*=AbsorbReduction

			if((Health/MaxHealth)<(Willpower/MaxWillpower))
				Health+=HH
				if(LethalCombatTracker) //if(Race!="Android")
					var/HDiv=1
					var/Berser=1
					if(Health/MaxHealth<0.7)HDiv=1.3
					if(Health/MaxHealth<0.5)HDiv=1.6
					if(Health/MaxHealth<0.3)HDiv=1.9
					if(Health/MaxHealth<0.1)HDiv=2.2
					if(HasMorphine) Willpower-=HDiv*(0.1125/(0+1))*(Berser)
					else Willpower-=HDiv*(0.075/(1))*(Berser)
				if((Health/MaxHealth)>(Willpower/MaxWillpower)) Health=(Willpower/MaxWillpower)*MaxHealth
				if(Willpower<0) Willpower=0
			if(!LethalCombatTracker) for(var/BodyPart/P in src) if(P.Health<=P.MaxHealth)
				Injure_Heal(LH,P)
				if(P.CanRegen) if(prob(Regenerate*5)) P.InjuryHealed(src)
			if(!LethalCombatTracker) if(Willpower<MaxWillpower&&Willpower>0)
				Willpower+=HH*0.01*WH
				if(Willpower>MaxWillpower) Willpower=MaxWillpower
			if(Willpower<0) Willpower=0

			if(Willpower>MaxWillpower) Willpower=MaxWillpower
		if(src)
			var/DBMult=1
			DBMult+=HasDeepBreathing*0.125
			var/KMult=1
			KMult*=1.5
			KMult=100/BPpcnt
			if(KMult>2) KMult=2
			if(KMult<0.5) KMult=0.5
			if(ChakraBlocked) KMult*=0
			if(HasFoodRecov)
				KMult*=1.1
			if(HasPercocet) KMult*=0.6
			if(KiDoesNotAffectBP==2) KMult*=0.7
			if(RecentSendEnergy) KMult*=0.5
			if(transenergydraining) KMult*=transenergydraining
			if(GodKiActive) KMult*=1.5
			if(Race=="Spirit Doll") KMult=1.5
			if(HasControlOfPower) KMult*=1.5
			if(Ki<=0)
				Ki++
			KMult*=DBMult
			KMult*=AbsorbReduction
			if(IsInSpace()) KMult*=0
			if(Senzu)
				Senzu-=0.05
				if(Senzu<0)Senzu=0
			if(HealthPotion)
				HealthPotion-=0.05
				if(HealthPotion<0)HealthPotion=0

			if(icon_state=="Meditate") KMult*=0


mob/proc/Available_Power()
	if(BPpcnt<0.01) BPpcnt=0.01
	if(Ki<0) Ki=0
	if(AndroidLevel<0) AndroidLevel=0
	if(RPPower<1) RPPower=1
	Body()
	var/RawHP=Health/MaxHealth
	var/Health_Multiplier=RawHP
	if(RawHP>0.9&&RawHP<=0.95) Health_Multiplier=0.95
	if(RawHP>0.85&&RawHP<=0.9) Health_Multiplier=0.90
	if(RawHP>0.8&&RawHP<=0.85) Health_Multiplier=0.85
	if(RawHP>0.75&&RawHP<=0.8) Health_Multiplier=0.80
	if(RawHP>0.7&&RawHP<=0.75) Health_Multiplier=0.75
	if(RawHP>0.65&&RawHP<=0.7) Health_Multiplier=0.70
	if(RawHP>0.60&&RawHP<=0.65) Health_Multiplier=0.65
	if(RawHP>0.55&&RawHP<=0.60) Health_Multiplier=0.60
	if(RawHP>0.50&&RawHP<=0.55) Health_Multiplier=0.55
	if(RawHP>0.45&&RawHP<=0.50) Health_Multiplier=0.50
	if(RawHP>0.40&&RawHP<=0.45) Health_Multiplier=0.45
	if(RawHP>0.35&&RawHP<=0.40) Health_Multiplier=0.40
	if(RawHP>0.30&&RawHP<=0.35) Health_Multiplier=0.35
	if(RawHP<=0.30) Health_Multiplier=0.30
	if(!AndroidLevel) Health_Multiplier=max(0.3,Health_Multiplier)
	else Health_Multiplier=max(0.5,Health_Multiplier)


	if(HPDoesNotAffectBP||HasPercocet||Vampire||HasAsLongAsMyHeartBeats)
		if(RawHP>0.9&&RawHP<0.97) Health_Multiplier=0.97
		if(RawHP>0.8&&RawHP<=0.9) Health_Multiplier=0.95
		if(RawHP>0.7&&RawHP<=0.8) Health_Multiplier=0.92
		if(RawHP>0.6&&RawHP<=0.7) Health_Multiplier=0.90
		if(RawHP>0.5&&RawHP<=0.6) Health_Multiplier=0.87
		if(RawHP>0.4&&RawHP<=0.5) Health_Multiplier=0.85
		if(RawHP>0.3&&RawHP<=0.4) Health_Multiplier=0.82
		if(RawHP>0.2&&RawHP<=0.3) Health_Multiplier=0.80
		if(RawHP>0.1&&RawHP<=0.2) Health_Multiplier=0.77
		Health_Multiplier=max(0.75,Health_Multiplier)

	if(Anger_Restoration) Health_Multiplier=1
	if(KOd)  Health_Multiplier=1

	var/RawKi=Ki/MaxKi




	if(Ki/MaxKi>1.3) RawKi=1.3					//This controls the overflow of power that have the players when they have more Ki than they should.KIPOWER
	else if(Ki/MaxKi>1.25) RawKi=1.25
	else if(Ki/MaxKi>1.20) RawKi=1.20
	else if(Ki/MaxKi>1.15) RawKi=1.15
	else if(Ki/MaxKi>1.10) RawKi=1.10
	else if(Ki/MaxKi>1.05) RawKi=1.05
	else if(Ki/MaxKi>1.04) RawKi=1.04
	else if(Ki/MaxKi>1.03) RawKi=1.03
	else if(Ki/MaxKi>1.02) RawKi=1.02
	else if(Ki/MaxKi>1.01) RawKi=1.01
	else if(Ki/MaxKi>1) RawKi=1
	else if(Ki/MaxKi>0.95&&Ki/MaxKi<1) RawKi=1
	else if(Ki/MaxKi>0.9) RawKi=0.98
	else if(Ki/MaxKi>0.85) RawKi=0.93
	else if(Ki/MaxKi>0.80) RawKi=0.84
	else if(Ki/MaxKi<=0.8) RawKi=RawKi**1.3 	//starts aroun 75% caps around 18%

	var/Energy_Multiplier=1
	RawKi=Ki/MaxKi
//	var/Gravity_Multiplier=min(2.5,1+((GravMastered/25)/25))
	var/RPMults=(RPPower*BPMult*OverFlowPower)														//RPMultipliers are equal to the BPMult and the OverFlowPower (The one from over flow)
	var/AngerM=(Anger/100)
	if(AngerM<1)AngerM=1
	var/BodyMults=Energy_Multiplier*Health_Multiplier*AngerM/Weight
	if(RacialPowerAdd<0) RacialPowerAdd=0
	BP=(RacialPowerAdd+Base)*Body*(BPpcnt/100)*RPMults*BodyMults
	BP+=BodyMults*RPMults*Body
	BP+=Absorb*(BPpcnt/100)*RPMults*BodyMults*Body
	if(HBTCPower>0) BP+=HBTCPower*(Base/12)*RPMults*BodyMults*Body
	if(BlackWaterPower>0) BP+=BlackWaterPower*(Base*0.11)*RPMults*BodyMults*Body
	BP+=(BP*(Modules*0.015))//Each module is 1.5% BP
	if(AndroidLevel&&Race=="Android") BP+=(BP*(AndroidLevel*0.0025))								//Each AndroidLevel is 0.22% BP for androids
	BP+=(BP*(Fusions*0.03))//Each Fusion is 3% BP
	BP+=RPPowerAdd*Body
	if(HasMagicMiles)
		if(HasRitualOfPower>(Year+(Month*0.01))||locate(/Skill/Buff/ArcanePower) in src) BP*=1
		else BP*=(1-(HasMagicMiles*0.05))
	if(HasIntMiles&&!Cyborg&&!PowerArmorOn)BP*=(1-(HasIntMiles*0.075))
	for((var/obj/items/Artifact/A) in src)
		BP*=A.ArtifactPower
	if(BP<1) BP=1

	if(RaceEraCurrent==src.Race) BP*= EraPowerUp
	if(RaceEraPrevious==src.Race) BP*= EraPowerDown


mob/proc/Dead_In_Living_World()
	set waitfor =0
	if(!GoingHome)
		if(Dead&&Check_Dead_Location())
			if(src)
				src<<"You have exhausted all your time in the living realm, you will return to the afterlife in 1 minute."
				GoingHome=1
				spawn(600) if(src&&src.Dead)
					view(src)<<"[src] is returned to the afterlife."
					loc=locate(DEADX,DEADY,DEADZ)
					SeanceYear=0
					GoingHome=0

mob/proc/Check_Dead_Location()
	var/turf/t = locate(src.x, src.y, src.z) // Locate returns a turf.
	if(!t) return
	if(KeepsBody) return
	if((z in list(1,2,3,4,5,6,7,8,12,14,15,17)) ) return TRUE
	else return FALSE


mob/proc/CheckBind()
	var/turf/t = locate(src.x, src.y, src.z) // Locate returns a turf.
	if(!t) return
	if(z==11) return TRUE
	else return FALSE

mob/proc/FoodLoss()
	if(HasFoodWP>0)HasFoodWP-=1
	if(HasFoodRegen>0)HasFoodRegen-=1
	if(HasFoodRecov>0)HasFoodRecov-=1
	if(HasFoodBPTrain>0)HasFoodBPTrain-=1
	if(HasFoodStatsTrain>0)HasFoodStatsTrain-=1
	if(HasFoodEnergyTrain>0)HasFoodEnergyTrain-=1
	if(HasFoodRegen<=0)
		HasFoodWP=0
		HasFoodRegen=0
		HasFoodRecov=0
		HasFoodBPTrain=0
		HasFoodStatsTrain=0
		HasFoodEnergyTrain=0
		src<<"Your stomach growls as you feel you could eat again."


mob
	var
		last_icon = null
	proc
		Eject(var/obj/items/Power_Armor/A)
			if(!istype(A,/obj/items/Power_Armor)) return
			A.loc = src.loc
			A.suffix = null
			if(src.hair) src.overlays += src.hair
			src.icon = src.last_icon
			A.icon_state = "idle"
			view(20,src) << "[src] leaves the power armor!"
			usr.saveToLog("| | [src] leaves the power armor!")
			//if(A.Gundam) animate(src, transform = null, time = 0)
			/*(if(Int_Mod>=4)
				if (A.Gundam)
					if(src.HasNewType) src.BPMult /=1.325
					else src.BPMult /=1.3
				else
					if(src.HasNewType) src.BPMult /=1.225
					else src.BPMult /= 1.2 */
			//for(var/Skill/Buff/Giant_Mode/G in usr) if(G.Using) animate(src, transform = matrix()*2, time = 0)
			if(A.ForceModel) src.PowMult /= 1.2
			else src.StrMult /= 1.2
			if(src.HasArmorMastery) src.EndMult/=1.37
			else src.EndMult/=1.3
			if(src.HasNewType) src.SpdMult /= 0.9
			else src.SpdMult /= 0.8
			src.PowerArmorOn=0
			src.BreathInSpace -= 1
			src.Equip_Magic(A,"Remove")
			if(A.Health <= 0) A.icon_state = "broken"
			A.desc="<br>This is a suit of power armor. Entering it will confer +20% Strength and +30% Endurance but reduce your speed by -20%.\
Once the armor is reduced to 0 durability, it will break and eject its user. To exit or enter the armor, simply use the associated verb.  \
The suit can be grabbed and moved like a prop.Requires an INT mod of 3 or the New Type milestone to use. It will remove the BP penalty associated with taking INT milestones. [Commas(A.Health)] Durability Power Armor"



client/control_freak = CONTROL_FREAK_ALL | CONTROL_FREAK_MACROS

mob/verb
	DisClick(argu = null as anything, sec = "" as text, number1 = 0 as num  , number2 = 0 as num)
		set name = ".click"
		set category = null
		return

	DisDblClick(argu = null as anything, sec = "" as text, number1 = 0 as num  , number2 = 0 as num)
		set name = ".dblclick"
		set category = null
		return

proc
    GetDataType(v)
        if(isnull(v)) return "null"
        if(isnum(v)) return "number"
        if(istext(v)) return "text"
        if(istype(v,/datum)||istype(v,/list)||istype(v,/savefile)||istype(v,/client))
            return "[v:type]"
        if(ispath(v)) return "path"
        if(isicon(v)) return "icon"
        if(isfile(v)) return "file"
        . = "unknown"

mob/proc
	AfterImage(var/State)
		flick(src.CustomZanzokenIcon,src)
		var/Icon_Obj/Effects/After_Image/P = unpool("AfterImage")
		P.appearance=appearance
		P.overlays-=EnergyBar
		P.overlays-=HealthBar
		P.pixel_x=pixel_x
		P.pixel_y=pixel_y
		P.pixel_z=pixel_z
		P.loc=loc
		P.dir=dir
		P.icon_state=icon_state
		animate(P,alpha=0,time=12)
		P.filters += filter(type = "blur", size = 0)
		animate(P.filters[P.filters.len], size = 1.5, time = 12)
		if(State=="Dash Attack")
			P.pixel_x+=rand(-8,8)
			P.pixel_y+=rand(-8,8)
			P.pixel_z+=rand(-8,8)
		spawn(12) pool("AfterImage",P)

