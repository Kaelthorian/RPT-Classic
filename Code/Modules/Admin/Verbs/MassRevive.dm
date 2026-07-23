mob/Admin2/verb
	Mass_Revive()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		switch(input("Are you sure you want to mass revive everyone on the server?") in list("No","Yes"))
			if("Yes")
				for(var/mob/player/P in Players)
					if(P.Dead) P.Revive()
					sleep(1)
				logAndAlertAdmins("[src.key] revived everyone.",2)