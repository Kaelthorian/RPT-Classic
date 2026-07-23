obj/Magic
	var/displaykey
	var/Creates
	var/Cost=0
	var/Mod=1
	Level=1
	verb
		Inspect()
			set src in world
			set name = "Inspect"
			//set category = "Other"
			if(src.Creates)
				var/obj/A=new src.Creates
				usr << A.desc
				del(A)
	Click()
		if(usr.Creating)
			usr<<"You may only make one thing at a time."
			return
		if(!usr.Confirm("Create [src]?")) return
		for(var/obj/Mana/B in usr)
			if(usr.Creating)
				usr<<"You may only make one thing at a time."
				return
			var/Amount=0
			for(var/obj/O in range(0,usr)) if(!(locate(O) in usr)) Amount++
			if(global.rebooting)
				usr << "Unable to make any new technology while a reboot is in progress."
				return
			for(var/area/UndergroundMine/W in view(3,usr))
				usr<<"You cannot do that here."
				return
			if(Amount>=20)
				usr<<"Nothing more can be placed on this spot."
				return
			if(B.Value < round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))
				usr<<"You do not have the mana to create this."
				return
			if(istype(src,/obj/Magic/Mana_Pylon))
				var/NumP=0
				for(var/obj/Mana_Pylon/MP) if(MP.Builder=="[usr.real_name]") NumP++
				if(NumP>=1)
					usr<<"You already have too many Pylons. ([NumP] is the tolta you can have)"
					return
			if(istype(src,/obj/Magic/Mana_Pylon))
				usr<<"Remember to bolt this item!"
			usr.Creating=1
			usr.AllOut("Crafting time for [src] is [((1*Level)/usr.Magic_Potential)/10] seconds.")
			spawn((1*Level)/usr.Magic_Potential)
				if(!usr.Creating)return
				B.Value -= round((initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))
				var/obj/A=new Creates
				A.cost= round((initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))
				if(istype(A,/obj/items/Armor))
					var/x=input(usr,"Choose the icon for [src]") in list("Armor 1","Bardock","Green","Black","Armor 2","Armor 3","Armor 4","Armor 5","Armor 6", "Armor 7", "Armor 8")
					switch(x)
						if("Armor 1")src.icon='Armor1.dmi'
						if("Bardock")src.icon='BardockArmor.dmi'
						if("Black")src.icon='TurlesArmor.dmi'
						if("Green")src.icon='Nappa Armor.dmi'
						if("Armor 2")src.icon='Armor2.dmi'
						if("Armor 3")src.icon='Armor3.dmi'
						if("Armor 4")src.icon='Armor4.dmi'
						if("Armor 5")src.icon='Armor5.dmi'
						if("Armor 6")src.icon='Armor6.dmi'
						if("Armor 7")src.icon='Armor7.dmi'
						if("Armor 8")src.icon='White Male Armor.dmi'

				if(istype(A,/obj/items/Sword))
					var/x=input(usr,"Choose the icon for [src]") in list("Trunks","Knight","Demon","Katana","Random","Short","Rebellion","Buster","Great", "Flame", "Samurai")
					switch(x)
						if("Trunks") src.icon='Sword_Trunks.dmi'
						if("Knight") src.icon='Sword 2.dmi'
						if("Demon") src.icon='Sword 1.dmi'
						if("Katana") src.icon='Item - Katana 2.dmi'
						if("Random") src.icon='Item - Katana.dmi'
						if("Short") src.icon='Short Sword.dmi'
						if("Rebellion") src.icon='Item, Sword 1.dmi'
						if("Buster") src.icon='Item, Buster Sword.dmi'
						if("Great") src.icon='Item, Great Sword.dmi'
						if("Flame") src.icon='Sword Flame.dmi'
						if("Samurai") src.icon='Sword, Samurai.dmi'

				if(A)
					view(20,usr) << "[usr] creates a [A]."
					A.loc=usr.loc
					A.Builder="[usr.real_name]"
					usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name] ([A])")
					A.SaveItem(A)
					global.worldObjectList+=A


				else
					B.Value += round(initial(Cost)/usr.Magic_Potential)
					usr<<"There are no more available ship interiors, you cannot create this."
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
				if(istype(A,/obj/items/Enchanted_Doll))
					A.Builder="[usr.real_name]"
					usr.MadeADoll++
					var/N=input(usr,"Enter a name.") as text
					if(!N)
						var/X = rand(100,900)
						A.name = "[X]"
					else A.name=N
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Spirit Doll",null) as text
				usr.Creating=0

	New()
		if(Creates)
			var/obj/A=new Creates
			if(A)
				icon=A.icon
				icon_state=A.icon_state
				del(A)
		else del(src)

//	Magic_Goo
//		Level=3
//		Creates=/obj/TrainingEq/Magic_Goo
//		Cost=4000
	Boxing_Gloves
		Level=4
		Creates=/obj/items/Boxing_Gloves
		Cost=1000
	Armor
		Level=5
		Creates=/obj/items/Armor/Normal_Armor
		Cost=625000
	Sword
		Level=6
		Creates=/obj/items/Sword/Normal_Sword
		Cost=1250000
	Magic_Gauntlets
		Level=6
		Creates=/obj/items/Gauntlets/Normal_Gauntlets
		Cost=1250000
	Door_Pass
		Level=9
		Creates=/obj/items/Door_Pass
		Cost=3000
	Magic_Hammer
		Level=9
		Creates=/obj/items/Hammer/Normal_Hammer
		Cost=1250000
	Mana_Pylon
		Level=10
		Creates=/obj/Mana_Pylon
		Cost=375000
		Mod=3
	Spell_Book
		Level=10
		Creates=/obj/items/Spell_Book
		Cost=50000
	Utility_Belt
		Level=14
		Creates=/obj/items/Utility_Belt/Normal_Utility_Belt
		Cost=625000
		Mod=1.5
	Book_Case
		Level=15
		Creates=/obj/items/Bookcase
		Cost=2000000
	Magic_Door
		Level=18
		Creates=/obj/Door/Lockable/Magic_Door
		Cost=400000
	Magic_Circle
		Level=18
		Creates=/obj/items/Magic_Circle
		Cost=250000
	Simulation_Crystal
		Level=27
		Creates=/obj/items/Simulation_Crystal
		Cost=10000000
		Mod=2
	Magic_Scanner
		Level=28
		Creates=/obj/items/Magic_Scanner
		Cost=1000000
	Basic_Stovetop
		Level=30
		Creates=/obj/items/furnace/Basic_Stovetop
		Cost=3320000
	Locator
		Level=35
		Creates=/obj/items/Locator
		Cost=2500000
		Mod=2
	Disguise
		Level=53
		Creates=/obj/items/Disguise
		Cost=62500000
		Mod=3
	Stone_Of_Understanding
		Level=32
		Creates=/obj/items/Stone_Of_Understanding
		Cost=35000000
		Mod=2
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
	Repair_Kit
		Level=19
		Creates=/obj/items/Repair_Kit
		Cost=800000
	Orb_Of_Mastery
		Level=25
		Creates=/obj/items/Orb_Of_Mastery
		Cost=3750000
		Mod=2
	Cooking_Bag
		Level=35
		Creates=/obj/items/Cooking_Bag
		Cost=8500000
		Mod=2
	Enchanted_Doll
		Level=25
		Creates=/obj/items/Enchanted_Doll
		Cost=4000000
		Mod=3
	Elixir_Of_Health
		Level=45
		Creates=/obj/items/Elixir_Of_Health
		Cost=1250000
		Mod=2
	Upgrade_Kit
		Level=69
		Creates=/obj/items/Upgrade_Kit
		Cost=1000000
		Mod=2
	Magic_Vault
		Level=47
		Creates=/obj/items/Magic_Vault
		Cost=10000000
	Elixir_Of_Life
		Level=55
		Creates=/obj/items/Elixir_Of_Life
		Cost=75000000
		Mod=3
	Elixir_of_Empowerment
		Level=53
		Creates=/obj/items/Elixir_Of_Empowerment
		Cost=31250000
		Mod=2
	Elixir_Of_Replenishment
		Level=58
		Creates=/obj/items/Elixir_Of_Replenishment
		Cost=6250000
		Mod=2

	Elixir_Of_Merriment
		Level=38
		Creates=/obj/items/Elixir_Of_Merriment
		Cost=150000
		Mod=2
	Crystal_Ball
		Level=90
		Creates=/obj/items/Crystal_Ball
		Cost=550000000
		Mod=4
	Book_of_Lessons
		Level=93
		Creates=/obj/items/Book_of_Lessons
		Cost=300000000
		Mod=3
	Book_of_Fortitude
		Level=96
		Creates=/obj/items/Book_of_Fortitude
		Cost=500000000
		Mod=4
	Book_of_Ages
		Level=100
		Creates=/obj/items/Book_of_Ages
		Cost=950000000
		Mod=5
	Book_of_Power
		Level=107
		Creates=/obj/items/Book_of_Power
		Cost=1000000000
		Mod=5
//	Elixir_Of_Reformation
//		Level=25
//		Creates=/obj/items/Elixir_Of_Reformation
//		Cost=6000000
//		Mod=5