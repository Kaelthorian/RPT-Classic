

mob/var/issupermystic=0

Skill/Buff/Mystic
	buffon="emits a great and calming power."
	buffoff="stops using Mystic."
	BP=1.5
//	Spd=1.2
	Def=1.2

	var/Super=0
	GetDescription(mob/Getter)
		return "Mystic will increase your BP by [BP]x, Defense by [Def]x and Power Up by +10%."
		..()
	verb/Mystic()
		set category="Skills"
		if(usr.ismajin)
			usr<<"You cant use this with Majin"
			return
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/WhiteCloak,0,0,0,0,0,0)
		usr.HairAdd()
		usr.FirstTransWPRestore(usr)


Skill/Buff/Sin_Force
	buffon="emits a great and terrifying power."
	buffoff="stops using Majin."
	BP=1.5
//	End=1.2
	Off=1.2

	var/Super=0
	icon='Electric_Majin.dmi'
	GetDescription(mob/Getter)
		return "Majin will increase your BP by [BP]x and Off by [Off]x. It will passively increase your base regen."
		..()
	verb/Majin()
		set category="Skills"
		if(usr.ismystic)
			usr<<"You cant use this with Mystic"
			return
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/BlackCloak,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)
			/*	if(Super) if(usr.Confirm("Would you like to use Super? (+1 God Ki)"))
					for(var/mob/player/M in view(usr)) M.BuffOut("You feel a great and terrifying power emanate from [usr].")
					usr.SSjGodKi++
					usr.issupermystic=1*/

/*
Skill/Support/Majinize
	Experience=100
	RequiresApproval=1
	var/LastUse
	var/list/Majins=list()
	verb/Majinize(mob/player/M in oview(1))
		set category="Other"
		set src = usr.contents
		if(Year<LastUse+5)
			usr<<"You cannot use this until year [LastUse+5]"
			return
		alert(usr,"You must make a discord post following the appropriate format which can be found in the RANKS section","ATTENTION")
		if(M.Race!="Kaio")for(var/Skill/Buff/Mystic/MM in M)
			if(usr.Confirm("Remove their Mystic?"))
				del(MM)
				LastUse=Year-2.5
				if(M.EnablementSlot) M.EnablementSlot=0
				return
		if(M.EnablementSlot)
			usr<<"They already possess great skill."
			return
		if(locate(/Skill/Buff/Sin_Force) in M)
			src<<"They already have it"
			return
		if(M.Race=="Demon")
			usr<<"You may not use this on another Demon."
			return
		var/x=input(M,"[usr] would like to use [src] on you.  You will be forced to obey them in-character. Do you accept?") in list("No","Yes")
		if(x!="Yes") return
		if(locate(/Skill/Buff/Sin_Force) in M)
			src<<"They already have it"
			return
		M.MajinBy = usr.key
		Majins+=M.key
		for(var/Skill/Buff/Mystic/A in M) del(A)
		M.contents += new /Skill/Buff/Sin_Force(M)
		LastUse=Year
		M.EnablementSlot=1
		M.AlignmentNumber-=4
		M.AlignmentCalibrate()
		alertAdmins("[key_name(usr)] has Majinized [key_name(M)].")
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Majinized [key_name(M)]")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Majinized [key_name(M)].\n")
		M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)] was Majinized by [key_name(usr)].\n")
*/
Skill/Support/Mystify

	RequiresApproval=1
	var/LastUse
	verb/Mystify(mob/player/M in oview(1))
		set category="Other"
		set src = usr.contents
		if(Year<LastUse+5)
			usr<<"You cannot use this until year [LastUse+5]"
			return
		alert(usr,"You must make a discord post following the appropriate format which can be found in the RANKS section","ATTENTION")
		if(M.Race!="Demon")for(var/Skill/Buff/Sin_Force/MM in M)
			if(usr.Confirm("Remove their Majin?"))
				del(MM)
				LastUse=Year-2.5
				if(M.EnablementSlot) M.EnablementSlot=0
				return
		if(M.EnablementSlot)
			usr<<"They already possess great skill."
			return
		if(locate(/Skill/Buff/Mystic) in M)
			src<<"They already have it"
			return
		if(M.Race=="Kaio")
			usr<<"You may not use this on another Kaio."
			return
		var/x=input(M,"[usr] would like to use [src] on you.  You will be alignment locked to Good for the duration. Do you accept?") in list("No","Yes")
		if(x!="Yes") return
		if(locate(/Skill/Buff/Mystic) in M)
			src<<"They already have it"
			return
		for(var/Skill/Buff/Sin_Force/A in M) del(A)
		M.contents += new/Skill/Buff/Mystic(M)
		LastUse=Year
		M.AlignmentNumber+=4
		M.AlignmentCalibrate()
		M.EnablementSlot=1
		alertAdmins("[key_name(usr)] has Mystified [key_name(M)].")
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Mystified [key_name(M)]")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Mystified [key_name(M)].\n")
		M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)] was Mystified by [key_name(usr)].\n")




