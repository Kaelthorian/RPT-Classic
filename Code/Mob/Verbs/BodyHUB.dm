mob/verb/Toggle_BodyHUD()
	set category=null
	if(usr.BodyHUD)
		usr.BodyHUD = 0
		usr << "You have turned off the Body HUD."
	else
		usr.BodyHUD = 1
		usr << "You have turned on the Body HUD."
	BodyHUD()