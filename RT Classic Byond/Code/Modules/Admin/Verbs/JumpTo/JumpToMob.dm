/client/proc/jumptomob(mob/M in Players)
	set category = null
	set name = "Jump to"
	if(!src.holder)
		src << "Only administrators may use this command."
		return

	if(!M) M=input("Jump to Mob") as mob in Players
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = get_turf(M)
	log_admin("[key_name(usr)] jumped to [key_name(M)]")
	alertAdmins("[key_name_admin(usr)] jumped to [key_name_admin(M)]", 1)