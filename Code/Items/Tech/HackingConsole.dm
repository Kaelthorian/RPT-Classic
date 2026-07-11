obj/items/Hacking_Console
	icon='Lab.dmi'
	icon_state="Labtop"

//	var/Value=0
	desc="If this is upgraded past the upgrade level of a door, it can open the door for you."
	verb/Upgrade()
		set src in view(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=10000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
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
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].\n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src] ([Value] Battery)"
		Level=Upgrade
		Value=Level**Level
	/*verb/Upgrade()
		set src in oview(1,usr)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			usr<<"You upgrade the [src] to level [Level]"
		else usr<<"It is beyond your upgrading capabilities"*/
	verb/Use()
		for(var/obj/A in get_step(usr,usr.dir))
			if(istype(A,/obj/Door))
				var/obj/Door/D=A
				if(D.Magic_Secure)
					view(usr)<<"[usr] tries to hack into the [A], but is not able to do so!"
					return
			if(A.Level+A.AntiHack<Level)
				if(prob(100))
					view(usr)<<"[usr] uses the [src] to hack into the [A] and opens it!"
					for(var/mob/player/M in view(src))
						if(!M.client) return
						M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] and opens it!\n")
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] and opens it!\n")
					if(istype(A,/obj/Door))
						var/obj/Door/D=A
						D.Open()
					if(istype(A,/obj/items/Safe))
						var/obj/items/Safe/S=A
						view(usr)<<"[usr] took [S.SafeResources] resources from the safe!"
						for(var/obj/Resources/B in usr) B.Value+=S.SafeResources
						S.SafeResources=0
					if(istype(A,/obj/items/Magic_Vault))
						var/obj/items/Magic_Vault/S=A
						view(usr)<<"[usr] took [S.SafeResources] mana from the vault!"
						for(var/obj/Mana/B in usr) B.Value+=S.SafeResources
						S.SafeResources=0
					if(istype(A,/obj/Ships/Spacepod))
						if(Level<A.Tech)
							view(usr)<<"[usr] tries to hack into the [A], but failed"
							return
						var/obj/Ships/Spacepod/Sh=A
						if(!Sh.Pilot)
							usr.isGrabbing = null
							Sh.Pilot=usr
							usr.reset_view(Sh)
							usr.S=Sh
							usr.loc=Sh.contents//locate(0,0,0)
					else if(istype(A,/obj/Ships))
						if(Level<A.Tech)
							view(usr)<<"[usr] tries to hack into the [A], but failed"
							return
						var/obj/Ships/Ship/Sh=A
						if(Sh.Ship=="Ardent"||Sh.Ship=="Icebreaker")
							for(var/obj/Airlock/C in world) if(C.Ship==Sh.Ship)
								view(usr)<<"[usr] enters the ship"
								usr.loc=locate(C.x,C.y-1,C.z)
								usr.InShip=Sh.Ship
						else for(var/obj/Airlock/C in world) if(C.Ship==Sh.Ship)
							view(usr)<<"[usr] enters the ship"
							usr.loc=locate(C.x,C.y-1,C.z)
							usr.InShip=Sh.Ship

					//if(A.Password) usr << "The password is [A.Password]"
					return
				else
					view(usr)<<"[usr] tries to hack into the [A], but failed"
					return
			else
				view(usr)<<"[usr] tries to hack into the [A], but it is too advanced"
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] but it is too advanced!\n")
				return