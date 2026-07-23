Skill/Support/Revive

	desc="This will bring someone back to life. You cannot use it more than once every 2 years and cost you 440 EXP to use it."
	var/LastUse=0
	verb/Revive()
		set category="Other"
		if(Year<LastUse+2)
			usr<<"You can not use this til year [LastUse+2]"
			return
		if(usr.Dead)
			usr<<"You cannot use this if you are dead."
			return
		if(usr.EXP<400)
			usr<<"Not enough EXP to use this."
			return
		if(usr.EXPLifetime<1400)
			usr<<"You have not enough EXPLifetime (1400)"
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client&&A.Dead)
			if(Year<A.Died+Dead_Time)
				usr<<"This can't be used on someone not attuned to the realm of the dead, their incorporeal form hasn't been deceased long enough. This process usually takes [Dead_Time] years."
				return
			view(usr)<<"[A] is revived by [usr]"
			usr.EXP-=400
			LastUse=Year
			A.Revive()
			alertAdmins("[key_name(usr)] used Kaio/Demon Revive on [key_name(A)]")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Kaio/Demon Revive on [key_name(A)].\n")
			A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was revived by [key_name(usr)] (Kaio/Demon Revive).\n")
			break

