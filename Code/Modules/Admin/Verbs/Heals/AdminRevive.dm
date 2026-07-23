mob/proc/
	ARevive(mob/M in Players)
		//set category = "Admin"
		set name = "Admin Give Life"
		/*if(!src.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(!M)
			alert("Mob doesn't exist!")
			return
		if(M.Dead)
			M.Revive()
			if(M.KOd) M.Un_KO()
			M.Health = M.MaxHealth
			M.Calm()
			M.Ki = M.MaxKi
		else
			alert("[M] isn't dead!")
			return
		log_admin("[key_name(src)] used AdminRevive on [key_name(M)]")
		alertAdmins("[key_name(src)] used AdminRevive on [key_name(M)]")