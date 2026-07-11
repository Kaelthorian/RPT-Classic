mob/verb/SETesting()
	set category ="Special Effects"
	var/Selection=input("What SE you want to test?") in list("AlphaMask","AngularBlur","Bloom","ColorMatrix","DisplacementMap","AlphaMask","DropShadow","GaussianBlur","MotionBlur","OutLine","RadianBlur","Rays","Ripple","Wave",)
	if(Selection=="AlphaMask")
		AlphaMask(usr)
	if(Selection=="AngularBlur")
		AngularBlur(usr)
	if(Selection=="Bloom")
		Bloom(usr)
	if(Selection=="ColorMatrix")
		ColorMatrix(usr)
	if(Selection=="DisplacementMap")
		DisplacementMap(usr)
	if(Selection=="DropShadow")
		DropShadow(usr)
	if(Selection=="GaussianBlur")
		GaussianBlur(usr)
	if(Selection=="Layering")
		Layering(usr)
	if(Selection=="MotionBlur")
		MotionBlur(usr)
	if(Selection=="OutLine")
		OutLine(usr)
	if(Selection=="RadianBlur")
		RadianBlur(usr)
	if(Selection=="Rays")
		Rays(usr)
	if(Selection=="Ripple")
		Ripple(usr)
	if(Selection=="Wave")
		Wave(usr)

mob/verb/RemoveEffect()
	set category ="Special Effects"
	for(var/i in filters)
		filters -= i






