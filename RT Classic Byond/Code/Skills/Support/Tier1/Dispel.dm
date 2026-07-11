Skill/Support/Dispel

	desc="The power to forcefully return a dead soul or any demon or kaio to the afterlife."
	verb/Dispel()
		set category="Other"
		if(usr.EXPLifetime<1430)
			usr<<"You have not enough EXPLifetime"
			return
		if(usr.Dead)
			usr<<"You cannot use this if you are dead."
			return
		for(var/mob/A in get_step(usr,usr.dir))
			if(A.Dead ||A.Race=="Kaio"||A.Race=="Demon")
				if(A.z!=11)
					if(!A.isGrabbing)
						if(A.KOd&&A.RPMode)
							A.x=250
							A.y=250
							A.z=11
							view(usr)<<"[A] is send back to the afterlife by [usr]"
							usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used dispel on [key_name(A)].\n")
							A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] used dispel on [key_name(usr)].\n")
							A.Dispelled	=Year+(Month*0.01)+1







