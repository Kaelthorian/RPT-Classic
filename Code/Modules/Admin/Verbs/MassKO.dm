mob/Admin1/verb

	Mass_KO()
		//set category = "Admin"
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
