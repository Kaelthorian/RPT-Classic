mob/proc/
	Warn(mob/M in Players)
//		set category = "Admin"
		set desc = "Warn a player"
		if(!src.client.holder)
			src << "Only administrators may use this command."
			return
		if(M.client && M.client.holder && (M.client.holder.level >= src.client.holder.level))
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return
		if(!src.Confirm("Warn [M]?")) return
		var/addedMemory = input("Warn for what?") as message
		if(!M.client.warned)
			M << "\red <B>You have been warned by an administrator. This is the only warning you will recieve.</B>"
			M << "\red <hr>[addedMemory]"
			M.client.warned = 1
			alertAdmins("[key_name(src)] warned [key_name(M)].")
			addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([src.key])<hr> [addedMemory]<br><hr>"
			M.mind.store_memory(addedMemory)
		else
			addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([src.key])<hr> [addedMemory]<br><hr>"
			M.mind.store_memory(addedMemory)
			AddBan(M.ckey, M.computer_id, "Autobanning due to previous warn", src.ckey, 1, 10)
			M << "\red<BIG><B>You have been autobanned by [src.ckey]. This is your \"second warning\".</B></BIG>"
			M << "\red <hr>[addedMemory]"
			M << "\red This is a temporary ban; it will automatically be removed in 10 minutes."
			log_admin("[key_name(src)] warned [key_name(M)], resulting in a 10 minute autoban.")
			alertAdmins("[key_name(usr)] warned [key_name(M)] resulting in a 10 minute autoban.")
			del(M.client)
			del(M)