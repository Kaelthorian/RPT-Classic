mob/Admin2/verb
	Edit_Login_Notes()
		set category="Admin"
		if(!usr.client.holder || (usr.client.holder.level < 2))	//LeadAdmin and above
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!WritingUpdates)
			WritingUpdates = usr
			alertAdmins("[key_name(usr)] is editting the login notes")
			Version_Notes=input(usr,"Edit!","Edit",Version_Notes) as message
			log_admin("[key_name(usr)] is finished editting the login notes")
			alertAdmins("[key_name(usr)] is finished editting the login notes")
			WritingUpdates = 0
			SaveLogin()
		else
			alert("[key_name(WritingUpdates)] is already editting the login notes!")
			return