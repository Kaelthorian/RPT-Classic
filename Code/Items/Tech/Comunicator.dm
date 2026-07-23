obj/items
	Communicator
		icon='Cell Phone.dmi'
		desc="Use this to communicate with anyone else that has a scouter or communicator on the same frequency.  It will also speak out of any cameras on the same frequency."

		New()
			src.detections = list()
			src.Frequency = "[rand(1,1000)]"
		verb/Transmit(msg as text)
			var/AL=0
			if(usr.z in list(8,11,10,17,16)) AL=1
			for(var/mob/player/A in Players) if(!A.afk)
				var/TAL=0
				if(A.z in list(8,11,10,17,16)) TAL=1
				if(TAL==AL)
					for(var/obj/items/Scanner/B in A)
						if(B.suffix&&B.Frequency==Frequency)
							A.ICOut("<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,A)]'")
							A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")
					for(var/obj/items/Communicator/B in A)
						if(B.Frequency==Frequency)
							A.ICOut("<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,A)]'")
							A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")
			for(var/mob/player/C in view(10,usr.loc)) if(!C.afk)
				C.ICOut("<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: [usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,C)]</span>")
			for(var/obj/items/Security_Camera/Ca in world) if(Ca.Frequency==Frequency)
				var/TAL=0
				if(Ca.z in list(6,18,19)) TAL=1
				if(TAL==AL)
					for(var/mob/player/CC in view(10,Ca)) CC.ICOut("<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: <b>\[[usr.lan]\]</b>[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,CC)]</span>")
		verb/Frequency()
			Frequency=input("Choose a frequency, it can be anything. It lets you talk to others on the same frequency. Default is 1") as text
			if(Frequency == "Communication Matrix") //if(usr.AS_Droid == 0)
				usr << "This Frequency seems to be entirely blocking off your access."
				Frequency = "1"