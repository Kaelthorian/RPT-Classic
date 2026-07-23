/client/proc/Sendtoarea(var/mob/M in Players)//var/area/A in world)
	set desc = "Area to jump to"
	set category = "Admin"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/area/A=input("Send to Area") as area in world
	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = pick(get_area_turfs(A))
	log_admin({"[key_name(usr)] sent [M] to [A]"})
	alertAdmins("[key_name_admin(usr)] sent [M] to [A]", 1)