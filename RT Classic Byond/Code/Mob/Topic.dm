/mob/Topic(href, href_list)

	if(href_list["telepathyrespond"])
		var/mob/M = locate(href_list["telepathyrespond"])
		if(M)
			if(!( ismob(M) )) return
			var/t = input("Message:", text("Telepathy response to [M]"))  as text
			if(!( t )) return
			if(M&&src)
				M.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>[usr] says in telepathy, \"[t]\" (<A HREF='?src=\ref[M];telepathyrespond=\ref[usr]'>Respond</A>)</span>")
				src.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>You say in telepathy, \"[t]\"</span>")
				for(var/mob/player/C in view(10,src.loc)) C.ICOut("<span class=\"say\"><font size=[C.TextSize] color=[src.TextColor]><b>\[[src.lan]\]</b> *??? [src.name] says, \"[src.LanguageSay(t,src.lan,src.lan.Mastery,C)]\"</span>")
				src.saveToLog("<span class=\"telepathy\">You say in telepathy to [M], \"[t]\"</span>\n")
				M.saveToLog("<span class=\"telepathy\">[key_name(usr)] telepathy: \"[t]\"</span>\n")
	if(href_list["priv_msg"])
		var/mob/M = locate(href_list["priv_msg"])
		if(M)
			if(src)if(src.client.muted)
				src << "You are muted have a nice day"
				return
			if(!( ismob(M) ))
				return
			var/t = input("Message:", text("Private message to [M.key]"))  as text
			if(!( t ))
				return
			if(src.client && src.client.holder)
				M.AdminOut("<font color = #0080FF><span class=\"admin\">Admin PM from-<b>[key_name(src, M, 0)]</b>: [t]</span>")
				src.AdminOut("<font color = #0080FF><span class=\"admin\">Admin PM to-<b>[key_name(M, src, 1)]</b>: [t]</span>")
			else
				if(M.client && M.client.holder)
					M.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM from-<b>[key_name(src, M, 1)]</b>: [t]</span>")
				else
					M.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM from-<b>[key_name(src, M, 0)]</b>: [t]</span>")
				src.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM to-<b>[key_name(M, src, 0)]</b>: [t]</span>")
			log_admin("PM: [key_name(src)]->[key_name(M)] : [t]")
			for(var/mob/player/K in world) if(K && K.client && K.client.holder && K.key != src.key && K.key != M.key)
				if(K.
				)K.AdminOut("<font color = #0080FF><b><span class=\"admin\">PM: [key_name(src, K)]->[key_name(M, K)]:</b> [t]</span>")
				else K.HelpOut("<font color = #0080FF><b><span class=\"admin\">PM: [key_name(src, K)]->[key_name(M, K)]:</b> [t]</span>")
	..()
	return