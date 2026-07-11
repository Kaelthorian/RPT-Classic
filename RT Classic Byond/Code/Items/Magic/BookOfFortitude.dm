obj/items/Book_of_Fortitude
	icon='enchantmenticons.dmi'
	icon_state="BoEW"
	desc="It is said that reading this book will increase your resistance to damage for a period of time due to its otherworldly accounts of torture and suffering. (One time use, grants extra endurance/damage reduction.)"
	Flammable = 1

	verb
		Use()
			if(!usr.HasUsedBookOfFortitude)
				usr.HasUsedBookOfFortitude=Year
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				del(src)
			else usr<<"It would have no effect on you."