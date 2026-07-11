obj/items
	Gauntlets
		icon='Clothes_Gloves.dmi'
		Health=1000

		Savable = 1
		MaxBPAdd=1
		Durability=100
		MaxDurability=100
		var/Firearm=0
		New()
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed +[MaxBPAdd]% your own BP. Can be enchanted to enhance your power."

		Click()
			if(src in usr)
				if(usr.Redoing_Stats) return
				for(var/obj/items/Sword/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a sword equipped."
					return
				if(Durability<=1)
					usr<<"[src] has 0 Durability. Repair it first."
					return
				if(!suffix)
					if(usr.HammerOn)
						usr<<"You are already wearing a hammer."
						return
					if(usr.SwordOn)
						usr<<"You are already wearing a sword."
						return
					if(usr.GlovesOn)
						usr<<"You are already wearing gauntlets."
						return
					usr.GlovesOn=1+CanCrit
					//usr.StrMult*=1.2
					suffix="*Equipped*"
					usr.NoWeapon=0
					usr.Equip_Magic(src,"Add")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					if(!usr.GlovesOn)
						usr<<"You are not currently wearing a sword."
						return
					suffix=null
					usr.GlovesOn=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					//usr.StrMult/=1.2
					usr.Equip_Magic(src,"Remove")
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Upgrade()
			set src in view(1)
			var/list/Cs=list("Resources","Mana","Cancel")
			//if(usr.Int_Level>=70&&usr.Int_Mod>=3&&!Firearm) Cs+="Add Firearm Attachment"
			var/R=input("Resources or Mana?") in Cs
			/*if(R=="Add Firearm Attachment")
				if(usr.Confirm("Would you like to add a firearm attachment to [src]? It will empower your Blast and Charge by causing them to use the higher of your strength or force stat and will decrease the drain by 50% but requires the NRA Membership MP for these benefits."))
					if(GCost>A.Value)
						usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
						return
					A.Value-=Cost
					cost += GCost
					Firearm=1*/

			if(R=="Resources")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Amount=round(input("Add how much BP to [src]'s attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Int_Mod
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")

				src.EquipmentDescAssign()
			if(R=="Mana")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Amount=round(input("Add how much BP to [src]'s attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Magic_Potential
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				src.EquipmentDescAssign()

		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
		verb/Repair()
			set src in oview(1)
			var/R=input("Intelligence or Magic?") in list("Intelligence","Magic","Cancel")
			if(R=="Intelligence")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=500000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
				if(!usr.Confirm("Repair [src] for [Cost] resources?")) return
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough resources to repair [src]"
					return
				A.Value-=Cost
				Durability=MaxDurability
				view(usr)<<"[usr] repairs [src]."


			if(R=="Magic")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Cost=800000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
				if(!usr.Confirm("Repair [src] for [Cost] mana?")) return
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough mana to repair [src]"
					return
				A.Value-=Cost
				Durability=MaxDurability
				view(usr)<<"[usr] repairs [src]."

		Normal_Gauntlets
			MaxBPAdd=1
		Copper_Gauntlets
			MaxBPAdd=5
		Bronze_Gauntlets
			MaxBPAdd=10
		Iron_Gauntlets
			MaxBPAdd=15
		Mythril_Gauntlets
			MaxBPAdd=20
		Silver_Gauntlets
			MaxBPAdd=25
		Auracite_Gauntlets
			MaxBPAdd=30
		Masterwork_Gauntlets
			MaxBPAdd=35