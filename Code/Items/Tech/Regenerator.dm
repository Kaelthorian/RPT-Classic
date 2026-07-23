obj/items
	Regenerator
		Grabbable = 1
		Savable=1
		desc="Stepping into this will accelerate your healing rate. It heals faster the more upgraded \
		it is. It will break in the strain of high gravity."
		icon = 'New regen tank.dmi'
		layer=MOB_LAYER+1
		New()
			..()
			src.pixel_x = -32
			src.pixel_y = -16
			spawn if(src) Regenerator_Loop()
		proc/Regenerator_Loop()
			set waitfor=0
			while(src)
				if(z) if(icon_state!="ez")
					if(z==0&&isnull(loc)) del(src)
					for(var/turf/A in range(0,src)) if(A.Gravity>25)if(prob(50))
						icon_state="middlebroke"
						view(src)<<"The [src] is crushed by the force of the gravity!"
						del(src)
					for(var/mob/A in range(0,src))
						if(A.Willpower<=0)
							A.WillpowerRestore() // if(A.Willpower<=0) if(!A.LethalCombatTracker) A.WillpowerRestore()
							A.Health=1
						if(A.Willpower<A.MaxWillpower&&A.Willpower>0) A.Willpower+=0.05
						if(A.LethalCombatTracker) A.LethalCombatTracker--
						if(A.Health<A.MaxHealth)
							A.Health+= 0.3*Level*A.Regeneration
							if(A.KOd&&A.Health>=A.MaxHealth) A.Un_KO()
						for(var/BodyPart/P in A) if(P.Health<P.MaxHealth)
							A.Injure_Heal(Level*0.01*A.Regeneration,P)
							if(prob(Level*0.02)) P.InjuryHealed(A)
						if(A.Willpower>A.MaxWillpower) A.Willpower=A.MaxWillpower
						if(A.Health>A.Willpower) A.Health=A.Willpower
						for(var/Skill/Support/Send_Energy/SE in A) SE.Active=0
						break
					for(var/obj/items/Regenerator/R in range(0,src)) if(R!=src)
						view(src)<<"You hear glass begin to crack..."
						sleep(1)
						del(src)
				sleep(60)
		verb/Bolt()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				Bolted=1
				Shockwaveable=0
				range(20,src)<<"[usr] bolts the [src] to the ground."

				return
			if(Bolted) if(src.Builder=="[usr.real_name]")
				range(20,src)<<"[usr] unbolts the [src] from the ground."
				Bolted=0
				Shockwaveable=1

				return
			SaveItemATOM(src)
		verb/Upgrade()
			set src in view(1)
			if(usr.Int_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Cost=20000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			var/Max_Upgrade=(A.Value/Cost)+Tech
			if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
//			if(usr.Int_Level>80&&!CapsuleTech) if(usr.Confirm("Add capsule tech for [Cost*10]?"))
//				if(Cost*10>A.Value)
//					usr<<"You do not have enough resources to add capsule tech."
//					return
//				A.Value-=Cost*10
//				src.cost += Cost*10
//				CapsuleTech=1
//				usr<<"Capsule Tech added! You may now add this item to your inventory!"
//				return
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
			icon_state="middle"
			Level=0.1*Upgrade*0.01*rand(50,200)
			desc="Level [Tech] [src]"
			SaveItemATOM(src)