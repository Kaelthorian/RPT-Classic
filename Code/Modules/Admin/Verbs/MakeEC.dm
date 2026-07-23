mob/Admin1/verb

	Make_EC(mob/M in Players)
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		M.MakeEC()