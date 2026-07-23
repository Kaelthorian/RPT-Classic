mob/Admin2/verb
	Mass_Summon()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		switch(input("Are you sure you want to mass summon everyone on the server?") in list("No","Yes"))
			if("Yes")
				for(var/mob/player/P in Players)
					P.unSummonX = P.x
					P.unSummonY = P.y
					P.unSummonZ = P.z
					P.loc = get_turf(usr)
				logAndAlertAdmins("[src.key] summoned everyone.",2)