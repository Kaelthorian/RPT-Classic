/client/proc/Jump()
	set category = "Admin"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/PP=input(usr,"Jump...","Jump") in list("Jump to Mob", "Jump to Turf", "Jump to Key", "Jump to Obj","Cancel")
	switch(PP)
		if("Jump to Area") usr.client.Jumptoarea()
		if("Jump to Mob") usr.client.jumptomob()
		if("Jump to Turf") usr.client.jumptoturf()
		if("Jump to Key") usr.client.jumptokey()
		if("Jump to Obj") usr.client.jumptoobj()