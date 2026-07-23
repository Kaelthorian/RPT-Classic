Skill/Majinize

	var/LastUse
	verb/Majinize(mob/player/M in oview(1))
		set category="Other"
//		set src = usr.contents
		if((Year+(Month*0.01))<LastUse)																												//CD check
			usr<<"You cannot use this until year [LastUse]"																							//msg
//			world<<"Working"																														//Debug Tool
			return																																	//Full stop
		if(usr.AmountOfMajinized>=2)																												//If the one who is using majinize have 2 majin guys already
			usr<<"You cannot control more than two persons at any time given."																		//msg
			return																																	//Full stop
		var/x=input(M,"[usr] would like to use [src] on you.  You will be forced to obey them in-character. Do you accept?") in list("No","Yes")	//Ask if you want to be majinized or not
		if(x!="Yes")																																//You don't want ?
//			world<<"I said no"																														//Debug Tool
			return																																	//Full stop
		if(M.Race=="Bio Android")																													//The one who is being majinized is a bio ?
			usr<<"The host soul and mind is too powerful to infect."																				//msg
			return																																	//Full stop
		if(locate(/Skill/Misc/FactionLeaderCommands/)in src)																						//Is a faction leader?
			usr<<"The host soul is too strong for you to infect his mind."																			//msg
			return																																	//Full stop
		if(M.Cyborg==1)																																//Is a cyborg?
			usr<<"The micropchip inside the host brain stop you from infecting it."																	//msg
			return																																	//Full stop
		if(M.Majinized==1)																															//Is a majin of someone ?
			usr<<"He already is under control of someone else."																						//msg
			return																																	//Full stop
		M.MajinBy = usr.ckey																														//Save who majinied this guy
		M.Majinized=1																																//Set his majin power to var to 1
		LastUse=Year+(Month*0.01)+1																													//CD kick in
		usr.AmountOfMajinized++																														//+1 to the amount of majins the summoner have
		M.AlignmentNumber-=10																														//karma change
		M.AlignmentCalibrate()																														//Karma proc to make it work
		alertAdmins("[key_name(usr)] has Majinized [key_name(M)].")																					//Alert admins
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Majinized [key_name(M)].\n")												//Logs
		view(usr)<<"[usr] is now controling the mind of [M.name]"
		M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)] was Majinized by [key_name(usr)].\n")												//Logs

	verb/Remove_Majinize()
		set category="Other"
		for(var/mob/player/M in world)
			if(M.MajinBy==usr.ckey)
				if(usr.Confirm("Do you want to stop controlling [M.name]'s mind?"))
					MajinizeRemove(M)
					M.Willpower-=20
					usr.AmountOfMajinized--
					M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)] Majin is removed by [key_name(usr)].\n")
					view(usr)<<"[usr] is no longer controling [M.name]"



proc/MajinizeRemove(mob/M)
	if(M.Majinized>=1)
		M.Majinized=0
		M.MajinBy=""
		M<<"You feel your life force and power drain away as your master releases the hold on your mind."
//		for(var/mob/player/M in world)
//			if(M.ckey==usr.MajinBy)
//				M.AmountOfMajinized--
//				if(M.AmountOfMajinized<0)
//					M.AmountOfMajinized=0



