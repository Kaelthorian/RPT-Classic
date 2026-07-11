/client/proc/narrate(var/message as message)
	set category = "Admin"
	set name = "Narrate"
	set desc = "Narrate to those within 55 tiles of you"
	if(!message)	//Lets you do narrate "stuff" OR narrate -> "bla bla"
		message = input("Narrative message to send:", "Admin Narrate", null, null)  as message
	if (message)
		if(usr.client.holder.rank != "Owner") message = adminscrub(message,MAX_MESSAGE_LEN)
		for(var/mob/M in view(usr,55))
			M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
		alertAdmins("[key_name(usr)] used narrate.")