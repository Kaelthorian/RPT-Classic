Skill/Support/Restore_Youth

	var/LastUse=0
	desc="You can use this to change someone's age to their body's peak."
	verb/Restore_Youth(mob/player/M in oview(1,usr))
		set category="Skills"
		set src=usr.contents
		if(usr.RPMode) return
		if(usr.Dead)
			usr<<"You may not do this while dead."
			return
		if(Year<LastUse+3)
			usr<<"You cannot use this until year [LastUse+3]"
			return
		if(!M) return
		if(M.SaveAge<14)
			usr<<"They must have a save age of atleast 14."
			return
		if(!M.client) return
		if(usr.Confirm("Restore [M]'s youth?"))
			switch(input(M,"Do you want [usr] to restore your youth?") in list("No","Yes",))
				if("Yes")
					M.Age=M.InclineAge
					M.Body=M.InclineAge
					LastUse=Year
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has altered [key_name(M)]'s age to [M.Age]")
					alertAdmins("[key_name(usr)] has altered [key_name(M)]'s age to [M.Age]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has altered [key_name(M)]'s age to [M.Age].\n")
					M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)]'s age was altered to [M.Age] by [key_name(usr)].\n")
				if("No")
					usr<<"[M] declined your offer."