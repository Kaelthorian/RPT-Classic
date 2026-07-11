mob/Admin1/verb

	Show_Muted_List()
		set category = "Server"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "Muted list contains: [list2params(global.MutedList)]"