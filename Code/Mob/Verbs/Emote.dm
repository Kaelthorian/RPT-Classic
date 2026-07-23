mob/verb
	Emote()
	//	set category="Other"
		set instant=1
		var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_y = 12
		_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
		overlays -= _overlay
		if((winget(client,"emoteW","is-visible")=="true"))
			winshow(client,"emoteW",0)
			return
		winshow(client,"emoteW",1)
	//	.winset "tabpane.tab.current-tab=chatpane;chatpane.chatinput.focus=true"
		winset(client, "emoteW.emoteinput", "focus=true")
		//winset(client, "emoteW", "emoteinput.focus=true")
		usr.saveToLog("<br> |  | ([x], [y], [z]) |<span class=\"emote\">*[usr] starts typing an emote.*</span>\n")
		overlays += _overlay
		//if(!RPMode) RPMode()
//		var/msg = input("Emote") as message

	EmoteS()
		set hidden=1
		if(EmoteCD) return
		else EmoteCD=1
		spawn(5) EmoteCD=0
		var/msg=winget(usr, "emoteW.emoteinput", "text")
		msg = copytext(sanitize_n(msg), 1, MAX_MESSAGE_LEN)
		if(!msg)
			winshow(client,"emoteW",0)
			var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
			_overlay.pixel_y = 12
			_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
			overlays -= _overlay
			usr.saveToLog("<br> |  | ([x], [y], [z]) |<span class=\"emote\">*[usr] cancels their emote.*</span>\n")
			return
		//r/icon/I = usr.getIconImage()
//		log_emote("[usr.name]/[usr.key] : [msg]")
		var/mob/Sender=usr
		if(InFusion) for(var/mob/player/M)if(M.FusionKey2==key) Sender=M
		for(var/mob/player/M in hearers(ViewX,Sender))
			if(M.client&&!M.afk)
				if(M.Observer) for(var/mob/player/S in Players) if(M.Observer==S.key) S.AllOut("<span class=\"emote\"><font size=[S.TextSize]>(Observe)*[Sender] [S.ICText(msg,usr)]*</span>")
				if(M.client.holder) M.ICOut("<span class=\"emote\"><font size=[M.TextSize]>*[Sender] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [M.ICText(msg,usr)]*</span>")
				else M.ICOut("<span class=\"emote\"><font size=[M.TextSize]>*[Sender] [M.ICText(msg,usr)]*</span>")
		usr.saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(usr)] ::<br> <span class=\"emote\">*[usr] [msg]*</span>\n")
//				for(var/Activity/A in M) if(A.Subtype=="RP") if(prob(30)) A.CheckProgress(1,usr.Signature,M)
		SaveToEmoteLog("[msg]")
		RPs += 1
		if(wordcount(msg)>29) 			EarnServerEmote()
		if(wordcount(msg)>=30)
			src.HitterListOld = list()					//If the emote is of 30 words or more , reset the hitter old list for the anger system
			src.FailToAnger=0
			src.HitterListNew = list()
			src.LastHitter = 0
		if(wordcount(msg)>59) 			EarnServerEmote()
		if(wordcount(msg)>89) 			EarnServerEmote()
		if(wordcount(msg)>119) 			EarnServerEmote()
		if(wordcount(msg)>149) 			EarnServerEmote()
		if(wordcount(msg)>179) 			EarnServerEmote()
		if(wordcount(msg)>209) 			EarnServerEmote()
		if(wordcount(msg)>239) 			EarnServerEmote()
		if(wordcount(msg)>269) 			EarnServerEmote()
		if(wordcount(msg)>299)			EarnServerEmote()
		if(wordcount(msg)>329) 			EarnServerEmote()
		if(wordcount(msg)>359) 			EarnServerEmote()
		if(wordcount(msg)>389) 			EarnServerEmote()
		if(wordcount(msg)>419) 			EarnServerEmote()
		Say_Spark()
		var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_y = 12
		_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
		overlays -= _overlay
		//if(RPMode) RPMode()
		winshow(client,"emoteW",0)
		winset(usr.client, "emoteW.emoteinput", "text=")

	EmoteClose()
		set hidden=1
		var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_y = 12
		_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
		overlays -= _overlay
		EmoteCD=0
		winshow(client,"emoteW",0)


	EmoteC()
		set hidden=1
		winset(usr.client, "emoteW.emoteinput", "text=")

mob/proc/ICText(A as text,mob/M)
	var/remainingtext=A
	var/output
	loop
	if(findtext(remainingtext,"&#34;"))
		output+=copytext(remainingtext,1,findtext(remainingtext,"&#34;"))
		output+="<font color=[M.TextColor]>\[[M.lan]\] &#34;"
		remainingtext=copytext(remainingtext,findtext(remainingtext,"&#34;")+5,0)
		if(findtext(remainingtext,"&#34;"))
			output+=M.LanguageSay(copytext(remainingtext,1,findtext(remainingtext,"&#34;")),M.lan,M.lan.Mastery,src)
			if(findtext(copytext(remainingtext,1,findtext(remainingtext,"&#34;")),M.name)) src.Contacts(M.Signature)
			output+="&#34;<span class=\"emote\">"
			remainingtext=copytext(remainingtext,findtext(remainingtext,"&#34;")+5,0)
			goto loop
		else output+=M.LanguageSay(remainingtext,M.lan,M.lan.Mastery,src)
	else output+=remainingtext
	return output