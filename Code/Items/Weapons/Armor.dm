obj/items/Armor
	Health=100

	var/KineticBarrier=0
	var/Spd=0.85
	var/End=1.2 //Copper Armor
	icon='Armor1.dmi'
	//desc="Wearing it will trade [Spd*100]% Speed for [End*100]% Endurance"
	New()
		desc="<br>[Commas(Health)] Health Armor. Wearing it will trade [Spd*100]% Speed for [End*100]% Endurance. (Armor Mastery adds +7% End)."
		..()
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
			Health=Tech*50
			src.EquipmentDescAssign()
			view(usr)<<"[usr] repairs [src]."


		if(R=="Magic")
			var/obj/Mana/A
			for(var/obj/Mana/B in usr) A=B
			var/Cost=500000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
			if(!usr.Confirm("Repair [src] for [Cost] mana?")) return
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough mana to repair [src]"
				return
			A.Value-=Cost
			Durability=MaxDurability
			Health=Tech*50
			src.EquipmentDescAssign()
			view(usr)<<"[usr] repairs [src]."


	verb/Upgrade()
		set src in view(1)
		var/R=input("Intelligence or Magic?") in list("Intelligence","Magic","Cancel")
		if(R=="Intelligence")
			if(usr.Int_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Cost=50000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			var/Max_Upgrade=(A.Value/Cost)+Tech
			if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
			var/Upgrade=input("Upgrade it to what level? ([Tech]-[round(Max_Upgrade)] [Cost] per level)") as num
			if(Upgrade<=0)
				return
			if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
			if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
			if(Upgrade<=Tech) return
			Upgrade=round(Upgrade)
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
				return
			A.Value-=Cost
			cost += Cost
			Tech=Upgrade
			Health=Tech*50
			src.EquipmentDescAssign()
			view(usr)<<"[usr] upgrades [src] to level [Tech]."

		if(R=="Magic")
			if(usr.Magic_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Mana/A
			for(var/obj/Mana/B in usr) A=B
			var/Cost=50000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
			var/Max_Upgrade=(A.Value/Cost)+Tech
			if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
			var/Upgrade=input("Upgrade it to what level? ([Tech]-[round(Max_Upgrade)] [Cost] per level)") as num
			if(Upgrade<=0)
				return
			if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
			if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
			if(Upgrade<=Tech) return
			Upgrade=round(Upgrade)
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough mana to upgrade it to level [Upgrade]"
				return
			A.Value-=Cost
			cost += Cost
			Tech=Upgrade
			Health=Tech*50
			src.EquipmentDescAssign()
			view(usr)<<"[usr] upgrades [src] to level [Tech]."

	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
	Click()
		if(src in usr)
			if(usr.Redoing_Stats) return
			for(var/obj/items/Armor/A in usr)
				if(A.suffix)if(A!=src)
					usr<<"You already have armor equipped."
					return
			for(var/obj/items/Power_Armor/A in usr)
				if(A.suffix)if(A!=src)
					usr<<"You already have armor equipped."
					return
			if(Durability<=1)
				usr<<"[src] has 0 Durability. Repair it first."
				return
			if(Health<=1)
				usr<<"[src] has 0 Health. Repair it first."
				return
			if(!suffix)
				if(usr.ArmorOn)
					usr<<"You are already wearing an armor."
					return
				if(usr.HelmetOn)if(!usr.HasHeavyArmorTraining)
					usr<<"You are already wearing a helmet."
					return
				suffix="*Equipped*"
				usr.ArmorOn=1+AvoidsCrits
				usr.Equip_Magic(src,"Add")
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer = src.layer
				usr.overlays+=_overlay
				if(usr.HasArmorMastery) usr.EndMult*=(End+0.07)
				else usr.EndMult*=End
				if(usr.HasArmorMastery) usr.SpdMult*=1
				else usr.SpdMult*=Spd
				for(var/mob/player/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
				return
			else
				if(!usr.ArmorOn)
					usr<<"You are not currently wearing an armor."
					return
				suffix=null
				usr.ArmorOn=0
				usr.Equip_Magic(src,"Remove")
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer = src.layer
				usr.overlays-=_overlay
				if(usr.HasArmorMastery) usr.EndMult/=(End+0.07)
				else usr.EndMult/=End
				if(usr.HasArmorMastery) usr.SpdMult/=1
				else usr.SpdMult/=Spd
				for(var/mob/player/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
				return
	Normal_Armor
	Copper_Armor
		Durability=240
		MaxDurability=240
	Bronze_Armor
		End=1.25 //Increased from 1.18
		Durability=300
		MaxDurability=300
	Iron_Armor
		Durability=400
		MaxDurability=400
		Spd=0.8
		End=1.3 //increased from 1.23
	Mythril_Armor
		Durability=600
		MaxDurability=600
		Spd=1
		End=1.2
	Masterwork_Armor
		Durability=1000
		MaxDurability=1000
		KineticBarrier=15
		Spd=0.9
		End=1.15 // increased from 1
	Silver_Armor
		End=1.3 // increased from 1.18
		Durability=400
		MaxDurability=400
		AvoidsCrits=1
	Auracite_Armor
		End=1.27 // increased from 1.2
		Durability=600
		MaxDurability=600
		AvoidsCrits=2