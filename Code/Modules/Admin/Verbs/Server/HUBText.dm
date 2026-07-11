/client/proc/Hubtext()
	set name = "Edit Hubtext"
	set category = "Admin"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	global.HubText=input("Input a message to be displayed on the hub.") as text
	if(!HubText)
		return
	else alertAdmins("[key_name(src)] set the HubText to [global.HubText]")