obj/items/Adamantine_Skeleton
	Health = 10000000000000000000000000000000000000000000000000000000000000000000000000
	Grabbable = 1
	Stealable=0
	density=1
	Savable=1
	Level=100
	icon = 'Adamantine Tech.dmi'
	New()
		desc="<br>This Adamantine Skeleton is nigh indesctrubtible. Installing it will increase limb health by 25 and will even increase your durability by 8%. However, this will set you to 0 willpower and knock you out."
	verb/Use()
		set src in usr
		if(usr.Redoing_Stats) return
//		if(usr.Cyborg)
//			usr<<"Cyborgs can't use power armors"
//			return
		if(Level!=100) return
		var/mob/M=input(usr,"Choose the target","Adamantine Skeleton") in view(1,usr)
		if(usr.Confirm("Install Adamantine Skeleton on [M]?"))
			/*if( M.Race == "Majin")
				usr << "Their race is unable to make use of this."
				return
			if(M.NoBreak)
				usr << "Their limbs are already immune to being broken."
				return*/
			if(M.HasAdamantineSkeleton == 0)
				Level=200
				switch(input(M,"[usr] wants to install the [src] on you. Allow it? This will knock you out and set you to 0 willpower.") in list("No","Yes"))
					if("No")
						Level=100
						return
				switch(input("Are you sure you want to proceed? they will become sterile, set to 0 willpower and be knocked out.") in list("No","Yes"))
					if("Yes")
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] applies the [src] to [M].\n")
						M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] applies the [src] to [M].\n")
						view(6,usr) << "<font color = grey>[usr] applies the [src] to [M]!"
						M.Willpower=0
						M.KO("applying the [src] to their body!")
						for(var/BodyPart/L in M)
							L.MaxHealth+=25
							M.Injure_Hurt(150,L,usr)
						M.HasAdamantineSkeleton=1
					//	M.Sterile=1
						//M.NoBreak = 1
						spawn() del(src)
					if("No") Level=100
			spawn(200) Level=100