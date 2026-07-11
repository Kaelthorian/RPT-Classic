obj/items/Farming/var/SeedCategory
obj/Farming/Crops/var/CropCategory
mob/var/tmp/LookingForSeeds

turf/Terrain/Grass
	verb
		Look_for_seeds()
			set src in view(1)
			if(usr.LookingForSeeds)
				usr<<"You are already doing that."
				return
			if(!usr.KOd)
				usr.LookingForSeeds++
				view(usr)<<"[usr] begins to look for some seeds."
				var/R=rand(600,1200)
				sleep(R)
				if(!usr.LookingForSeeds)
					return
				view(usr)<<"[usr] found some seeds!"
				var/obj/items/Farming/Packet_of_Seeds/S=new
				var/Seed		=pick("potato","corn","wheat","carrot")
				S.icon			='seeds.dmi'
				S.icon_state	="[Seed]"
				S.loc			=usr.loc
				S.SeedCategory	="[Seed]"
				S.desc			="A packet of [S.SeedCategory] seeds! plant them to grow them"
				usr.LookingForSeeds--

obj/items/Farming/Packet_of_Seeds
	icon		='seeds.dmi'
	icon_state	="banana"
	verb/Plant()
		set src in view(1)
		if(locate(/obj/Farming/Crops) in get_step(src,0))
			usr<<"You can't plant here."
			return
		view(usr)<<"[usr] plant some seeds of [SeedCategory]"
		var/obj/Farming/Crops/S	=new
		S.loc					=usr.loc
		S.CropCategory			=SeedCategory
		S.name					=SeedCategory
		DeleteSaveItem(src)
		del(src)


obj/Farming/Crops
	icon		='Growing.dmi'
	icon_state	="Soil"
	desc		="Crops , water them to make them grow and harvest them when they are ready for some food."
	Bolted=1
	Savable=1
	var/Growing
	var/Harvest
	verb/Water_it()
		set src in view(1)

		if(Growing)
			src<<"Already have water!"
			return
		Growing++
		view(usr)<<"[usr] waters the [src]"
		sleep(rand(1000,2500))
		icon_state	="[CropCategory]-grow1"
		sleep(rand(1000,2500))
		icon_state	="[CropCategory]-grow2"
		sleep(rand(1000,2500))
		icon_state	="[CropCategory]-grow3"
		sleep(rand(1000,2500))
		density=1
		icon_state	="[CropCategory]-grow4"
		sleep(rand(1000,2500))
		icon_state	="[CropCategory]-grow5"
		sleep(rand(1000,2500))
		icon_state	="[CropCategory]-grow6"
		sleep(rand(1000,2500))
		icon_state	="[CropCategory]-harvest"
		Harvest=1

	verb/Harvest()
		set src in view(1)
		if(!Harvest)
			src<<"Is not ready!"
			return
		if(Harvest)
//			var/SeedR=rand(0,2)
			var/obj/items/Farming/FarmingFood/S=new
			S.icon			='harvest.dmi'
			S.icon_state	="[CropCategory]"
			S.loc			=usr.loc
			S.name			="[CropCategory]"
			S.SeedCategory	="[CropCategory]"
			S.desc			="A [S.SeedCategory] , it looks tasty."

//			while(SeedR>0)
//				var/obj/items/Farming/Packet_of_Seeds/A=new
//				A.loc=usr.loc
//				A.icon			='seeds.dmi'
//				A.icon_state	="[CropCategory]"
//				A.name			="Packet of [CropCategory]"
//				A.desc			="A packet of [S.SeedCategory] seeds! plant them to grow them"
//				SeedR--
			DeleteSaveItem(src)
			del(src)
		view(usr)<<"[usr] harvest the [src]"


obj/items/Farming/FarmingFood
	icon				='Harvest.dmi'
	icon_state			="wheat"
	var/GivesRegenBoost	=1000
	var/GivesWPBoost	=1000

	verb/
		Eat()
			for(var/BodyPart/Throat/A in usr)
				if(A.Status == "Broken"||A.Status =="Missing"||A.Status =="Maimed")
					usr<<"You can't eat with your throat like that!"
					return
			if(usr.KOd==0) //if(usr.Race!="Android")
				usr.HasFoodWP=GivesWPBoost
				usr.HasFoodRegen=GivesRegenBoost
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
				view(usr)<<"[usr] eats a [src]."
				del(src)
			DeleteSaveItem(src)
		Sell()
			var/tmp/SpamStop=0
			if(SpamStop==1)
				usr<<"Please wait to sell more"
				return
			switch(input(usr ,"What you want to sell it for?") in list("Mana","Resources","Cancel"))
				if("Resources")
					for(var/obj/Resources/M in usr)
						var/tmp/Selling=rand(1000,3000)*max(1,Year)/20
						M.Value += Selling
						usr<<"You sell it for $[Selling] Resources."
						del(src)
						SpamStop=1
						sleep(20)
						SpamStop=0
						DeleteSaveItem(src)
				if("Mana")
					for(var/obj/Mana/M in usr)
						var/tmp/Selling=rand(1000,3000)*max(1,Year)/20
						M.Value += Selling
						usr<<"You sell it for $[Selling] Mana."
						del(src)
						SpamStop=1
						sleep(20)
						SpamStop=0
						DeleteSaveItem(src)