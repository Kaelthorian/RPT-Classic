mob/Admin4/verb
	Close_Server()
		set category="Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Close server?"))
			global.ItemsLoaded=0
			global.MapsLoaded=0
			logAndAlertAdmins("[src.key] has manually CLOSED the server. (DEBUG: [global.MapsLoaded]:[global.ItemsLoaded])",2)