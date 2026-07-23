/client/proc/Grant_Alien_Trans(mob/M as mob in Players)
	/*if(!src.holder)
		alert("You cannot perform this action.  You must be of a higher administrative rank!")
		return*/
	if(M.HasBojack)
		if(usr.Confirm("Make it drainless?")) M.FirstTransDrainless=1
		if(usr.Confirm("Grant [M] Super Bojack? (SSj2)"))
			M.HasBojack=2
			M.BojackSSj2()
			M<<"You have achieved a power beyond your previous limits. You have unlocked the power of Super Bojack. (SSj2)"
			log_admin("[key_name(src)] has granted [M] Super Bojack 2.")
			alertAdmins("[key_name(src)] has granted [M] Super Bojack 2.")
			return
	else if(M.Race=="Heran")
		if(usr.Confirm("Give [M] Bojack Transformation?")) M.HasBojack=1
	else M.HasAlienTrans = 1
	if(usr.Confirm("Make it drainless?")) M.FirstTransDrainless=1
	log_admin("[key_name(src)] has granted [M] their Alien Transformation.")
	alertAdmins("[key_name(src)] has granted [M] their Alien Transformation.")