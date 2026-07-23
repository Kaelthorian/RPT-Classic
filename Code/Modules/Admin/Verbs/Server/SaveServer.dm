/obj/admins/proc/Saveserver()
	set category = "Admin Other"
	set desc="Save the server"
	set name="Save Server"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	world << "<span class=\"announce\"> <b>Saving world!</b> </span>"
	log_admin("[key_name(usr)] initiated a world save.")
	SaveWorld()