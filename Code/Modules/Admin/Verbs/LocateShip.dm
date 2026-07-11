mob/Admin1/verb

	Locate_Ships()
		set category = "Admin"
		if(!usr.client.holder||usr.client.holder.level<1) return
		var/count
		for(var/obj/AndroidShip/A in world)
			src << "AndroidShip found at ([A.x],[A.y],[A.z])"
			count++
		if(count>=2)
			src<<"Found more then one AndroidShip, deleting duplicate."
			SpawnAndroidShip()
			src << "Done."
		if(count<=0)
			src<< "Found NO AndroidShip."
			if(usr.Confirm("Spawn a new Android Ship?")) SpawnAndroidShip()
			src << "Done."
		for(var/obj/Ships/Ship/Ardent/A in world) src << "Ardent found at ([A.x],[A.y],[A.z])"
		for(var/obj/Ships/Ship/Icebreaker/A in world) src << "Icebreaker found at ([A.x],[A.y],[A.z])"
