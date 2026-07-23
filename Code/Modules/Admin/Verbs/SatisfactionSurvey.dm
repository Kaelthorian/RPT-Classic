mob/Admin4/verb
	Satisfaction_Survey()
		set category = "Admin Other"
		var/message = {"Roleplay Tenkaichi staff values your feedback, please take a moment to fill out this survey and let us know how we are doing so that we can improve! <br><br><a href="https://goo.gl/forms/ZlTn7tFswqCI65Qf2"> Satisfaction Survey </a>"}
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.client.holder.rank != "Owner") message = adminscrub(message,MAX_MESSAGE_LEN)
		world << "<span class=\"announce\"><b>[usr.client.stealth ? "[usr]" : usr.key] Announces:</b><br>[message]</center></span>"
		log_admin("Announce: [key_name(usr)] : [message]")