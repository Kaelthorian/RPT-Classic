mob/Admin1/verb/SendMob(mob/M in Players)
	set category = "Admin"
	set name ="Send Mob To"
	if(!usr.client.holder)
		src << "Only administrators may use this command."
		return
	var/PP=input("Send [M]...","Send Mob") in list("Send to Spawn", "Send to Player","Send to XYZ","Send to Corpse","Summon","Unsummon","Cancel")
	switch(PP)
		if("Send to Spawn") usr.client.sendToSpawn(M)
		if("Send to Player") usr.client.sendmob(M)
		if("Send to XYZ") usr.XYZTeleport(M)
		if("Send to Area") usr.client.Sendtoarea(M)
		if("Send to Corpse") usr.client.Sendtoobj(M)
		if("Summon") usr.client.Getmob(M)
		if("Unsummon") usr.client.returnmob(M)