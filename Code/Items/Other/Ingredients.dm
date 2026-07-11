obj/items/ingredients
	Fishing_Line
		icon='FishingLine.dmi'
		desc="This is some fishing line. A blacksmith can combine this with some tin to make a fishing rod."
		Flammable = 1

	Heart_Of_The_Mountain
		icon='enchantmenticons.dmi'
		icon_state="ArcanOrb"
		desc="This is a heart of the mountain. This gem can be used with some tin to fashion a pickaxe by a blacksmith or used to change a Mythril item into a Masterwork."
		Flammable = 1

		var/ReqSkill=55
		var/GivesXP=25000
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost+(usr.HasMasterBlacksmith*15)>=ReqSkill&&!usr.KOd)
				var/list/Items=new
/*
				for(var/obj/items/Sword/Mythril_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Mythril_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Mythril_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Mythril_Armor/K in usr) Items+=K
				for(var/obj/items/storage/Mythril_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Mythril_Helmet/K in view(usr)) Items+=K
				for(var/obj/items/Utility_Belt/Mythril_Utility_Belt/K in view(usr)) Items+=K
*/
				for(var/obj/items/Sword/Auracite_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Auracite_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Auracite_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Auracite_Armor/K in usr) Items+=K
				for(var/obj/items/storage/Mythril_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Mythril_Helmet/K in view(usr)) Items+=K
				for(var/obj/items/Utility_Belt/Mythril_Utility_Belt/K in view(usr)) Items+=K


				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					var/Creating
					if(istype(C,/obj/items/Sword/Auracite_Sword)) Creating=/obj/items/Sword/Masterwork_Sword
					if(istype(C,/obj/items/Hammer/Auracite_Hammer)) Creating=/obj/items/Hammer/Masterwork_Hammer
					if(istype(C,/obj/items/Gauntlets/Auracite_Gauntlets)) Creating=/obj/items/Gauntlets/Masterwork_Gauntlets
					if(istype(C,/obj/items/Armor/Auracite_Armor)) Creating=/obj/items/Armor/Masterwork_Armor
					if(istype(C,/obj/items/storage/Mythril_Chest)) Creating=/obj/items/storage/Masterwork_Chest
					if(istype(C,/obj/items/Helmet/Mythril_Helmet)) Creating=/obj/items/Helmet/Masterwork_Helmet
					if(istype(C,/obj/items/Utility_Belt/Mythril_Utility_Belt)) Creating=/obj/items/Utility_Belt/Masterwork_Utility_Belt
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
					var/XPG=GivesXP
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=XPG*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=XPG*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."


