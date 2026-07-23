obj/items
	Sword
		var/Off=0.75
		icon='Sword_Trunks.dmi'
		Health=1000

		Savable = 1
		MaxBPAdd=1
		Durability=100
		MaxDurability=100
		New()
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed +[MaxBPAdd]% your own BP, reduces your Offense to [Off*100]%."

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
					if(usr.SwordOn)
						usr<<"You are already wearing a sword."
						return
					if(usr.HammerOn)
						usr<<"You are already wearing a hammer."
						return
					if(usr.GlovesOn)
						usr<<"You are already wearing gauntlets."
						return
					if(usr.KiFists)
						usr<<"This can not be used with a sword"
						return
					if(usr.KiBlade)
						usr<<"This can not be used with a sword"
						return
					if(usr.SpiritSword)
						usr<<"This can not be used with a sword"
						return
					if(usr.KiHammer)
						usr<<"This can not be used with a sword"
						return
					usr.SwordOn=1+CanCrit
					if(usr.HasSwordsman) usr.OffMult*=(Off+0.08)
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
					if(!usr.SwordOn)
						usr<<"You are not currently wearing a sword."
						return
					suffix=null
					usr.SwordOn=0
					usr.NoWeapon=1
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					//usr.StrMult/=1.1
					if(usr.HasSwordsman) usr.OffMult/=(Off+0.08)
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
				var/Amount=round(input("Add how much BP to this sword's attack power?") as num)
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
				var/Amount=round(input("Add how much BP to this sword's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Magic_Potential
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				src.EquipmentDescAssign()
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

		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
		Normal_Sword
			MaxBPAdd=25
			Off=0.78
		Practice_Sword
			icon='Great Oar.dmi'
			MaxBPAdd=1
		Copper_Sword
			MaxBPAdd=35
			Off=0.78
		Bronze_Sword
			MaxBPAdd=40
			Off=0.79
		Iron_Sword
			MaxBPAdd=45
			Off=0.8
		Mythril_Sword
			MaxBPAdd=50
			Off=0.81
		Silver_Sword
			MaxBPAdd=55
			Off=0.82
		Auracite_Sword
			MaxBPAdd=60
			Off=0.83
		Masterwork_Sword
			MaxBPAdd=65
			Off=0.84