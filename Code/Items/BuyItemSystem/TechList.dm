obj/Technology
	var/displaykey
	var/Creates
	var/Cost=0
	var/Mod=1
	Level=1
	verb
		Inspect()
			set src in world
			set name = "Inspect"
			set category = "Other"
			if(src.Creates)
				var/obj/A=new src.Creates
				usr << A.desc
				del(A)
	Click()
		if(usr.Creating)
			usr<<"You may only make one thing at a time."
			return
		if(!usr.Confirm("Create [src]?")) return
		for(var/obj/Resources/B in usr)
			if(usr.Creating)
				usr<<"You may only make one thing at a time."
				return
			var/Amount=0
			for(var/obj/O in range(0,usr)) if(!(locate(O) in usr)) Amount++
			if(global.rebooting)
				usr << "Unable to make any new technology while a reboot is in progress."
				return
			if(Amount>=20)
				usr<<"Nothing more can be placed on this spot."
				return
			for(var/area/UndergroundMine/W in view(3,usr))
				usr<<"You cannot do that here."
				return
			if(B.Value < round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))) )
				usr<<"You do not have the resources to create this."
				return
			if(istype(src,/obj/Technology/Drill_Tower))
				var/NumP=0
				for(var/obj/Drill/MP) if(MP.Builder=="[usr.real_name]") NumP++
				if(NumP>=1)
					usr<<"You already have too many Drills. ([NumP] is the total you can have)"
					return
			if(istype(src,/obj/Technology/Drill_Tower))
				usr<<"Remember to bolt this item!"
			usr.AllOut("Crafting time for [src] is [((1*Level)/usr.Int_Mod)/10] seconds.")
			usr.Creating=1
			spawn((1*Level)/usr.Int_Mod)
				if(!usr.Creating)return
				B.Value -= round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
				var/obj/A=new Creates
				A.cost= round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
				if(istype(A,/obj/items/FriendshipBracelet))
					A.Level=usr.Signature
					A.name="[usr]s Friendship Bracelet"
				if(istype(A,/obj/Ships))
					if(usr.z==10 || usr.z==11 || usr.z==8||usr.z==17||usr.z==9)
						usr<<"<b>The materials in this realm cannot conjoin to make this [src].</b>"
						del (A)
				if(istype(A,/obj/items/Armor))
					var/x=input(usr,"Choose the icon for [src]") in list("Armor 1","Bardock","Green","Black","Armor 2","Armor 3","Armor 4","Armor 5","Armor 6", "Armor 7", "Armor 8")
					switch(x)
						if("Armor 1")A.icon='Armor1.dmi'
						if("Bardock")A.icon='BardockArmor.dmi'
						if("Black")A.icon='TurlesArmor.dmi'
						if("Green")A.icon='Nappa Armor.dmi'
						if("Armor 2")A.icon='Armor2.dmi'
						if("Armor 3")A.icon='Armor3.dmi'
						if("Armor 4")A.icon='Armor4.dmi'
						if("Armor 5")A.icon='Armor5.dmi'
						if("Armor 6")A.icon='Armor6.dmi'
						if("Armor 7")A.icon='Armor7.dmi'
						if("Armor 8")A.icon='White Male Armor.dmi'


				if(istype(A,/obj/items/Power_Armor))
					if(usr.Confirm("Make this a Force Model? (Increases Force insead of Strength)"))
						var/obj/items/Power_Armor/BB=A
						BB.ForceModel=1
				if(istype(A,/obj/items/Sword))
					var/x=input(usr,"Choose the icon for [src]") in list("Trunks","Knight","Demon","Katana","Random","Short","Rebellion","Buster","Great", "Flame", "Samurai")
					switch(x)
						if("Trunks") A.icon='Sword_Trunks.dmi'
						if("Knight") A.icon='Sword 2.dmi'
						if("Demon") A.icon='Sword 1.dmi'
						if("Katana") A.icon='Item - Katana 2.dmi'
						if("Random") A.icon='Item - Katana.dmi'
						if("Short") A.icon='Short Sword.dmi'
						if("Rebellion") A.icon='Item, Sword 1.dmi'
						if("Buster") A.icon='Item, Buster Sword.dmi'
						if("Great") A.icon='Item, Great Sword.dmi'
						if("Flame") A.icon='Sword Flame.dmi'
						if("Samurai") A.icon='Sword, Samurai.dmi'
				if(A)
					view(10,usr) << "[usr] creates a [A]."
					A.loc=usr.loc
					A.cost = round(Cost/usr.Int_Mod)
					A.Builder="[usr.real_name]"
					usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name] ([A])")
					if(istype(A,/obj/items/Scanner)) if(usr.Confirm("Make the scouter use the sunglasses icon?")) A.icon='Item - Sun Glassess.dmi'
					A.SaveItem(A)
					global.worldObjectList+=A

				else
					B.Value +=  round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
					usr<<"There are no more available ship interiors or the realm you are in does not support this invention.  Therefore, you cannot create this."
					del(A)
				if(istype(A,/obj/Door))
					A:Grabbable=0
					A.Builder="[usr.real_name]"
					var/New_Password=input(usr,"Enter a password or leave blank") as text
					if(!A) return
					A.Password=New_Password
					SaveItemATOM(A)
				if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
					var/obj/items/O=A
					O.MaxBPAdd+=5
					O.MasterSmith=1
				if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
					var/obj/items/Armor/O=A
					O.KineticBarrier+=5
					O.MasterSmith=1
				if(istype(A,/obj/items/Android_Chassis))
					A.Builder="[usr.real_name]"
					usr.MadeAnAndroid++
					var/N=input(usr,"Enter a name.") as text
					if(!N)
						var/X = rand(100,900)
						A.name = "Android - [X]"
					else A.name=N
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Android",null) as text
				usr.Creating=0



	New()
		if(Creates)
			var/obj/A=new Creates
			if(A)
				icon=A.icon
				icon_state=A.icon_state
				del(A)
		else del(src)



	FriendshipBracelet
		Level=1
		Creates=/obj/items/FriendshipBracelet
		Cost=500
	Armor
		Level=2
		Creates=/obj/items/Armor/Normal_Armor
		Cost=625000
	Shovel
		Level=2
		Creates=/obj/items/Digging/Shovel
		Cost=10000
	Boxing_Gloves
		Level=3
		Creates=/obj/items/Boxing_Gloves
		Cost=1500
	Bandages
		Level=3
		Creates=/obj/items/Bandages
		Cost=10000
	Sword
		Level=3
		Creates=/obj/items/Sword/Normal_Sword
		Cost=1250000
	Punching_Bag
		Level=4
		Creates=/obj/TrainingEq/Punching_Bag
		Cost=4000
	Soccer_Ball
		Level=5
		Creates=/obj/items/Soccer_Ball
		Cost=25000
	Gauntlets
		Level=6
		Creates=/obj/items/Gauntlets/Normal_Gauntlets
		Cost=1250000
	Drill_Tower
		Level=7
		Creates=/obj/Drill
		Cost=375000
		Mod=3
	Door_Pass
		Level=7
		Creates=/obj/items/Door_Pass
		Cost=20000
	Communicator
		Level=8
		Creates=/obj/items/Communicator
		Cost=40000
	LSD
		Level=8
		Creates=/obj/items/LSD
		Cost=10000
	Hand_Drill
		Level=9
		Creates=/obj/items/Digging/Hand_Drill
		Cost=150000
	Utility_Belt
		Level=14
		Creates=/obj/items/Utility_Belt/Normal_Utility_Belt
		Cost=625000
		Mod=1.5
		Cost=4000
	Reinforced_Vault
		Level=10
		Creates=/obj/Door/Lockable/Reinforced_Vault
		Cost=300000
	Reinforced_Door
		Level=10
		Creates=/obj/Door/Lockable/Reinforced_Door
		Cost=300000
	Spacesuit
		Level=16
		Creates=/obj/items/Spacesuit
		Cost=250000
	PDA
		Level=16
		Creates=/obj/items/PDA
		Cost=1000
	Book_Case
		Level=18
		Creates=/obj/items/Bookcase
		Cost=2000000
	Hammer
		Level=18
		Creates=/obj/items/Hammer/Normal_Hammer
		Cost=1250000
	Medicine_Cabinet
		Level=18
		Creates=/obj/items/Medicine_Cabinet
		Cost=250000
	Stun_Controls
		Level=20
		Creates=/obj/items/Stun_Controls
		Cost=1000000
		Mod=2
	Stun_Chip
		Level=20
		Creates=/obj/items/Stun_Chip
		Cost=500000
		Mod=2
	Punchometer
		Level=27
		Creates=/obj/TrainingEq/Punchometer
		Cost=250000
		Mod=2
	Translator
		Level=32
		Creates=/obj/items/Translator
		Cost=33200000
		Mod=2
	Cooking_Bag
		Level=35
		Creates=/obj/items/Cooking_Bag
		Cost=8300000
		Mod=2
	Mining_Bag
		Level=35
		Creates=/obj/items/Mining_Bag
		Cost=8300000
		Mod=2

	Ninja_Scarf
		Level=25
		Creates=/obj/items/Ninja_Scarf
		Cost=3750000
		Mod=2
	Locator
		Level=35
		Creates=/obj/items/Locator
		Cost=2490000
		Mod=2
	Scanner
		Level=22
		Creates=/obj/items/Scanner
		Cost=2500000
	Security_Monitor
		Level=23
		Creates=/obj/items/Security_Monitor
		Cost=250000
	Regenerator
		Level=24
		Creates=/obj/items/Regenerator
		Cost=1125000
	Motion_Detector
		Level=25
		Creates=/obj/items/Motion_Detector
		Cost=187500
	Simulator
		Level=27
		Creates=/obj/items/Simulator
		Cost=15000000
	Repair_Kit
		Level=19
		Creates=/obj/items/Repair_Kit
		Cost=800000

	Upgrade_Kit
		Level=69
		Creates=/obj/items/Upgrade_Kit
		Cost=1000000
		Mod=2
	Vending_Machine
		Level=38
		Creates=/obj/Vending_Machine
		Cost=3320000
		Mod=3
	Cooking_Bag
		Level=35
		Creates=/obj/items/Cooking_Bag
		Cost=8300000
		Mod=2
	Basic_Stovetop
		Level=30
		Creates=/obj/items/furnace/Basic_Stovetop
		Cost=3320000
	Basic_Forge
		Level=35
		Creates=/obj/items/furnace/Basic_Forge
		Cost=4150000
		Mod=2
	Advanced_Furnace
		Level=47
		Creates=/obj/items/furnace/Advanced_Furnace
		Cost=6250000
		Mod=3
//	Hand_Grenade
//		Level=28
//		Creates=/obj/items/Explosives/Hand_Grenade
//		Cost=2500000
//		Mod=1.5
//	Stun_Grenade
//		Level=39
//		Creates=/obj/items/Explosives/Stun_Grenade
//		Cost=3320000
//		Mod=2
//	Fire_Bomb
//		Level=50
//		Creates=/obj/items/Explosives/Fire_Bomb
//		Cost=3125000
//		Mod=3
//	High_Explosive_Grenade
//		Level=61
//		Creates=/obj/items/Explosives/High_Explosive_Grenade
//		Cost=3000000
//		Mod=4
	Basic_Chest
		Level=28
		Creates=/obj/items/storage/Basic_Chest
		Cost=10000000
//	Super_Anti_Virus
//		Level=75
//		Creates=/obj/items/drugs/Super_Anti_Virus
//		Cost=60000000
//		Mod=6
//	Cialis
//		Level=50
//		Creates=/obj/items/drugs/Cialis
//		Cost=2250000
//		Mod=3
//	Epinephrine
//		Level=25
//		Creates=/obj/items/drugs/Epinephrine
//		Cost=2000000
//		Mod=3
//	Morphine
//		Level=25
//		Creates=/obj/items/drugs/Morphine
//		Cost=1500000
//		Mod=2.5
//	Percocet
//		Level=20
//		Creates=/obj/items/drugs/Percocet
//		Cost=1250000
//		Mod=2.5
//	Vitamins
//		Level=13
//		Creates=/obj/items/drugs/Vitamins
//		Cost=300000
//		Mod=2
//	Methylphenidate
//		Level=15
//		Creates=/obj/items/drugs/Methylphenidate
//		Cost=750000
//		Mod=2
	Medical_Assessment
		Level=35
		Creates=/obj/items/Medical_Assessment
		Cost=600000
		Mod=2
	Security_Camera
		Level=37
		Creates=/obj/items/Security_Camera
		Cost=500000
	Hacking_Console
		Level=42
		Creates=/obj/items/Hacking_Console
		Cost=80000000
		Mod=3
	Antihacking_Circuitry
		Level=42
		Creates=/obj/items/Antihacking_Circuitry
		Cost=62500000
		Mod=2
	Transporter_Pad
		Level=43
		Creates=/obj/items/Transporter_Pad
		Cost=18750000
		Mod=2
	Stud_Finder
		Level=44
		Creates=/obj/items/Stud_Finder
		Cost=1125000
	Safe
		Level=47
		Creates=/obj/items/Safe
		Cost=10000000
	Android_Upgrade_Component
		Level=25
		Creates=/obj/items/Android_Upgrade
		Cost=6000000
		Mod=2
	Android_Chassis
		Level=25
		Creates=/obj/items/Android_Chassis
		Cost=10000000
		Mod=3
	Advanced_Door_Pass
		Level=55
		Creates=/obj/items/Advanced_Door_Pass
		Mod=4
		Cost=25000000
	Cloak
		Level=55
		Creates=/obj/items/Cloak
		Cost=75000000
	Cloak_Controls
		Level=55
		Creates=/obj/items/Cloak_Controls
		Cost=112500000
		Mod=3
	Gravity
		Level=60
		Creates=/obj/Tech/Stations/Gravity_Generator
		Cost=312500000
		Mod=3
	Healing_Pylon
		Level=61
		Creates=/obj/items/HealingPylon
		Cost=500000000
		Mod=4
	Moon
		Level=65
		Creates=/obj/items/Moon
		Cost=25000000
		Mod=3
	Pod
		Level=68
		Creates=/obj/Ships/Spacepod
		Cost=180000000
		Mod=3
	Elixir_Of_Empowerment
		Level=53
		Creates=/obj/items/Elixir_Of_Empowerment
		Cost=31250000
		Mod=2
	Genetic_Sequencer
		Level=75
		Creates=/obj/items/Genetic_Sequencer
		Cost=250000000
		Mod=4
	Teleportation_Watch
		Level=80
		Creates=/obj/items/Transporter_Watch
		Cost=200000000
		Mod=4
	Adamantine_Skeleton
		Level=90
		Creates=/obj/items/Adamantine_Skeleton
		Cost=400000000
		Mod=5
	PodMKIII
		Level=70
		Creates=/obj/Ships/SpacepodMKIII
		Cost=450000000
		Mod=4
	Mutagen_Injection
		Level=60
		Creates=/obj/items/Mutagen_Injection
		Cost=100000000
		Mod=5
	Self_Replicating_Code_Injector
		Level=65
		Creates=/obj/items/Self_Replicating_Code_Injector
		Cost=100000000
		Mod=5
	Power_Armor
		Level=65
		Creates=/obj/items/Power_Armor
		Cost=2500000000
		Mod=4
	Ship
		Level=85
		Mod=4
		Creates=/obj/Ships/Ship
		Cost=1000000000
	ShipMKII
		Level=85
		Creates=/obj/Ships/ShipMKII
		Cost=5000000000
		Mod=5
	ShipMKIII
		Level=85
		Creates=/obj/Ships/ShipMKIII
		Cost=10000000000
		Mod=5
//	Elixir_Of_Reformation
//		Level=25
//		Creates=/obj/items/Elixir_Of_Reformation
//		Cost=6000000
//		Mod=5

	Crafting_Station
		Level=10
		Creates=/obj/Tech/Stations/Crafting_Station
		Cost=10000000
		Mod=3