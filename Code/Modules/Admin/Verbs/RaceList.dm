mob/Admin1/verb
	Races_List()
		//set category="Other"
		var/list/Races=new
		for(var/mob/player/A in Players) if(!(A.Race in Races))
			if(usr.client.holder)
				var/Amount=0
				Races+=A.Race
				for(var/mob/player/B in Players) if(B.Race==A.Race) Amount++
				usr.AllOut("[A.Race]: [Amount]")
			else if(A.Race!="Majin")if(A.Race!="Bio-Android")
				var/Amount=0
				Races+=A.Race
				for(var/mob/player/B in Players) if(B.Race==A.Race) Amount++
				usr.AllOut("[A.Race]: [Amount]")