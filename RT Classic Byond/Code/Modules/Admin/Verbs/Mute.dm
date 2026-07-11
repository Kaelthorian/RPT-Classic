/mob/proc/sfIsMuted(var/M)

	//call(/sf_SpamFilter/proc/sf_IsMuted)(M)
	//gSpamFilter.sf_IsMuted(M)
	//if(src==null) src = usr
	if(!M) return FALSE
	M							= src.sfID(M)
	if (!(M in global.MutedList))	return FALSE
	return (global.MutedList[M] > world.realtime)
	return TRUE

/mob/proc/sfID(var/Chatter)
	if ( istype(Chatter,/client) )
		var/client/C	= Chatter
		return ckey(C.key)
	if ( ismob(Chatter) )
		var/mob/M	= Chatter
		return ckey(M.key)
	return null

/mob/proc/sfUnMute(var/M)

//	gSpamFilter.sf_UnMute(M)

	var/id	= src.sfID(M)
	if (id in global.MutedList)
		global.MutedList	-= id
		//world << "<font color=red><b>DEBUG71 :: </font>[M] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b><br>called by [src]"
		M << "<font color=yellow><b>SYSTEM :: </font>You have been unmuted.</b>"
		return TRUE
	//call(/sf_SpamFilter/proc/sf_Unmute)(M)
//	return TRUE

/client/proc/cmd_admin_mute(mob/player/C as mob in world)
	set category = "Admin"
	set popup_menu = 0
	set name = "Mute"
	if(!src.holder)
		alert("Only administrators may use this command.")
		return

	if(!ismob(C))
		alert("[C] has no mob!")
		return

	if (C.client && C.client.holder && (C.client.holder.level >= src.holder.level))
		alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
		return


	if(C.client.muted || usr.sfIsMuted(C))

		C << "You have been unmuted."
		log_admin("[key_name(usr)] has voiced [key_name(C)].")
		alertAdmins("[key_name_admin(usr)] has voiced [key_name_admin(C)].", 1)
		//file("AdminLog.log")<<"[usr]([usr.key] voiced [C] at [time2text(world.realtime,"Day DD hh:mm")]\n"
		global.MutedList-="[C.client]"
		global.MutedList-="[usr.sfID(C)]"
		C.client.muted = 0
		//usr.sfUnMute(C)
		//world << "<font color=red><b>DEBUG2 :: </font>[C] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"

	else

		var
			time = input("Select an amount of time to mute [C.name] (1 = 1 second)","Mute") as num|null
			reason = input("Why are you muting [C.name] ? (This may be left blank.)","Reason") as text|null

		if( !(time) || time == null)
			src << "You can't have a null time!"
			return
		if( !(reason) || reason == "" || reason == null)
			reason = "Unknown."
		global.MutedList["[C.client]"] = (world.realtime)+(time*10)

		C << "You have been muted for [time] seconds for the following reason: \"[reason]\"."
		log_admin("[key_name(usr)] has muted [key_name(C)] for [time] seconds for the following reason: \"[reason]\".")
		alertAdmins("[key_name_admin(usr)] has muted [key_name_admin(C)] for [time] seconds for the following reason: \"[reason]\".", 1)
		for (var/client/P)
			if(P.listen_ooc && P != C) P << "<span class=\"announce\">[usr.client.key] muted [C.client.key] for [time] seconds for the following reason: \"[reason]\".</span>"
		//file("AdminLog.log")<<"[usr]([usr.key] muted [C] at [time2text(world.realtime,"Day DD hh:mm")] for [time] seconds for the following reason: \"[reason]\"\n"
		spawn() C.client.MutedCheck()
		C.client.muted = 1

	//C.client.muted = !C.client.muted