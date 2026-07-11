/client/proc/jumptokey()
	set category = "Admin"
	set name = "Jump to Key"

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	var/list/keys = list()
	for(var/client/C)
		keys += C
	var/selection = input("Please, select a player!", "Admin Jumping") as null|anything in keys
	if(!selection)
		return
	var/mob/M = selection:mob

	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = M.loc
	log_admin({"[key_name(usr)] jumped to [key_name(M)]"})
	alertAdmins("[key_name_admin(usr)] jumped to [key_name_admin(M)]", 1)