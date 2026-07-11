proc/ghostDens_check(atom/A)
	if(istype(A,/mob/player))
		var/mob/player/_player=A
		if(_player.adminDensity) return TRUE
		else return FALSE

atom/proc/GetPronoun()
	switch(gender)
		if("male")
			return "he"
		if("female")
			return "she"
		if("Male")
			return "he"
		if("Female")
			return "she"
		else
			return "it"

atom/proc/Enlarge_Icon(scale,scale2)
	if(!icon) return
	var/icon/A=new(icon)
	A.Scale(scale,scale2)
	//var/matrix/M = matrix()
	//M.Scale(scale,scale)
	//A.transform = M
	icon = A
	pixel_x= ((scale -32)*(-1))/2
	pixel_y= ((scale2 -32)*(-1))/2
	del(A)
	Enlarge_Overlays(scale)

atom/proc/Enlarge_Overlays(scale)
	if(!overlays) return
	for(var/O in overlays) if(O:icon)
		var/icon/A=new(O:icon,O:icon_state)
		//var/matrix/M = matrix()
		//M.Scale(scale,scale)
		//A.transform = M
		A.Scale(32*scale,32*scale)
		overlays -= O
		overlays += A
		del(A)