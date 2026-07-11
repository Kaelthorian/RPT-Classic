mob/proc/
	Grant_Capped_Stats(mob/M in Players)
		set category="Admin"
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(usr.Confirm("Cap all [M]'s stats?"))
			var/N=input("Cap them at which rate? 1x = cap, 1.1x=over cap)") as num
			if(N<0.5)N=0.5
			if(N>1.5)N=1.5
			M.CapStats(N)

			log_admin("[key_name(usr)] capped [M]'s stats.")
			alertAdmins("[key_name_admin(usr)] capped [M]'s stats.", 1)