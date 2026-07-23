/client/proc/Delete_Player_save()
	//set category = "Admin"
	set name = "Del Player Save"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/list/PsDs=list()
	for(var/mob/C in Players) PsDs+=C
	PsDs+="Cancel"
	var/mob/A=input("Delete whose save?") in PsDs
	if(A=="Cancel") return
	if (A.client && A.client.holder && (A.client.holder.level >= src.holder.level) && A != src)
		alert("You cannot delete the save of a higher level admin.", null, null, null, null, null)
		return
	switch(input("Really delete [key_name(A)]'s savefile?") in list("No","Yes"))
		if("Yes")
			log_admin({"[key_name(src)] deleted [key_name(A)]'s savefile"})
			alertAdmins("[key_name(src)] deleted [key_name(A)]'s savefile")
			var/charname = A.real_name
			var/lastkey = A.lastKnownKey
			del(A)
			if(fexists("Data/Players/[lastkey]/Characters/[charname].sav"))
				fcopy("Data/Players/[lastkey]/Characters/[charname].sav","Data/Players/[lastkey]/[charname].deleted")
				fdel("Data/Players/[lastkey]/Characters/[charname].sav")
		if("No")
			alert("Aborted deleting [key_name(A)]'s savefile!")
			return