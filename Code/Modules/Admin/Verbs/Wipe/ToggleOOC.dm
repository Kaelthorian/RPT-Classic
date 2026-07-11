mob/Admin3/verb
	Toggle_World_OOC()
		set category = "Admin Other"
		set desc="Toggle OOC on and off"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		ooc_allowed = !( ooc_allowed )
		if (ooc_allowed)
			world << "<B>The OOC channel has been globally enabled!</B>"
		else
			world << "<B>The OOC channel has been globally disabled!</B>"
		log_admin("[key_name(usr)] toggled OOC.")
		alertAdmins("[key_name_admin(usr)] toggled OOC.", 1)