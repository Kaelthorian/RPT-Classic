Skill/Spell/Seance

	desc="Allows you to summon the spirit of a deceased person to this realm for one year. (50+ familiarity in contacts)"
	verb/Seance()
		set src=usr.contents
		set category="Skills"
		if(usr.z in list(8,11,10,17,16,13,9))
			usr<<"You can't use this here."
			return
		var/list/Tlist=list()
//		for(var/mob/AA in Players) if(AA.Dead&&AA.z==11) Tlist+=AA
		for(var/obj/Contact/X in usr.Contacts) for(var/mob/AA in Players) if(AA.z==11&&AA.ckey == X.pkey&&AA.Signature==X.Signature&&AA.Dead&&X.familiarity>=50 && AA.SeanceYear<Year&&AA.isGrabbing==0) if(AA.Dispelled>=(Year+(Month*0.01)))Tlist+=AA
		Tlist+="Cancel"
		var/mob/M = input("Whose spirit would you like to summon?") in Tlist
		if(M=="Cancel") return
		var/TAL=0
		if(M.z in list(8,11,10,17,16)) TAL=1
		if(!TAL)
			usr<<"You can not find their spirit..."
			return
		else
			usr<<"You locate their spirit..."
			var/Cost = 50000000
			var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
			usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
			if(usr.Confirm("Would you like to summon [M]s spirit to the mortal realm for one year? It will cost [Commas(Actual)] mana."))
				for(var/obj/Mana/MM in usr)
					if(MM.Value > Actual)
						M.SeanceYear=Year+1
						M.loc=usr.loc
						logAndAlertAdmins("[usr] used seance on [M].",1)
						for(var/mob/player/MMM in view(usr)) MMM.BuffOut("[usr] has summoned [M]s spirit!")
						MM.Value -= Actual
						hearers(10,usr) << sound(pick('imhere1.ogg','behindyou1.ogg','behindyou2.ogg','farnoise.ogg','growl1.ogg','growl2.ogg','growl3.ogg','iseeyou1.ogg','iseeyou2.ogg','lookup1.ogg','lookup2.ogg','overhere1.ogg','overhere2.ogg','overhere3.ogg','turnaround1.ogg','turnaround2.ogg','veryfarnoise.ogg','overhere3.ogg'),volume=20)
						usr << "Something else went through as you summomned this ghost..."
					else
						usr<<"Not enough mana."
						return

Skill/Spell/Advanced_Seance

	desc="Allows you to summon the spirit of a deceased person to this realm for 5 years (100+ familiarity in contacts)"
	verb/Advanced_Seance()
		set src=usr.contents
		set category="Skills"
		if(usr.z in list(8,11,10,17,16,13,9))
			usr<<"You can't use this here."
			return
		var/list/Tlist=list()
		for(var/obj/Contact/X in usr.Contacts) for(var/mob/AA in Players) if(AA.z==11&&AA.ckey == X.pkey&&AA.Signature==X.Signature&&AA.Dead&&X.familiarity>=100 && AA.SeanceYear<Year &&AA.isGrabbing==0) if(AA.Dispelled>=(Year+(Month*0.01)))Tlist+=AA
		Tlist+="Cancel"
		var/mob/M = input("Whose spirit would you like to summon?") in Tlist
		if(M=="Cancel") return
		var/TAL=0
		if(M.z in list(8,11,10,17,16)) TAL=1
		if(!TAL)
			usr<<"You can not find their spirit..."
			return
		else
			usr<<"You locate their spirit..."
			var/Cost = 250000000
			var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
			usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
			if(usr.Confirm("Would you like to summon [M]s spirit to the mortal realm for 1 year? It will cost [Commas(Actual)] mana."))
				for(var/obj/Mana/MM in usr)
					if(MM.Value > Actual)
						M.SeanceYear=Year+5
						M.loc=usr.loc
						logAndAlertAdmins("[usr] used advanced seance on [M].",1)
						for(var/mob/player/MMM in view(usr)) MMM.BuffOut("[usr] has summoned [M]s spirit!")
						MM.Value -= Actual
						hearers(10,usr) << sound(pick('imhere1.ogg','behindyou1.ogg','behindyou2.ogg','farnoise.ogg','growl1.ogg','growl2.ogg','growl3.ogg','iseeyou1.ogg','iseeyou2.ogg','lookup1.ogg','lookup2.ogg','overhere1.ogg','overhere2.ogg','overhere3.ogg','turnaround1.ogg','turnaround2.ogg','veryfarnoise.ogg','overhere3.ogg'),volume=20)
						usr << "Something else went through as you summomned this ghost..."
					else
						usr<<"Not enough mana."
						return
