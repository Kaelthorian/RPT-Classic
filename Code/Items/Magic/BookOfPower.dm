obj/items/Book_of_Power
	icon='enchantmenticons.dmi'
	icon_state="BoTW"
	desc="It is said that reading this book help you achieve greatness. (One time use, grants 5% BP Mod and 20% Base BP)"
	Flammable = 1

	verb
		Use()
			if(!usr.PotentialUnlocked)
				usr.PotentialUnlocked=3
				usr.BPMod*=1.05
				usr.Base*=1.05
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				logAndAlertAdmins("[key_name(usr)] used a [src]",2)
				del(src)
			else usr<<"It would have no effect on you."