mob/AdminToggles/verb
	listen_admin_logins()
		set category = "Admin Other"
		set name = "(Un)Mute Player Logins"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.listen_Logins = !(usr.client.holder.listen_Logins)
		if (usr.client.holder.listen_Logins)
			src << "You are now listening to player logins."
		else src << "You are no longer listening to player logins."