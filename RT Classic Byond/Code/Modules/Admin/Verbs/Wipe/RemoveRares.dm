mob/Admin2/verb
	Remove_Rares()
		set category= "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "[AllowRares] list is [global.AllowRares.len] long."
		src << "[AllowRares] contains:"
		var/list/rarelist = new
		for(var/I in AllowRares)
			src << "[I]"
			rarelist+=I
		rarelist+="Cancel"
		var/choice = input("Remove who from the rares list?","Rare removal") in rarelist
		switch(choice)
			if("Cancel")
				return
			else
				for(var/i in AllowRares)
					AllowRares-=choice
					src << "You removed; [choice]"