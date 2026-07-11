obj/items/Cloak_Controls
	icon='Cloak.dmi'
	icon_state="Controls"
	desc="You can use this to activate or deactivate all cloaked objects matching the same password \
	you have set for the controls. You can also use this to remove the cloaking chip from objects \
	next to you by using uninstall on it. You can upgrade this to have more cloaking capability so \
	that it is harder to detect. This is also a personal cloak, if you activate it, you will become \
	out of phase, and stay out of phase until you deactivate it. While out of phase you will also see \
	anything that is in the same phase or lower than yourself. The personal cloak is 5 levels less \
	powerful than the cloaking modules themselves."
	var/Active
	Level=1

	verb/Use()
		if(Level<1)
			usr<<"You cannot use this without further upgrades"
			return
		if(!usr.invisibility)
			view(usr)<<"[usr] activates their personal cloak"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their personal cloak.\n")
			usr<<"You are now [Level] levels out of phase"
			usr.invisibility=Level
			usr.see_invisible=Level
			winset(usr.client,"INVIS","is-visible=true")
		else
			usr.invisibility=0
			usr.see_invisible=0
			view(usr)<<"[usr] deactivates their personal cloak."
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates their personal cloak.\n")
			winset(usr.client,"INVIS","is-visible=false")

	verb/Activate()
		if(!Active)
			view(usr)<<"[usr] activates the cloaking controls"
			Active=1
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their cloak controls.\n")
		else
			view(usr)<<"[usr] deactivates the cloaking controls"
			Active=0
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates their cloak controls.\n")
		for(var/obj/A) for(var/obj/items/Cloak/B in A) if(B.Password==Password)
			if(Active) A.invisibility=Level
			else A.invisibility=0
	verb/Set() Password=input("Set the password for tracking cloaking chips of the same password") as text
	verb/Uninstall() for(var/obj/A in get_step(usr,usr.dir)) for(var/obj/items/Cloak/B in A)
		view(usr)<<"[usr] removes the cloaking system from [A]"
		A.invisibility=0
		B.loc=usr.loc
	verb/Upgrade()
		set src in view(1)
		if(Level>=100)
			usr<<"It is at the maximum."
			return
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=400000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].\n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Level=1+round(0.1*Upgrade)
		if(Level<1) Level=1
		if(Level>100) Level=100