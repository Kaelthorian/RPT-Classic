obj/items
	Hammer
		icon='Sledgehammer.dmi'
		Health=1000

		Savable = 1
		MaxBPAdd=1
		Durability=100
		MaxDurability=100
		var/Spd=0.85
		var/Off=0.75
		New()
			if(prob(50)) icon='Hammer.dmi'
		//	else if(prob(25)) icon='Great Oar.dmi'
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed +[MaxBPAdd]% your own BP. [Spd*100]% Speed and [Off*100]% Offense."

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
					if(usr.KiFists)
						usr<<"This can not be used with a hammer"
						return
					if(usr.KiBlade)
						usr<<"This can not be used with a hammer"
						return
					if(usr.SpiritSword)
						usr<<"This can not be used with a hammer"
						return
					if(usr.KiHammer)
						usr<<"This can not be used with a hammer"
						return
					usr.HammerOn=1+CanCrit
					//usr.StrMult*=1.1
					if(usr.HasHammerTime) usr.SpdMult*=(Spd+0.06)
					else usr.SpdMult*=Spd
					if(usr.HasHammerTime) usr.OffMult*=(Off+0.06)
					else usr.OffMult*=Off
					suffix="*Equipped*"
					usr.NoWeapon=0
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
					if(!usr.HammerOn)
						usr<<"You are not currently wearing a hammer."
						return
					suffix=null
					usr.HammerOn=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					//usr.StrMult/=1.1
					if(usr.HasHammerTime) usr.SpdMult/=(Spd+0.06)
					else usr.SpdMult/=Spd
					if(usr.HasHammerTime) usr.OffMult/=(Off+0.06)
					else usr.OffMult/=Off
					usr.Equip_Magic(src,"Remove")
					for(var/Skill/Buff/Bushido/SF in usr) if(SF.Using) SF.use(usr)
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Upgrade()
			set src in view(1)
			var/R=input("Resources or Mana?") in list("Resources","Mana","Cancel")
			if(R=="Resources")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Amount=round(input("Add how much BP to this hammer's attack power?") as num)
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
				var/Amount=round(input("Add how much BP to this hammer's attack power?") as num)
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


		Normal_Hammer
			MaxBPAdd=35
			Off=0.78
			Spd=0.82
		Copper_Hammer
			MaxBPAdd=65
			Off=0.78
			Spd=0.82
		Bronze_Hammer
			MaxBPAdd=70
			Off=0.79
			Spd=0.82
		Iron_Hammer
			MaxBPAdd=75
			Off=0.8
			Spd=0.82
		Mythril_Hammer
			MaxBPAdd=80
			Off=0.81
			Spd=0.82
		Silver_Hammer
			MaxBPAdd=85
			Off=0.82
			Spd=0.82
		Auracite_Hammer
			MaxBPAdd=90
			Off=0.84
			Spd=0.82
		Masterwork_Hammer
			MaxBPAdd=100
			Off=0.84
			Spd=0.82