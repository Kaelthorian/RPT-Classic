mob/Admin2/verb
	Force_Liftoff()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/A=input("Choose something to forcibly launch into space!") as mob|obj in view(usr)
		Liftoff(A)