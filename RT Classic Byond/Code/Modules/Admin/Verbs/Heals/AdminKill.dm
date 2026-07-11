/client/proc/Kill(mob/M in world)
	//set category = "Admin"
	set name = "Admin Kill"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/reason = input(src,"Reason") as text
	reason = copytext(sanitize(reason), 1, MAX_MESSAGE_LEN)
	if(!reason)
		reason = "admin"	//fallback
	if(!usr.Confirm("Kill [M] with reason [reason]?")) return
	M.Death(reason,1)
	log_admin({"[key_name(src)] killed [key_name(M)] with reason \'[reason]\'"})
	alertAdmins("[key_name(src)] killed [key_name(M)] with reason \'[reason]\'")