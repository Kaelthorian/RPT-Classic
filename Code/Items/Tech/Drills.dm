obj/Drill
	density=1
	var/Resources=0
	var/DrillRate=1
	Savable = 1
	Bolted=1
	desc="This is an automated drill.  While it has a slow extraction rate, it is always on."

	New()
		var/image/A=image(icon='Space.dmi',icon_state="d1",pixel_y=16,pixel_x=-16)
		var/image/Z=image(icon='Space.dmi',icon_state="d2",pixel_y=16,pixel_x=16)
		var/image/C=image(icon='Space.dmi',icon_state="d3",pixel_y=-16,pixel_x=-16)
		var/image/D=image(icon='Space.dmi',icon_state="d4",pixel_y=-16,pixel_x=16)
		overlays.Remove(A,Z,C,D)
		overlays.Add(A,Z,C,D)
		global.DrillList += src // add them to the global list


	Click()
		if(!(usr in range(1,src))) return
		if(usr.client.eye!=usr) return
		src.Drill_Link(usr)
		SaveItemATOM(src)

	verb/Upgrade()
		set src in view(1)
		if(usr.Int_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=(1000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))*usr.Int_Mod*3
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level*10) Max_Upgrade=usr.Int_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level*10) Upgrade=usr.Int_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		DrillRate=Upgrade
		SaveItemATOM(src)

	verb/Mass_Upgrade()
		set src in view(1)
		if(usr.Int_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return

		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=1000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level*10) Max_Upgrade=usr.Int_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level*10) Upgrade=usr.Int_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) return
		for(var/obj/Drill/D in view(10))
			Cost=1000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [D] to level [Upgrade]"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [D] to level [Upgrade]. \n")
			A.Value-=Cost
			D.cost += Cost
			D.Tech=Upgrade
			D.desc="Level [D.Tech] [D]"
			D.DrillRate=Upgrade
			SaveItemATOM(D)
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."
			SaveItemATOM(src)
			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1
			SaveItemATOM(src)
			return