mob/Admin4/verb
	Live_Patch()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Are you sure?"))
			//PrepareWorld()
		//	world << "<span class=\"announce\"> <b>Saving world!</b> </span>"
		//	log_admin("[key_name(usr)] initiated a world save.")
			//SaveWorld()
			src<<"<b>Live Patch beginning!</b>"
			usr.client.holder.listen_Logins = 1
			src<<"<b>Player login notifications enabled</b>"
			var/NewPort=world.port
			src<<"<b>Current Port is [NewPort]!"
			if(NewPort==25857) NewPort=26482
			else if(NewPort==26482) NewPort=25857
			else if(NewPort==2292) NewPort=8261
			else if(NewPort==8261) NewPort=2292
			else NewPort=""
			var/ServerAddress="byond://[world.internet_address]:[NewPort]" as text
			var/WOR = input(usr,"Choose the BYOND address","Server Address",ServerAddress) as text
			if(usr.Confirm("Are you sure you want to transfer the entire playerbase to [ServerAddress]?")) TransferClients(WOR)