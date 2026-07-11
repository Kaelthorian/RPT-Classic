obj/items/Elixir_Of_Replenishment
	icon='enchantmenticons.dmi'
	icon_state="BPRES+"
	desc="Drinking this will temporarily speed up your Willpower recovery outside of combat and make your Lethal Combat Tracker go down quicker.  Be careful though, you can build up a resistance."
	Flammable = 1

	verb
		Use()
			if(usr.KOd==0)// if(usr.Race!="Android")
				usr.HasUsedReplenish++
				usr.TicksOfReplenish+=500/max(1,usr.HasUsedReplenish/10)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				del(src)