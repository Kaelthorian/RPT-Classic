obj/items/Self_Replicating_Code_Injector
	icon='enchantmenticons.dmi'
	icon_state="BPEND"
	Level=1

	desc="This will give an Android a mutation. They can only have one."
	verb/Use()
		if(usr.MutationNumber<2)
			if(usr.Race!="Android")
				usr<<"Only an Android can use this."
				return
			view(usr)<<"[usr] injects themselves with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses a [src]!\n")
			usr.GetMutation()
			del(src)
		else usr<<"You already have mutations."