/client/proc/returnmob(mob/M in Players)
	set category = "Admin"
	set name = "UnSummon"
	set desc = "Return a mob to its previous location"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if(!M) M=input("Unsummon Mob") as mob in Players
	if(!M.unSummonX||!M.unSummonY||!M.unSummonZ){src << "This mob does not have coordinates to return to."; return}
	M.loc = locate(M.unSummonX,M.unSummonY,M.unSummonZ)
	M.unSummonX = null
	M.unSummonY = null
	M.unSummonZ = null
	log_admin({"[key_name(usr)] teleported [key_name(M)] to their old location."})
	alertAdmins("[key_name_admin(usr)] teleported [key_name_admin(M)] to their old location.", 1)