/client/proc/Getmob(var/mob/M in Players)
	set category = "Admin"
	set name = "Summon"
	set desc = "Summon a mob"
	if(!src.holder)
		src << "Only administrators may use this command."
		return

	if(!M) M=input("Summon Mob") as mob in Players
	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = get_turf(usr)
	log_admin({"[key_name(usr)] summon [key_name(M)]"})
	alertAdmins("[key_name_admin(usr)] summon [key_name_admin(M)]", 1)