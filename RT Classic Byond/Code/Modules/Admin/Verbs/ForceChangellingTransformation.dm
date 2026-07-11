/client/proc/ForceChangeling(mob/M in Players)
	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	if(M.Race!="Changeling") return
	if(usr.Confirm("Give [M] Form [M.HasForm+1]?"))// return
		if(M && M.client)	//Do the checks in the reverse of what you'd assume
			if(M.HasForm < 1)
				M.HasForm = 1
				usr<<"Unlocked [M]s Form [M.HasForm]."
			else if(M.HasForm < 2&&M.Class!="King Kold")
				M.HasForm = 2
				usr<<"Unlocked [M]s Form [M.HasForm]."
			else if(M.HasForm < 3&&M.Class!="King Kold")
				M.HasForm = 3
				usr<<"Unlocked [M]s Form [M.HasForm]."
			else if(M.HasForm < 4&&M.Class=="Cooler")
				M.HasForm = 4
				usr<<"Unlocked [M]s Form [M.HasForm]"
			else
				alert("[M] already has their forms fully unlocked!")
				return
			log_admin("[key_name(src)] granted [key_name(M)] Form [M.HasForm]")
			alertAdmins("[key_name(src)] granted [key_name(M)] Form [M.HasForm]!")