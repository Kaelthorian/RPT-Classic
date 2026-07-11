mob/verb/Toggle_Lethality()
	set category=null//"Other"
	if(!HasCreated)
		usr<<"You must create a character first."
		return
	if(usr.Spar)
		usr.Spar = 0
		usr.Lethality = 1
		usr.overlays+='Lethal_Hud.dmi'
		usr << "You will now try to kill your opponent."
		for(var/obj/items/Boxing_Gloves/A in usr) if(A.suffix)
			A.suffix=null
			winset(usr.client,"GLOVES","is-visible=false")
			usr.overlays-=A.icon
			view(20,usr) << "[usr] removes the [A]."
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [A]\n")
		for(var/obj/items/Weights/A in usr) if(A.suffix)
			A.suffix=null
			usr.overlays-=A.icon
			view(20,usr) << "[usr] takes off the [A]."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes the [A].\n")

		for(var/obj/items/Sword/Practice_Sword/A in usr) if(A.suffix)
			usr.SwordOn=0
			var/image/_overlay = image(A.icon)
			_overlay.pixel_x = A.pixel_x
			_overlay.pixel_y = A.pixel_y
			_overlay.layer= A.layer
			usr.overlays-=_overlay
			if(usr.HasSwordsman) usr.OffMult/=(A.Off+0.08)
			else usr.OffMult/=A.Off
			usr.Equip_Magic(src,"Remove")
			for(var/Skill/Buff/Bushido/SF in usr) if(SF.Using) SF.use(usr)
			for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [A].")
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [A]\n")

		oview(10,usr) << "<font color = green>[usr]'s eyes gloss over as their actions shift to lethal intent."
		winset(src.client,"LETHAL","is-visible=true")
		//UpdateStats("Lethality")
		return
	else
		usr.Spar = 1
		usr.Lethality = 0
		usr.overlays-='Lethal_Hud.dmi'
		usr << "You will no longer try to kill your opponent."
		oview(10,usr) << "<font color = green>[usr]'s eyes seem to brighten as they cease their lethal intentions."
		winset(src.client,"LETHAL","is-visible=false")
		//UpdateStats("Lethality")
		return