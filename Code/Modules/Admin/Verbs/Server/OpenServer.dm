mob/Admin4/verb
	Open_Server()
		set category="Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Open server?"))
			global.ItemsLoaded=1
			global.MapsLoaded=1
			logAndAlertAdmins("[src.key] has manually OPENED the server. (DEBUG: [global.MapsLoaded]:[global.ItemsLoaded])",2)