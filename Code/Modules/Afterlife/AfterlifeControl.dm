var
	DeadReturn = 1
	ALRacePower= 1

obj/Crystal
	desc="A huge crystal made out of the most powerful material in the universe. You can sense a strange energy coming from it similar to the energies Kaios and Demons have. Probably impossible to break."
	Bolted		=1
	icon		='Crystal.dmi'
	Health		=1.#INF
	density 	=1
	Savable 	=1
	Grabbable 	=0
	ImmuneYear	=100

	var/tmp/Stop			=0
	var/Claimed				=0
	var/ClaimedBy			="No one"
	var/ClaimedByName		="No one"
	var/tmp/ClaimedByTemp	="No one"
	var/LastUsed			=0
	var/tmp/InUse			=0
	var/tmp/list/DeadList	=new/list()

	verb
		Read_Crystal_Energy()
			set src in oview(5)
			usr<<"This Crystal is under the control of [ClaimedByName]."
			usr<<"This Crystal can't be claim until [LastUsed]"
		Claim()
			set src in oview(1)
			if(usr.EXPLifetime<300)
				usr<<"You lack the life experience to claim this (330)."
				return
			if(usr.KOd)
				return
			if(usr.real_name == ClaimedBy)
				usr<<"You already own this!"
				return
			if(usr.RPMode)
				return
			if(Stop==1)
				usr<<"The process was stopped , wait until it gather enough energy to claim it again."
				return
			if(InUse==1)
				usr<<"Someone is already claiming it."
				return
			if(LastUsed>Year+(Month*0.01))
				usr<<"The crystal refuse to let you claim it.(CD year [LastUsed])"
				return
			if(usr.Race!="Kaio")if(usr.Race!="Demon")if(usr.Race!="Oni")if(usr.Race!="Demigod")
				usr<<"Your soul lack the energy to claim the crystal."
				return
			if(!usr.Confirm("Are you sure you want to claim the crystal?(You must emote it and CD)")) return
			for(var/mob/player/A in Players)
				if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon")
					A<<"<big><b><font color=red>Your mind snaps as you sense someone trying to take over the afterlife [name] at x:[x],y:[y],z:[z]!</b></big>"
			usr<<"This action will take a month to be compleated , if someone comes and stop you it will have to start all over again.Do not log out or it will not work."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Started the crystal claim.\n")
			InUse=1
			ClaimedByTemp=usr.ckey
			sleep(4500)
			view(src)<<"Crystal claiming attunment at 14,5%"
			if(Stop==1)
				view(src)<<"Crystal claiming attunment interrupted."
				InUse=0
				return
			sleep(4500)
			view(src)<<"Crystal claiming attunment at 25%"
			if(Stop==1)
				view(src)<<"Crystal claiming attunment interrupted."
				InUse=0
				return
			sleep(4500)
			view(src)<<"Crystal claiming attunment at 39.5%"
			if(Stop==1)
				view(src)<<"Crystal claiming attunment interrupted."
				InUse=0
				return
			sleep(4500)
			view(src)<<"Crystal claiming attunment at 50%"
			if(Stop==1)
				view(src)<<"Crystal claiming attunment interrupted."
				InUse=0
				return
			sleep(4500)
			view(src)<<"Crystal claiming attunment at 64.5%"
			if(Stop==1)
				view(src)<<"Crystal claiming attunment interrupted."
				InUse=0
				return
			sleep(4500)
			view(src)<<"Crystal claiming attunment at 75%"
			if(Stop==1)
				view(src)<<"Crystal claiming attunment interrupted."
				InUse=0
				return
			sleep(4500)
			view(src)<<"Crystal claiming attunment at 89.5%"
			if(Stop==1)
				view(src)<<"Crystal claiming attunment interrupted."
				InUse=0
				return
			sleep(4500)
			view(src)<<"Crystal claiming attunment at 100%"
			if(Stop==0)
				for(var/mob/player/AA in Players)
					if(ClaimedBy==AA.ckey)
						AA.CrystalPower --
						AA.CrystalClaimer = 0
						AA<<"You feel how the power of the afterlife scape your body."
				for(var/mob/player/A in Players)
					if(A.ckey == ClaimedByTemp)
						LastUsed=Year+(Month*0.01)+1
						Claimed=1
						ClaimedByName=A.real_name
						ClaimedBy=A.ckey
						A.CrystalPower++
						A.CrystalClaimer=1
						A<<"You succeed to claim the crystal."
						if(A.CrystalPower ==4)
							for(var/mob/player/AAA in Players)
								if(AAA.z==11 || AAA.Race=="Kaio" || AAA.Race=="Demon"||AAA.Magic_Potential>5)
									AAA<<"<big><b><font color=red>A wall of light decend and strike [A.name] as he ascend beyond any other god in the afterlife.</b></big>"
				for(var/mob/player/A in Players)
					if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon")
						A<<"<big><b><font color=red>[usr.name] have claimed the afterlife [name]!</b></big>"
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Claimed the afterlife crystal.\n")
				InUse=0
				return
			usr<<"You fail to claim the crystal."
			InUse=0


		Stop_Claim()
			set src in oview(1)
			if(usr.KOd)
				return
			if(usr.RPMode)
				return
			if(usr.EXPLifetime<300)
				usr<<"You lack the life experience to use this (330)."
				return
			if(Stop==1||InUse==0)
				usr<<"The process has already being stop or there is nothing to stop."
				return
			if(!usr.Confirm("Are you sure you want to stop the crystal ?(You must emote this and do a CD)")) return
			Stop=1
			view(src)<<"[usr] stopped the process."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Stopped the crystal claim.\n")
			sleep(4500)
			view(src)<<"Crystal spiritual energy at 12.5%"
			sleep(4500)
			view(src)<<"Crystal spiritual energy at 25%"
			sleep(4500)
			view(src)<<"Crystal spiritual energy at 37.5%"
			sleep(4500)
			view(src)<<"Crystal spiritual energy at 50%"
			sleep(4500)
			view(src)<<"Crystal spiritual energy at 62.5%"
			sleep(4500)
			view(src)<<"Crystal spiritual energy at 75%"
			sleep(4500)
			view(src)<<"Crystal spiritual energy at 87.5%."
			sleep(4500)
			view(src)<<"Crystal spiritual energy at 100%."
			Stop=0


		Final_Realm_Gate()
			set src in oview(1)
			if(usr.CrystalPower<4)
				usr<<"Only the Kaioshin or the Demon lord can use this."
				return
			if(LastUsed>Year+(Month*0.01))
				usr<<"The crystal refuse to to be used.(CD year [LastUsed])"
				return
			if(!usr.Confirm("Are you REALLY sure you know what are you doing?")) return
			usr<<"<font color=red>...What have you done...</b>"
			for(var/mob/player/A in Players)
				if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
					A<<"<big><b><font color=red>The afterlife shakes intensively as a portal to the forbidden realm materialize somewhere around the gods land.</b></big>"
			var/obj/Final_Realm_Portal/S = new
			S.x= rand(200,400)
			S.y= rand(200,400)
			LastUsed=Year+(Month*0.01)+10
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Used the final realm gate.\n")

		Veil_Control()
			set src in oview(1)
			if(usr.CrystalPower<4)
				usr<<"Only the Kaioshin or the Demon lord can use this."
				return
			if(LastUsed>Year+(Month*0.01))
				usr<<"The crystal refuse to be used.(CD year [LastUsed])"
				return
			if(!usr.Confirm("Toggle Global Realm Teleport? Current is [RealmTeleport]")) return
			if(RealmTeleport==0)
				RealmTeleport=1
				for(var/mob/player/A in Players)
					if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
						A<<"<big><b><font color=red>The veil of the afterlife has grow weak.</b></big>"
			else
				RealmTeleport=1
				for(var/mob/player/A in Players)
					if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
						A<<"<big><b><font color=red>The veil of the afterlife has grow weak.</b></big>"
			LastUsed=Year+(Month*0.01)+3
			logAndAlertAdmins("([usr.key]) [usr] set Global Realm Teleport to [RealmTeleport ? "On" : "Off"]",2)
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used realm travel toggle.\n")


		Allow_Mortals()
			set src in oview(1)
			if(usr.CrystalPower<4)
				usr<<"Only the Kaioshin or the Demon lord can use this."
				return
			if(LastUsed>Year+(Month*0.01))
				usr<<"The crystal refuse to to be used.(CD year [LastUsed])"
				return
			if(DeadReturn == 1)
				if(!usr.Confirm("You want to allow the mortals to stay in the AL while they are alive?")) return
				DeadReturn = 0
				for(var/mob/player/A in Players)
					if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
						A<<"<big><b><font color=red>The essence of the living realm begins to mix with the afterlife , they are now one.</b></big>"
			else
				DeadReturn = 1
				for(var/mob/player/A in Players)
					if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
						A<<"<big><b><font color=red>The essence of the living realm begins to banish from the afterlife , they are no longer one.</b></big>"
			LastUsed=Year+(Month*0.01)+2
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Allow Mortals.\n")

		Revive_Soul()
			set src in oview(1)
			if(usr.CrystalPower<4)
				usr<<"Only the Kaioshin or the Demon lord can use this."
				return
			if(LastUsed>Year+(Month*0.01))
				usr<<"The crystal refuse to to be used.(CD year [LastUsed])"
				return
			if(!usr.Confirm("You sure want to revive someone?")) return
			for(var/mob/player/AA in Players)
				if(AA.Dead)
					DeadList.Add("[AA.name]")
			var/tmp/DeadPick=input("Choose who to summon") in DeadList
			for(var/mob/player/A in Players)
				if(A.name==DeadPick)
					A.x=usr.x
					A.y=usr.y
					A.z=usr.z
					A.Revive()
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Crystal Revive on [key_name(A)].\n")
					A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was revived by [key_name(usr)] (Crystal Revive).\n")
					LastUsed=Year+(Month*0.01)+5

obj/Final_Realm_Portal
	desc="As you get closer you can hear something, like a thousand of souls screaming for help followed by the darkest energy you could ever sense in your life."
	Bolted		=1
	icon		='PortalZC.dmi'
	Health		=1.#INF
	density 	=1
	Savable 	=1
	Grabbable 	=0
	ImmuneYear	=100

	verb
		Attunment()
			set src in oview(1)
			if(!usr.Confirm("Are you sure you want to continue with this attunment?")) return
			if(!usr.Confirm("You need the sacrifice of a soul to open the gates , you want to continue?")) return
			icon='Portalz.dmi'