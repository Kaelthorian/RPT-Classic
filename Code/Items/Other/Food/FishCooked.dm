obj/items/cookedfood
	icon='Food_Fish.dmi'
	Savable=0
	var
		GivesWPBoost=0
		GivesRegenBoost=0
		GivesRecovBoost=0
		GivesCapStats=0
		GivesBPTrain=0
		GivesEnergyTrain=0
		GivesStatTrain=0
	verb
		Eat()
			for(var/BodyPart/Throat/A in usr)
				if(A.Status == "Broken"||A.Status =="Missing"||A.Status =="Maimed")
					usr<<"You can't eat with your throat like that!"
					return
			if(usr.KOd==0) //if(usr.Race!="Android")
				usr.HasFoodWP=GivesWPBoost
				usr.HasFoodRegen=GivesRegenBoost
				usr.HasFoodRecov=GivesRecovBoost
				usr.HasFoodBPTrain=GivesBPTrain
				usr.HasFoodStatsTrain=GivesStatTrain
				usr.HasFoodEnergyTrain=GivesEnergyTrain
				if(GivesCapStats)
					usr.CapStats()
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
				view(usr)<<"[usr] eats a [src]."
				del(src)
	Cooked_Small_Fish
		desc="This is a small, cooked fish. This will grant a small regeneration bonus for a period of time."
		Flammable = 1

		GivesWPBoost=0
		GivesRegenBoost=20
		GivesRecovBoost=0
		icon='Fish small.dmi'
	Cooked_Game_Meat
		desc="This is a cooked animal meat. This will grant a small regeneration and recovery bonus for a period of time."
		Flammable = 1
		icon='Food Leg.dmi'
		GivesWPBoost=0
		GivesRegenBoost=40
		GivesRecovBoost=40
	Cooked_Medium_Fish
		desc="This is a medium, cooked fish. This will grant a small regeneration and recovery bonus for a period of time."
		Flammable = 1

		GivesWPBoost=0
		GivesRegenBoost=40
		GivesRecovBoost=40
		icon='Fish medium.dmi'
	Cooked_Large_Fish
		desc="This is a large, cooked fish. This will grant a small regeneration, recovery and willpower regeneration bonus for a period of time."
		Flammable = 1

		GivesWPBoost=60
		GivesRegenBoost=60
		GivesRecovBoost=60
		icon='Fish large.dmi'
	Cooked_Magic_Fish
		desc="This is a magic, cooked fish. This will grant a small regeneration, recovery and willpower regeneration bonus for a period of time. This will also cap all of your stats."
		Flammable = 1

		GivesWPBoost=60
		GivesRegenBoost=60
		GivesRecovBoost=60
		GivesCapStats=1
		icon='Magic Fish.dmi'
	Cooked_Baby_Shark
		desc="doo doo doo doo doo doo."
		Flammable = 1

		GivesWPBoost=80
		GivesRegenBoost=80
		GivesRecovBoost=80
		New()
			src.icon+=rgb(20,40,20)
			..()
	Chefs_Special
		desc="The chef made this just for you."
		Flammable = 1
		icon='Tiny_Crab.dmi'
		GivesWPBoost=85
		GivesRegenBoost=85
		GivesRecovBoost=85
		verb/Change_Recipe()
			set src in usr
			desc=input("Change the description of this.") as text
			usr<<"desc set to [desc]"




	Cooked_Stat_Fish
		desc="This is a rare fish. It will grant a bonus to stat training."
		Flammable = 1

		GivesWPBoost=30
		GivesRegenBoost=30
		GivesRecovBoost=30
		GivesStatTrain=30
		icon='Stat Fish.dmi'
	Cooked_BP_Fish
		desc="This is a rare fish. It will grant a bonus to BP training."
		Flammable = 1

		GivesWPBoost=30
		GivesRegenBoost=30
		GivesRecovBoost=30
		GivesBPTrain=30
		icon='Bp Fish.dmi'
	Cooked_Energy_Fish
		desc="This is a rare fish. It will grant a bonus to energy training."
		Flammable = 1

		GivesWPBoost=10
		GivesRegenBoost=30
		GivesRecovBoost=30
		GivesEnergyTrain=30
		New()
			src.icon+=rgb(0,0,90)
			..()

	Delicacy
		desc="This is a very special meal. It provides every food buff available."
		Flammable = 1

		icon='FoodTurkey.dmi'
		GivesWPBoost=30
		GivesRegenBoost=30
		GivesRecovBoost=30
		GivesCapStats=1
		GivesBPTrain=30
		GivesEnergyTrain=30
		GivesStatTrain=30

	Cheese
		desc="This some cheese. Just cheese, nothing else."
		Flammable = 1

		icon='cheese.dmi'
		GivesWPBoost=500
		GivesRegenBoost=500
		GivesRecovBoost=500
		GivesCapStats=1
		GivesBPTrain=500
		GivesEnergyTrain=500
		GivesStatTrain=500