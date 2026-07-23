mob/Admin1/verb

	Announce(var/message as message)
		set category = "Admin"
		set desc="Announce your desires to the world"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!message)	//Lets you do announce "stuff" OR announce -> "bla bla"
			message = input("Global message to send:", "Admin Announce", null, null)  as message
		if (message)
			if(usr.client.holder.rank != "Owner" ) message = adminscrub(message,MAX_MESSAGE_LEN)
			world << "<span class=\"announce\"><b>[usr.client.stealth ? "[usr]" : usr.key] Announces:</b><br>[message]</center></span>"
			log_admin("Announce: [key_name(usr)] : [message]")