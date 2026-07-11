mob/Admin1/verb

	Edit_Notes()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!WritingNotes)
			WritingNotes=src
			logAndAlertAdmins("[src.key] is editing the notes...",1)
			Notes=input(usr,"Edit!","Edit Notes",Notes) as message
			logAndAlertAdmins("[src.key] is done editing the notes...",1)
			WritingNotes=0
			SaveNotes()
		else usr<<"<b>Someone is already editing the notes."