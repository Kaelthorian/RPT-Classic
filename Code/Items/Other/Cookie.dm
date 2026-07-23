obj/items
	Cookie
		icon='Cookie.dmi'
		desc="This is a delicious looking cookie. You feel as though eating it would give you quite the energy rush."
		verb/Eat()
			set src in usr
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
			view(usr)<<"[usr] eats a [src]!"
			usr<<"You feel well rested and full of energy!"
			del(src)