obj/items/Transporter_Watch
	icon='Transporter Watch.dmi'
	desc="You can use this to transport yourself to any transporter pad that matches your watch's \
	remote access code"
	Level=1

	Savable = 1
	proc/Transport()
		var/list/A=new
		for(var/obj/items/Transporter_Pad/B)
			if(Level<2&&B.z!=usr.z&&B.z)
			else if(B.Password==Password&&B.z)
				A+=B
				var/restricted = list(13,16)
				if(B.z in restricted)
					A-=B
				if(B.z!=usr.z) A-=B
		var/obj/items/Transporter_Pad/C=input("Go to which transporter?") in A
		usr.overlays+='SBombGivePower.dmi'
		var/OldHP=usr.Health
		sleep(120)
		usr.overlays-='SBombGivePower.dmi'
		usr.overlays-='SBombGivePower.dmi'
		if(usr.Health<OldHP)
			usr<<"Interrupted due to damage."
			return
		if(C)
			usr.loc=C.loc
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses [src] to teleport to [C] ([C.x],[C.y],[C.z]) \n")
	verb/Use()
		if(usr.Int_Level < 80|| usr.Int_Mod < 2)
			usr << "You need an intelligence level of at least 80 and Int Mod of 2+ in order to understand how to operate the complex piece of equipment!"
			return
		if(usr.KOd==1)
			usr << "You do not have the energy required to do this..."
			return
		Transport()
	verb/Set()
		if(usr.Int_Level < 80|| usr.Int_Mod < 2)
			usr << "You need an intelligence level of at least 80 and Int Mod of 2+ in order to understand how to operate the complex piece of equipment!"
			return
		Password=input("Set the remote identification code.") as text
/*	verb/Upgrade()
		set src in view(1)
		if(Level>=2)
			usr<<"This is already fully upgraded."
			return
		var/Cost=20000000/usr.Int_Mod
		for(var/obj/Resources/A in usr)
			if(A.Value>=Cost)
				A.Value-=Cost
				src.cost += Cost
				Level++
			else usr<<"Only with [Commas(Cost)] resources can you upgrade this, allowing to to travel between planets."*/