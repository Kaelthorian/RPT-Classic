mob/verb/Toggle_Status_Overlays()
	set category=null//"Other"
	if(usr.SOverlayToggle)
		usr.SOverlayToggle = 0
		usr << "Status overlays turned off."
		winset(usr.client,"LETHAL","is-visible=false")
		winset(usr.client,"INVIS","is-visible=false")
		winset(usr.client,"GLOVES","is-visible=false")
		winset(usr.client,"lethalcombat","is-visible=false")
//		winset(src.client,"guardB","is-visible=false")
		return
	else
		usr.SOverlayToggle = 1
		usr << "Status overlays on."
		if(usr.Lethality == 1) winset(usr.client,"LETHAL","is-visible=true")
		if(usr.invisibility >= 1) winset(usr.client,"INVIS","is-visible=true")
		if(usr.LethalCombatTracker) winset(usr.client,"lethalcombat","is-visible=true")
		for(var/obj/items/Boxing_Gloves/A in usr) if(A.suffix=="*Equipped*") winset(usr.client,"GLOVES","is-visible=true")
		return