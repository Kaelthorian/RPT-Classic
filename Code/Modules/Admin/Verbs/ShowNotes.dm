mob/Admin1/verb

	Show_Notes()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		alertAdmins("[key_name(usr)] displayed notes to all admins.</b>")
		for(var/mob/M in Players)
			if(M.client) if(M.client.holder)
				var/html_doc="<head><title>Admin Notes</title></head><body bgcolor=#000000 text=#FFFF00>[Notes]"
				M<<browse(html_doc,"window=Admin Notes")