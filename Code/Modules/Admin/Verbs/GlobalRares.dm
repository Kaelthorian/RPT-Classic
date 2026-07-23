/client/proc/Toggle_Global_Rares()
	set name = "Toggle Global Rares"
	set category = "Admin Other"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr << "Global Rares are currently [Allow_Rares]."
	switch(input("Toggling this off will no longer allow players the chance to roll a rare race.") in list("Off","On"))
		if("On")
			Allow_Rares = "On"
			log_admin({"[key_name(src)] allowed global rares on for all players."})
			alertAdmins("[key_name(src)]  allowed global rares on for all players.")
			return
		if("Off")
			Allow_Rares = "Off"
			log_admin({"[key_name(src)] turned global rares off for all players."})
			alertAdmins("[key_name(src)] turned global rares off for all players.")
			return