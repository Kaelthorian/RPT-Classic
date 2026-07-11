obj/items/verb/Drop()
	if(global.rebooting)
		usr << "Unable to pick up or drop items while a reboot is in progress."
		return
	for(var/area/Void/V in range(usr))																//If you try to drop something in the void
		usr<<"You may not drop things here."														//Tell them you can't drop it
		return																						//stop
	if(locate(/obj/items/Artifact) in get_step(src,0))												//If there is an artifact under you on the ground.
		usr<<"You may not drop things here."														//Tell them they can't drop more artifacts things here.
		return																						//stop
	if(istype(src,/obj/items/Artifact))																//if you are dropping an artifact
		usr.ArtifactSkillRemove()																	//Remove all the artifacts buffs from him.
	if(isturf(usr.loc))
		var/Amount=0
		for(var/obj/A in get_step(usr,usr.dir)) if(!(locate(A) in usr)) Amount++
		if(Amount>4)
			usr<<"Nothing more can be placed on this spot."
			return
		if(suffix) if(!Can_Drop_With_Suffix)
			usr<<"You must unequip it first"
			return
		for(var/mob/player/A in view(usr))															//For all the players around you
			if(A.see_invisible>=usr.invisibility)													//If they can see you
				A<<"[usr] drops [src]"																//Announce it to the public around you
				A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [src].\n")		//Log of whta you drop
//		for(var/mob/player/A  in view(10,usr))
//			A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [src].\n")
		for(var/obj/items/Artifact/T in src)														//If the thing you drop is an artifact
			T.ArtifactGrabCD = 0																	//Set the CD to 0 , since is not an accident
		for(var/obj/items/Magic_Ball/T in src)														//If what you drop is a DB
			T.DBGrabCD = 0																			//Set the CD to 0 , since is not an accident
		usr.overlays-=icon																			//Remove the overlay icon from the user if it have one
		loc=usr.loc																					//Change the location of the item to the usr location
		step_to(src,usr.dir)																		//Move it in front of the user.
		src.SaveItem(src)
		dir=SOUTH																					//
	usr.Save()																						//Save ... the user? not sure why or what.
//	usr.InventoryCheck()
//obj/items/var/Element
// ### ITEMS ###