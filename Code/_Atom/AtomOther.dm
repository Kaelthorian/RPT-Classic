atom/movable
	Bump(atom/other)
		lastBumped = other
		if(isThrown) //OnThrownInto(other)
			var/mob/as_mob = other
			var/will_hit = 1
			if(thrower && istype(other, /mob) ) will_hit = thrower.CanAttackMob(as_mob, 1)
			if(will_hit)
				src << "You were thrown into [other.name]!"
				spawn(10) if(src) lastBumped = null
				other << "[src] was just thrown into you!"
				spawn(10) if(other) other.lastBumped = null
				if(!hasHitAnything) hasHitAnything = 1
			else
				src.x = other.x
				src.y = other.y
				src.z = other.z

/atom/movable/var/
	tmp/inertia_dir		//Which direction we're floating through space
	tmp/moved_recently
	tmp/last_move	//dir we moved last
	tmp/m_flag
	tmp/l_move_time	//last world.timeofday we moved
	tmp/move_speed	//How often we're moving
	anchored = 0	//Whether or not it'll float through space, or if it can be pushed

/atom/movable/overlay/New()
	for(var/x in src.verbs)
		src.verbs -= x
	return

/atom/movable/Move()
	var/atom/A = src.loc
	. = ..()
	src.move_speed = world.timeofday - src.l_move_time
	src.l_move_time = world.timeofday
	src.m_flag = 1
	if ((A != src.loc && A && A.z == src.z))
		src.last_move = get_dir(A, src.loc)
		src.moved_recently = 1
	return


/atom/verb/examine(obj/A as obj|mob in view(10,usr))
	set name = "Examine"
//	set category = "Other"
	var/CanPing=1
	if(CanPing)
		if(A) src = A
		if(!usr) return
		if(ismob(usr) && get_dist(usr,src)>10)
			usr << "That's too far away to examine."
			return
		var/icon/I = src.getIconImage()
		usr << "This is \icon[I] \an [src.name]."
		if(usr.client.holder)
			usr<<"Builder: [src.Builder]"
		if(istype(A,/obj))
			var/obj/O=A
			if(O.Serial) usr << "It seems to have a serial number of [O.Serial]."
		if(istype(A,/obj/items))
			var/obj/items/O=A
			usr << "It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."
		if(istype(A,/Skill/Buff))
			var/Skill/Buff/S=A
			usr<<"[S.GetDescription(usr)]"
		else usr << src.desc
		if(isobj(src)) if(istype(src,/obj/items)) usr<<"[usr.Display_Magic(src)]"
		if(src in usr.contents)if(istype(src,/obj/items)) if(usr.Confirm("Reveal this item to those nearby?")) for(var/mob/player/PP in view(usr)) PP.ICOut("[usr] reveals their [src]. [src.desc]")
		CanPing=0
		if(ismob(src)&&istype(src,/mob/player))usr.Check_Profile(src)
		spawn(15) CanPing=1

atom
	MouseEntered(location, control, params)
		..()
		var/showstuff="[src.desc]"
		if(istype(src,/obj/items))
			var/obj/items/O=src
			showstuff="[showstuff] [usr.Display_Magic(src)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."


//		usr.client.tooltipHolder.showHover(src, list(
//			"params" = params,
//			"title" = src.name,
//			"content" = showstuff
//		))

//	MouseExited()
//		if (usr.client.tooltipHolder)
//			usr.client.tooltipHolder.hideHover()


/*clickTip(src, usr, list("params" = params,"title" = src.name,"content" = src.desc))*/
atom
	DblClick(location, control, params)
		..()
		//usr<<"location [location] || control [control]"
		var/showstuff="[src.desc]"
		if(istype(src,/obj/items))
			var/obj/items/O=src
			showstuff="[showstuff] [usr.Display_Magic(src)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."

//		clickTip(src, usr, list(
//			"params" = params,
//			"title" = src.name,
//			"content" = showstuff
//		))