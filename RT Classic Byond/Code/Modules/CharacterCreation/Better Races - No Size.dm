



mob/proc/GetLanguage()


	switch(Race)
		if("Android")
			contents+=new/Language/Machine(100,src)
			contents+=new/Language/Common(100,src)
//			contents+=new/Language/Earthling(100,src)
//			contents+=new/Language/Arconian(100,src)
		if("Human")
//			contents+=new/Language/Earthling(100,src)
			contents+=new/Language/English(100,src)
			contents+=new/Language/Common(100,src)
		if("Demigod")
//			contents+=new/Language/Arconian(100,src)
//			contents+=new/Language/Earthling(100,src)

			contents+=new/Language/Common(100,src)

			contents+=new/Language/Old_Tongue(100,src)
			contents+=new/Language/English(100,src)
			contents+=new/Language/Demonic(50,src)
			contents+=new/Language/Makyojin(100,src)
			contents+=new/Language/Kaio(100,src)
			contents+=new/Language/Spiritual(100,src)
			contents+=new/Language/Tuffle(100,src)
			contents+=new/Language/Namekian(100,src)
			contents+=new/Language/Saiyan(100,src)
			contents+=new/Language/Changeling(100,src)
			contents+=new/Language/Oni(100,src)
			contents+=new/Language/Heran(100,src)
			contents+=new/Language/Yardrat(100,src)
			contents+=new/Language/Kanassan(100,src)

		if("Makyojin")
			contents+=new/Language/Demonic(50,src)
//			contents+=new/Language/Arconian(100,src)
			contents+=new/Language/Makyojin(100,src)

			contents+=new/Language/Common(100,src)
		if("Kaio")
			contents+=new/Language/Kaio(100,src)
//			contents+=new/Language/Earthling(100,src)
			contents+=new/Language/Common(100,src)
//			contents+=new/Language/Arconian(100,src)
		if("Spirit Doll")
			contents+=new/Language/Spiritual(100,src)
//			contents+=new/Language/Earthling(100,src)
			contents+=new/Language/Common(100,src)
//			contents+=new/Language/Arconian(100,src)
		if("Tuffle")
//			contents+=new/Language/Earthling(100,src)
			contents+=new/Language/Tuffle(100,src)

			contents+=new/Language/Common(100,src)
		if("Namekian")
//			contents+=new/Language/Earthling(100,src)
			contents+=new/Language/Namekian(100,src)

			contents+=new/Language/Common(100,src)
		if("Saiyan")
//			contents+=new/Language/Arconian(100,src)
			contents+=new/Language/Saiyan(100,src)

			contents+=new/Language/Common(100,src)
		if("Changeling")
			contents+=new/Language/Changeling(100,src)
//			contents+=new/Language/Arconian(100,src)

			contents+=new/Language/Common(100,src)
		if("Demon")
			contents+=new/Language/Demonic(100,src)
//			contents+=new/Language/Earthling(100,src)
			contents+=new/Language/Common(100,src)
			contents+=new/Language/Arconian(100,src)
		if("Oni")
			contents+=new/Language/Oni(100,src)
//			contents+=new/Language/Earthling(100,src)

			contents+=new/Language/Common(100,src)
		if("Heran")
			contents+=new/Language/Heran(100,src)
//			contents+=new/Language/Arconian(100,src)

			contents+=new/Language/Common(100,src)
		if("Yardrat")
//			contents+=new/Language/Earthling(100,src)
			contents+=new/Language/Yardrat(100,src)

			contents+=new/Language/Common(100,src)
		if("Kanassa")
//			contents+=new/Language/Earthling(100,src)
			contents+=new/Language/Kanassan(100,src)

			contents+=new/Language/Common(100,src)
		if("Alien")
			contents+=new/Language/Common(100,src)
//			contents+=new/Language/Arconian(100,src)
//			contents+=new/Language/Earthling(100,src)

/*

mob/proc/Android(sizing=0)
	RaceDescription={"-Androids-
Androids are mechanical beings with great potential. Their skill is more so determined by their ability to gather and consume component chips. With the right amount of technological support, they can be a dominant force in the universe. They are created by skilled scientists.

"}
	if(!sizing)
//		Potential=0
		undelayed=1
		Sterile=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=100
		InclineAge=0
		HPDoesNotAffectBP = 1
		ZanzoMod=2
		Zanzoken=10000
		FlyMod=5
		FlySkill=50
		GravMastered=1
		Zenkai=1
		MedMod=1
		Race="Android"
		BaseMaxKi=100
		Age=1
		IgnoresGodKi=1
		BreathInSpace=1
		contents+=new/Skill/Misc/Absorb_Android
//		GeneticLearnList=AndroidLearnList

	BPMod=2.3
	FBMMult=2
	AscensionMult=1.1
	BaseMaxAnger=100
	KiMod=3
	StrMod=1.1
	EndMod=1.1
	SpdMod=1.1
	OffMod=1.1
	DefMod=1.1
	BaseRegeneration=1.5
	BaseRecovery=3


	//Android_Advancement()
	if(!sizing&&!HasCreated)
		var/list/Androids = new
		var/GiveChoice = 0
		for(var/obj/items/Android_Chassis/A)
			if(A.z)
				Androids += A
				GiveChoice = 1
		if(!GiveChoice)
			src<<"There are no available Chasis to choose from, please choose a different race."
			del(src)
			return
		if(GiveChoice)
			Androids+="Cancel"
			var/obj/choice = input("Choose an Android to activate.","Android Activation") in Androids
			switch(choice)
				if("Cancel")
					BackChar()
					/*del(src)
					return*/
				else
					if(!src.Confirm("This Android was made by [choice.Builder]. Continue?"))
						del(src)
						return
					if(choice.Password)
						var/PA=input(src,"[choice] Password","New Character",null)
						if(PA!=choice.Password)
							if(src)
								var/mob/player/A = new
								A.key = key
								A = src
								del(src)
					var/obj/items/Android_Chassis/O = choice
					src.loc = O.loc
					src.Builder=O.Builder
					src.name = O.name
					view(8,src) << "[O.name] activates."
					view(8,src) << "[O] says: Systems online..."
					src.Delete = O
					src.Age+=5											//5 years old android so he can learn things
					var/FreeUps=5
					while(FreeUps>0)
						var/obj/items/Android_Upgrade/AU=new
						contents+=AU
						FreeUps--

*/
/*
Absorb cost money and cyberize grants it.
*/
/*
mob/proc/Android_Advancement() for(var/mob/player/A in Players) if(A.AS_Droid)
	if(A.Int_Level>Int_Level)
		Int_Level=A.Int_Level
		Int_XP=A.Int_XP
		Int_Next=A.Int_Next
	if(A.Base*0.5>Base)
		Base+=A.Base*0.25
	//Offspring=1
	if(A.GainMultiplier>GainMultiplier) GainMultiplier=A.GainMultiplier
	src<<"The Android Ship has learned from her past mistakes and made you all the more powerful."
*/
mob/proc/Human(sizing=0)//

	RaceDescription={"-Human-
The human race, originating on the planet Earth, is one built upon the foundation of pride, honor, and loyalty. They are capable martial artists as well as skilled magicians and mages, naturally specializing in each at an accelerated rate. Though weak compared to most races in the universe their ability to adapt and learn if given enough time is second to none.

"}

	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=16
		Decline=45
		ZanzoMod=1.5
		FlyMod=1.3
		BaseMaxKi=100
		Zenkai=3
		MedMod=2
		Race="Human"
		GravMastered=1
//		GeneticLearnList=HumanLearnList

	BPMod=1
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=110
	KiMod=2
	StrMod=3
	EndMod=3
	SpdMod=3
	OffMod=3
	DefMod=3
	BaseRegeneration=2
	BaseRecovery=3



mob/proc/Demigod(sizing=0) //
	RaceDescription={"-Demi-Gods-
When two God like beings mate, a Demi-God is formed. Demi-Gods are extremely powerful beings with a seemingly limitless ceiling. They control the power of the Pantheon and with it defend their beliefs, be them for good or for evil.

"}
	if(!sizing)
		Magic_Potential=1
		InclineAge=16
		Decline=45
		ZanzoMod=1
		FlyMod=2
		BaseMaxKi=100
		MedMod=2
		Race="Demigod"
		GravMastered=1
		//Sterile=1

//		GeneticLearnList=DemiLearnList
//		RacialPowerAdd=100

	BPMod=2
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=130
	KiMod=2
	StrMod=1.3
	EndMod=1.3
	SpdMod=1.3
	OffMod=1.3
	DefMod=1.3
	BaseRegeneration=2
	BaseRecovery=2.8

mob/proc/Makyojin(sizing=0) //17.3 anger, expand, fbm
	RaceDescription={"-Makyojin-
Makyo's are powerful beings, both in body and knowledge of the arcane. Whether it be honing their body to levels of near invincibility or tapping into their natural ability to weave magic, the Makyo race is nothing to scoff at. Though their origins are shrouded in mystery, one thing about them is clear - Wherever they go, none will forget them.
"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 2
		InclineAge=16
		Decline=45
		FlySkill=4
		BaseMaxKi=100
		Zenkai=5
		MedMod=2
		FlyMod=1.3
		ZanzoMod=1.2
		Race="Makyojin"
		GravMastered=1

//		GeneticLearnList=MakyoLearnList
		/*AlignmentNumber=-2
		Alignment="Evil"*/
//		RacialPowerAdd=100

	BPMod=1.3
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=120
	KiMod=2
	StrMod=2
	EndMod=3
	SpdMod=2.2
	OffMod=2
	DefMod=2
	BaseRegeneration=2
	BaseRecovery=2.5


mob/proc/Kaio(sizing=0)//
	RaceDescription={"-Kaios-
Kaios are almost always benevolent beings. They are born with the purest of hearts and have a innate understanding of ki and energy manipulation. However, this stereotype does prove itself false from time to time.
"}

	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=18
		Decline=60
		ZanzoMod=2
		Zanzoken=10000
		FlyMod=2
		FlySkill=2
		BaseMaxKi=100
		Zenkai=2.5
		MedMod=3
		Race="Kaio"
		BreathInSpace=1
		GravMastered=1
//		GeneticLearnList=KaioLearnList
		AlignmentNumber=5
		Alignment="Good"
//		Sterile=1
//		RacialPowerAdd=100
//		Asexual=1
	BPMod=1
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=100
	KiMod=2
	StrMod=1.5
	EndMod=1.5
	SpdMod=1.6
	OffMod=1.6
	DefMod=1.6
	BaseRegeneration=1
	BaseRecovery=14

/*
mob/proc/Doll(sizing=0) //
	RaceDescription={"-Spirit Doll-
These curious things are constructs of pure magic, typically created by a skilled mage.
"}
	if(!sizing)
		//Asexual=1
		Sterile=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=65
		InclineAge=0
		Sterile=1
		ZanzoMod=2
		FlyMod=2
		BaseMaxKi=100
		BreathInSpace=1
		contents+=new/Skill/Support/Telekinesis
		src.TK = 1
		MedMod=2
		Race="Spirit Doll"

//		GeneticLearnList=DollLearnList

	BPMod=1.9
	FBMMult=2.1
	AscensionMult=1.2
	BaseMaxAnger=130
	KiMod=3
	StrMod=1.9
	EndMod=1.9
	SpdMod=2
	OffMod=2.2
	DefMod=2.2
	BaseRegeneration=2
	BaseRecovery=3
	if(!sizing&&!HasCreated)
		var/list/Dolls = new
		var/GiveChoice = 0
		for(var/obj/items/Enchanted_Doll/ED in world)
			if(ED.invisibility <= 0)
				Dolls += ED
				GiveChoice = 1
		if(!GiveChoice)
			src<<"There are no available Dolls to choose from, please choose a different race."
			del(src)
			return
		if(GiveChoice)
			Dolls+="Cancel"
			var/obj/choice = input("Choose a Doll to activate.","Spirit Doll Activation") in Dolls
			switch(choice)
				if("Cancel")
					BackChar()
				else
					if(!src.Confirm("This Spirit Doll was made by [choice.Builder]. Continue?"))
						del(src)
						return
					if(choice.Password)
						var/PA=input(src,"[choice] Password","New Character",null)
						if(PA!=choice.Password)
							if(src)
								var/mob/player/A = new
								A.key = key
								A = src
								del(src)
					var/obj/items/Enchanted_Doll/O = choice
					src.loc = O.loc
					src.Builder=O.Builder
					src.name = O.name
					view(8,src) << "[O.name] awakens."
					src.Delete = O
*/

mob/proc/Tuffle(sizing=0) //
	RaceDescription={"-Tuffles-
Tuffles are known to be one of, if not the most intellectual race in existence. They have a natural gift of understanding science and through their intellect they propel themselves forward.
"}
	if(!sizing)
		Int_Mod=2
		Magic_Potential = 1
		Decline=45
		InclineAge=16
		ZanzoMod=2
		FlyMod=1.5
		BaseMaxKi=100
		Zenkai=5
		MedMod=2
		Race="Tuffle"
		GravMastered=1

//		GeneticLearnList=TuffleLearnList
//		RacialPowerAdd=100

	BPMod=0.9
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=110
	KiMod=2
	StrMod=2.7
	EndMod=2.7
	SpdMod=3
	OffMod=3.3
	DefMod=3.3
	BaseRegeneration=2
	BaseRecovery=4


mob/proc/Namekian(sizing=0) //
	RaceDescription={"-Namekian-
Namekians are often considered a kind and nurturing race. A race of warriors and magicians, the Namekians possess abilities that some may odd or even unnatural. Highly resilient, this race recovers quickly from most injuries.
"}

	if(!sizing)
		Asexual=1
		Magic_Potential = 1
		Int_Mod=1
		InclineAge=8
		Decline=60
		BaseMaxKi=100
		ZanzoMod=2
		Zanzoken=10000
		FlyMod=2
		FlySkill=10
		Zenkai=2.5
		MedMod=2.5
		Race="Namekian"
		Class="Undefined Class"
		GravMastered=1
		contents+=new/Skill/Support/Counterpart
//		GeneticLearnList=NamekianLearnList
		CanLimbRegen=1

//		SNjAt=600000

	BPMod=1.3
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=130
	KiMod=2
	StrMod=2
	EndMod=2
	SpdMod=2
	OffMod=2
	DefMod=2
	BaseRegeneration=3
	BaseRecovery=3.6


mob/proc/AncientNamekian(sizing=0) //
	RaceDescription={"-Ancient Namekian-
Ancient Namekians are a very dark and evil race.
"}

	if(!sizing)
		Asexual=1
		Magic_Potential = 2
		Int_Mod=1
		InclineAge=8
		Decline=60
		BaseMaxKi=100
		ZanzoMod=2
		Zanzoken=10000
		FlyMod=2
		FlySkill=10
		Zenkai=5
		MedMod=2.5
		Race="Namekian"
		Class="Ancient"
		GravMastered=1
		//contents+=new/Skill/Support/Counterpart
//		GeneticLearnList=AncientNamekianLearnList
		CanLimbRegen=1
//		RacialPowerAdd=100

//		SNjAt=600000

	BPMod=2.3
	FBMMult=2
	AscensionMult=1.16
	BaseMaxAnger=150
	KiMod=3.3
	StrMod=2
	EndMod=2.4
	SpdMod=2
	OffMod=2
	DefMod=1.5
	BaseRegeneration=3
	BaseRecovery=1.8


mob/proc/Low(sizing=0) //
	RaceDescription={"-Saiyan-
A race of proud warriors. Though brutal in their tactics their society does have the occaisional soft spot, or even a magician or technician or two. The longer a fight goes on, the stronger a saiyan gets - Whether it be by means of tapping into their rage or through their race's special ability: Zenkai.

"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=16
		Race="Saiyan"
		Class="Undefined Class"
		Decline=45
		ZanzoMod=1.2
		BaseMaxKi=100
		FlyMod=1.5
		Zenkai=10
		MedMod=2
		GravMastered=1

		SSjMult=1.5
		SSj2Mult=1.2
//		GeneticLearnList=SaiyanLearnList
	BPMod=2.5
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=150
	KiMod=2
	StrMod=1
	EndMod=1
	SpdMod=1
	OffMod=1
	DefMod=1
	BaseRegeneration=2
	BaseRecovery=1.9

mob/proc/GetChangieTrans() if(Race=="Changeling")
	if(Class=="Undefined Class")
		Form2Mult = 1.08
		Form3Mult = 1.25
		Form4Mult = 1.15
	if(Class=="Cooler")
		Form2Mult=1.08
		Form3Mult=1.25
		Form4Mult=1.15
		Form5Mult=1.4
	//roughly 17 mil total with mults, brings them up to almost compete with SSj2 equally but not quite
	if(Class=="King Kold")
		Form2Mult=1.6
	MaxHealth=110
	MaxWillpower=110
	Health=MaxHealth
	Willpower=MaxWillpower


mob/proc/Changeling(sizing=0) //
	RaceDescription={"-Changeling-
Changelings are arguable one of the toughest races in the universe as history would present it. Not many are left within the universe, for reasons unknown, but those in existence are massive forces of destruction. Their power rests in their ability to transform unlike any other race.
"}
	if(!sizing)
		Asexual=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=45
		InclineAge=10
		BaseMaxKi=100
		Race="Changeling"
		GravMastered=1
		Zanzoken=10000
		ZanzoMod=1.5
		FlyMod=3
		FlySkill=4
		BreathInSpace=1
		contents+=new/Skill/Buff/ChangelingTransformation
		Zenkai=5
	//	GeneticLearnList=ChangelingLearnList
		AlignmentNumber=-2
		Alignment="Evil"

	BPMod=3
	FBMMult=1
	BaseMaxAnger=120
	KiMod=2
	StrMod=1
	EndMod=1.2
	SpdMod=1.1
	OffMod=1.1
	DefMod=1
	BaseRegeneration=2
	BaseRecovery=1.6
	AscensionMult=1


mob/proc/Cooler(sizing=0) //
	RaceDescription={"-Changeling-
Changelings are arguable one of the toughest races in the universe as history would present it. Not many are left within the universe, for reasons unknown, but those in existence are massive forces of destruction. Their power rests in their ability to transform unlike any other race.
"}
	if(!sizing)
		Class="Cooler"
		Asexual=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=45
		InclineAge=10
		BaseMaxKi=100
		Race="Changeling"
		GravMastered=1
		Zanzoken=10000
		ZanzoMod=1.5
		FlyMod=3
		FlySkill=4
		BreathInSpace=1
		contents+=new/Skill/Buff/ChangelingTransformation
		Zenkai=5
//		GeneticLearnList=ChangelingLearnList
		AlignmentNumber=-2
		Alignment="Evil"

	BPMod=2.5
	FBMMult=1
	BaseMaxAnger=110
	KiMod=2
	StrMod=1.4
	EndMod=2.5
	SpdMod=1.4
	OffMod=1.4
	DefMod=1.4
	BaseRegeneration=2
	BaseRecovery=1.6
	AscensionMult=1

mob/proc/Kold(sizing=0) //
	RaceDescription={"-Changeling-
Changelings are arguable one of the toughest races in the universe as history would present it. Not many are left within the universe, for reasons unknown, but those in existence are massive forces of destruction. Their power rests in their ability to transform unlike any other race.
"}
	if(!sizing)
		Asexual=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=45
		InclineAge=10
		BaseMaxKi=100
		Race="Changeling"
		Class="King Kold"
		GravMastered=1
		Zanzoken=10000
		ZanzoMod=1.5
		FlyMod=3
		FlySkill=4
		BreathInSpace=1
		Zenkai=5
//		GeneticLearnList=ChangelingLearnList

	BPMod=3.5
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=100
	KiMod=2
	StrMod=1.1
	EndMod=1.3
	SpdMod=1.1
	OffMod=1.1
	DefMod=1.1
	BaseRegeneration=2
	BaseRecovery=1.4


mob/proc/Demon(sizing=0)//
	RaceDescription={"-Demons-
Demons are entities usually consisting of pure evil. Most of their race seek to twist everything pure and good into something vile and corrupt. Powerful fighters, a majority of demons prefer to get up close and personal with their opponents to enjoy the brutality of combat.
"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		Decline=50
		InclineAge=16
		ZanzoMod=1.5
		Zanzoken=10000
		FlyMod=2
		FlySkill=3
		Zenkai=6
		MedMod=2
		Race="Demon"
		AlignmentNumber=-5
		Alignment="Evil"
		BreathInSpace=0
		GravMastered=1
//		GeneticLearnList=DemonLearnList
		BaseMaxKi=100

	BPMod=1.6
	AscensionMult=1
	FBMMult=1
	BaseMaxAnger=160
	KiMod=2
	StrMod=1.3
	EndMod=1.3
	SpdMod=1.3
	OffMod=1.3
	DefMod=1.3
	BaseRegeneration=1.5
	BaseRecovery=1.5


mob/proc/Oni(sizing=0)
	RaceDescription={"-Oni-
The Oni are a peculiar race, Some are evil, some good, but all of them are usually both durable and powerful. Though they aren't masters of it to the same level as other races, Oni's do still possess a great deal of intellect and magical potential.

"}
	if(!sizing)
		Int_Mod=1.5
		Magic_Potential =1.5
		InclineAge=12
		Decline=50
		ZanzoMod=1
		FlyMod=1
		BaseMaxKi=100
		Zenkai=5
		MedMod=2
		Race="Oni"
		GravMastered=1
		BreathInSpace=0
		FlySkill=2
//		GeneticLearnList=OniLearnList

	BPMod=1.2
	FBMMult=1
	BaseMaxAnger=160
	AscensionMult=1
	KiMod=2
	StrMod=2
	EndMod=2
	SpdMod=2
	OffMod=1.8
	DefMod=1.8
	BaseRegeneration=2
	BaseRecovery=1


mob/proc/SpacePirate(sizing=0)
	RaceDescription={"-Heran-
Herans are creatures of brute strength and phenomenal combat prowess. Their culture is certainly rough around the edges, with a great deal of them enjoying narcotics, gambling, robbery, and murder. Similar to saiyans, they possess a great deal of hidden power that is unleashed when they're truly angry, and a natural ability to get stronger after falling in combat.
"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=12
		Race="Heran"
		Decline=45
		FlySkill= 50
		FlyMod=1.5
		BaseMaxKi=100
		Zenkai=6
		GravMastered=1
		Class="Heran"
//		GeneticLearnList=HeranLearnList

	BojackMult=1.6
	SuperBojackMult=1.25
	AscensionMult=1.17
	BPMod=2
	FBMMult=1
	BaseMaxAnger=140
	KiMod=2
	StrMod=1.4
	EndMod=1.4
	SpdMod=1.3
	OffMod=1.3
	DefMod=1.3
	BaseRegeneration=2
	BaseRecovery=1.9
	IgnoreTaxes = 1


mob/proc/Yardrat(sizing=0) //
	RaceDescription={"-Yardrats-

Yardrats are known for being the fastest race in the galaxy. Whether this be through practicing with their body or through manipulating ki, the rate at which they move is second to none.
"}
	if(!sizing)
		Asexual=1
		Magic_Potential = 1
		Int_Mod=1
		InclineAge=10
		Decline=50
		BaseMaxKi=100
		ZanzoMod=5
		Zanzoken=10000
		FlyMod=2
		FlySkill=1
		Zenkai=3
		MedMod=3
		Race="Yardrat"
		Class="Yardrat"
		GravMastered=1
//		contents+=new/Skill/Support/InstantTransmission
//		GeneticLearnList=YardratLearnList

	BPMod=2.2
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=110
	KiMod=1.1
	StrMod=1.9
	EndMod=1.9
	SpdMod=3
	OffMod=1.9
	DefMod=1.9
	BaseRegeneration=2
	BaseRecovery=2.5


mob/proc/Kanassa(sizing=0)//
	RaceDescription={"-Kanassans-
Kanassans are a race of impressive foresight. Some say that the most skilled of their race are even able to see events in the future, though only for fleeting moments.
"}
	if(!sizing)
		Int_Mod=1
		Asexual=1
		Magic_Potential = 1
		InclineAge=14
		Decline=50
		ZanzoMod=1.5
		FlyMod=1.5
		Zenkai=3
		MedMod=3
		Race="Kanassa"
		Class="Kanassa"
		GravMastered=1
//		GeneticLearnList=KanassaLearnList
		contents+=new/Skill/Support/Telepathy
		BaseMaxKi=100
		swimSkill=2000

	BPMod=1.4
	FBMMult=1
	AscensionMult=1
	BaseMaxAnger=120
	KiMod=2
	StrMod=1.7
	EndMod=1.7
	SpdMod=2
	OffMod=2
	DefMod=2.4
	BaseRegeneration=2
	BaseRecovery=3
	Asexual=1
/*
mob/proc/Alien(skipicon=0)
	RaceDescription={"-Custom Alien-
Aliens are a place holder race for whatever you can come up with. Highly customizable.
"}
	if(!skipicon)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=16
		Decline=55
		//alert("[RaceDescription]")
		ZanzoMod=1.5
		FlyMod=2
		Zenkai=4
		MedMod=2
		Race="Alien"
		BaseMaxKi=100
//		RacialPowerAdd=50
		//MilestonePoints=4
		GravMastered=1
//		GeneticLearnList=AlienLearnList

	BPMod=2.2
	FBMMult=1.95
	AscensionMult=1.18
	BaseMaxAnger=130
	KiMod=1.4
	StrMod=1.15
	EndMod=1.15
	SpdMod=1.15
	OffMod=1.15
	DefMod=1.15
	BaseRegeneration=1.9
	BaseRecovery=1.35
*/

mob/proc/Majin(sizing=0) //
	RaceDescription="Majin(Placeholder)"

	if(!sizing)
		Sterile=1
		Int_Mod=1
		Magic_Potential = 1.5
		undelayed=1
		InclineAge=10
		Decline=200
		contents+=new/Skill/Misc/Absorb_Majin
		//FlySkill=1
		BaseMaxKi=100
		Zenkai=1
		Age=1
		Race="Majin"
		BreathInSpace=1
		Zanzoken=10000
		GravMastered=1
		Regenerate=2
		CanLimbRegen=1
		contents+=new/Language/Common(100,src)
		AlignmentNumber=-6
		Alignment="Very Evil"
	BPMod=2.5
	FBMMult=1.9
	AscensionMult=1.3
	BaseMaxAnger=140
	KiMod=3
	StrMod=2
	EndMod=2
	SpdMod=2
//	ResMod=2
	OffMod=1.5
	DefMod=1.5
	BaseRegeneration=5
	BaseRecovery=3


mob/proc/Bio(sizing=0) //
	RaceDescription="You are created as a Biological Android! Through many years of study, careful processing, data collection and sample acquisition, your creator has perfected the fabrication of a master hybrid species. However, you are not complete just yet and an insatiable urge, a hunger; hollowness of self lingers at the back of your mind constantly. It seems by some design or instinct, you are destined to seek ultimate perfection and ascend to your fullest potential. As a Biological Android, you are able to regenerate from death, so long as a single one of your unique cells remain. "

	if(!sizing)
		Sterile=1
		Int_Mod=1.5
		Magic_Potential = 1
//		Potential=1
		InclineAge=0
		Decline=20
		contents+=new/Skill/Misc/Absorb_Bio
		Zanzoken=10000
		FlySkill=10
		FlyMod=2
		BaseMaxKi=100
		Zenkai=9
		MedMod=2
		Age=1
		Race="Bio-Android"
		BreathInSpace=1
		Regenerate=1
		CanLimbRegen=1
//		GeneticLearnList+="Super Perfect Form"
		contents+=new/Language/Common(100,src)
		contents+=new/Language/Machine(100,src)
		src.loc = locate(321,419,14)
		GravMastered=1
		//src << "<p>You are created as a Biological Android! Through many years of study, careful processing, data collection and sample acquisition, your creator has perfected the fabrication of a master hybrid species. However, you are not complete just yet and an insatiable urge, a hunger; hollowness of self lingers at the back of your mind constantly. It seems by some design or instinct, you are destined to seek ultimate perfection and ascend to your fullest potential. As a Biological Android, you are able to regenerate from death, so long as a single one of your unique cells remain. <p><p>"
		AlignmentNumber=-5
		Alignment="Evil"
	BPMod=2.5
	FBMMult=1
	AscensionMult=1.00
	BaseMaxAnger=150
	KiMod=2
	StrMod=1.8
	EndMod=1.8
	SpdMod=1.8
	OffMod=1.8
	DefMod=1.8
	BaseRegeneration=2.5
	BaseRecovery=2.5




mob/proc/LSSJ(sizing=0)
	RaceDescription="(Placeholder)"
	if(!sizing)
		FlyMod=1.5
		Zenkai=10
		MedMod=2
		GravMastered=1
		alert(src,"You are born with the Legendary Gene, a rare mutation within a Saiyans genetic DNA structure! A mythic pantheon of unstoppable might and resilience amongst a race of already formidable warriors, your destiny truly seems laid out in gold. However, the gene is highly unstable, lowering your lifespan by around ten years and causing you to become prone to fits of anger more easily at best, and insane insatiable perpetual rage fits at worst. Although not impossible, it is quite hard to snap out of such episodes. This is certainly both a blessing or a curse, left up for you to decide. Lastly and most importantly, achieving the Super Saiyan state is nearly as easy as breathing for you.")
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=16
		Race="Saiyan"
		Class="Legendary"
		Decline=100
		ZanzoMod=1.2
		BaseMaxKi=100
		AlignmentNumber=-5
		Alignment="Evil"
	BPMod=2.2
	FBMMult=1.7
	AscensionMult=1
	BaseMaxAnger=160
	KiMod=1.8
	StrMod=1.7
	EndMod=1.7
	SpdMod=1.7
	OffMod=1.7
	DefMod=1.7
	BaseRegeneration=2
	BaseRecovery=1.8






