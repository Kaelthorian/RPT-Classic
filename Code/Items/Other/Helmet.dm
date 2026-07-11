obj/items
	Helmet
		Copper_Helmet
			desc="This will make it so people can not reach you with telepathy."
			HelmetLevel=1
		Bronze_Helmet
			desc="This will make it so people can not reach you with telepathy and they can not see your status bars."
			HelmetLevel=2
			New()
				..()
				icon+=rgb(30,10,0)
		Iron_Helmet
			desc="This will make it so people can not reach you with telepathy and they can not see your status bars and you can not be observed."
			HelmetLevel=3
			icon='HelmetMask.dmi'
		Mythril_Helmet
			desc="This will make it so people can not reach you with telepathy and they can not see your status bars and you can not be observed and you can not be sensed."
			HelmetLevel=4
			icon='HelmetMask.dmi'
			New()
				..()
				icon-=rgb(30,10,0)
				icon+=rgb(0,0,10)
		Masterwork_Helmet
			desc="This will make it so people can not reach you with telepathy and they can not see your status bars and you can not be observed and you can not be sensed and your BP is hidden."
			HelmetLevel=5
			icon='BucketMask.dmi'
		icon='Iron_Helmet.dmi'
		Health=150000

		var/HelmetLevel=1
		Click()
			if(src in usr)
				/*for(var/obj/items/Helmet/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a helmet equipped."
					return*/
				/**/
				if(!suffix)
					if(usr.HelmetOn)
						usr<<"You already have a helmet equipped."
						return
					if(usr.ArmorOn||usr.PowerArmorOn)if(!usr.HasHeavyArmorTraining)
						usr<<"You can not wear armor and a helmet at the same time."
						return
					suffix="*Equipped*"
					usr.HelmetOn=HelmetLevel
					usr.Equip_Magic(src,"Add")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					if(!usr.HelmetOn)
						usr<<"You are not currently wearing a helmet."
						return
					suffix=null
					usr.HelmetOn=0
					usr.Equip_Magic(src,"Remove")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return




	var/MaxBPAdd=30
	var/CanCrit=0
	var/AvoidsCrits=0