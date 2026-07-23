obj/items
	Disguise
		icon='Shinji.dmi'
		Health=150000

		Click()
			if(src in usr)
				for(var/obj/items/Disguise/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a Disguise equipped."
					return
				/**/
				if(!suffix)
					suffix="*Equipped*"
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					if(usr.name==usr.real_name)
						usr.name="?"
						var/DD=rand(0,12)
						while(DD>0)
							usr.name="[usr.name]?"
							DD--
					return
				else
					suffix=null
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					if(usr.name!=usr.real_name)usr.name=usr.real_name
					return