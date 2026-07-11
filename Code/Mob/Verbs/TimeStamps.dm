mob/verb/Toggle_Timestamps()
	set category=null
	if(usr.Toggled_Timestamps)
		usr.Toggled_Timestamps = 0
		usr << "You have made OOC timestamps hidden."
		return
	else
		usr.Toggled_Timestamps = 1
		usr << "You have made OOC timestamps show."
		return