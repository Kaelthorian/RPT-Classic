Skill/Support/Vampire_Infect

	var/LastUse=-1
	desc="You can use this ability to give someone vampiric abilities, and causes low HP to only reduce BP to 70% instead of 30% but will reduce their Regeneration ticks by 20%. They will also get one charge of Death Regen and some skills. Each infection will drain you of 1000 of your max energy and 35% of your current stats. 1 Year CD."
	verb/Vampire_Infect()
		set category="Skills"
		if(usr.RPMode) return
		if(LastUse+1>Year)
			usr<<"You need to wait until year [LastUse+1]."
			return
		if(usr.BaseMaxKi >= 1500)
			for(var/mob/P in get_step(usr,usr.dir)) if(P.client)
				if(P.KOd==0) switch(input(P,"Do you want [usr] to turn you into a vampire? (1 charge of Death Regen, and causes low HP to only reduce BP to 70% instead of 30% but will reduce their Regeneration ticks by 30%)") in list("No","Yes"))
					if("No") return
				if(P.Regenerate||P.Race=="Android"||P.Race=="Majin")
					usr<<"They seem to be immune to vampirism."
					return
				if(P.Vampire)
					usr<<"They are already a vampire"
					return
				usr.BaseMaxKi -= 1000
				view(usr)<<"[usr] bites [P] and turns them into a vampire!"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] turns [P] into a vampire \n")
				alertAdmins("[key_name_admin(usr)] has turned [P] into a vampire.")
//				usr.StrMod/= 1.2
//				usr.SpdMod/=1.2
//				usr.EndMod/= 1.2
//				usr.DefMod/= 1.2
//				usr.OffMod/= 1.2
				LastUse=Year
				P.Vampire=1
				P.Vampire_Skills()
				return
Skill/Support/Vampire_Telepathy

	verb/Vampire_Telepathy()
		set src=usr.contents
		set category="Other"
		set instant=1
		var/message=input("Say what in Vampire Telepathy?") as text
		usr << "<span class=\"telepathy\"><font size=[usr.TextSize]>You say in Vampire Telepathy \"[message]\"</font></span>"
		usr.saveToLog("<span class=\"telepathy\">You say in Vampire Telepathy \"[message]\"</span>\n")
		for(var/mob/player/M in Players)
			if(M.Vampire)
				if(M.seetelepathy) if(M != usr)
					message = copytext(sanitize(message), 1, MAX_MESSAGE_LEN)
					if(!message)	return
//					log_telepathy("[usr.name]/[usr.key] : [message]\n")
					if(M)  M<< "<span class=\"telepathy\"><font size=[M.TextSize]>[usr] says in Vampire Telepathy, \"[message]\"</font></span>"
				else
					usr << "You are unable to communicate with [M.name]!"

mob/proc/RemoveVampire_Skills()if(Vampire==1)
	contents.Remove(/Skill/Support/Invisibility,/Skill/Buff/Power_Control,/Skill/Support/Telekinesis,/Skill/Misc/Absorb_Energy,/Skill/Support/Send_Energy,/Skill/Support/Vampire_Infect,/Skill/Support/Vampire_Telepathy)
	Vampire=0
	if(Regenerate) Regenerate=0
	TK = 0

mob/proc/Vampire_Skills()
	if(Vampire==2)
		contents+=new/Skill/Support/Vampire_Infect
		contents+=new/Skill/Support/Send_Energy
		contents+=new/Skill/Support/Imitation
	contents.Add(new/Skill/Support/Invisibility,new/Skill/Support/Telekinesis,new/Skill/Misc/Absorb_Energy,new/Skill/Support/Vampire_Telepathy)
	src.TK = 1
	Regenerate=1
	Remove_Duplicate_Moves()