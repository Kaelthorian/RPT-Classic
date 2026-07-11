mob/Admin2/verb
	Enlarge(atom/A as mob|obj in world)
		set category = "Admin"
		set name = "Enlarge Icon"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!A.icon)
			alert("They don't have an icon to enlarge!")
			return
		var/scale=input(usr,"How many X pixels?","Enlarge",1) as num
		var/scale2=input(usr,"How many Y pixels?","Enlarge",1) as num
		A.Enlarge_Icon(scale,scale2)
	//	log_admin("[key_name(usr)] used Enlarge Icon on [key_name(A)]")
		alertAdmins("[key_name(usr)] used Enlarge Icon on [key_name(A)]")