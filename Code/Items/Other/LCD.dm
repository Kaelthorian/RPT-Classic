obj/items/LSD
	icon='LSD.dmi'
	Level=1

	desc="This will cause you to hallucinate and become intoxicated."
//	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.KOd)
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with LSD (level: [src.Level]!\n")
			if(A.client) A.LSD(src.Level)
			del(src)
	verb/Upgrade()
		set src in view(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value)]") as num
			if(Amount>round(A.Value)) Amount=round(A.Value)
			if(Amount<0) Amount=0
			Level+=Amount*usr.Int_Mod
			A.Value-=Amount//*(1-(0.15*usr.HasDeepPockets))
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
		desc="Level [Level] [src]."

mob/proc/LSD(var/Level)
	spawn(100)
	while(src&&Level>1)
		src<<"OSHIT!"
//		client.dir=pick(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST,NORTHEAST,NORTHWEST)
		sleep(rand(10,600))
		Level--
//		if(client.dir==NORTH) return