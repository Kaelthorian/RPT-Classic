obj/items
	Boxing_Gloves
		icon='Boxing Gloves.dmi'
		Health=100

		Flammable = 1
		New()
			desc="<br>Equipping these make your hits a lot less powerful, good for sparring. This will increase the rate at which you gain Unarmed."

		Click()
			if(src in usr)
				for(var/obj/items/Boxing_Gloves/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a set of boxing gloves equipped."
					return
				if(!suffix)
					if(usr.Lethality)
						usr<<"You shouldn't use these in lethal combat."
						return
					suffix="*Equipped*"
					var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays += _overlay
					usr.BoxingGloves=1
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					winset(usr.client,"GLOVES","is-visible=true")
					return
				else
					suffix=null
					winset(usr.client,"GLOVES","is-visible=false")
					var/image/_overlay = image(icon) // not sure if the equipped thing is an icon/object so
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays -= _overlay
					usr.BoxingGloves=0
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src