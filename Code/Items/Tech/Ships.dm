obj/Ships/verb/Drop()
	if(global.rebooting)
		usr << "Unable to pick up or drop items while a reboot is in progress."
		return
	if(isturf(usr.loc))
		for(var/mob/player/A in view(usr))
			if(A.see_invisible>=usr.invisibility)
				A<<"[usr] deploys [src]"
				A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deploys [src].\n")
		usr.overlays-=icon
		loc=usr.loc
		step_to(src,usr.dir)
		dir=SOUTH
	usr.Save()
//	usr.InventoryCheck()