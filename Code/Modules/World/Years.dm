mob/proc/Yearly_Update()
	set waitfor=0
	if(src.Savable)
		Check_Milestones()
		CatchUpMPCheck()
		if(FactionApproved(Z1FactionCode)) FactionIncome(Z1FactionCode,1)
		if(FactionApproved(Z2FactionCode)) FactionIncome(Z2FactionCode,2)
		if(FactionApproved(Z3FactionCode)) FactionIncome(Z3FactionCode,3)
		if(FactionApproved(Z4FactionCode)) FactionIncome(Z4FactionCode,4)
		if(FactionApproved(Z5FactionCode)) FactionIncome(Z5FactionCode,5)
		if(FactionApproved(Z6FactionCode)) FactionIncome(Z6FactionCode,6)
		if(FactionApproved(Z7FactionCode)) FactionIncome(Z7FactionCode,7)
		if(Age>4) for(var/Language/BabyTalk/BT in src)
			src<<"You have outgrown the baby talk phase."
			del(BT)
			if(!lan) for(var/Language/L in src)
				lan=L
				break
		if(TeachCD) TeachCD-=TeachLimit*0.5
		if(TeachCD<0) TeachCD=0
		for(var/Skill/B in src)
			if(B.Teach < TeachLimit) B.Teach += TeachLimit*0.1
		for(var/Language/B in src) if(B.Teach < TeachLimit) B.Teach += TeachLimit*0.5
		if(Race=="Saiyan"&&Age<18&&!locate(/BodyPart/Tail) in src)
			contents+=new/BodyPart/Tail(src)
			src<<"Your tail grew back."
		if(Race=="Half-Saiyan"&&Age<18&&!locate(/BodyPart/Tail) in src)
			contents+=new/BodyPart/Tail(src)
			src<<"You feel a strange itching on your backside as you come to realize you now have a tail."
		if(client) if(src)
			Age_Update()
			//Gains_Update()
			if(Counterpart) for(var/mob/player/B in Players) if(Counterpart=="[B]([B.key])"&&B.Race==Race)
				B.Counterpart="[src]([src.key])"
				if(GainMultiplier<B.GainMultiplier) src.GainMultiplier=B.GainMultiplier
				src<<"<span class=\"narrate\">Your gain has equaled your counterpart, [Counterpart]</span>"
			if(Month==1||Month==4||Month==7||Month==10)
				src<<"<span class=\"narrate\">The moon comes out!</span>"
				var/turf/ZZ = src.loc
				if(ZZ.Inside==0)
					for(var/BodyPart/Tail/B in src) if(!src.afk) if(B.Setting)
						switch(src.z)
							if(1) if(EarthMoon) src.Oozaru()
		if(!Players.Find(src))
			Players += src
			Update_Player()
		if(PercocetAddiction)PercocetAddiction--
		if(MorphineAddiction)MorphineAddiction--
		if(EpinephrineAddiction)EpinephrineAddiction--



		var/Absorb_Max = Base*0.3
		if(Absorb>Absorb_Max) Absorb=Absorb_Max
		if(Absorb)
			var/N = Absorb_Max
			N = N * 0.25
			Absorb -= N
			if(Absorb <= Base*0.05)
				Absorb = 0
				src << "All your absorbed power has faded away."
		//sleep(1)

//		if(Race=="Makyojin") MakyoStar()

		if(PercocetAddiction)src<<pick("You begin to crave some more Percocet...","You need more Percocet.","Your body aches for more Percocet.")
		if(MorphineAddiction)src<<pick("You begin to crave some more Morphine...","You need more Morphine.","Your body aches for more Morphine.")
		if(EpinephrineAddiction)src<<pick("You begin to crave some more Epinephrine...","You need more Epinephrine.","Your body aches for more Epinephrine.")
		if(Month==1&&TaxPaid&&Race=="Oni")
			src<<"You get your resource tax returns."
			for(var/obj/Resources/ManaBag in src) ManaBag+=round(TaxPaid*1.2)
			TaxPaid=0
		if(Month==1&&MTaxPaid&&Race=="Oni")
			src<<"You get your mana tax returns."
			for(var/obj/Mana/ManaBag in src) ManaBag+=round(MTaxPaid*1.2)
			MTaxPaid=0

		//Baby Age Up
		if(Offspring)
			if(Age>=13)
				if(icon=='BabyGirl.dmi') if(Confirm("Would you like to change your icon into an adult icon?"))Skin()
				if(icon=='BabyBoy.dmi') if(Confirm("Would you like to change your icon into an adult icon?"))Skin()
				if(icon=='Kid Namekian.dmi') if(Confirm("Would you like to change your icon into an adult icon?")) Skin()
			else if(Age>=6)
				if(icon=='BabyGirl.dmi') if(Confirm("Would you like to change your icon into a child/kid?"))icon='Kid Girl.dmi'
				if(icon=='BabyBoy.dmi') if(Confirm("Would you like to change your icon into a child/kid?"))icon='Kid Boy.dmi'
				if(icon=='Kid Namekian.dmi') if(Confirm("Would you like to change your icon into an adult icon?")) Skin()
			else if(Age>=2)
				if(icon=='BabyGirl.dmi') if(Confirm("Would you like to change your icon into a toddler?"))icon='Toddler Girl.dmi'
				if(icon=='BabyBoy.dmi') if(Confirm("Would you like to change your icon into a toddler?"))icon='Toddler Boy.dmi'
				if(icon=='Kid Namekian.dmi') if(Confirm("Would you like to change your icon into an adult icon?")) Skin()
		if(Age>=InclineAge) if(icon=='updated_baby_cell.dmi')if(Confirm("Would you like to change your icon now that you are at full incline?")) Skin()


mob/var/CatchUpMark=-5
mob/var/LastCatchUp=0
mob/var/RepeatMP=0
mob/var/LogoutDate=0
mob/var/LoginDate=0
mob/proc/CatchUpMPCheck()
	RepeatMP=((LoginDate - LogoutDate)*12)
	if(Year+(Month*0.01)>LastCatchUp)
		Again
		if(TotalMilestonePoints<Year)
			TotalMilestonePoints++
			LastCatchUp=Year+(Month*0.01)
			CatchUpMPs++
			MilestonePoints++
			for((var/obj/items/Artifact/A) in src)
				if(A.ArtifactMilestonePoints > 0)
					MilestonePoints+=A.ArtifactMilestonePoints
			for((var/obj/items/Artifact/A) in src)
				if(A.ArtifactEXP > 0)
					EXP+=A.ArtifactEXP
			src<<"Milestone catch up! 1 MP granted. [max(0,round(Year)-TotalMilestonePoints)] Catch Up Remaining"
			if(RepeatMP>0)
				RepeatMP--
				LogoutDate=(Year+(Month*0.01))
				goto Again

mob/verb/CheckMP()
	CatchUpMPCheck()
var/MakyoStar=0

mob/proc/MakyoStar()// if(src.Savable)
	set background=1
	set waitfor=0
	if(MakyoStar==1&&!HadStarBoost)
		if(MakyoPower==0&&Race=="Makyojin"||MakyoPower==0&&Race=="Half-Makyojin")
			src<<"<span class=\"narrate\">The Makyo Star infuses you with power. (This causes your Expand to grant 1.10x BP)"
			HadStarBoost++
	if(MakyoStar==0) HadStarBoost=0


mob/proc/Age_Update()
	set background=1
	set waitfor=0
	if(Savable)
		Real_Age=Year-BirthYear
		SaveAge=Year-YearCreated
	/*	Moon_Used -= 1
		if(Moon_Used <= 0) Moon_Used = 0*/
		if(!Dead) Age+=Year-LogYear
		LogYear=Year
		if(!Dead&&Age>Decline&&Body<=0.1) Die()
		GreyHair()
		if(Age>Decline) usr<<"Old age wears on your body."
		if(!Sterile&&Age>=16&&!(locate(/obj/Mate) in src))
			contents+=new/obj/Mate
			for(var/obj/Mate/B in src) B.LastUse=Year-1
		src<<"<span class=\"narrate\">You are now [round(Real_Age,0.1)] years old</span>"
		src<<"<span class=\"narrate\">[YearOutput()]</span>"
	//Save()
		if(locate(/obj/items/Necklace_Of_Wisdom) in src)
			for(var/obj/items/Necklace_Of_Wisdom/NW in src) if(NW.Level<Year)
				NW.Level=Year
				MilestonePoints+=0.25
		if(locate(/obj/items/Ring_Of_Experience) in src)
			for(var/obj/items/Ring_Of_Experience/NW in src) if(NW.Level<Year)
				NW.Level=Year
				EXP+=75



proc/YearOutput()
	if(Month==1) return "Week [MonthCycle] of January, Year [round(Year)]"
	if(Month==2) return "Week [MonthCycle] of February, Year [round(Year)]"
	if(Month==3) return "Week [MonthCycle] of March, Year [round(Year)]"
	if(Month==4) return "Week [MonthCycle] of April,Year [round(Year)]"
	if(Month==5) return "Week [MonthCycle] of May, Year [round(Year)]"
	if(Month==6) return "Week [MonthCycle] of June, Year [round(Year)]"
	if(Month==7) return "Week [MonthCycle] of July, Year [round(Year)]"
	if(Month==8) return "Week [MonthCycle] of August, Year [round(Year)]"
	if(Month==9) return "Week [MonthCycle] of September, Year [round(Year)]"
	if(Month==10) return "Week [MonthCycle] of October, Year [round(Year)]"
	if(Month==11) return "Week [MonthCycle] of November, Year [round(Year)]"
	if(Month==12) return "Week [MonthCycle] of December, Year [round(Year)]"

mob/proc/Body()
	if((Age<InclineAge) && (InclineAge>0))
		Body = min(100,100/((InclineAge-Age)**(0.3)))	//Incline speed works better this way
	else Body = 100	//100 percent niggaaa
	if(Dead)
		Body = 10
		if(z==11)
			Body = 100
		if(KeepsBody && z!=11)
			Body = 100

	if(Immortal) Body = 100
	Body *= 0.01	//Body is a percent, out of 100%
mob/proc/Die() //from old age
	if(inertia_dir)
		inertia_dir = 0
		last_move = null
	PotentialUnlocked=0
	HBTC_Enters=0
	Age=1
	if(icon=='Namek Old.dmi')
		icon='Namek Young.dmi'
	src << "<span class=\"narrate\">Old age takes it's toll, and you pass away.</span>"
	Death("old age")
	Body()
mob/proc/GreyHair()
	if(!ssj&&hair&&Age>Decline)
		if(Hair_Age<Decline) Hair_Age=Decline
		overlays -= hair
		hair = Hair_Base
		if(HairColor) hair+=HairColor
		hair += rgb(round(3*(Age-Hair_Age)),round(3*(Age-Hair_Age)),round(3*(Age-Hair_Age)))
		overlays += hair
