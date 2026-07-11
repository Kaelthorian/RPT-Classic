Skill/Support/Keep_Body

	desc="Using this on someone will allow them to use 100% of their power while dead and in the living realm."
	verb/Keep_Body()
		set category="Other"
		if(usr.EXP<100)
			src<<"You have not enough EXP"
			return
		if(usr.EXPLifetime<1430)
			src<<"You have not enough EXPLifetime"
			return
		for(var/mob/M in get_step(usr,usr.dir))
			switch(input("Allow [M] to keep their body?") in list("Yes","No"))
				if("Yes")
					M.KeepsBody=1
					usr.EXP-=100
					if(M.last_icon) M.icon = M.last_icon
					alertAdmins("[key_name(usr)] has allowed [key_name(M)] to keep their body")
					view(usr)<<"[usr] gives [M]'s body back"
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has allowed [key_name(M)] to keep their body.\n")
				if("No")
					M.KeepsBody=0
					alertAdmins("[key_name(usr)] has prevented [key_name(M)] from keeping their body")
			break
