/client/proc/sendmob(var/mob/M in Players)
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/mob/A=input("Send to Player") in Players
	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = A.loc
	log_admin({"[key_name(usr)] teleported [key_name(M)] to [A]"})
	alertAdmins("[key_name_admin(usr)] teleported [key_name_admin(M)] to [A]", 1)