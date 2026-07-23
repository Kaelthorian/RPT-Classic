/client/proc/ForceBio(mob/M in Players)

	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	if(M.Race!="Bio-Android") return
	if(usr.Confirm("Give [M] the next Bio Form?"))// return
		if(M && M.client)	//Do the checks in the reverse of what you'd assume
			if(!M.Perfect_Form)
				M.Bio_Forms()
				usr<<"Unlocked [M]s Bio Trans!"
			else
				alert("[M] already has their forms fully unlocked!")
				return
			log_admin("[key_name(src)] granted [key_name(M)] Bio Trans!")
			alertAdmins("[key_name(src)] granted [key_name(M)] Bio Trans!")