/obj/admins/proc/check_world_logs()
	set category = "Admin"
	set name = "Check World Logs"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!fexists("Data/Logs/"))
		alert("No world logs found!")
		return
	var/filedialog/F = new(usr.client, /client/proc/read_world_log)
	F.msg = "Choose a logfile."   // message in the window
	F.title = "Load World Log"      // popup window title
	F.root = "Data/Logs/"               // directory to use
	F.saving = 0                    // saving? (false is default)
	//F.default_file = "./[time2text(world.realtime, "YYYY/Month")]"    // default file name
	F.ext = ".log"                  // default extension
	F.filter = ".log"
	usr << ftp(F)
	F.Create(usr.client)            // now display the dialog
	usr << ftp(F)//"Data/Players/errors.log","errors.log")