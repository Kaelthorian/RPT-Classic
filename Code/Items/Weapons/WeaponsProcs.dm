mob/proc/ArmorRemove()
	for(var/obj/items/Armor/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		ArmorOn=0
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		if(usr.HasArmorMastery)
			usr.EndMult/=(A.End+0.07)
		else usr.EndMult/=A.End
		if(usr.HasArmorMastery)
			usr.SpdMult*=1
		else usr.SpdMult/=A.Spd
		view(20,src) << "[src]'s [A] falls off."
		A.desc = initial(A.desc)+"<br>[Commas(A.Health)] Durability Armor"
		break

mob/proc/SwordRemove()
	for(var/obj/items/Sword/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		SwordOn=0
//		world<<"NoWeapon [NoWeapon]"
		NoWeapon=1
		if(src.HasSwordsman) src.OffMult/=(A.Off+0.08)
		else src.OffMult/=A.Off
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		for(var/Skill/Buff/Bushido/SF in src) if(SF.Using) SF.use(src)
		view(20,src) << "[src] removes [A]."
		break

mob/proc/HammerRemove()
	for(var/obj/items/Hammer/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		HammerOn=0
		NoWeapon=1
		StrMult/=1.1
		if(src.HasHammerTime) src.SpdMult*=(A.Spd+0.06)
		else src.SpdMult*=A.Spd
		if(src.HasHammerTime) src.OffMult*=(A.Off+0.06)
		else src.OffMult*=A.Off
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		for(var/Skill/Buff/Bushido/SF in src) if(SF.Using) SF.use(src)
		view(20,src) << "[src] removes [A]."
		break
mob/proc/HelmetRemove()
	for(var/obj/items/Helmet/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		HelmetOn=0
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		view(20,src) << "[src] removes [A]."
		break
mob/proc/MaskRemove()
	for(var/obj/items/Magic_Mask/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		MaskOn=0
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		view(20,src) << "[src] removes [A]."
		break

mob/proc/GlovesRemove()
	for(var/obj/items/Gauntlets/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		GlovesOn=0
		NoWeapon=1
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		view(20,src) << "[src] removes [A]."
		break