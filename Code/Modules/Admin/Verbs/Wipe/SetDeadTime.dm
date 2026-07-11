mob/Admin4/verb
	Set_Dead_Time()
		set name = "Set Minimum Dead Time"
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		usr << "Global death times are set for [Dead_Time]."
		var/N = input(usr,"Choose in years how long someone must remain dead before they can be revived. Current is [Dead_Time].") as num
		if(N <= 0)
			N = 1
		Dead_Time = N
		log_admin("[key_name(usr)] set the global death times to [Dead_Time].")
		alertAdmins("[key_name(usr)] set the global death times to [Dead_Time].")