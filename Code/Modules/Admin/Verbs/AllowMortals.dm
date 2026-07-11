mob/Admin1/verb

	Allow_Mortals()
		set category="Admin"
		if(DeadReturn == 1)
			if(!usr.Confirm("You want to allow the mortals to stay in the AL while they are alive?")) return
			DeadReturn = 0
			for(var/mob/player/A in Players)
				if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
					A<<"<big><b><font color=red>The essence of the living realm begins to mix with the afterlife , they are now one.</b></big>"
					logAndAlertAdmins("[src] allowed the mortals to stay in the AL.")
		else
			if(!usr.Confirm("You want to stop the mortals from staying in the AL while they are alive?")) return
			DeadReturn = 1
			for(var/mob/player/A in Players)
				if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
					A<<"<big><b><font color=red>The essence of the living realm begins to banish from the afterlife , they are no longer one.</b></big>"
					logAndAlertAdmins("[src] denied the mortals to stay in the AL.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Allow Mortals.\n")
