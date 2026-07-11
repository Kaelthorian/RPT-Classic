mob/AdminToggles/verb
	listen_admin_chat()
		set category = "Admin Other"
		set name = "(Un)Mute Admin Chat"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.listen_Chat = !(usr.client.holder.listen_Chat)
		if (usr.client.holder.listen_Chat)
			src << "You are now listening to admin chat."
		else src << "You are no longer listening to admin chat but you probably should be."