obj/items/Magic_Circle
	icon='Magic_Circle_Pulse.dmi'
	icon_state = null
	Grabbable = 1
//	Bolted = 1
	Savable = 1
	layer = 2
	desc="This is a magical creation of sorts, able to bolster the amount of ambient mana absorbed into yourself when held in your inventory."
	verb
		Relocate()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				Bolted=1
				range(20,src)<<"[usr] secures the [src] to the ground."

				return
			if(Bolted) if(src.Builder=="[usr.real_name]")
				range(20,src)<<"[usr] moves the [src] from the ground."
				Bolted=0

				return
		Remove()
			set src in range(1,usr)
			if(src.Builder=="[usr.real_name]")
				switch(input("Are you sure you want to remove this circle?") in list("No","Yes"))
					if("Yes")
						if(usr in range(1,src))
							range(20,src) << "[usr] removes their [src]."
							for(var/mob/M in range(20,src))
								if(M.client)
									M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removed their circle [src].\n")
							del(src)
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

		/*Destroy()
			set category=null
			if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(src in usr) del src*/