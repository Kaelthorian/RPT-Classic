obj/items/Elixir_Of_Life
	icon='enchantmenticons.dmi'
	icon_state="PoM1"
	Level=1

	desc="This extends life by 25 years."
	verb/Use(mob/A in view(1,usr))
		if(A.Race=="Android")
			usr<<"You can not use this on an Android."
			return
		if(A==usr|A.Frozen|A.KOd)
			view(usr)<<"[usr] Gives [A] a mysterious elixir!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Elixer of Life!\n")
			A.Decline+=25
			A.Ki=10
			del(src)