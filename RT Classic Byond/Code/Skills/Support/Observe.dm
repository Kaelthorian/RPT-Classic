Skill/Support/Observe
	desc="This will allow you to observe someone's character.  You will also see says/emotes that they see."

	verb/Observe()
		set category="Other"
		set src=usr.contents
		var/mob/A=input(usr,"Choose someone to observe.") as mob in Players
		if(A.HelmetOn>=3)
			usr<<"You can not seem to locate this person."
			return
		if(A=="Cancel") return
		usr << "You are now watching [A]."
		usr.Get_Observe(A)
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe on [key_name(A)].\n")

Skill/Support/Observe_Majinizations

	verb/Observe_Majinizations()
		set category="Other"
		set src=usr.contents
		var/list/CanO=list()
		for(var/mob/T in Players) if(T.MajinBy==usr.key) CanO+=T
		CanO+=usr
		var/mob/M=input("Choose who to observe") in CanO
		if(M == usr)
			usr.Get_Observe(M)
			return
		if(M.MajinBy == usr.key)
			usr << "You use your link to [M] and see through their eyes. Observe yourself to reset your view."
			usr.Get_Observe(M)
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe majinization on [key_name(M)].\n")

Skill/Support/ObserveAbsorber
	desc="This will allow you to observe the person who absorbed you.  You will also see says/emotes that they see."

	verb/Observe_Absorber()
		set category="Other"
		set src=usr.contents
		var/list/Choices=list()
		Choices+=usr
		for(var/mob/M in Players) if(M.key==usr.MajinAbsorbed) Choices+=M
		var/mob/MM=input("Choose") in Choices
		usr.Get_Observe(MM)
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe on [key_name(MM)].\n")