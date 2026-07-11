/mob/verb/
	ClearAhelpW()
		set hidden=1
		winset(usr.client, "AhelpW.AHELPin", "text=")
		winshow(client,"AhelpW",0)

	AdminHelp()
		set name="Admin Help"
		//set category="Other"
		winshow(client,"AhelpW",1)
		alert(usr,"Please be descriptive in your admin help.  It is important to clearly state your issue and what you need help with. If it is to get something approved, be clear with what you want approved and why you feel it should be approved.  Include a link to a pastebin of the appropriate RP. (Do not use this to complaing about development choices or thing related to game design. Use the discord instead.  Misuse of ahelp will result in punishment)","Admin Help")
		winset(client, "AhelpW.AHELPin", "focus=true")
	//	winset(usr.client, "AhelpW.AHELPin", "text=")