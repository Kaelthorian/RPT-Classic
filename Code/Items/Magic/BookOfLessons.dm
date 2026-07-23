obj/items/Book_of_Lessons
	icon='enchantmenticons.dmi'
	icon_state="BoTT"
	desc="It is said that reading this book will assist you with growing stronger by learning of the great lessons of the past. (One time use. Increases stats, bp and energy gains for 1 year.)"
	Flammable = 1

	verb
		Use()
			if(!usr.HasUsedBookOfLessons)
				usr.HasUsedBookOfLessons=Year
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				del(src)
			else usr<<"It would have no effect on you."