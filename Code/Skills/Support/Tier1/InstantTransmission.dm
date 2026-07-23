Skill/Support/InstantTransmission
	var/Teachable=0


	var/Zon=0
	var/tmp/inUse //A temporary var so the state doesn't get saved or logging out while using it might bug the skill.
	desc="Shunkan Ido, also known as Instant Transmission, is self-explanatory. If you have enough \
	skill you can detect powers further away, and teleport to them. The more skill you have the \
	less time it will take to locate their energy. Anyone next to you will also be brought with you. \
	Some people are just too weak to sense, even to someone with very high skill in Shunkan Ido"
	verb/Instant_Transmission(var/obj/Contact/X in usr.Contacts)
		set category="Skills"
		set src=usr.contents
		if(usr.RPMode) return
		var/mob/A = null
		for(var/mob/M in Players)
			if(M.ckey == X.pkey)
				if(M.Race == "Android")
					usr << "Androids do not have an energy signature!"
					return
				if(X.familiarity >= 15)
					A = M
					break
				else
					usr << "You're not familiar enough with that energy signature to find it."
					return
				if(M.BP<5000)
					usr<<"You can't seem to find their energy."
					return
				else if(M.z!=usr.z) if(M.BP<250000)
					usr<<"You can't seem to find their energy."
					return
		if(A)
			var/restricted = list(13,16)
			var/al = list(10,11)
			var/lr = list(1,2,3,4,5,6,7,8,9,12,14,15,17)
			var/travel_al = 0
			if(usr.z in lr) if(A.z in al) travel_al=1
			if(usr.z in al) if(A.z in lr) travel_al=1
			if(A.z in restricted)
				usr<<"You cannot teleport to other dimensions."
				return
			if(usr.z in restricted)
				usr<<"You cannot locate their energy from here."
				return
			/*if(travel_al) if(X.familiarity<40)
				usr<<"You cannot sense their energy..."
				return*/
			if(travel_al) if(!RealmTeleport) if(!usr.IgnoreRealmTeleport)
				usr<<"You cannot teleport to other dimensions."
				return
		if(!A) return
		if(A.afk)
			usr<<"You can not reach them now."
			return
		if(usr.Ki<100||inUse)
			usr<<"You do not have enough energy"
			return
		inUse=1
		view(usr)<<"[usr] begins concentrating..."
		var/OldHP=usr.Health
		usr<<"This may take a minute..."
		var/Modifier=1
		if(usr.Race=="Yardrat"||usr.Race=="Half-Yardrat") Modifier=2
		sleep(1200/Modifier)
		hearers(10,usr) << sound('Zanzoken1.mp3',volume=20)


		if(usr.Health<OldHP)
			usr<<"Interrupted due to damage."
			inUse=0
			return
		if(usr.KOd==0&&usr.Ki>100)
			if(A)
				usr<<"You found their energy signature."
				CD=1000
				CDTick(usr)
				oview(usr)<<"[usr] disappears in a flash!"
				for(var/mob/B in oview(1,usr)) if(B.client) if(B.client.address!=usr.client.address)
					oview(B)<<"[B] disappears!"
					B.loc=A.loc
					step_rand(B)
					spawn(1) oview(B)<<"[B] suddenly appears!"
					hearers(10,usr) << sound('Zanzoken1.mp3',volume=20)
				usr.loc=A.loc
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] teleported to [key_name(A)] who was at [A.loc]")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] teleported to [key_name(A)] who was at [A.loc]\n")
				step_rand(usr)
				inUse=0
			else
				usr<<"They logged out..."
				inUse=0