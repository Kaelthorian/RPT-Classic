obj/items/Upgrade_Kit
	icon='Lab.dmi'
	icon_state="Tool2"
	desc="Doubles the BP add of any weapon. (Target must be on the ground)"
	New()
		..()
		icon-=rgb(0,75,75)
	verb/Upgrade()
		var/list/repairlist=list()
		for(var/obj/items/Hammer/A in view(usr,1)) repairlist+=A
		for(var/obj/items/Gauntlets/A in view(usr,1)) repairlist+=A
		for(var/obj/items/Sword/A in view(usr,1)) repairlist+=A
		repairlist+="Cancel"
		var/obj/items/c=input("Upgrade what?") in repairlist
		if(c=="Cancel") return
		else
			c.Health*=2
			if(c.Health>999999999999)c.Health=999999999999
			view(usr)<<"[usr] upgraded the [c] to +[c.Health] BP!"
			if(istype(c,/obj/items/Sword))
				var/obj/items/Sword/S=c
				S.desc="<br>+[Commas(S.Health)] BP to each melee attack. However this bonus cannot exceed +[S.MaxBPAdd]% your own BP, reduces your Offense to [S.Off*100]%."
			if(istype(c,/obj/items/Hammer))
				var/obj/items/Hammer/H=c
				H.desc="<br>+[Commas(H.Health)] BP to each melee attack. However this bonus cannot exceed +[H.MaxBPAdd]% your own BP. [H.Spd*100]% Speed and [H.Off*100]% Offense."
			if(istype(c,/obj/items/Gauntlets)) c.desc="<br>+[Commas(c.Health)] BP to each melee attack. However this bonus cannot exceed +[c.MaxBPAdd]% your own BP. Can be enchanted to enhance your power."
			del(src)