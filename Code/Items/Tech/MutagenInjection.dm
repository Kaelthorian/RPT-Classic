obj/items/Mutagen_Injection
	icon='Roids.dmi'
	icon_state="2"
	Level=1

	desc="This will inject a mutation into someone that has less than two mutations already."
	verb/Use()
		if(usr.MutationNumber<2)
			if(usr.Race=="Android")
				usr<<"You can not use this on an Android."
				return
			view(usr)<<"[usr] injects themselves with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses a Mutagen Injection!\n")
			usr.GetMutation()
			del(src)
		else usr<<"You already have mutations."