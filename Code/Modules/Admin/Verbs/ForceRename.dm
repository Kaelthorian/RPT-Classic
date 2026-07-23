mob/Admin1/verb

	FRename(atom/A in world)
		set category = "Admin"
		set name = "Force Rename"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/newname = copytext(sanitize(input("Renaming [A]",A.name)), 1, MAX_NAME_LENGTH)
		if(!newname) return
		else
			log_admin("[key_name(usr)] changed [key_name(A)]'s name to [newname]")
			alertAdmins("[key_name(usr)] changed [key_name(A)]'s name to [newname]")
			A.name = newname
			if(ismob(A))
				var/mob/B = A
				B.real_name = newname