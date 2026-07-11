mob/Drone
	icon='Android (8).dmi'
	var/function
	var/dronekey
	var/Tech=1
	var/tmp/target
	Savable = 1
	Click()
		if(dronekey==usr.ckey)
			var/list/Choices=new
			Choices.Add("Follow","Stop","Attack Target","Guard Area","Destroy Drones","Destroy this drone","Toggle Follow Mouse Clicks","Cancel") //"Guard Area"
			switch(input("Choose Option") in Choices)
				if("Guard Area")
					walk(src,0)
					attacking=0
					function=1
					spawn while(src&&function)
						var/obj/items/Door_Pass/L //=null
						sleep(5)
						for(var/mob/P in oview(12,src)) for(L in P) // for(var/mob/player/P in oview(12,src)) for(L in usr)  for(L in usr)  original   NPC_AI not taken into account.  Drones not attacking each other. /mob/Drone  /NPC_AI/Hostile/Tiger_Bandit
							for(L in P.contents)
								if(L.Password == src.Password) break
//								else if(src.Allow_Move(get_dir(src,P)))
//									step_towards(src,P)
//									break
							sleep(2)
				if("Destroy Drones") for(var/mob/Drone/A) if(dronekey==usr.ckey) del(A)
				if("Destroy this drone") del(src)
				if("Follow")
					function=0
					attacking=1
					walk(src,0)
					walk_towards(src,usr,3)
				if("Stop")
					function=0
					walk(src,0)
				if("Attack Target")
					walk(src,0)
					function=0
					attacking=0
					var/mob/list/Targets=new
					for(var/mob/M in oview(12,src)) Targets.Add(M)
//					var/mob/Choice=input("Attack who?") in Targets
					sleep(2)
					function=1
					while(src&&function)
//						if(src.Allow_Move(get_dir(src,Choice)))
//							step_towards(src,Choice)
						sleep(2)
				if("Toggle Follow Mouse Clicks")
					usr.SplitFollowsMouse=!usr.SplitFollowsMouse
					usr<<"SplitFollowsMouse is now [usr.SplitFollowsMouse]."
					if(function==2) function=0
					return
	proc/DoChoice(var/_choice,var/clickT)
		switch(_choice)
			if("Click Target")
				walk(src,0)
				function=0
				//attacking=0
				function=2
//				if(src.Allow_Move(get_dir(src,clickT))) walk_towards(src,clickT,3)

	verb/Upgrade()
		set src in view(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=40000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
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
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		BP=(Upgrade)*2
		Str=(Upgrade/100)*SoftStatCap
		End=(Upgrade/100)*SoftStatCap
		Spd=(Upgrade/100)*SoftStatCap
		Off=(Upgrade/100)*SoftStatCap
		Def=(Upgrade/100)*SoftStatCap
		view(src)<<"[src]: New combat parameters identified. (BP:[BP] Str:[Str] End:[End] Spd:[Spd] Off:[Off] Def:[Def])"
	verb/Set_Password()
		set src in oview(1)
		if(!Password)
			Password=input("Enter a password to keep this drone from being stolen from you.") as text
			usr<<"Password set!"
	verb/Claim_Drone()
		set src in oview(1)
		var/Claim_Drone=input("What is this drone's password?")
		if (Claim_Drone!=Password)
			usr<<"Incorrect password."
		if (Claim_Drone==Password)
			dronekey=usr.ckey
			usr<<"You have claimed this drone!"