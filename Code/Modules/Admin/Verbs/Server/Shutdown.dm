/obj/admins/proc/Shutdown(var/reason as text)
	set category = "Admin Other"
	set desc="Shut down the server"
	set name="Shutdown"
	if(!reason)
		reason = "No reason specified!"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if( alert("Shut down server?",,"Yes","No") == "No")
		return
	global.rebooting = 1
	world << "<span class=\"announce\"> <b>Shutting down world!</b> Initiated by Administrator with reason: [reason]!</span>"
	log_admin("[key_name(usr)] initiated a shutdown.")
	//file("AdminLog.log")<<"[usr]([usr.key]) initiated a shutdown at [time2text(world.realtime,"Day DD hh:mm")]\n"
	for(var/mob/M in Players) M<<pick('ClosingTime.mid')
	sleep(100)
	SaveWorld()

	//global.ItemsLoaded=0
	//global.MapsLoaded=0
	world << "<span class=\"announce\"> Shutdown in 10 seconds.</span>"
	sleep(100)
	world.Del()