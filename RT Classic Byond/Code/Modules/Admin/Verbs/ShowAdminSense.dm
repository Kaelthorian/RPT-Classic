mob/AdminToggles/verb
	Show_Admin_Sense()
		set category="Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.AdminSenseToggle)
			usr.AdminSenseToggle = 0
			usr << "You have made your Admin Sense tab hidden."
			return
		else
			usr.AdminSenseToggle = 1
			usr << "You have made your Admin Sense tab shown."
			return