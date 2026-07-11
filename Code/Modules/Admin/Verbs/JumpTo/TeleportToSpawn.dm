/client/proc/sendToSpawn(mob/A in Players)
	set name = "Send to Spawn"
	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	A.z = 0
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	A.Location()
	log_admin({"[key_name(src)] sent [key_name(A)] to spawn"})
	alertAdmins("[key_name(src)] sent [key_name(A)] to spawn")