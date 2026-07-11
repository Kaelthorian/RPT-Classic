/client/proc/Delete(atom/A in world)
	set category = "Admin"
	set name = "Delete"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	//Deleting areas fucks stuff up but i guess owners and stuff can do it if they want
	if(isarea(A) && !(src.holder.level >= 5))
		alert("You cannot delete areas! You must be of a higher administrative rank!")
		return
	//Don't let us boot a higher level admin
	if(ismob(A))
		var/mob/M = A
		if (M.client && M.client.holder && (M.client.holder.level >= src.holder.level) && !(M==src))
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return
	if(A)
		switch(input("Are you sure you want to delete [A]?") in list("No","Yes"))
			if("Yes")
				log_admin({"[key_name(src)] deleted [A]"})
				alertAdmins("[key_name(src)] deleted [A]")
				DeleteSaveItem(A)
				del(A)
			else
				return
	else
		alert("Object doesn't exist anymore!")
		return