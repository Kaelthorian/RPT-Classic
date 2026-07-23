obj/items/rawfood
	icon='Food_Fish.dmi'
	Savable=0
	var
		ReqSkill=1
		GivesXP=200
		ResultingFood=null
	verb
		Cook()
			set src in view(1)
			var/HasBoost=0
			if(locate(/obj/items/How_To_Serve_Saiba) in usr) HasBoost=15
			if(usr.Cooking_Level+HasBoost>=ReqSkill)
				if(!usr.IsCooking)
					view(usr)<<"[usr] starts to cook [src]."
					usr.IsCooking=1
					var/CookSpeed=rand(300,600)
					if(locate(/obj/items/furnace/Advanced_Furnace) in view(2,usr)) CookSpeed-=400
					else if(locate(/obj/items/furnace/Basic_Stovetop) in oview(2,usr)) CookSpeed-=200
					if(usr.Cooking_Level+HasBoost>=10) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=25) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=40) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=50) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=60) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=70) CookSpeed*=0.9
					if(CookSpeed<5)CookSpeed=5
					spawn(CookSpeed) if(src&&usr&&usr.IsCooking)
						view(usr)<<"[usr] has finished cooking [src]."
						var/obj/items/cookedfood/A=new ResultingFood
						var/XPG=GivesXP
						usr.Cooking_XP+=XPG
						if(usr.HasLiberalArtsDegree)
							usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
							usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)

						usr.CookingLevelCheck()
						if(istype(A,/obj/items/cookedfood))usr.contents+=A
						else A.loc=usr.loc
						if(istype(A,/obj/items/cookedfood))
							A.GivesWPBoost*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesRegenBoost*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesRecovBoost*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesBPTrain*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesEnergyTrain*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesStatTrain*=usr.Cooking_Level+(usr.HasMasterChef*50)
//							A.icon-=rgb(50,50,50)
							A.icon= 'Foods.dmi'
							A.icon_state= "[rand(1,98)]"
							A.name= "Food"
						usr.IsCooking=0
						del(src)
				else usr<<"You may only cook one thing at a time."
			else usr<<"You require cooking level [ReqSkill] to cook this."
		Sell()
			var/tmp/SpamStop=0
			if(SpamStop==1)
				usr<<"Please wait to sell more"
				return
			SpamStop=1																										//Sellable update here
			switch(input(usr ,"What you want to sell it for?") in list("Mana","Resources","Cancel"))
				if("Resources")
					for(var/obj/Resources/M in usr)
						var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
						M.Value += Selling
						usr<<"You sell it for $[Selling] Resources."
						del(src)
						SpamStop=1
						sleep(20)
						SpamStop=0
				if("Mana")
					for(var/obj/Mana/M in usr)
						var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
						M.Value += Selling
						usr<<"You sell it for $[Selling] Mana."
						del(src)
						SpamStop=1
						sleep(20)
						SpamStop=0




	Small_Fish
		desc="This is a small, raw fish."
		icon='Fish small.dmi'
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Small_Fish
	Animal_Meat
		icon='Food Leg.dmi'
		desc="This is a raw animal meat."
		Flammable = 1
		ResultingFood=/obj/items/cookedfood/Cooked_Game_Meat
		ReqSkill=12
		GivesXP=1000

	Medium_Fish
		desc="This is a medium, raw fish."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Medium_Fish
		ReqSkill=10
		GivesXP=750
		icon='Fish medium.dmi'
	Large_Fish
		desc="This is a large, raw fish."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Large_Fish
		ReqSkill=25
		GivesXP=1500
		icon='Fish large.dmi'
	Magic_Fish
		desc="This is a magic, raw fish."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Magic_Fish
		ReqSkill=40
		GivesXP=5000
		icon='Magic Fish.dmi'
	Mana_Fish
		desc="This fish is worth some amount of mana once cooked."
		icon='Mana Fish.dmi'
		Flammable = 1

		ResultingFood=/obj/Mana/Mana_Crystal
		ReqSkill=15
		GivesXP=1000

	Gold_Fish
		desc="This is a worth some amount of resources once cooked."
		Flammable = 1

		ResultingFood=/obj/Resources/Treasure
		ReqSkill=15
		GivesXP=1000
		icon='Gold Fish.dmi'
		New()
			..()
			icon-=rgb(0,20,75)
			icon+=rgb(212,175,55)
	Baby_Shark
		desc="doo doo doo doo doo doo."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Baby_Shark
		ReqSkill=50
		GivesXP=5500
		New()
			src.icon+=rgb(30,50,40)
			..()
	Stat_Fish
		desc="This is a rare fish. It will grant a bonus to stat training."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Stat_Fish
		ReqSkill=30
		GivesXP=3000
		icon='Stat Fish.dmi'
	BP_Fish
		desc="This is a rare fish. It will grant a bonus to BP training."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_BP_Fish
		ReqSkill=30
		GivesXP=3000
		icon='Bp Fish.dmi'
	Energy_Fish
		desc="This is a rare fish. It will grant a bonus to energy training."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Energy_Fish
		ReqSkill=30
		GivesXP=3000
		New()
			src.icon+=rgb(0,0,90)
			..()
	Crab
		desc="This is a rare fish. It will grant a bonus to energy training."
		Flammable = 1
		icon='CRAB.dmi'
		ResultingFood=/obj/items/cookedfood/Chefs_Special
		ReqSkill=40
		GivesXP=6000

	Rare_Ingredients
		desc="This is a collection of rare ingredients. This will make a very special meal."
		Flammable = 1
		icon='CRAB.dmi'
		ResultingFood=/obj/items/cookedfood/Delicacy
		ReqSkill=50
		GivesXP=15000