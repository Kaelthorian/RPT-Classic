mob/proc/Clothes_Equip(obj/items/A) if(A in usr)
	if(!A.suffix)
		A.suffix = "*Equipped*"
		usr.Equip_Magic(A,"Add")
		var/image/_overlay = image(A.icon) // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		_overlay.layer= A.layer
		overlays += _overlay
	else
		A.suffix = null
		var/image/_overlay = image(A.icon) // not sure if the equipped thing is an icon/object so
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		_overlay.layer= A.layer
		overlays -= _overlay
		overlays -= A.icon
		usr.Equip_Magic(A,"Remove")

mob/proc/Clothes_Proc(obj/A)
	if(A in Clothing)
		if(HairChoose) return
		HairChoose=1
		var/obj/B=new A.type
		var/RGB=input(src,"") as color|null
		if(!B) return
		if(RGB) B.icon+=RGB
		contents+=B
		HairChoose=0
	else Clothes_Equip(A)

var/list/Clothing=new