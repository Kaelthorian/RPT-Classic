mob/Admin1/verb

	Force_RolePlay_Mode(mob/M in Players)
		set category =null// "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!M)
			alert("Mob doesn't exist!")
			return
		if(usr.Confirm("Toggle their RPMode?")) M.RPMode()