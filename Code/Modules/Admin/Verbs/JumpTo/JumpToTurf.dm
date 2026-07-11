/client/proc/jumptoturf()//var/turf/T in world)
	set category = "Admin"
	set name = "Jump to turf"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/turf/T=input("Jump to Turf") as turf in world
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = T
	log_admin({"[key_name(usr)] jumped to [T.x],[T.y],[T.z] in [T.loc]"})
	alertAdmins("[key_name_admin(usr)] jumped to [T.x],[T.y],[T.z] in [T.loc]", 1)