Skill/Support/Bind

	var/LastUse=0
	var/LastUnBind=0
	desc="You can use this to bind someone to hell. You can only bind a person who is less than your own power at the time. The stronger they are compared to you the more energy it will drain to bind them (1 Year CD)"
	verb/Bind()
		set category="Other"
		if(usr.RPMode) return
		if(LastUse+0.15>Year)
			usr<<"You can only use this once every two months."
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			if(A.KOd)
				if(A.BP>usr.BP)
					view(usr)<<"[usr] attempts to bind [A] to hell, but [A]'s spiritual power deflects it!"
					return
				if(usr.Ki<usr.MaxKi*0.9)
					usr<<"You need at least 90% energy to attempt a bind"
					return
				if(A.BindPower)
					view(usr)<<"[usr] strengthens the bind already placed on [A]!"
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] strenghtens the bind already placed on [A].\n")
					A.BindPower+=usr.MaxKi
				else

					view(usr)<<"[usr] successfully binds [A] to hell!"
7					alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] binds [key_name(A)] to Hell.")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] binds [key_name(A)] to Hell.\n")
					A.BindPower=usr.MaxKi
7				usr.Ki=0
				LastUse=Year
			else
				usr << "[A] must be knocked out in order to use this."
				return
	verb/UnBind()
		set category="Other"
		if(LastUnBind+1>Year)
			usr<<"You can only use this once every year"
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client) if(A.BindPower)
			if(usr.Ki<usr.MaxKi*0.9)
				usr<<"You need at least 90% energy to attempt to remove a bind"
				return
			LastUnBind=Year
			A.BindPower-=usr.Ki
			usr.Ki=0
			if(A.BindPower<=0)
				view(usr)<<"[usr] succeeds in breaking the bind placed on [A]!"
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unbound [key_name(A)] from hell")
				alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unbound [key_name(A)] from hell")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unbound [key_name(A)] from Hell.\n")
				A.BindPower=0
			else
				view(usr)<<"[usr] weakened the bind somewhat, but did not yet break it"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] weakened the bind somewhat, but did not yet break it.\n")
			return