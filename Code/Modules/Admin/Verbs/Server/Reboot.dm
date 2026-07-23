/obj/admins/proc/immreboot(var/reason as text)
	set category = "Admin Other"
	set desc="Reboots the server"
	set name="Reboot"
	if(!reason)
		reason = "No reason specified!"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(usr.client.holder.rank<3)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if( alert("Reboot server?",,"Yes","No") == "No")
		return
	world << "<span class=\"announce\"> <b>Rebooting world!</b> Initiated by Administrator with reason: [reason]</span>"
	log_admin("[key_name(usr)] initiated a reboot.")
	global.rebooting = 1
	SaveWorld()
	world << "<span class=\"announce\">World saved. Rebooting in 5 seconds.</span>"
	sleep(50) // Wait 5 seconds just to be safe
	world.Reboot("Initiated by [usr.key] with reason: [reason]")
	//usr.Save()
	//del(usr)
