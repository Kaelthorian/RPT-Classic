mob/AdminToggles/verb
	ListenAllPMs()
		set category = "Admin Other"
		set name = "(Un)Mute Admin PMs"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.SeeAllPMs = !(usr.client.holder.SeeAllPMs)
		if (usr.client.holder.listen_Alerts)
			src << "You are now listening to Admin PMs."
		else src << "You are no longer listening to Admin PMs."