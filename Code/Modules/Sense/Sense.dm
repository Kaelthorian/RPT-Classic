Skill/Support/Sense_Energy
	desc="Allows you to sense the energies within a given area."
	verb/Sense_Energy()
		set category="Other"
		if(usr.Cyborg) return
		for(var/mob/A in block(locate(1,1,1), locate(10,10,1))
			if(A.Race!="Android"&&!A.Cyborg)
				if(!A.adminDensity)
					if(!A.afk)
			var/MyP=usr.BP*max(usr.Pow,usr.Str)*usr.Spd*usr.Off*usr.Def
			var/TheyP=A.BP*max(A.Pow,A.Str)*A.Spd*A.Off*A.Def
			var/Power=round((TheyP/MyP)*100)
			if(Power>10000) Power=10000
			if(A.GodKiActive&&!usr.GodKi) Power="???"
			var/nameout="??? ([A.Signature])"
			var/Manahas
			for(var/obj/Mana/Ma in A) Manahas=Ma.Value
			if(usr.Race=="Spirit Doll") nameout="[nameout] ([Manahas] Mana)"
			for(var/obj/Contact/Z in usr.Contacts) if(Z.Signature == A.Signature) nameout=A//.name
			if(A.HelmetOn<4) usr.AllOut("[nameout] [Power]% [get_dist(usr,A)] tiles [dir2text(get_dir(usr.loc,A.loc))]")
			if(locate(/obj/items/Artifact) in A)usr.AllOut("You sense a mysterious power coming from [get_dist(usr,A)] tiles [dir2text(get_dir(usr.loc,A.loc))]")
			if(locate(/obj/items/Mark_Of_The_Beast) in A)usr.AllOut("You sense a mysterious power coming from [get_dist(usr,A)] tiles [dir2text(get_dir(usr.loc,A.loc))]")
			if(locate(/obj/items/Ring_Of_Power) in A)usr.AllOut("You sense a mysterious power coming from [get_dist(usr,A)] tiles [dir2text(get_dir(usr.loc,A.loc))]")
			if(locate(/obj/items/Necklace_Of_Wisdom) in A)usr.AllOut("You sense a mysterious power coming from [get_dist(usr,A)] tiles [dir2text(get_dir(usr.loc,A.loc))]")
			if(locate(/obj/items/Ring_Of_Experience) in A)usr.AllOut("You sense a mysterious power coming from [get_dist(usr,A)] tiles [dir2text(get_dir(usr.loc,A.loc))]")
			if(locate(/obj/items/Magic_Ball) in A)usr.AllOut("You sense a mysterious power coming from [get_dist(usr,A)] tiles [dir2text(get_dir(usr.loc,A.loc))]")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used sense.\n")
		for(var/obj/items/Mark_Of_The_Beast/M) if(M.z==usr.z||M.loc.z==usr.z) usr.AllOut("You sense a mysterious power coming from [get_dist(usr,M)] tiles [dir2text(get_dir(usr.loc,M.loc))]")
		for(var/obj/items/Ring_Of_Power/M) if(M.z==usr.z||M.loc.z==usr.z) usr.AllOut("You sense a mysterious power coming from [get_dist(usr,M)] tiles [dir2text(get_dir(usr.loc,M.loc))]")
		for(var/obj/items/Necklace_Of_Wisdom/M) if(M.z==usr.z||M.loc.z==usr.z) usr.AllOut("You sense a mysterious power coming from [get_dist(usr,M)] tiles [dir2text(get_dir(usr.loc,M.loc))]")
		for(var/obj/items/Ring_Of_Experience/M) if(M.z==usr.z||M.loc.z==usr.z) usr.AllOut("You sense a mysterious power coming from [get_dist(usr,M)] tiles [dir2text(get_dir(usr.loc,M.loc))]")
		for(var/obj/items/Artifact/M) if(M.z==usr.z||M.loc.z==usr.z) usr.AllOut("You sense a mysterious power coming from [get_dist(usr,M)] tiles [dir2text(get_dir(usr.loc,M.loc))]")
		for(var/obj/items/Magic_Ball/M) if(M.z==usr.z||M.loc.z==usr.z) usr.AllOut("You sense a mysterious power coming from [get_dist(usr,M)] tiles [dir2text(get_dir(usr.loc,M.loc))]")

proc/SenseMath(mob/A)
	SenseMath= (A.SenseMod*A.KiMod)

	return SenseMath