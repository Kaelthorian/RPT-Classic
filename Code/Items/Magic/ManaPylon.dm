obj/Mana_Pylon
	density=1
	var/Resources=0
	var/DrillRate=1
	Bolted=1
	Savable = 1
	desc="This is a Mana Pylon. It will slowly absorb ambient energy (And Kael will to code)."
	icon = 'Mana_Pylon.dmi'
	New()
		global.DrillList += src // add them to the global list

	Click()
		if(!(usr in range(1,src))) return
		if(usr.client.eye!=usr) return
		src.Pylon_Link(usr)
		SaveItemATOM(src)

	verb/Enhance()
		set src in oview(1)
		SaveItemATOM(src)
		if(usr.Magic_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Mana/A
		for(var/obj/Mana/B in usr) A=B
		var/Cost=(1000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets)))*usr.Magic_Potential*3
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Magic_Level*10) Max_Upgrade=usr.Magic_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magical skill (Max Upgrade cannot exceed magical skill), and how much mana you have. So if the maximum is less than your magic skill then it is instead due to not having enough mana to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Magic_Level*10) Upgrade=usr.Magic_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		if(Upgrade<=Tech)
			usr<<"This Pylon is already upgraded to or past that point."
			return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		DrillRate=Upgrade
		SaveItemATOM(src)



	verb/Mass_Enhance()
		set src in oview(1)
		SaveItemATOM(src)
		if(usr.Magic_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Mana/A
		for(var/obj/Mana/B in usr) A=B
		var/Cost=1000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Magic_Level*10) Max_Upgrade=usr.Magic_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magical skill (Max Upgrade cannot exceed magical skill), and how much mana you have. So if the maximum is less than your magic skill then it is instead due to not having enough mana to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Magic_Level*10) Upgrade=usr.Magic_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		for(var/obj/Mana_Pylon/MP in view(10))
			Cost=1000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough mana to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [MP] to level [Upgrade]"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [MP] to level [Upgrade]. \n")
			A.Value-=Cost
			MP.Tech=Upgrade
			MP.desc="Level [MP.Tech] [MP]"
			MP.DrillRate=Upgrade
		SaveItemATOM(src)

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