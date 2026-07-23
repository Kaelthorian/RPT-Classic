/client/proc/cmd_admin_pm(mob/player/M as mob in world, t as text)
	set category = "Admin"
	set name = "Admin PM"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if(M)
		var/X = M.key
		if(src.muted)
			src << "You are muted have a nice day"
			return
		if (!( ismob(M) ))
			return
		if(!t)t = input("Message:", text("Private message to [X]"))  as text
		if(src.holder.rank != "Owner")
			t = strip_html(t,500)
		if (!( t ))
			return
		if(usr.client && usr.client.holder)
			if(M)
				M.AdminOut("<font color = #0080FF><span class=\"admin\">Admin PM from-<b>[key_name(usr, M, 0)]:</b> [t]</span>")
				usr.AdminOut("<font color = #0080FF><span class=\"admin\">Admin PM to-<b>[key_name(M, usr, 1)]:</b> [t]</span>")
		else
			if(M)
				if(M.client && M.client.holder)
					M.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM from-<b>[key_name(usr, M, 1)]:</b> [t]</span>")
				else
					M.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM from-<b>[key_name(usr, M, 0)]:</b> [t]</span>")
				usr.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM to-<b>[key_name(M, usr, 0)]:</b> [t]</span>")

		log_admin("PM: [key_name(usr)]->[key_name(M)] : [t]")
		for(var/mob/K in Players)	//we don't use alertAdmins here because the sender/receiver might get it too
			if(K && K.client && K.client.holder && K.client.holder.listen_Chat && K.key != usr.key && K.key != M.key)
				if(K.client.holder.SeeAllPMs) K.AdminOut("<font color = #0080FF><span class=\"admin\"><B>PM: [key_name(usr, K)]-&gt;[key_name(M, K)]:</B> [t]</span>")
				else K.HelpOut("<font color = #0080FF><span class=\"admin\"><B>PM: [key_name(usr, K)]-&gt;[key_name(M, K)]:</B> [t]</span>")
