mob/verb/Say(msg as text)
	set category="Other"
	if(SayCD) return
	else SayCD=1
	spawn(1) SayCD=0
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg) return
	var/SQ=say_quote(msg)
	var/IC=1
	if(findtext(SQ,"OOC")) IC=0
	if(!IC&&!usr.CanOOC()) return
	if(IC&&!findtext(SQ,"thinks"))
		if(usr.KOd) if(prob(50)) msg=stutter(msg)
		if(usr.TicksOfMerriment) if(prob(usr.TicksOfMerriment/80)) msg=stutter(msg)
		if(usr.Critical_Throat) if(prob(50)) msg = "*Mumbles incoherently*..."
	var/SN=1
	var/mob/Sender=usr
	if(wordcount(msg)>1) EarnServerEmote(2)
	if(findtext(SQ,"exclaims"))
		for(var/mob/player/M in hearers(18,Sender))
			if(M.client)
				if(M==usr) SN=1
				if(M.Observer) for(var/mob/player/S in Players) if(M.Observer==S.key)
					if(IC)S.AllOut("<span class=\"say\"><font size=[S.TextSize] color=[TextColor]><b>\[[lan]\]</b>(Observe) [Sender.name] [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,S)]\"</span>")
					else S.AllOut("<span class=\"say\"><font size=[S.TextSize] color=[TextColor]>[Sender.name] [SQ] [OOCText(msg)]</span>")
				for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature) SN=1
				for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature_True) SN=1
				var/Hear = 1
				if(M.Critical_Hearing)
					Hear = 0
					if(prob(60)) Hear=1
				if(M.afk)
					Hear=0
					if(prob(50)) Hear=-1
				if(Hear==1)
					if(M.client.holder)
						if(!SN) M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> ???([Sender.name]) (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
						if(SN) M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> [Sender.name] (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
					else
						if(!SN) M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> ??? [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
						if(SN) M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> [Sender.name] [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
				else if(Hear==0) M.ICOut("<i>You hear a distant noise...</i>")
		Say_Spark()
		usr.saveToLog("<font color=#FF00FF>\n<span class=\"say\">[usr]([key]): [msg] ([usr.x], [usr.y], [usr.z])</span>\n")
		return
	else
		usr.saveToLog("<font color=#FF00FF>\n<span class=\"say\">[usr]([key]) says [msg] ([usr.x], [usr.y], [usr.z])</span>\n")
		for(var/mob/player/M in hearers(12,Sender))
			if(M.client)
				if(M==usr)SN=1
				if(M.Observer) for(var/mob/player/S in Players) if(M.Observer==S.key)
					if(IC)S.AllOut("<span class=\"say\"><font size=[S.TextSize] color=[TextColor]><b>\[[lan]\]</b>(Observe) [Sender.name] [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,S)]\"</span>")
					else S.AllOut("<span class=\"say\"><font size=[S.TextSize] color=[TextColor]>[Sender.name] [SQ] [OOCText(msg)]</span>")
				for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature) SN=1
				for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature_True) SN=1
				var/Hear = 1
				if(M.Critical_Hearing)
					Hear = 0
					if(prob(25)) Hear=1
				if(M.afk)
					Hear=0
					if(prob(50)) Hear=-1
				if(!IC) if(!findtext(SQ,"thinks")) if(M.listen_looc||findtext(msg,"INF") )if(!M.afk)
					if(M.client.holder)
					//	M.ICOut("<BIG>\icon[I]</BIG><span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[Sender.name] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] [OOCText(msg)]</span>")
						M.AllOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[Sender.name] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] [OOCText(msg)]</span>")
						M.OOCOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[Sender.name] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] [OOCText(msg)]</span>")
					else
					//	M.ICOut("<BIG>\icon[I]</BIG><span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[Sender.name] [SQ] [OOCText(msg)]</span>")
						M.AllOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[Sender.name] [SQ] [OOCText(msg)]</span>")
						M.OOCOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[Sender.name] [SQ] [OOCText(msg)]</span>")
				if(findtext(SQ,"thinks"))if(!M.afk)
					if(M.client.holder)
						if(!SN)M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]>???([Sender.name]) (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] [ThinkText(msg)]</span>")
						if(SN)M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[Sender.name] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] [ThinkText(msg)]</span>")
					else
						if(!SN)M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]>??? [SQ] [ThinkText(msg)]</span>")
						if(SN)M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]>[Sender.name] [SQ] [ThinkText(msg)]</span>")
					IC=0
				else if(Hear==1)
					if(IC)
						if(M.client.holder)
							if(!SN)M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> ???([Sender.name]) (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
							if(SN)M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> [Sender.name] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
						else
							if(!SN)M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> ??? [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
							if(SN)M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> [Sender.name] [SQ] \"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
				else if(Hear==0) if(IC) M.ICOut("<i>You hear a distant noise...</i>")
		Say_Spark()
		return


proc/OOCText(A as text)
	var/remainingtext=A
	var/output="("
	if(findtext(remainingtext,"(")|findtext(remainingtext,"\[")|findtext(remainingtext,"{"))
		if(findtext(remainingtext,")")|findtext(remainingtext,"\]")|findtext(remainingtext,"}"))
			output+=copytext(remainingtext,2,-1)
			output+=")"
		else output+="[copytext(remainingtext,2,0)])"
	else if(findtext(remainingtext,")")|findtext(remainingtext,"\]")|findtext(remainingtext,"}"))
		output+=copytext(remainingtext,1,-1)
		output+=")"
	return output

proc/ThinkText(A as text)
	var/remainingtext=A
	var/output="<i>\<"
	if(findtext(remainingtext,"\<"))
		if(findtext(remainingtext,"\>"))
			output+=copytext(remainingtext,5,-4)
			output+=">"
		else output+="[copytext(remainingtext,5,0)]\>"
	else if(findtext(remainingtext,"\>"))
		output+=copytext(remainingtext,1,-4)
		output+="\></i>"
	return output

/proc/stars(n, pr)	//Use if someone can't understand what's being said
	if (pr == null)
		pr = 25
	if (pr <= 0)
		return null
	else
		if (pr >= 100)
			return n
	var/te = n
	var/t = ""
	n = length(n)
	var/p = null
	p = 1
	while(p <= n)
		if ((copytext(te, p, p + 1) == " " || prob(pr)))
			t = text("[][]", t, copytext(te, p, p + 1))
		else
			t = text("[]*", t)
		p++
	return t

/proc/stutter(n)	//Returns a staggered version of input
	var/te = html_decode(n)
	var/t = ""
	n = length(n)
	var/p = null
	p = 1
	while(p <= n)
		var/n_letter = copytext(te, p, p + 1)
		if (prob(80))
			if (prob(10))
				n_letter = text("[n_letter][n_letter][n_letter][n_letter]")
			else
				if (prob(20))
					n_letter = text("[n_letter][n_letter][n_letter]")
				else
					if (prob(5))
						n_letter = null
					else
						n_letter = text("[n_letter][n_letter]")
		t = text("[t][n_letter]")
		p++
	return copytext(sanitize(t),1,MAX_MESSAGE_LEN)