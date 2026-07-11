mob/Admin4/verb/viewerrors()
	set name = "Error Log"
	set category = "Admin Other"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	src << ftp("Data/Logs/errors.log","errors.log")
	return