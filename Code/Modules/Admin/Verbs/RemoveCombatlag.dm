mob/proc/
	RemoveCombat(mob/M in Players)
		if(!src.client.holder)
			src << "Only administrators may use this command."
			return
		if(src.Confirm("Remove [M]s Combat Tracker?"))
			M.LethalCombatTracker=0
			log_admin("[key_name(usr)] used Remove Combat Flag on [key_name(M)]")
			alertAdmins("[key_name(usr)] used Remove Combat Flag on [key_name(M)]")