mob/Admin1/verb

	AdminLogs()
		set category="Admin"
		set name="Admin Logs"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		//usr<<browse(file("AdminLog.log"))
		usr << ftp("AdminLog.log")