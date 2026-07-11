/client/proc/allow_rares(var/client/C as mob in world) // Yes. WORLD. Incase they havn't made a character yet.
	set category = "Admin"
	set name = "Allow Rares"
	set popup_menu = 0
	set desc = "Allow this particulair player to chose a rare race."
	if(!ismob(C))
		return
	if(!src.holder)
		alert("Only administrators may use this command.")
		return
	if(src.holder.level < 2)
		alert("Only administrators may use this command.")
		return
	if(!AllowRares)AllowRares=new
	if(C.ckey in AllowRares)
		AllowRares-=C.ckey
		if(!AllowRares|!AllowRares.len) AllowRares=null
		log_admin("[key_name(usr)] has removed the ability to create any race from [key_name(C)].")
		alertAdmins("[key_name_admin(usr)] has removed the ability to create any race from [key_name(C)].", 1)
		C << "An admin has removed your ability to make all races."
		return
	else AllowRares+=C.ckey
	log_admin("[key_name(usr)] has granted the ability to create any race to [key_name(C)].")
	alertAdmins("[key_name_admin(usr)] has granted the ability to create any race to [key_name(C)].", 1)
	C << "An admin has granted you the ability to make all races. It's assumed you know how to handle this responsibly."
