mob/AdminToggles/verb
	See_IC_Names()
		set category = "Admin Other"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.SeeIC = !(usr.client.holder.SeeIC)
		if(usr.client.holder.SeeIC)
			src << "You are now viewing IC names in OOC."
		else src << "You are no longer viewing IC names in OOC."