obj/items
	Magic_Mask
		icon='Ichigo.dmi'
		Health=1000

		Savable = 1
		New()
			desc="<br>+[Commas(Health)] BP to each ki attack. However this bonus cannot exceed +33% your own BP, additionally you lose 25% Offense."

		Click()
			if(src in usr)
				if(usr.Redoing_Stats) return
				for(var/obj/items/Magic_Mask/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a sword equipped."
					return
				if(Durability<=1)
					usr<<"[src] has 0 Durability. Repair it first."
					return
				if(!suffix)
					if(usr.MaskOn)
						usr<<"You are already wearing a mask."
						return
					usr.MaskOn=1
					//usr.OffMult*=0.75
					usr.OffMult*=0.75
					suffix="*Equipped*"
					usr.Equip_Magic(src,"Add")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					//usr.StrMult*=1.1
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					if(!usr.MaskOn)
						usr<<"You are not currently wearing a mask."
						return
					suffix=null
					usr.MaskOn=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					//usr.StrMult/=1.1
					usr.OffMult/=0.75
					usr.Equip_Magic(src,"Remove")
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Upgrade()
			set src in view(1)
			var/R=input("Resources or Mana?") in list("Resources","Mana","Cancel")
			if(R=="Resources")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Amount=round(input("Add how much BP to this sword's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Int_Mod
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				desc="<br>+[Commas(Health)] BP to each ki attack. However this bonus cannot exceed +33% your own BP, additionally you lose 25% Offense."
			if(R=="Mana")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Amount=round(input("Add how much BP to this sword's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Magic_Potential
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				desc="<br>+[Commas(Health)] BP to each ki attack. However this bonus cannot exceed +33% your own BP, additionally you lose 25% Offense."
		verb/Repair()
			set src in oview(1)
			var/R=input("Intelligence or Magic?") in list("Intelligence","Magic","Cancel")
			if(R=="Intelligence")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=cost/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
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

		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src