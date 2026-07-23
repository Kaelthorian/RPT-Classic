
mob/var/CanBeMagicScanned=1


obj/items/Scanner/verb/Scan()
	set category="Other"
	if(!usr.Toggled_Sense)
		usr.Toggled_Sense = 1
		winshow(usr.client,"ScanArea",1)
		usr << "You have made your scanner tab show."
		winset(usr.client,"GridSA","cells=0x0")
		usr.Sense_Update()
	else usr.Sense_Update()
obj/items/Magic_Scanner/verb/Scan()
	set category="Other"
	if(!usr.Toggled_Sense)
		usr.Toggled_Sense = 1
		winshow(usr.client,"ScanArea",1)
		usr << "You have made your scanner tab show."
		winset(usr.client,"GridSA","cells=0x0")
		usr.Sense_Update()
	else usr.Sense_Update()

var/sense_tab_on = 1
mob/proc/Sense_Update()
	set background=1
	set waitfor=0
	//while(Toggled_Sense&&sense_tab_on&&src)
	var/atom/E
	if(S) E=S
	else E=src
	usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used scan.\n")
	if(sense_tab_on)
		if(Toggled_Sense&&!afk)
			var/Scouter
			var/I=1
			if(ScouterOn)
				for(var/obj/items/Scanner/A in src) if(A.suffix)
					Scouter=1
					var/mob/Center
					if(usr.S) Center=S
					else Center=src
					src << output("Location:","ScanArea.GridSA:1,[I]")
					src << output("([E.x],[E.y],[E.z])","ScanArea.GridSA:2,[I]")
					for(var/mob/B in Mob_Range_Scanner(Center,round(A.Range)))if(!B.afk) if(B.HelmetOn<4)
						var/Scan=B.BP
						if(Scan>A.Scan) Scan="!?"
						else Scan=Commas(Scan)
						if(A.Implant)Scan=Commas(B.BP)
						if(isnull(B)||isnull(B.client)) continue
						if(B.GodKiActive) Scan="???"
						var/nameout="??? ([B.Signature])"
						for(var/obj/Contact/Z in Contacts) if(Z.Signature == B.Signature) nameout=Z.name
						if(B==src) nameout=B//.name
						I++
						src << output(nameout,"ScanArea.GridSA:1,[I]")
						src << output("[Scan], [get_dist(Center.loc,B.loc)] tiles [dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
					I++
						//Radar
					if(A.Detects)
						I++
						src << output("Radar","ScanArea.GridSA:1,[I]")
						for(var/obj/B) if(B.z==Center.z&&B.type==A.Detects) if(B.invisibility<=see_invisible) if(B.x>Center.x-A.Range&&B.x<Center.x+A.Range&&B.y>Center.y-A.Range&&B.y<Center.y+A.Range)
							if(!(B.type==/obj/items/Magic_Ball&&!B.icon_state))
								I++
								src << output("[dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
								src << output(B.name,"ScanArea.GridSA:1,[I]")
						for(var/mob/B in Mob_Range_Scanner(Center,round(A.Range))) for(var/obj/C in B) if(C.type==A.Detects)
							if(!(C.type==/obj/items/Magic_Ball&&!C.icon_state)) if(C.invisibility<=see_invisible)
								I++
								src << output("[dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
								src << output(B.name,"ScanArea.GridSA:1,[I]")
							//MagicScanner
					break
				if(!Scouter)for(var/obj/items/Magic_Scanner/A in src) if(A.suffix)
					Scouter=1
					var/mob/Center
					if(usr.S) Center=S
					else Center=src
					src << output("Location:","ScanArea.GridSA:1,[I]")
					src << output("([E.x],[E.y],[E.z])","ScanArea.GridSA:2,[I]")
					for(var/mob/B in Mob_Range_Scanner(Center,round(A.Range)))if(!B.afk)if(B.HelmetOn<4)
						var/Scan=B.BP
						var/ScanBase=B.MaxKi//B.Base*B.Body*min(2.5,1+((B.GravMastered/25)/25))*B.RPPower//B.Base
						if(Scan>A.Scan) Scan="!?"
						else Scan=Commas(Scan)
						if(ScanBase>A.Scan*0.5) ScanBase="!?"
						else ScanBase=Commas(ScanBase)
						if(B.CanBeMagicScanned==0) ScanBase="!?"
						if(isnull(B)||isnull(B.client)) continue
						if(B.GodKiActive) Scan="[Scan] (Unknown Energy Type)"
						I ++
						var/nameout="??? ([B.Signature])"
						for(var/obj/Contact/Z in Contacts) if(Z.Signature == B.Signature) nameout=B.name
						if(B==src) nameout=B//.name
						src << output(nameout,"ScanArea.GridSA:1,[I]")
						src << output("[Scan] (Ki: [ScanBase]), [get_dist(Center,B)] tiles [dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
					break
			else if(Race=="Android")
				var/mob/Center
				if(usr.S) Center=S
				else Center=src
				src << output("Location:","ScanArea.GridSA:1,[I]")
				src << output("([E.x],[E.y],[E.z])","ScanArea.GridSA:2,[I]")
				for(var/mob/B in Mob_Range_Scanner(Center,150))if(!B.afk)
					var/Scan=B.BP
					Scan=Commas(Scan)
					if(isnull(B)||isnull(B.client)) continue
					if(B.GodKiActive) Scan="???"
					var/nameout="??? ([B.Signature])"
					for(var/obj/Contact/Z in Contacts) if(Z.Signature == B.Signature) nameout=Z//.name
					if(B==src) nameout=B//.name
					I++
					src << output(nameout,"ScanArea.GridSA:1,[I]")
					src << output("[Scan], [get_dist(Center.loc,B.loc)] tiles [dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
				I++
			winset(client,"ScanArea.GridSA","cells=2x[I]")
//		sleep(30)

Skill/Support/Sense_Energy


	desc="Allows you to sense the energies within a given area."
	verb/Sense_Energy()
		set category="Other"
		if(usr.Cyborg) return
		for(var/mob/A in Mob_Range(usr,round(0.75*(usr.MaxKi)))) if(A.Race!="Android"&&!A.Cyborg)if(!A.adminDensity)if(!A.afk)
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
/*
	verb/Ki_Beacon()
		set category="Other"

		if(usr.Willpower < 5 )
			usr<<"You can't use this move right now , it would kill you"
			return

		if(!usr.Confirm("Are you sure you want to use this skill? it will drain you 5 Willpower(Remember to RP it)")) return

		usr.Willpower= (usr.Willpower-5)
		usr.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Used Beacon Ki")

		for(var/mob/player/A in Mob_Range(usr,round((usr.KiMod)*60)))

			A<<"<big><b><font color=red>Your mind snaps as you sense burst of ki comming from [usr.name] at [dir2text(get_dir(A.loc,src.loc))]!</b></big>"
			return

		for(var/mob/player/A)
			if(A.z== usr.z)
				if(A.KiMod>=4	&& A!=usr)
					A<<"<big><b><font color=red>Your mind snaps as you sense a burst of ki comming from [usr.name] at [dir2text(get_dir(A.loc,src.loc))]!</b></big>"
					return
				if(A.KiMod>3	&& A!=usr)
					A<<"<big><b><font color=red>Your mind snaps as you sense a burst of ki comming from [usr.name]!</b></big>"
					return
				if(A.KiMod>2.5	&& A!=usr)
					A<<"<big><b><font color=red>Your mind snaps as you sense an unknow burst of ki!</b></big>"
					return
*/

/*
mob/verb/MapTextTest()
	var/image/O = new
	O.maptext="<font color=#a81202><span class=\"overs\">T</span></font>"
	O.maptext_y=-8
	O.maptext_x=13
	O.maptext_width=64
	O.layer=MOB_LAYER+EFFECTS_LAYER+10
	O.loc=usr
	usr<<O*/
mob/verb/Toggle_Scouter_Overlays()
	set category=null
	if(usr.ShowScouterOn)
		usr.ShowScouterOn = 0
		usr << "You have made Scouter Overlays hidden."
		return
	else
		usr.ShowScouterOn = 1
		usr << "You have made Scouter Overlays show."
		return

mob/verb/Toggle_Languages()
	set category=null
	if(usr.ShowLanguages)
		usr.ShowLanguages = 0
		usr << "You have made Languages hidden."
		return
	else
		usr.ShowLanguages = 1
		usr << "You have made Languages show."
		return
mob/var/ShowLanguages=0
mob/var/ShowBodyParts=0
mob/verb/Toggle_Body_Parts()
	set category=null
	if(usr.ShowBodyParts)
		usr.ShowBodyParts = 0
		usr << "You have made Body Parts hidden."
		return
	else
		usr.ShowBodyParts = 1
		usr << "You have made Body Parts show."
		return


mob/verb/Toggle_Team_Overlays()
	set category=null
	if(usr.TeamDisplay)
		usr.TeamDisplay = 0
		usr << "You have made Team overlays hidden."
		return
	else
		usr.TeamDisplay = 1
		usr << "You have made Team overlays show."
		return
mob/var/ShowScouterOn=1
mob/var/tmp/ScouterUpdates=0
mob/proc/addBPs()
	set waitfor=0
	if(Race=="Android")ScouterOn=9999999999999
	if(ScouterOn&&ShowScouterOn)
		ScouterUpdates++
		if(ScouterUpdates==1)
			for(var/mob/player/P in view(10)) if(P.HelmetOn<4)
				var/image/O = new
				O.maptext="<font color=#ffffff><span class=\"overs\">[ScouterDispNum(P.BP,ScouterOn)]</font>"
				O.maptext_y=34+(P.HealthBar.pixel_y-4)
				O.maptext_width=64
				O.layer=MOB_LAYER+EFFECTS_LAYER+10
				O.loc=P
				src<<O
				spawn(76) del O
		if(ScouterUpdates>=5)ScouterUpdates=0
proc/ScouterDispNum(var/Num,var/MaxP=10000)
	if(isnum(Num))
		var/NN=Num
		if(Num>MaxP) NN = "!?!?"
		else if(Num>1000000)
			NN/=1000000
			NN=round(NN,0.1)
			NN="[Commas(NN)] M"
		else if(Num>25000)
			NN/=1000
			NN=round(NN,0.1)
			NN="[Commas(NN)] K"
		else NN="[Commas(NN)]"
		return NN

mob/var/TeamDisplay=1//<span style=font-size:4pt>
mob/proc/addTeams()
	set waitfor=0
	if(TeamDisplay)
		for(var/mob/player/P in view(10))
			if(Target==P)
				var/image/O = new
				O.maptext="<font color=#a81202><span class=\"overs\">T</span></font>"
				O.maptext_y=-8
				O.maptext_x=abs(P.pixel_x)
				O.maptext_width=64
				O.layer=MOB_LAYER+EFFECTS_LAYER+10
				O.loc=P
				src<<O
				spawn(16) del O
			else if(P.Team==Team&&P!=src)
				var/image/O = new
				O.maptext="<font color=#009ec9><span class=\"overs\">T</span></font>"
				O.maptext_y=-8
				O.maptext_x=13
				O.maptext_width=64
				O.layer=MOB_LAYER+EFFECTS_LAYER+10
				O.loc=P
				src<<O
				spawn(16) del O
