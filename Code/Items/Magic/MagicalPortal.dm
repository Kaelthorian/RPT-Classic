obj/Magical_Portal
	Bolted = 1
	Savable=1
	Health = 99999999999999999999999999999999
	desc="Click to travel. This is a magicial portal, it could lead anywhere..."
	icon = 'SEffect.dmi'
	icon_state="3"
	pixel_x=-80
	pixel_y=-80
	var/gotRE=0
	var/Portal_Number
	New()
		var/image/B=image(icon='SEffect.dmi',icon_state="")
		overlays.Remove(B)
		overlays.Add(B)
		spawn(10)
			if(src.tag == "Special")
				spawn(9000)
					if(src)
						view(8,src) << "[src] closes shut!"
						del(src)
						return
		..()
	//		if(src) src.pixel_x = -37

	Click()
		if(src in range(2,usr))
			for(var/obj/Magical_Portal/P in world)
				if(P != src) if(P.Portal_Number) if(P.Portal_Number == src.Portal_Number)
					view(8,usr) << "[usr] enters the portal."
					if(ismob(P.loc))
						var/mob/PP=P.loc
						usr.loc = PP
					else usr.loc = P.loc
					view(8,usr) << "[usr] exits the portal."
					return
	verb
		Remove()
			set src in range(1,usr)
			if(z==17)
				usr<<"You can not remove this portal."
				return
			switch(input("Are you sure you want to close this portal permanently?") in list("No","Yes"))
				if("Yes")
					if(src.Builder=="[usr.real_name]")
						spawn(5) del(src)

	verb
		Harness_Radiant_Energy()
			set src in range(1,usr)
			if(usr.Magic_Potential<3)
				usr<<"You do not understand the art of magic enough to fully utilize it here."
				return
			if(src.tag=="Special") return
			if(gotRE==Year)
				usr<<"You have already gathered Radiant Energy this year."
				return
			if(usr.GotRE==Year)
				usr<<"You have already gathered Radiant Energy this year."
				return
			if(RadiantEnergy==src.z)
				view(usr) <<"[usr] begins to gather Radiant Energy using [src]!"
				gotRE=Year
				//usr.GotRE=Year
				sleep(36000)//1 hr
				if(src)
					view(src)<<"[src] has finished gathering Radiant Energy."
					gotRE=Year
					//usr.GotRE=Year
					new/obj/Mana/Radiant_Mana_Crystal(src.loc)