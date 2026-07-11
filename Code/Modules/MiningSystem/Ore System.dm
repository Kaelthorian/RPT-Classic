mob/var
	IsMiningDeep = 0
mob/proc/MiningLevelCheck()
	if(Mining_XP>=Mining_Next&&Mining_Level<TechCap)
		Mining_XP-=Mining_Next
		Mining_Next=round(Mining_Next*1.06)
		Mining_Level++
		if(Mining_XP>=Mining_Next&&Mining_Level<TechCap) MiningLevelCheck()
	if(Mining_Level>=TechCap) Mining_XP=0
//	UpdateStats("Mining")
mob/proc/SmithingLevelCheck()
	if(Smithing_XP>=Smithing_Next&&Smithing_Level<TechCap)
		Smithing_XP-=Smithing_Next
		Smithing_Next=round(Smithing_Next*1.06)
		Smithing_Level++
		if(Smithing_XP>=Smithing_Next&&Smithing_Level<TechCap) SmithingLevelCheck()
	if(Smithing_Level>=TechCap) Smithing_XP=0

//	UpdateStats("Smithing")




mob/verb/Sense_Exit()
	set category="Other"
	if(usr.z==1)
		for(var/turf/atom/Caves/A)
			if(A.z==usr.z)
				usr<<"Exit [A.name] [Distance2(A,usr)] tiles away"




obj/items/var/SellingPrice=0

obj/items/rawmetal
//	Savable=0
	var
		GivesXP=300
		ReqSkill=1
	verb/Practice()
		set category=null
		var/HasBoost=0
		if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
		if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill)
			if(usr.Confirm("Train your Smithing skill, destroying [src] in the process?"))
				view(usr)<<"[usr] has practiced their Smithing! ([src])."
				var/XPG=GivesXP
				if(usr.HasLiberalArtsDegree)
					usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
					usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
				usr.Smithing_XP+=XPG
				usr.SmithingLevelCheck()
			//	usr.UpdateStats("Smithing")
				del(src)
		else usr<<"You require Smithing level [ReqSkill] to use this."
	Copper_Ingot
		icon='Copper Bar.dmi'
		//icon_state="Copper"
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Normal_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Normal_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Normal_Gauntlets/K in usr) Items+=K
				for(var/obj/items/storage/Basic_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Utility_Belt/Normal_Utility_Belt/K in view(usr)) Items+=K
				for(var/obj/items/rawmetal/Tin_Ingot/K in usr) Items+=K
				for(var/obj/items/Clothes/Sentai_Helmet/K in view(usr)) Items+=K
				for(var/obj/items/Armor/K in usr)
					if(istype(K,/obj/items/Armor/Copper_Armor))continue
					if(istype(K,/obj/items/Armor/Bronze_Armor))continue
					if(istype(K,/obj/items/Armor/Iron_Armor))continue
					if(istype(K,/obj/items/Armor/Mythril_Armor))continue
					if(istype(K,/obj/items/Armor/Masterwork_Armor))continue
					Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					if(C.suffix)
						usr<<"Unquip the item first"
						return
					var/Creating
					if(istype(C,/obj/items/Sword/Normal_Sword)) Creating=/obj/items/Sword/Copper_Sword
					if(istype(C,/obj/items/Hammer/Normal_Hammer)) Creating=/obj/items/Hammer/Copper_Hammer
					if(istype(C,/obj/items/Gauntlets/Normal_Gauntlets)) Creating=/obj/items/Gauntlets/Copper_Gauntlets
					if(istype(C,/obj/items/Armor)) Creating=/obj/items/Armor/Copper_Armor
					if(istype(C,/obj/items/storage/Basic_Chest)) Creating=/obj/items/storage/Copper_Chest
					if(istype(C,/obj/items/Clothes/Sentai_Helmet)) Creating=/obj/items/Helmet/Copper_Helmet
					if(istype(C,/obj/items/rawmetal/Tin_Ingot)) Creating=/obj/items/Sword/Practice_Sword
					if(istype(C,/obj/items/Utility_Belt/Normal_Utility_Belt)) Creating=/obj/items/Utility_Belt/Copper_Utility_Belt
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					A.magical=A.magical
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."

	Tin_Ingot
		GivesXP=1500
		ReqSkill=10
		icon='Tin Bar.dmi'
		//icon_state="Tin"
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Copper_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Copper_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Copper_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Copper_Armor/K in usr) Items+=K
				for(var/obj/items/Utility_Belt/Copper_Utility_Belt/K in usr) Items+=K
				for(var/obj/items/ingredients/Fishing_Line/K in usr) Items+=K
				for(var/obj/items/ingredients/Heart_Of_The_Mountain/K in usr) Items+=K
				for(var/obj/items/storage/Copper_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Copper_Helmet/K in view(usr)) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					if(C.suffix)
						usr<<"Unquip the item first"
						return
					var/Creating
					if(istype(C,/obj/items/Sword/Copper_Sword)) Creating=/obj/items/Sword/Bronze_Sword
					if(istype(C,/obj/items/Hammer/Copper_Hammer)) Creating=/obj/items/Hammer/Bronze_Hammer
					if(istype(C,/obj/items/Gauntlets/Copper_Gauntlets)) Creating=/obj/items/Gauntlets/Bronze_Gauntlets
					if(istype(C,/obj/items/Armor/Copper_Armor)) Creating=/obj/items/Armor/Bronze_Armor
					if(istype(C,/obj/items/ingredients/Fishing_Line)) Creating=/obj/items/fishingpole/Old_Rod
					if(istype(C,/obj/items/ingredients/Heart_Of_The_Mountain)) Creating=/obj/items/pickaxe/Old_Pickaxe
					if(istype(C,/obj/items/storage/Copper_Chest)) Creating=/obj/items/storage/Bronze_Chest
					if(istype(C,/obj/items/Helmet/Copper_Helmet)) Creating=/obj/items/Helmet/Bronze_Helmet
					if(istype(C,/obj/items/Utility_Belt/Copper_Utility_Belt)) Creating=/obj/items/Utility_Belt/Bronze_Utility_Belt
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."

	Silver_Ingot
		GivesXP=3000
		ReqSkill=25
		icon='Tin Bar.dmi'
		New()
			..()
			icon+=rgb(100,100,100)
		//icon_state="Tin"
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill&&!usr.KOd)
				var/list/Items=new
/*
				for(var/obj/items/Sword/Bronze_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Bronze_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Bronze_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Bronze_Armor/K in usr) Items+=K
*/
				for(var/obj/items/Sword/Mythril_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Mythril_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Mythril_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Mythril_Armor/K in usr) Items+=K
				for(var/obj/items/storage/Mythril_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Mythril_Helmet/K in view(usr)) Items+=K
				for(var/obj/items/Utility_Belt/Mythril_Utility_Belt/K in view(usr)) Items+=K

				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					if(C.suffix)
						usr<<"Unquip the item first"
						return
					var/Creating
					if(istype(C,/obj/items/Sword/Mythril_Sword)) Creating=/obj/items/Sword/Silver_Sword
					if(istype(C,/obj/items/Hammer/Mythril_Hammer)) Creating=/obj/items/Hammer/Silver_Hammer
					if(istype(C,/obj/items/Gauntlets/Mythril_Gauntlets)) Creating=/obj/items/Gauntlets/Silver_Gauntlets
					if(istype(C,/obj/items/Armor/Mythril_Armor)) Creating=/obj/items/Armor/Silver_Armor
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."

	Iron_Ingot
		GivesXP=5000
		ReqSkill=30
		icon='Iron Bar.dmi'
		//icon_state="Iron"
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Bronze_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Bronze_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Bronze_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Bronze_Armor/K in usr) Items+=K
				for(var/obj/items/Utility_Belt/Bronze_Utility_Belt/K in usr) Items+=K
				for(var/obj/items/fishingpole/Old_Rod/K in usr) Items+=K
				for(var/obj/items/pickaxe/Old_Pickaxe/K in usr) Items+=K
				for(var/obj/items/storage/Bronze_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Bronze_Helmet/K in view(usr)) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					if(C.suffix)
						usr<<"Unquip the item first"
						return
					var/Creating
					if(istype(C,/obj/items/Sword/Bronze_Sword)) Creating=/obj/items/Sword/Iron_Sword
					if(istype(C,/obj/items/Hammer/Bronze_Hammer)) Creating=/obj/items/Hammer/Iron_Hammer
					if(istype(C,/obj/items/Gauntlets/Bronze_Gauntlets)) Creating=/obj/items/Gauntlets/Iron_Gauntlets
					if(istype(C,/obj/items/Armor/Bronze_Armor)) Creating=/obj/items/Armor/Iron_Armor
					if(istype(C,/obj/items/fishingpole/Old_Rod)) Creating=/obj/items/fishingpole/Good_Rod
					if(istype(C,/obj/items/pickaxe/Old_Pickaxe)) Creating=/obj/items/pickaxe/Good_Pickaxe
					if(istype(C,/obj/items/storage/Bronze_Chest)) Creating=/obj/items/storage/Iron_Chest
					if(istype(C,/obj/items/Utility_Belt/Bronze_Utility_Belt)) Creating=/obj/items/Utility_Belt/Iron_Utility_Belt
					if(istype(C,/obj/items/Helmet/Bronze_Helmet)) Creating=/obj/items/Helmet/Iron_Helmet
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."
	Mythril_Ingot
		GivesXP=8000
		ReqSkill=50
		icon='Mythril Bar.dmi'
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Iron_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Iron_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Iron_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Iron_Armor/K in usr) Items+=K
				for(var/obj/items/Utility_Belt/Iron_Utility_Belt/K in usr) Items+=K
				for(var/obj/items/fishingpole/Good_Rod/K in usr) Items+=K
				for(var/obj/items/pickaxe/Good_Pickaxe/K in usr) Items+=K
				for(var/obj/items/storage/Iron_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Iron_Helmet/K in view(usr)) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					if(C.suffix)
						usr<<"Unquip the item first"
						return
					var/Creating
					if(istype(C,/obj/items/Sword/Iron_Sword)) Creating=/obj/items/Sword/Mythril_Sword
					if(istype(C,/obj/items/Hammer/Iron_Hammer)) Creating=/obj/items/Hammer/Mythril_Hammer
					if(istype(C,/obj/items/Gauntlets/Iron_Gauntlets)) Creating=/obj/items/Gauntlets/Mythril_Gauntlets
					if(istype(C,/obj/items/Armor/Iron_Armor)) Creating=/obj/items/Armor/Mythril_Armor
					if(istype(C,/obj/items/fishingpole/Good_Rod)) Creating=/obj/items/fishingpole/Super_Rod
					if(istype(C,/obj/items/pickaxe/Good_Pickaxe)) Creating=/obj/items/pickaxe/Super_Pickaxe
					if(istype(C,/obj/items/storage/Iron_Chest)) Creating=/obj/items/storage/Mythril_Chest
					if(istype(C,/obj/items/Helmet/Iron_Helmet)) Creating=/obj/items/Helmet/Mythril_Helmet
					if(istype(C,/obj/items/Utility_Belt/Iron_Utility_Belt)) Creating=/obj/items/Utility_Belt/Mythril_Utility_Belt
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."
	Auracite_Ingot
		GivesXP=12000
		ReqSkill=45
		icon='Mythril Bar.dmi'
		desc="This is used for blacksmithing."
		New()
			..()
			icon+=rgb(66,66,66)
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill&&!usr.KOd)
				var/list/Items=new

				for(var/obj/items/Sword/Silver_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Silver_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Silver_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Silver_Armor/K in usr) Items+=K


				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					if(C.suffix)
						usr<<"Unquip the item first"
						return
					var/Creating
					if(istype(C,/obj/items/Sword/Silver_Sword)) Creating=/obj/items/Sword/Auracite_Sword
					if(istype(C,/obj/items/Hammer/Silver_Hammer)) Creating=/obj/items/Hammer/Auracite_Hammer
					if(istype(C,/obj/items/Gauntlets/Silver_Gauntlets)) Creating=/obj/items/Gauntlets/Auracite_Gauntlets
					if(istype(C,/obj/items/Armor/Silver_Armor)) Creating=/obj/items/Armor/Auracite_Armor
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."


obj/items/rawore
	Savable=0
	var
		GivesXP=300
		ReqSkill=1
		ResultingOre=/obj/items/rawmetal/Copper_Ingot
	Copper
		icon='Copper Raw.dmi'
		//icon_state="Copper"
		ResultingOre=/obj/items/rawmetal/Copper_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Tin
		GivesXP=1500
		ReqSkill=10
		icon='Tin Raw.dmi'
		//icon_state="Tin"
		ResultingOre=/obj/items/rawmetal/Tin_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Iron
		GivesXP=5000
		ReqSkill=30
		icon='Iron Raw.dmi'
		//icon_state="Iron"
		ResultingOre=/obj/items/rawmetal/Iron_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Silver
		GivesXP=3000
		ReqSkill=25
		icon='Small Magic Ore.dmi'
		ResultingOre=/obj/items/rawmetal/Silver_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Mythril
		GivesXP=8000
		ReqSkill=50
		icon='Mythril Raw.dmi'
		ResultingOre=/obj/items/rawmetal/Mythril_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Auracite
		GivesXP=12000
		ReqSkill=45
		icon='Medium Magic Ore.dmi'
		New()
			..()
			icon+=rgb(35,35,35)
		ResultingOre=/obj/items/rawmetal/Auracite_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	verb
		Smelt()
			set src in view(1)
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill)
				if(!usr.IsCooking)
					view(usr)<<"[usr] starts to smelt [src]."
					usr.IsCooking=1
					var/CookSpeed=rand(300,600)
					if(locate(/obj/items/furnace/Advanced_Furnace) in view(2,usr)) CookSpeed-=400
					else if(locate(/obj/items/furnace/Basic_Forge) in view(2,usr)) CookSpeed-=200
					if(usr.Smithing_Level+HasBoost>=15) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=30) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=45) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=60) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=75) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=90) CookSpeed*=0.9
					if(CookSpeed<5)CookSpeed=5
					spawn(CookSpeed) if(src&&usr&&usr.IsCooking)
						view(usr)<<"[usr] has finished smelting [src]."
						var/obj/items/cookedfood/A=new ResultingOre
						var/XPG=GivesXP/4
						usr.Smithing_XP+=XPG
						if(usr.HasLiberalArtsDegree)
							usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
							usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
						usr.SmithingLevelCheck()
						usr.contents+=A
						usr.IsCooking=0
//						usr.InventoryCheck()
						del(src)
				else usr<<"You may only smelt one thing at a time."
			else usr<<"You require smithing level [ReqSkill] to smelt this."
		Sell()
			var/tmp/SpamStop=0
			if(SpamStop==1)
				usr<<"Please wait to sell more"
				return
			switch(input(usr ,"What you want to sell it for?") in list("Mana","Resources","Cancel"))
				if("Resources")
					for(var/obj/Resources/M in usr)
						var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
						M.Value += Selling
						usr<<"You sell it for $[Selling] Resources."
						del(src)
						SpamStop=1
						sleep(20)
						SpamStop=0
				if("Mana")
					for(var/obj/Mana/M in usr)
						var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
						M.Value += Selling
						usr<<"You sell it for $[Selling] Mana."
						del(src)
						SpamStop=1
						sleep(20)
						SpamStop=0
		Sell_All()
			var/tmp/SpamStop=0
			if(SpamStop==1)
				usr<<"Please wait to sell more"
				return
			switch(input(usr ,"What you want to sell it for?") in list("Mana","Resources","Cancel"))
				if("Resources")
					for(var/obj/items/rawore/L in usr)
						for(var/obj/Resources/M in usr)
							var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
							M.Value += Selling
							usr<<"You sell it for $[Selling] Resources."
							del(src)
							SpamStop=1
							sleep(20)
							SpamStop=0
							return
				if("Mana")
					for(var/obj/items/rawore/L in usr)
						for(var/obj/Mana/M in usr)
							var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
							M.Value += Selling
							usr<<"You sell it for $[Selling] Mana."
							del(src)
							SpamStop=1
							sleep(20)
							SpamStop=0
							return
			return
mob/var
	MineX
	MineY
	MineZ
mob/var/tmp/IsMining=0
area/UndergroundMine
	luminosity = 1
	Earth
		Entrance
	Namek
	Vegeta
		Entrance
	Ice
	Arconia
		Entrance
	New()
		..()
		Mines +=src
	Del()
		Mines-=src
		..()

turf/atom/Underground
	var/tmp/HasOre=0
	var/tmp/ExtraOre=0
	New()
		..()
		if(prob(10)) OreGenerate()
	proc/OreGenerate()
		src.HasOre=0
		src.overlays=null
		if(prob(1))
			HasOre++
			if(prob(20)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15))
				HasOre++
				if(prob(10)) HasOre++
		switch(HasOre)
			if(1) overlays+='Copper Ore Small.dmi'
			if(2) overlays+='Tin Ore Small.dmi'
			if(3) overlays+='Iron Ore  Small.dmi'
			if(4) overlays+='Mythril Ore Small.dmi'
			if(5) overlays+='Small Magic Ore.dmi'
			if(6) overlays+='Medium Magic Ore.dmi'
		if(prob(20)) ExtraOre++
		if(HasOre) luminosity = 5
		if(ExtraOre)
			src.overlays=null
			switch(HasOre)
				if(1) overlays+='Copper Ore Medium.dmi'
				if(2) overlays+='Tin Ore Medium.dmi'
				if(3) overlays+='Iron Ore  Medium.dmi'
				if(4) overlays+='Mythril Ore.dmi'



	proc/OreGenerate2()
		src.HasOre=0
		src.overlays=null
		if(prob(66))
			if(z==1) Gravity=(EarthGrav)
			else if(z==2) Gravity=(NamekGrav)
			else if(z==3) Gravity=(VegetaGrav)
			else if(z==5) Gravity=(ArconiaGrav)
			else if(z==4) Gravity=(IceGrav)
			else Gravity=(1)
		if(prob(30))
			HasOre++
			if(prob(20)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15))
				HasOre++
				if(prob(10)) HasOre++
		switch(HasOre)
			if(1) overlays+='Copper Ore Small.dmi'
			if(2) overlays+='Tin Ore Small.dmi'
			if(3) overlays+='Iron Ore  Small.dmi'
			if(4) overlays+='Mythril Ore Small.dmi'
			if(5) overlays+='Small Magic Ore.dmi'
			if(6) overlays+='Medium Magic Ore.dmi'
		if(prob(20)) ExtraOre++
		if(ExtraOre)
			src.overlays=null
			switch(HasOre)
				if(1) overlays+='Copper Ore Medium.dmi'
				if(2) overlays+='Tin Ore Medium.dmi'
				if(3) overlays+='Iron Ore  Medium.dmi'
				if(4) overlays+='Mythril Ore.dmi'

	verb
		Mine()
			set src in view(1)
			if(src.HasOre&&!usr.IsMining&&!usr.KOd)
				var/SkillNeed=1
				var/obj/items/rawore/A=/obj/items/rawore/Copper
				if(src.HasOre==2)
					SkillNeed=10
					A=/obj/items/rawore/Tin
				if(src.HasOre==3)
					SkillNeed=30
					A=/obj/items/rawore/Iron
				if(src.HasOre==4)
					SkillNeed=50
					A=/obj/items/rawore/Mythril
				if(src.HasOre==5)
					SkillNeed=25
					A=/obj/items/rawore/Silver
				if(src.HasOre==6)
					SkillNeed=45
					A=/obj/items/rawore/Auracite
				var/HasBoost=0
				if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
				if(usr.Mining_Level+HasBoost+(usr.HasMasterBlacksmith*15)<SkillNeed)
					usr<< "You require mining level [SkillNeed] in order to mine this."
					return
				view(usr)<<"[usr] starts to mine at the [src]."
				var/R=rand(1,1000)
				usr.IsMining=R
				var/MineSpeed=rand(300,600)
				if(locate(/obj/items/pickaxe/Super_Pickaxe) in usr) MineSpeed-=200
				else if(locate(/obj/items/pickaxe/Good_Pickaxe) in usr) MineSpeed-=140
				else if(locate(/obj/items/pickaxe/Old_Pickaxe) in usr) MineSpeed-=75
				if(usr.Mining_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=15) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=30) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=45) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=60) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=75) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=90) MineSpeed*=0.9
				spawn(MineSpeed) if(src&&usr&&usr.IsMining==R&&HasOre)
					if(prob(1))
						usr<<"You manage to find a heart of the mountain."
						usr.contents+= new /obj/items/ingredients/Heart_Of_The_Mountain
					var/obj/items/rawore/AA=new A
					var/XPG=AA.GivesXP
					usr.Mining_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.MiningLevelCheck()
					usr.contents+=AA
					view(usr)<<"[usr] has mined out a [AA] ore!"
					if(ExtraOre)
						var/obj/items/rawore/AAA=new A
						usr.contents+=AAA
						view(usr)<<"[usr] has mined out a [AA] ore!"
					usr.IsMining=0
//					usr.InventoryCheck()
					src.HasOre=0
					src.overlays=null


