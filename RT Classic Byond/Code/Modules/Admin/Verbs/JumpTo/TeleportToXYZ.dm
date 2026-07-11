mob/proc/XYZTeleport(mob/M in Players)
	set category="Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!usr.client.holder) return
	usr<<"This will send the mob you choose to a specific xyz location."
	var/xx=input("X Location? Current is [M.x]") as num
	var/yy=input("Y Location? Current is [M.y]") as num
	var/zz=input("Z Location? Current is [M.z]") as num
	switch(input("Are you sure?") in list ("Yes", "No",))
		if("Yes")
			M.unSummonX = M.x
			M.unSummonY = M.y
			M.unSummonZ = M.z
			M.loc=locate(xx,yy,zz)
			logAndAlertAdmins("[key_name_admin(src)] used XYZTeleport on [M] to ([M.x],[M.y],[M.z])",2)