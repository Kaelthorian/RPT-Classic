/client/proc/EmoteAudit(mob/player/M as mob in world)
	M.LastEmoteAudit=Year
	var/addedMemory = "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key]) audited logs and approved them.<br><hr>"
	M.mind.store_memory(addedMemory)