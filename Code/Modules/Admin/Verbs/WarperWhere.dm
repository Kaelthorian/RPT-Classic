mob/Admin1/verb/Warper_Where()
	set category = "Admin Other"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	for(var/obj/Warper/W in world)
		usr<<"[W] is located at [W.x], [W.y], [W.z]."