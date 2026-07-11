mob/Admin3/verb
	Respawn_Ore()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/turf/atom/Underground/G in world) if(G.z&&prob(10)) G.OreGenerate()
		for(var/turf/atom/Water/G in world) if(G.HasFish==0) G.GenerateFishes()
		log_admin("[key_name(usr)] respawned Ore and Fishes.")
		alertAdmins("[key_name(usr)] respawned Ore and Fishes.")