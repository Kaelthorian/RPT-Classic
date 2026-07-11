mob/proc/
	Force_Reincarnate(mob/M in Players)
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Reincarnate [M]?"))
			M<<"You are being reincarnated. Please choose new and create your new character. If this was in mistake, press load."
			M.Reincarnation()
			log_admin("[key_name(usr)] reincarnated [M].")
			alertAdmins("[key_name_admin(usr)] reincarnated [M].", 1)