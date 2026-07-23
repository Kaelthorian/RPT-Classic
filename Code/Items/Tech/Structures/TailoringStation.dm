obj/Tech/Stations/Crafting_Station
	desc="This station allow you to craft items."
	Health=100
	density=1
	Savable=1
	Grabbable = 1
	Bolted = 0
	layer = 2
	pixel_x=-16
	icon='CraftStation1.dmi'

	verb/Make_Weights()
		set src in oview(1)
		set category="Station"

		if(!usr.Int_Mod>3)
			usr<<"You don't understand how the machine works"
			return
		var/Weights=input("How heavy?(Costs 100000 resources per pound.)") as num
		if(Weights>usr.MaxKi*usr.KiMod) Weights=usr.MaxKi*usr.KiMod
		if(Weights<1) Weights=1
		Weights=round(Weights)
		var/Cost=(100000)*Weights*(1-(0.15*usr.HasDeepPockets))/usr.Int_Mod
		var/obj/Resources/AA
		for(var/obj/Resources/B in usr) AA=B
		if(AA.Value<Cost)
			usr<<"You do not have enough resources."
			return
		AA.Value-=Cost
		var/obj/items/Weights/A=new(usr.loc)
		A.Weight=round(Weights)
		A.name="[round(A.Weight)]lb Weights"
		var/style=pick("Cape","Shirt","Wristbands","Scarf","Turban")
		switch(style)
			if("Cape") A.icon='Clothes_Cape.dmi'
			if("Shirt") A.icon='Clothes_ShortSleeveShirt.dmi'
			if("Wristbands") A.icon='Clothes_Wristband.dmi'
			if("Scarf") A.icon='Clothes_NamekianScarf.dmi'
			if("Turban") A.icon='Clothes_Turban.dmi'
		var/RGB=input("") as color|null
		if(RGB) A.icon+=RGB
		hearers(10,usr) << sound('Pop.wav',volume=20)

	verb/Lift_Test()
		set src in oview(1)
		set category="Station"

		if(!usr.Int_Mod>3)
			usr<<"You don't understand how the machine works"
			return

		var/mob/A=input(usr,"Choose someone to test their lift.") as mob in oviewers(2)

		usr<<"...Scanning..."

		sleep(10)

		if(prob(10))
			usr<<"ERROR , DO NOT MOVE"
			sleep(10)

		A<<"[A.name] can lift [round(A.BPMod*A.Base)] pounds."
		usr<<"[A.name] can lift [round(A.BPMod*A.Base)] pounds."