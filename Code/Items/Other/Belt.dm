obj/items
	Utility_Belt
		desc="This will increase your maximum inventory space."
		Normal_Utility_Belt BeltLevel=3
		Copper_Utility_Belt BeltLevel=4
		Bronze_Utility_Belt BeltLevel=5
		Iron_Utility_Belt BeltLevel=6
		Mythril_Utility_Belt BeltLevel=7
		Masterwork_Utility_Belt BeltLevel=8
		icon='Clothes_Sash.dmi'
		Health=150000

		var/BeltLevel=3
		Click()
			if(src in usr)
				for(var/obj/items/Utility_Belt/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a belt equipped."
					return
				if(!suffix)
					if(usr.HasBelt)usr.HasBelt=0
					suffix="*Equipped*"
					usr.HasBelt=BeltLevel
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					/*(!usr.HasBelt)
						usr<<"You are not currently wearing a belt."
						return*/
					suffix=null
					usr.HasBelt=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
