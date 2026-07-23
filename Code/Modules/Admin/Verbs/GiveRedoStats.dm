mob/proc/
	Give_RedoStats(mob/M as mob in Players)
		set hidden=1//set category="Admin"
	/*	if(!usr.client.holder || usr.client.holder.level < 1)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		M.contents+=new/obj/Redo_Stats
		logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] the [M.Race] [M.Class] Redo Stats.",2)