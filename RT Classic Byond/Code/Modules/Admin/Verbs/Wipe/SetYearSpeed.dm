mob/Admin4/verb
	Set_Year_Speed()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/YS = input(usr,"Current is [Year_Speed]. 1:1 Ratio for minutes in a week of the month. 4 weeks to a month","Year Speed",Year_Speed) as num
		if(YS<1)YS=1
		if(YS>10000)YS=10000
		Year_Speed=YS
		log_admin("[key_name(usr)] set Year Speed to [Year_Speed] minutes per week")
		alertAdmins("[key_name(usr)] set Year Speed to [Year_Speed] minutes per week")