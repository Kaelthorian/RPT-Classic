obj/items/Moon
	icon='Moon.dmi'

	desc="Using this may be unhealthy."
	var/Emitter
	verb/Use()
		set src in oview(1)
		if(icon_state=="On") return
		if(usr)
			view(usr)<<"[usr] activates the [src]!"
			icon_state="On"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates the [src]!\n")
			for(var/mob/A in view(12,src))
				if(Emitter&&A.HasSSj >= 1) A.Golden()
				else
					if(locate(/obj/items/Mark_Of_The_Beast) in A) A.Werewolf()
					else A.Oozaru()
			//spawn(10) if(src&&Emitter) for(var/mob/A in view(12,src)) if(A.SSjDrain>=300&&usr.Race=="Saiyan"&&usr.HasSSj > 0) A.Golden()
			spawn(100) if(src) del(src)
	/*verb/Upgrade()
		set src in view(1)
		if(Emitter>=1)
			usr<<"This is already fully upgraded."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(A.Value>=80000000*Tech/usr.Int_Mod&&!Emitter) if(usr.Int_Mod>=2.5) Choices.Add("Turn into Emitter ([80000000*Tech/usr.Int_Mod])")
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Turn into Emitter ([80000000*Tech/usr.Int_Mod])")
			if(A.Value<80000000*Tech/usr.Int_Mod) return
			A.Value-=80000000*Tech/usr.Int_Mod
			Emitter=1*/

		//Tech++
	Emitter
		name="Emitter"
		icon='Moon2.dmi'