mob/proc/
	Grant_Anger(mob/M as mob in Players)
		set category = "Admin"
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(!M) return
		var/DA=input("Death Anger?") in list("Full Death", "Partial Death", "Normal")
		if(M)
			if(DA=="Full Death")
				M.DeathAnger=1
				M.Anger()
			if(DA=="Partial Death")
				M.DeathAnger=0.5
				M.Anger()
			if(DA=="Normal") M.Anger()
			alertAdmins("Grant Anger: [key_name(usr)] granted [M] [DA] Anger",1)
			log_admin("Grant Anger: [key_name(usr)] granted [M] [DA] Anger")