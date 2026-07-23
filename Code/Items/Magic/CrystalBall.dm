obj/items
	Crystal_Ball
		icon='Magic Items.dmi'
		icon_state = "crystal ball"
		Health=100

		New()
			desc="<br>Clicking this will let you observe people....for a time...for a cost.."

		Click()
			if(src in usr.client.screen)
				for(var/mob/player/M in Players) if(M.Observer==usr.key) M.Observer=null
				usr.client.screen.Remove(src)
				usr.client.eye=usr
				usr << "View returned to normal."
				return
		verb/Watch_Someone(var/obj/Contact/X in usr.Contacts)
			set src in view(1)
			if(src.Special_Ball)
				view(6,usr) << "[usr] activates their crystal ball..."
				var/list/P = list()
				for(var/mob/M in Players) if(M.z == 1|M.z==16|M.z==11&&M.y<=320)
					P += M
				var/mob/O=input(usr,"Choose someone to observe.") as mob in P
				usr << "You are now watching [O] through your crystal ball."
				usr.Get_Observe(O)
				src.screen_loc = "1,1"
				usr.client.screen.Add(src)
				return
			else if(usr.Magic_Level >= 55&&usr.Magic_Potential>=3)
				if(src.Health < 100000)
					usr << "The crystal ball must have at least 100,000 mana to work!"
					return
				if(src.Health >= 100000)
					var/mob/A = null
					for(var/mob/M in Players)
						if(M.ckey == X.pkey)
							if(M.Race == "Android")
								usr << "Androids do not have an energy signature!"
								return
							if(X.familiarity >= 5)
								A = M
								break
							else
								usr << "You're not familiar enough with that energy signature to find it. (5 Familiarity)"
								return
							if(M.BP<1000)
								usr<<"You can't seem to find their energy. (BP too low)"
								return
							if(!RealmTeleport) if(M.z==8||z==11||z==10)
								usr<<"You can not see them."
								return
					if(A.HelmetOn<3)
						usr << "You are now watching [A] through your crystal ball."
						usr.Get_Observe(A)
						src.Health -= 100000
						desc="<br>Clicking this will let you observe people....for a time...for a cost..<br>[Commas(Health)] Durability Crystal Ball"
						src.screen_loc = "1,1"
						usr.client.screen.Add(src)
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe on [key_name(A)].\n")
			else
				usr << "You do not possess enough magic skill to use that item."
				return
		verb/Enhance()
			set src in oview(1)
			var/obj/Mana/A
			for(var/obj/Mana/B in usr) A=B
			var/Amount=round(input("Add how much mana to this crystal ball?") as num)
			if(Amount>A.Value) Amount=A.Value
			if(Amount<0) Amount=0
			A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
			Amount*=usr.Magic_Potential
			Health+=Amount
			desc="<br>Clicking this will let you observe people....for a time...for a cost..<br>[Commas(Health)] Durability Crystal Ball"
			view(usr)<<"[usr] adds +[Commas(Amount)] to the [src]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds +[Commas(Amount)] to the [src].\n")