


mob/var
	GodKiActive=0
	GodKi=0
	MaxGodKi=0
	SparGodKi=0

obj/God_Ki
	verb/Toggle_God_Ki()
		set category="Other"
		if(!usr.MaxGodKi) return
		if(usr.GodKiActive) usr.GodKiDeactivate()
		else usr.GodKiActivate()



mob/proc/GodKiActivate()
	if(GodKi>0&&MaxGodKi)
//		winset(client,"GODKI","is-visible=true")
		BuffOut("You will now utilize your God Ki.")
		overlays+=/Icon_Obj/Cloak/WhiteCloak
		overlays+=GodKiAura
	/*	if(Race=="Saiyan")
			Revert()
			SSG()*/
		GodKiActive=1

mob/proc/GodKiDeactivate()
	if(GodKiActive)
//		winset(client,"GODKI","is-visible=false")
		BuffOut("You will now hide your God Ki from others.")
		overlays-=/Icon_Obj/Cloak/WhiteCloak
		overlays-=GodKiAura
		GodKiActive=0
	//	Revert()
//		if(Race=="Saiyan") SSG()


mob/proc/DrainGodKi()
	if(GodKiActive)
		GodKi=max(0,GodKi-1)
		if(GodKi<=0)
			GodKi=0
			overlays-=/Icon_Obj/Cloak/WhiteCloak
			overlays-=GodKiAura
			GodKiActive=0
//			winset(client,"GODKI","is-visible=false")
			BuffOut("You have run out of available God Ki.")
			if(Race=="Saiyan") SSG()
			if(ssj&&ssj!=4)
				Revert()
				SSj()
				SSj2()

mob/proc/SSG() if(Race=="Saiyan")
	overlays.Remove(hair,SSjHair,USSjHair,SSjFPHair,SSj2Hair,SSj3Hair,SSj4Hair,SSGFPHair,SSGSSHair,SSRHair,SSGHair)
	overlays-=/Icon_Obj/Cloak/SSG2
	overlays-=/Icon_Obj/Cloak/SSGCloak
	overlays-=/Icon_Obj/Cloak/WhiteCloak
	overlays-=GodKiAura
	if(GodKiActive)
		overlays+=/Icon_Obj/Cloak/SSG2
		overlays+=/Icon_Obj/Cloak/SSGCloak
		HairAdd()
		view(8,src) << "[src] harnesses the power of a Super Saiyan God!"
	else
		HairAdd()
		view(8,src) << "[src] stops harnessing the power of a Super Saiyan God."

