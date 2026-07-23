obj/items/Cloak
	icon='Cloak.dmi'
	desc="You can install this on any object to cloak it using cloak controls. First you must set the \
	password so that it matches the password of your cloak controls or it cannot be activated by those \
	controls."
	verb/Set() Password=input("Set the password for this cloak") as text
	verb/Use()
		if(!Password)
			usr<<"You must Set it first"
			return
		for(var/obj/A in get_step(usr,usr.dir))
			for(var/X in NoCloak)
				if(A.type == X)
					usr << "Unable to bend light around this item using a cloaking device....how strange..."
					return
			view(usr)<<"[usr] installs a cloaking system onto the [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] installs a cloaking system onto [A].\n")
			A.contents+=src