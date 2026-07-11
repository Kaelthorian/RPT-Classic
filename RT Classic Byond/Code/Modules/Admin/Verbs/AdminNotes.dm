mob/Admin1/verb

	Add_Admin_Note()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		M.mind.show_memory(usr)
/*		var/addedMemory = input("Admin Note for [M]") as message
		if(!usr.Confirm("Save this note?")) return
		addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key])<hr> [addedMemory]<br><hr>"
		M.mind.store_memory(addedMemory)
		log_admin({"<div class="ban">[key_name(usr)] added to [key_name(M)]'s mind.</div>"})
		alertAdmins("[key_name(usr)] added to [key_name(M)]'s mind.")*/