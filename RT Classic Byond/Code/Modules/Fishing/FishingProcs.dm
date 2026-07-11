mob/proc/FishingLevelCheck()
	if(Fishing_XP>=Fishing_Next&&Fishing_Level<TechCap)
		Fishing_XP-=Fishing_Next
		Fishing_Next=round(Fishing_Next*1.06)
		Fishing_Level++
		if(Fishing_XP>=Fishing_Next&&Fishing_Level<TechCap)FishingLevelCheck()
	if(Fishing_Level>=TechCap) Fishing_XP=0

proc/CleanFish()
	for(var/obj/items/rawfood/cf in world) if(cf.z)
		var/turf/P=cf.loc
		if(cf.z&&!ismob(P))
			if(prob(50)) view(cf)<<"[cf] rots away."
			del(cf)
		sleep(-1)
	for(var/obj/items/rawore/cf in world)
		var/turf/P=cf.loc
		if(cf.z&&isturf(P))
			if(prob(50)) view(cf)<<"[cf] crumbles away."
			del(cf)
		sleep(-1)
	for(var/obj/items/cookedfood/cf in world) if(cf.z)
		var/turf/P=cf.loc
		if(cf.z&&!ismob(P))
			if(prob(50)) view(cf)<<"[cf] rots away."
			del(cf)
		sleep(-1)
	for(var/obj/items/rawmetal/cf in world)
		var/turf/P=cf.loc
		if(cf.z&&isturf(P))
			if(prob(50)) view(cf)<<"[cf] crumbles away."
			del(cf)
		sleep(-1)