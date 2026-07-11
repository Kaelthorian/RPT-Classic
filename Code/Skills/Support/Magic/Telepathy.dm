Skill/Support/Telepathy

	desc="Allows you to communicate with someone you know the energy signature of (5+ familiarity in contacts)"
	verb/Telepathy()
		set src=usr.contents
		set category="Other"
		set instant=1
		if(usr.Critical_Head)
			usr.ICOut("Your head injury is preventing you from doing this for now.")
			return
		var/list/Tlist=list()
		for(var/obj/Contact/X in usr.Contacts) for(var/mob/AA in Players) if(AA.ckey == X.pkey&&AA.Signature==X.Signature&&X.familiarity>5)
			Tlist+=AA
		Tlist+="Cancel"
		var/mob/M = input("Telepathy who?") in Tlist
		if(M=="Cancel") return
		var/AL=0
		if(usr.z in list(8,11,10)) AL=1
		var/TAL=0
		if(M.z in list(8,11,10)) TAL=1
		if(TAL!=AL)
			if(!usr.Rank)
				usr<<"You can not reach them."
				return
			/*if(!RealmTeleport)
				usr<<"You can not reach them."
				return*/
		if(!M.HelmetOn)
			var/message=input("Say what in telepathy?") as text
			message = copytext(sanitize(message), 1, MAX_MESSAGE_LEN)
			if(!message)	return
//			log_telepathy("[usr.name]/[usr.key] : [message]")
			if(M)
				if(locate(/Skill/Support/Telepathy) in M)
					usr.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>You say in telepathy to [M.name], \"[message]\"</font></span>")
					M.ICOut("<span class=\"telepathy\"><font size=[M.TextSize] color=[usr.TextColor]>[usr] says in telepathy, \"[message]\" (<A HREF='?src=\ref[M];telepathyrespond=\ref[usr]'>Respond</A>)</font></span>")
				else
					usr.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>You say in telepathy to [M.name], \"[message]\" (They do not have Telepathy)</font></span>")
					M.ICOut("<span class=\"telepathy\"><font size=[M.TextSize] color=[usr.TextColor]>A voice in your head says, \"[message]\" (<A HREF='?src=\ref[M];telepathyrespond=\ref[usr]'>Respond</A>)</font></span>")
			for(var/mob/player/C in view(10,usr.loc)) C.ICOut("<span class=\"say\"><font size=[C.TextSize] color=[usr.TextColor]><b>\[[usr.lan]\]</b> *[usr.name] says, \"[usr.LanguageSay(message,usr.lan,usr.lan.Mastery,C)]\"</span>")
			usr.saveToLog("<span class=\"telepathy\">You say in telepathy to [M.name], \"[message]\"</span>\n")
		else
			usr << "You are unable to communicate with [M.name]!"
