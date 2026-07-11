/client/proc/jumptoobj()//var/obj/M in world)
	set category = "Admin"
	set name = "Jump to Obj"

	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/obj/M=input("Jump to Obj") as obj in world
	if(!M.z) return
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = get_turf(M)
	log_admin({"[key_name(usr)] jumped to [M]"})
	alertAdmins("[key_name_admin(usr)] jumped to [M]", 1)