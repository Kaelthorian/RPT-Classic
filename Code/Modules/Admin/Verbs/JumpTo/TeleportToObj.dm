/client/proc/Sendtoobj(var/mob/M in Players)//var/obj/M in world)
	set category = "Admin"
	set name = "Jump to Obj"

	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/list/WList=list()
	for(var/obj/Cookable/B in world) WList+=B
	var/obj/O=input("Send to Corpse") as mob in WList
	if(!O.z) return
	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = O.loc
	log_admin({"[key_name(usr)] sent [M] to [O]"})
	alertAdmins("[key_name_admin(usr)] sent [M] to [O]", 1)