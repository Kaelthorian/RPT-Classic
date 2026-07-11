/client/proc/Jumptoarea()//var/area/A in world)
	set desc = "Area to jump to"
	set category = "Admin"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/area/A=input("Jump to Area") as area in world
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = pick(get_area_turfs(A))
	log_admin({"[key_name(usr)] jumped to [A]"})
	alertAdmins("[key_name_admin(usr)] jumped to [A]", 1)
