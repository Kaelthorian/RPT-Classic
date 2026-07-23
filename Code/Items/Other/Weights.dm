obj/items
	Weights
		icon='Clothes_ShortSleeveShirt.dmi'

		Savable=0
		Flammable = 1
		var/Weight=1
		New()
			name="[round(Weight)]lb Weights"

		Click() if(locate(src) in usr)
			var/CurrentWeight=0
			var/Weights=0
			if(suffix)
				suffix=null
				usr.overlays-=icon
				view(20,usr) << "[usr] takes off the [src]."
				usr.Weights=0
				usr<<"You take off the [src]."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes the [src].\n")
				return
			for(var/obj/items/Weights/A in usr) if(A.suffix)
				CurrentWeight+=A.Weight
				Weights++
			if(!suffix&&Weights>=1)
				usr<<"You cannot wear more than 1 of these at once"
				return
			if(!suffix&&(CurrentWeight+Weight)>((usr.BPMod)*usr.Base))
				usr<<"Putting this on would exceed your maximum lift."
				return
			if(!suffix)
				suffix="*Equipped*"
				usr.overlays+=icon
				view(20,usr) << "[usr] puts on the [src]."
				usr.Weights=1
				usr<<"You put on the [src]."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] puts on the [src].\n")
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
			SaveItemATOM(src)