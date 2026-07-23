obj/items
	Digging
		var/DigMult=1
		var/ExtraDigMult=0
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

		Shovel
			icon='Shovel.dmi'
			desc="This will help increase the speed at which you can dig up resources."
			DigMult=5
			Flammable = 1
			Click() if(src in usr)
				for(var/obj/items/Digging/A in usr) if(A!=src&&A.suffix)
					usr<<"You already have one equipped."
					return
				if(!suffix) suffix="*Equipped*"
				else suffix=null
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Equips" : "Unqequips"] the [src]\n")
		Hand_Drill
			icon='Drill Hand 2.dmi'
			desc="This will help increase the speed at which you can dig up resources."
			DigMult=1
			New()
				name="Level [DigMult] Hand Drill (+[ExtraDigMult])"
				..()
			Click() if(src in usr)
				for(var/obj/items/Digging/A in usr) if(A!=src&&A.suffix)
					usr<<"You already have one equipped."
					return
				if(!suffix) suffix="*Equipped*"
				else suffix=null
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Unequips" : "Equips"] the [src]\n")
			verb/Upgrade()
				set src in view(1)
				if(usr.Int_Level<DigMult)
					usr<<"This is too advanced for you to mess with."
					return
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=((100000/usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))
				var/Max_Upgrade=(A.Value/Cost)+DigMult
				if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
				if(DigMult>=Max_Upgrade)
					usr<<"It is already upgraded beyond what you can manage."
					return
				var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed intelligence), and how much resources you have. So if the maximum is less than your int skill then it is instead due to not having enough res to upgrade it higher than the said maximum.") as num
				if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
				if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
				if(Upgrade<1) Upgrade=1
				if(Upgrade<DigMult)
					usr<<"You must upgrade it to at least [DigMult+1]x."
				Upgrade=round(Upgrade)
				if(Upgrade<DigMult) return
				Cost*=Upgrade-DigMult
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
					return
				view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
				A.Value-=Cost
				DigMult=Upgrade
				name="Level [DigMult] Hand Drill (+[ExtraDigMult])"
				//desc="Level [DigMult] Hand Drill"