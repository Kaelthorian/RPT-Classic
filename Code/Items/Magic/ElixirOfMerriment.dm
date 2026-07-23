obj/items/Elixir_Of_Merriment
	icon='enchantmenticons.dmi'
	icon_state="BPRES+"
	New()
		..()
		icon+=rgb(25,25,25)
	desc="Drinking this will temporarily speed up your Contact Points. It is customarily alcholic. Be careful though, you can build up a resistance."
	Flammable = 1

	verb
		Use()
			if(usr.KOd==0) if(usr.Race!="Android")
				usr.TicksOfMerriment+=500
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				del(src)