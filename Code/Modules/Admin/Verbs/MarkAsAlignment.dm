mob/Admin1/verb

	Mark_As_Alignment()
		set category="Admin Other"
		if(M.LastAlignmentAssign+1<=Year)
			var/Align=input("Mark [M] as being which alignment?") in list("Good","Evil","Neutral")
			view(M)<<"[M] has been marked as [Align]."
			if(M.LastAlignmentAssign+1> Year) return
			switch(Align)
				if("Evil") M.AlignmentNumber-=1
				if("Good") M.AlignmentNumber+=1
				if("Neutral") if(M.AlignmentNumber!=0) M.AlignmentNumber/=3
			M.AlignmentCalibrate()
			M.LastAlignmentAssign=Year
			logAndAlertAdmins("([M.Rank]) [key_name(usr)] marked [key_name(M)] to [Align].")
			M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
		else usr<<"Their alignment is on cooldown."