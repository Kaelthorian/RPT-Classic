Skill/Buff/False_Moon


	desc="A skill that uses Ki to create a False Moon that will trigger any nearby Saiyan's Oozaru transformation."
	verb/False_Moon()
		set category="Skills"
		if(usr.getCooldown("[src]")>world.time)
			usr<<"You must wait longer."
			return
		if(usr.RPMode) return
		if(usr.KOd) return
		else
			var/obj/items/Moon/M = new
			M.loc=locate(usr.x,usr.y+1,usr.z)
			M.icon_state="On"
			spawn(100)
				if(M) del(M)
			for(var/mob/A in view(12,usr))
				A.Oozaru()
				if(locate(/obj/items/Mark_Of_The_Beast) in A) A.Werewolf()
			usr.Ki/=1.05
			hearers(10,usr) << sound('Pop.wav',volume=20)

