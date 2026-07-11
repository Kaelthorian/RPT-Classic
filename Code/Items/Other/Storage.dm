obj/items/storage
	var/MaxContents=8
	desc="This will allow you to store items inside, but it can not be moved once placed."
	Health=100000
	Grabbable=0
	Bolted=1
	Flammable = 1
	density=1
	verb/Store()
		set src in oview(1)
		if(contents.len<MaxContents)
			var/list/Items=new
			for(var/obj/items/K in usr) Items+=K
			Items+="Cancel"
			var/obj/items/C=input("Store what from your inventory? (Can hold [MaxContents] total items)") in Items
			if(istype(C,/obj/items/Magic_Ball))
				usr<<"You can not store this."
				return
			if(istype(C,/obj/items/Artifact))
				usr<<"You can not store this."
				return
			if(C=="Cancel") return
			if(usr.Confirm("Store [C] in [src]?"))
				src.contents+=C
				view(usr)<<"[usr] stored [C] in [src]."
		else usr<<"It is already full."
		SaveItemATOM(src)
	verb/Withdraw()
		set src in oview(1)
		var/list/Items=new
		for(var/obj/K in src.contents) Items+=K
		Items+="Cancel"
		var/obj/items/C=input("Withdraw what from [src]?") in Items
		if(C=="Cancel") return
		if(usr.Confirm("Withdraw [C]?"))
			usr.contents+=C
//			usr.InventoryCheck()
			view(usr)<<"[usr] took [C] out of the [src]."
		SaveItemATOM(src)

	Del()
		for(var/obj/I in contents) I.loc=src.loc
		..()
	Basic_Chest
		icon='Normal Chest.dmi'
		MaxContents=8
	Copper_Chest
		icon='Chest Copper.dmi'
		MaxContents=9
		Flammable = 0
	Bronze_Chest
		icon='Chest Bronze.dmi'
		MaxContents=10
		Flammable = 0
	Iron_Chest
		icon='Chest Iron.dmi'
		MaxContents=12
		Flammable = 0
	Mythril_Chest
		icon='Chest Mytril.dmi'
		MaxContents=15
		Flammable = 0
	Masterwork_Chest
		icon='Chest MasterWork.dmi'
		MaxContents=25
		Flammable = 0