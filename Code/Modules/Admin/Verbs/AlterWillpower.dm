mob/proc/
	AlterWP(mob/M in Players)
		if(!src.client.holder)
			src << "Only administrators may use this command."
			return
		var/inp=input("New WP for [M]") as num
		if(src.Confirm("Change [M]s WP to [inp]"))
			M.Willpower=inp
			log_admin("[key_name(usr)] used Alter WP on [key_name(M)]")
			alertAdmins("[key_name(usr)] used Alter WP on [key_name(M)]")