/client/proc/Watch(var/mob/M in Players)	//This is what admin.. observing is now, so to speak
	set name = "Watch"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(src.mob)
		usr.Get_Observe(M)
	else
		alert("You've got no mob guy! That isn't good!")
		return