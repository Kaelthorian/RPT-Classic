mob/verb/SenseClose()
	set category=null
	winshow(usr.client,"ScanArea",0)
	usr.Toggled_Sense = 0
	usr << "You have made your scanner tab hidden."