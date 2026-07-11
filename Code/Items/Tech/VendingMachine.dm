obj/Vending_Machine
	icon='Vending_machine.dmi'
	pixel_x=-18
	var/MaxContents=8
	desc="This will allow you to store items inside and then sell them at a given price."
	Health=50000
	Savable=1
	density=1
	var/SafeResources = 0
	verb/Sell_Item()
		set src in oview(1)
		var/passwd = input ("What is this [src]'s password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
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
					C.SellingPrice=input("Sell this [C] for how many resources?") as num
					if(C.SellingPrice<1) C.SellingPrice=1
					view(usr)<<"[usr] stored [C] in [src]."
			else usr<<"It is already full."
	verb/Withdraw_Item()
		set src in oview(1)
		var/passwd = input ("What is this [src]'s password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/list/Items=new
			for(var/obj/K in src.contents) Items+=K
			Items+="Cancel"
			var/obj/items/C=input("Withdraw what from [src]?") in Items
			if(C=="Cancel") return
			if(usr.Confirm("Withdraw [C]?"))
				usr.contents+=C
//				usr.InventoryCheck()
				view(usr)<<"[usr] took [C] out of the [src]."
	verb/Purchase_Item()
		set src in oview(1)
		var/list/Items=new
		for(var/obj/K in src.contents) Items+=K
		Items+="Cancel"
		var/obj/items/C=input("Purchase what from [src]?") in Items
		if(C=="Cancel") return
		if(usr.Confirm("Purchase [C] for [C.SellingPrice] resources?"))

			var/Cost = C.SellingPrice
			for(var/obj/Resources/RR in usr)
				if(RR.Value >= Cost)
					RR.Value-=Cost
					SafeResources+=Cost
					usr.contents+=C
//					usr.InventoryCheck()
					view(usr)<<"[usr] bought [C] out of the [src] for [Cost] resources."
				else
					usr << "You do not have [Commas(Cost)] resources to spare in order to buy [C]."
					return
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."
			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1
		SaveItemATOM(src)

	verb/Set_Password()
		set src in oview(1)
		if(Password == null)
			Password = input("Entering a password will help keep this [src] private.") as text
			usr << "Password set!"
			return
		else
			usr << "The password has already been set!"
			return
		SaveItemATOM(src)

	verb/Withdraw_Resources()
		set src in view(1)
		var/passwd = input("What is this [src]'s password?")
		if(SafeResources <= 0)
			SafeResources = 0
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/getRSC = input("How many resources would you like to withdraw from [src]?") as num
			if(getRSC < 1) return
			getRSC=round(getRSC)
			if(getRSC > SafeResources)getRSC=SafeResources
			for(var/obj/Resources/A in usr)
				A.Value       += getRSC
				SafeResources -= getRSC
				usr<<"You withdrew [getRSC] resources."
		SaveItemATOM(src)

	verb/Check_Resources()
		set src in view(1)
		if(SafeResources <= 0)
			SafeResources = 0
		var/passwd = input ("What is this [src]'s password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			usr << "You have [Commas(SafeResources)] in the [src]."
			return
		SaveItemATOM(src)
	verb/Upgrade()
		set src in view(1)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			Health=50000*Level
			usr<<"Upgraded [src] to security level [Level]. Health [Health]"
		SaveItemATOM(src)
	Del()
		for(var/obj/I in contents) I.loc=src.loc
		var/obj/Resources/A=new
		A.loc=src.loc
		A.Value=SafeResources
		A.name="[Commas(A.Value)] Resources"
		..()