/client/proc/Update_So_Far(var/message as message)
	set category = "Admin"
	set name = "Update So Far"
	set desc = "Narrate to everyone in the game world"
	if(!message)	//Lets you do narrate "stuff" OR narrate -> "bla bla"
		message = input("Narrative message to send:", "Admin Narrate", null, null)  as message
	if(message)
		if(usr.client.holder.rank != "Owner") message = adminscrub(message,MAX_MESSAGE_LEN)
		for(var/mob/M in world)
			M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
	for(var/mob/M in Players) M<<'Carry On My Son.mid'
	alertAdmins("[key_name(usr)] used narrate world to World.")