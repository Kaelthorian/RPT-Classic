mob/AdminToggles/verb
	listen_admin_alerts()
		set category = "Admin Other"
		set name = "(Un)Mute Admin Alerts"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.listen_Alerts = !(usr.client.holder.listen_Alerts)
		if (usr.client.holder.listen_Alerts)
			src << "You are now listening to admin alerts."
		else src << "You are no longer listening to admin alerts."