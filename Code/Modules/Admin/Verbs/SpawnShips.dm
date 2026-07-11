proc/SpawnAndroidShip()
	set waitfor=0
	var/totalcount=0
	for(var/obj/AndroidShip/A in world)
		totalcount++
		if(Android==0) del(A)
	if(Android==0) return
	if(totalcount==1) return
	else if(totalcount<1)
		var/obj/AndroidShip/A = new
		A.loc = locate(164,322,12)
		A.Ship = 50
		log_errors("Found no androidships, added a new one.")
		src << "Found no androidships, added a new one."
	else if(totalcount>=1)
		for(var/obj/AndroidShip/A in world)
			del(A)
			break
		log_errors("Deleted a duplicate Androidship. [totalcount-1] ships remaining.")
		world << "Deleted a duplicate Androidship. [totalcount-1] ships remaining."

proc/SpawnArdent()
	var/totalcount=0
	for(var/obj/Ships/Ship/Ardent/B in world) totalcount++
	if(totalcount==1) return
	else if(totalcount<1)
		var/obj/Ships/Ship/Ardent/B = new
		B.loc = locate(190,222,12)
		log_errors("Found no Ardent, added a new one.")
		src << "Found no Ardent, added a new one."
	else if(totalcount>=1)
		for(var/obj/Ships/Ship/Ardent/B in world)
			del(B)
			break
		log_errors("Deleted duplicate Ardent. [totalcount-1] ships remaining.")
		src << "Deleted duplicate Ardent. [totalcount-1] ships remaining."

proc/SpawnIcebreaker()
	var/totalcount=0
	for(var/obj/Ships/Ship/Icebreaker/B in world) totalcount++
	if(totalcount==1) return
	else if(totalcount<1)
		var/obj/Ships/Ship/Icebreaker/B = new
		B.loc = locate(175,225,12)
		log_errors("Found no Icebreaker, added a new one.")
		src << "Found no Icebreaker, added a new one."
	else if(totalcount>=1)
		for(var/obj/Ships/Ship/Icebreaker/B in world)
			del(B)
			break
		log_errors("Deleted duplicate Icebreaker. [totalcount-1] ships remaining.")
		src << "Deleted duplicate Icebreaker. [totalcount-1] ships remaining."
