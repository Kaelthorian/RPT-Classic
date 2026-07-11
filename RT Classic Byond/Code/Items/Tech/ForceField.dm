obj/items/Force_Field
	desc="Holding this will protect you against energy attacks by having a 70% chance to reduce the damage by 30%. Each shot it shields drains the battery and requires battery to work."
	icon='Lab.dmi'
	icon_state="Computer 1"

	verb/Upgrade()
		set src in oview(1,usr)
		if(Level>10000000)
			usr<<"Item is already beyond its capacity."
			return
		var/Amount=input("How many resources do you want to put into its battery?") as num
		if(Amount<1) return
		for(var/obj/Resources/A in usr)
			if(Amount>10000000) Amount=10000000
			if(Amount>A.Value) Amount=A.Value
			Amount=round(Amount)
			src.cost += Amount
			A.Value-=Amount
			//var/Extra = 1 + Year //Helps make force fields stronger as years go by.
			Level+=Amount*usr.Int_Mod
			if(Level>65000000) Level=65000000
			view(usr)<<"[usr] adds [Commas(Amount*usr.Int_Mod)] to the [src]'s battery"
			desc=initial(desc)+"<br>[Commas(Level)] Battery Remaining"
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds to the [Commas(Amount*usr.Int_Mod)] [src]'s battery.\n")

mob/proc/Force_Field() spawn if(src)
	var/A='Force Field.dmi'
	A+=rgb(100,200,250,120)
	overlays-=A
	overlays+=A
	spawn(50) overlays-=A