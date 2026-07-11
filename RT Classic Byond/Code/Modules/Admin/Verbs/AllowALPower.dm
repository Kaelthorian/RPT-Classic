mob/Admin1/verb

	Allow_AL_Power()
		set category="Admin"
		if(ALRacePower == 1)
			if(!usr.Confirm("Want to remove the AL race power?")) return
			ALRacePower = 0
			for(var/mob/player/A in Players)
				if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon")
					A<<"<big><b><font color=red>The inner power the afterlife gift you fades away.</b></big>"
					logAndAlertAdmins("[src] removed the AL races power.")
		else
			if(!usr.Confirm("Want to restore the AL race power?")) return
			ALRacePower = 1
			for(var/mob/player/A in Players)
				if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon")
					A<<"<big><b><font color=red>The inner power the afterlife gift you comes back to your power.</b></big>"
					logAndAlertAdmins("[src] give back the AL races power.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] give back the AL races power.\n")