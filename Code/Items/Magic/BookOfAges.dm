obj/items/Book_of_Ages
	icon='enchantmenticons.dmi'
	icon_state="BoG"
	desc="It is said that reading this book will alter your perception of time and age you rapidly. Others say reading it will drive you mad. (One time use that grants +5 Age and +1 Milestone Point)"
	Flammable = 1

	verb
		Use()
			if(!usr.HasUsedBookOfAges)
				usr.HasUsedBookOfAges=1
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				usr.Age+=5
				usr.Hair_Age+=5
				usr.MilestonePoints++
				//usr.TotalMilestonePoints++
//				usr.UpdateStats("Milestone Points")
				del(src)
			else usr<<"It would have no effect on you."