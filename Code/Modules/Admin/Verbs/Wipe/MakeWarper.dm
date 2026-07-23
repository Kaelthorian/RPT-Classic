mob/Admin1/verb

	Warper()
		set category="Admin"
		//if(!src.client.holder||src.client.holder.level<2) return
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Make a warper here?"))
			var/obj/Warper/A=new(locate(usr.x,usr.y,usr.z))
			A.gotox=input("x location to send to") as num
			A.gotoy=input("y") as num
			A.gotoz=input("z") as num
			logAndAlertAdmins("[key_name_admin(src)] created a warper at ([A.x],[A.y],[A.z])",2)
			A.SaveItem(A)