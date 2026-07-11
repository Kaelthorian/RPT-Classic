obj/items/Transporter_Pad
	icon='Telepad.dmi'
	desc="You can use this to transport yourself between other pads sharing the same remote access code"

	Level=1
	pixel_x=-1
	pixel_y=-13
	layer=3
	Savable = 1
	proc/Transport()
		var/list/A=new
		for(var/obj/items/Transporter_Pad/B) if(B!=src)
			if(B.Password==Password&&B.z)
				A+=B
				var/restricted = list(13,16)
				var/al = list(10,11)
				var/lr = list(1,2,3,4,5,6,7,8,12,14,15)
				var/travel_al = 0
				if(B.z in al) travel_al = 1
				if(B.z in restricted) A-=B
				if(usr.z in al) if(travel_al == 0) A-=B
				if(usr.z in lr) if(travel_al) A-=B
				if(Level<2&&B.z!=usr.z&&B.z) A-=B
				if(B.Level<2&&B.z!=usr.z&&B.z) A-=B
			else

		if(!A) return
		A+="Cancel"
		var/obj/items/Transporter_Pad/C=input("Go to which transporter?") in A
		if(C=="Cancel") return
		usr.overlays+='SBombGivePower.dmi'
		sleep(30)
		if(usr)
			usr.overlays-='SBombGivePower.dmi'
			usr.overlays-='SBombGivePower.dmi'
			if(C) usr.loc=C.loc
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses [src] to teleport to [C] ([C.x],[C.y],[C.z]) \n")
			SaveItemATOM(src)
	verb/Set()
		set src in oview(1)
		if(!Password)
			Password=input("Set the indentification code, you can only transport to \
			other pads using the same code") as text
			name=input("Name the transporter pad, preferably name it after the location it will take you \
			to") as text
			if(!name) name=initial(name)
		else usr<<"It is already initialized"
		SaveItemATOM(src)
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."

			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1

			return
		SaveItemATOM(src)
	verb/Upgrade()
		set src in view(1)
		var/Cost=500000000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(Level>=2)
			usr<<"This is already fully upgraded."
			return
		if(!usr.Confirm("Upgrade [src]? This will cost [Cost]")) return
		for(var/obj/Resources/A in usr)
			if(A.Value>=Cost)
				A.Value-=Cost
				src.cost += Cost
				Level++
				usr<<"[src] upgraded!"
			else usr<<"Only with [Commas(Cost)] resources can you upgrade this, allowing to to travel between \
			planets."
		SaveItemATOM(src)