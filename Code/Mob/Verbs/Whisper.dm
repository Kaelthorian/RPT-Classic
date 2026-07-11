/mob/verb/Whisper(msg as text)
	set category="Other"
	set instant=1
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg) return
	var/SN=0
	if(usr.Health<=0 && prob(95)) msg=stutter(msg)
	for(var/mob/player/M in view(usr)-view(1))if(!M.afk)  if(M.Critical_Hearing == 0) M.ICOut("<font size=[M.TextSize]>-[name] whispers something...")
	for(var/mob/player/M in hearers(1))
		if(M.client&&!M.SNj&&M.Race!="Namekian")
			if(M==usr) SN=1
			for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature) SN=1
			var/Hear = 1
			if(M.Critical_Hearing) Hear = 0
			if(M.afk)
				Hear=0
				if(prob(50)) Hear=-1
			if(Hear==1)
				if(M.client.holder)
					if(!SN) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> *??? ([usr.name]) (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
					if(SN) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> *[usr.name] (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
				else
					if(!SN) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> *??? whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
					if(SN) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> *[usr.name] whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
				if(M.Observer) for(var/mob/player/S in Players) if(S.key==M.Observer) S.AllOut("<span class=\"whisper\"><font size=[S.TextSize] color=[TextColor]><b>\[[lan]\]</b> *[usr.name] whispers, \"[LanguageSay(msg,lan,lan.Mastery,S)]\"</span>")
			else if(Hear==0) M.ICOut("<i>You hear a distant noise...</i>")
	for(var/mob/player/M in hearers(10,usr)) if(M.SNj||M.Race=="Namekian") M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> (Namekian Hearing) *[usr.name] whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
	Say_Spark()
	usr.saveToLog("<font color=#FF00FF>\n<span class=\"whisper\">[usr]([key]): whispers [msg]  ([usr.x], [usr.y], [usr.z])</span>\n")