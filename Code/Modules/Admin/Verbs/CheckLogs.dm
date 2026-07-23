mob/Admin1/verb/check_log()
	set category = "Admin"
	set name = "Check Player Logs"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!fexists("Data/Players/"))
		alert("No world logs found!")
		return
	var/filedialog/F = new(usr.client, /client/proc/get_log)
	F.msg = "Choose a logfile."   // message in the window
	F.title = "Load Player Log"      // popup window title
	F.root = "Data/Players/"               // directory to use
	F.saving = 0                    // saving? (false is default)
	//F.default_file = "./[time2text(world.realtime, "YYYY/Month")]"    // default file name
	F.ext = ".log"                  // default extension
	F.filter = ".log"
	usr << ftp(F)
	F.Create(usr.client)            // now display the dialog
	usr << ftp(F)//"Data/Players/errors.log","errors.log")
