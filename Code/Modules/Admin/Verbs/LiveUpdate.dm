proc/TransferClients(Destination as text)
	var url = Destination + "?reconnecting=true"

	var/list/clients = new
	for(var/client/c) if(c.mob) if(c.mob.z) clients += c

	for(var/client/C as anything in clients)
		C << "<b><u>You are being moved.</b></u>"
		var/mob/M=C.mob
        //SAVE CLIENT'S MOB NOW

		C.SaveChar()
		C << link(url)
        //DELETE MOB IF NEED BE, I think clientless mobs are deleted by the server already.

		del(M)
	spawn () shutdown()


mob/verb/Reconnect()
	usr << link("[world.url]")

mob/Admin4/verb/TestForceConnect()
	var/NewPort=world.port
	src<<"<b>Current Port is [NewPort]!"
	if(NewPort==25857) NewPort=26482
	else if(NewPort==26482) NewPort=25857
	else if(NewPort==2292) NewPort=8261
	else if(NewPort==8261) NewPort=2292
	else NewPort=""
	var/ServerAddress="byond://[world.internet_address]:[NewPort]" as text
	var/WOR=input("Choose the BYOND address","Server Address",ServerAddress) as text
	PrepareServerForUpdatee(WOR)


proc/PrepareServerForUpdatee(var/NextWorld as text)
	sleep(10)
	for(var/mob/player/C in Players)
		C<<link(NextWorld)
		sleep(1)
	sleep(10)
	for(var/client/C in world)
		C<<link(NextWorld)
		sleep(1)
