/obj/admins/Topic(href, href_list)
	..()
	//Don't allow people to enter html from cmd line
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if (usr.client != src.owner)
		world << "\red [usr.key] has attempted to override the admin panel!"
		log_admin("[key_name(usr)] tried to use the admin panel without authorization.")
		return

	//Mute a player
	if (href_list["mute2"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator"  )))
			var/mob/M = locate(href_list["mute2"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return

				if(M.client.muted || usr.sfIsMuted(M))

					M << "You have been unmuted."
					log_admin("[key_name(usr)] has voiced [key_name(M)].")
					alertAdmins("[key_name_admin(usr)] has unmuted [key_name_admin(M)].", 1)
					//file("AdminLog.log")<<"[usr]([usr.key] voiced [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
					global.MutedList-="[M.client]"
					global.MutedList-="[usr.sfID(M)]"
					M.client.muted = 0
					//MutedList-="[ckey(M.key)]"
					//usr.sfUnMute(M)
					//world << "<font color=red><b>DEBUG1 :: </font>[M] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"

				else

					var/time = input("Select an amount of time to mute [M.name] (1 = 1 second)","Mute") as num|null
					if( !(time) || time == null)
						src << "You can't have a null time!"
						return
					var/reason = input("Why are you muting [M.name] ? (This may be left blank.)","Reason") as text|null
					if( !(reason) || reason == "" || reason == null)
						reason = "Unknown."
					global.MutedList["[M.client]"] = (world.realtime)+(time*10)

					M << "You have been muted for [time] seconds for the following reason: \"[reason]\"."
					log_admin("[key_name(usr)] has muted [key_name(M)] for [time] seconds for the following reason: \"[reason]\".")
					alertAdmins("[key_name_admin(usr)] has muted [key_name_admin(M)] for [time] seconds for the following reason: \"[reason]\".", 1)
					for (var/client/C)
						if(C.listen_ooc && C != M) C << "<span class=\"announce\">[usr.key] muted [M.key] for [time] seconds for the following reason: \"[reason]\".</span>"
					//file("AdminLog.log")<<"[usr]([usr.key] muted [M] at [time2text(world.realtime,"Day DD hh:mm")] for [time] seconds for the following reason: \"[reason]\"\n"
					spawn() M.client.MutedCheck()
					M.client.muted = 1

				//M.client.muted = !M.client.muted
/*
	//Force a player to say something
	if (href_list["forcespeech"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator"  )))
			var/mob/M = locate(href_list["forcespeech"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return
				var/speech = input("What will [key_name(M)] say?.", "Force speech", "")
				speech = copytext(sanitize(speech), 1, MAX_MESSAGE_LEN)
				if(!speech)
					return
				M.Say(speech)
				log_admin("[key_name(usr)] forced [key_name(M)] to say: [speech]")
				alertAdmins("[key_name_admin(usr)] forced [key_name_admin(M)] to say: [speech]")
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return*/

	if (href_list["jumpto"])
		if((src.rank in list("Owner", , "SeniorAdministrator", "Administrator", "Moderator") ))
			var/mob/M = locate(href_list["jumpto"])
			usr.client.jumptomob(M)
			//file("AdminLog.log")<<"[usr]([usr.key] teleported to [M] [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You are not a high enough administrator or you aren't observing!")
			return

	if (href_list["summon"])
		if((src.rank in list("Owner", , "SeniorAdministrator", "Administrator", "Moderator")))
			var/mob/M = locate(href_list["summon"])
			usr.client.Getmob(M)
			//file("AdminLog.log")<<"[usr]([usr.key] summoned [M] [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You are not a high enough administrator or you aren't observing!")
			return

	if (href_list["prom_demot"])
		if((src.rank in list("Owner", , "SeniorAdministrator", "Administrator"  )))
			var/client/C = locate(href_list["prom_demot"])
			if(src != C && C.holder && (C.holder.level >= src.level))
				alert("This cannot be done as [C] is a [C.holder.rank]")
				return
			var/dat = "[C] is a [C.holder ? "[C.holder.rank]" : "non-admin"]<br><br>Change [C]'s rank?<br>"
			if(src.level == 5)
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Owner;client4ad=\ref[C]'>Owner</A><BR>
				<A href='?src=\ref[src];chgadlvl=SeniorAdministrator;client4ad=\ref[C]'>Senior Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 4)
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 3)
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 2)
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else
				alert("This can not be done.")
				return
			usr << browse(dat, "window=prom_demot;size=480x300")
	if (href_list["chgadlvl"])
	//change admin level
		var/rank = href_list["chgadlvl"]
		var/client/C = locate(href_list["client4ad"])
		if(src!=src||!src.rank)
			alert("You are not an admin")
			log_admin("[key_name(usr)] tried to Give or Remove [C]'s adminship")
			alertAdmins("[key_name_admin(usr)] tried to Give or Remove [C]'s adminship", 1)
			return
		if(rank == "Remove")
			C.clear_admin_verbs()
			C.update_admins(null)
			log_admin("[key_name(usr)] has removed [C]'s adminship")
			alertAdmins("[key_name_admin(usr)] has removed [C]'s adminship", 1)
			admins.Remove(C.ckey)
			save_admins()
		else
			C.clear_admin_verbs()
			C.update_admins(rank)
			log_admin("key_name(usr)] has made [C] a [rank]")
			alertAdmins("[key_name_admin(usr)] has made [C] a [rank]", 1)
			admins[C.ckey] = rank
			save_admins()

	//Boot
	if (href_list["boot2"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator"  )))
			var/mob/M = locate(href_list["boot2"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return
				var/reason = input("Why are you booting them?") as text
				if(!reason){usr << "You need a reason to boot someone.";return}
				log_admin("[key_name(usr)] booted [key_name(M)] with reason: \"[reason]\".")
				alertAdmins("[key_name_admin(usr)] booted [key_name_admin(M)] with reason: \"[reason]\".", 1)
				var/punter = M.client.key
				if(M.client){M<<"[usr.key] has booted you with reason: \"[reason]\".";del(M.client)}
				if(M)		{M<<"[usr.key] has booted you with reason: \"[reason]\".";del(M)}
				//file("AdminLog.log")<<"[usr]([usr.key] booted [M] [time2text(world.realtime,"Day DD hh:mm")]"

				for (var/client/C)
					if(C.listen_ooc) C << "<span class=\"announce\">SERVER: [usr.client.key] booted [punter] for the following reason: \"[reason]\".</span>"

	//Bans
	if (href_list["newban"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator","Moderator")))
			var/mob/M = locate(href_list["newban"])
			if(!ismob(M)) return
			if((M.client && M.client.holder && (M.client.holder.level >= src.level)))
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			switch(alert("Temporary Ban?",,"Yes","No"))
				if("Yes")
					var/mins = input(usr,"How long (in hours)?","Ban time",1) as num
					if(!mins)
						return
					if(mins >= 500) mins = 500
					var/reason = input(usr,"Reason?","reason","Griefer") as text
					if(!reason)
						return
					AddBan(M.ckey, M.computer_id, reason, usr.ckey, 1, mins*60)
					M << "\red<BIG><B>You have been banned by [usr.client.ckey].\nReason: [reason].</B></BIG>"
					M << "\red This is a temporary ban, it will be removed in [mins] hours."
					//M << "\red To try to resolve this matter head to http://dbzphoenix.proboards.com/index.cgi"
					log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] hours.")
					alertAdmins("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] hours.")
					//file("AdminLog.log")<<"[usr]([usr.key] has temporarily banned [M] for [reason] for [mins] minutes at [time2text(world.realtime,"Day DD hh:mm")]\n"
					usr.client.HttpPost(
						// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
						"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",

						list(content = "``` [usr.client.ckey] has banned [M.name]([M.ckey]). \n\n Reason: [reason] \n\n Duration: [mins] hours.```",username = "[usr.client.ckey]"))

					var/punter = M.client.key
					del(M.client)
					del(M)

					for (var/client/C)
						if(C.listen_ooc) C << "<span class=\"announce\">SERVER: [usr.client.key] banned [punter] for [mins] hours for the following reason: \"[reason]\".</span>"

				if("No")
					var/reason = input(usr,"Reason?","reason","Griefer") as text
					if(!reason)
						return
					AddBan(M.ckey, M.computer_id, reason, usr.ckey, 0, 0)
					M << "\red<BIG><B>You have been banned by [usr.client.ckey].\nReason: [reason].</B></BIG>"
					M << "\red This is a permanent ban."
					//M << "\red To try to resolve this matter head to http://dbzphoenix.proboards.com/index.cgi"
					log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
					alertAdmins("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
					//file("AdminLog.log")<<"[usr]([usr.key] has permanently banned [M] for [reason] at [time2text(world.realtime,"Day DD hh:mm")]\n"
					usr.client.HttpPost(
						// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
						"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",

						list(
							content = "``` [usr.client.ckey] has banned [M.name]([M.ckey]). \n\n Reason: [reason] \n\n Duration: Permanent. ```",
							username = "[usr.client.ckey]"
						)
					)
					//var/punter = M.client.key
					del(M.client)
					del(M)

	if(href_list["unbanf"])
		var/banfolder = href_list["unbanf"]
		Banlist.cd = "/base/[banfolder]"
		var/key = Banlist["key"]
		if(alert(usr, "Are you sure you want to unban [key]?", "Confirmation", "Yes", "No") == "Yes")
			if (RemoveBan(banfolder))
				unbanpanel()
			else
				alert(usr,"This ban has already been lifted / does not exist.","Error","Ok")
				unbanpanel()

	if(href_list["unbane"])
		UpdateTime()
		var/reason
		var/mins = 0
		var/banfolder = href_list["unbane"]
		Banlist.cd = "/base/[banfolder]"
		var/reason2 = Banlist["reason"]
		var/temp = Banlist["temp"]
		var/minutes = (Banlist["minutes"] - CMinutes)
		if(!minutes || minutes < 0) minutes = 0
		var/banned_key = Banlist["key"]
		Banlist.cd = "/base"

		switch(alert("Temporary Ban?",,"Yes","No"))
			if("Yes")
				temp = 1
				mins = input(usr,"How long (in minutes)? (Default: 1440)","Ban time",minutes ? minutes : 1440) as num
				if(!mins||mins==0||mins<0)
					return
				if(mins >= 525600) mins = 525599
				reason = input(usr,"Reason?","reason",reason2) as text
				if(!reason)
					return
			if("No")
				temp = 0
				reason = input(usr,"Reason?","reason",reason2) as text
				if(!reason)
					return

		log_admin("[key_name(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [GetExp(mins)]")
		alertAdmins("[key_name_admin(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [GetExp(mins)]", 1)
		Banlist.cd = "/base/[banfolder]"
		Banlist["reason"] << reason
		Banlist["temp"] << temp
		Banlist["minutes"] << (mins + CMinutes)
		Banlist["bannedby"] << usr.ckey
		Banlist.cd = "/base"
		unbanpanel()

	if(href_list["readmind"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator" )))
			var/mob/M = locate(href_list["readmind"])
			if(!M.mind)
				alert("[key_name(M)] has no mind! That is a problem!")
				return
			M.mind.show_memory(usr)
			log_admin("[key_name(usr)] read the player journal of [key_name(M)]")
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

	if(href_list["heal"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator" )))
			var/mob/M = locate(href_list["heal"])
			if(usr.Confirm("Heal Injuries?"))  for(var/BodyPart/P in M) if(P.Health<=P.MaxHealth) M.Injure_Heal(200,P,1)
			if(M.KOd) M.Un_KO()
			M.Health = M.MaxHealth
			M.Ki = M.MaxKi
			M.LastHitter = 0
			M.HitterListNew = list()
			M.FailToAnger=0
			M.HitterListOld = list()
			log_admin("[key_name(usr)] healed [key_name(M)]")
			alertAdmins("[key_name(usr)] healed [key_name(M)]")
			//file("AdminLog.log")<<"[usr]([usr.key] healed[M] at [time2text(world.realtime,"Day DD hh:mm")]\n"

		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

	if(href_list["revive"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator" )))
			var/mob/M = locate(href_list["revive"])
			if(M.Dead)
				M.Revive()
				log_admin("[key_name(usr)] revived [key_name(M)]")
				alertAdmins("[key_name(usr)] revived [key_name(M)]")
				//file("AdminLog.log")<<"[usr]([usr.key] revived [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
			else
				alert("[M.name] is not dead!")
				return
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

//observe
	if(href_list["observe"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator")))
			var/mob/M = locate(href_list["observe"])
			log_admin("[key_name(usr)] has observed [key_name(M)].")
			alertAdmins("[key_name(usr)] has observed [key_name(M)].", 1)
			usr.Get_Observe(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//subtlemessage
	if(href_list["subtlemessage"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["subtlemessage"])
			usr.client.cmd_admin_subtle_message(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//emoteaudit
	if(href_list["emoteaudit"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["emoteaudit"])
			usr.client.EmoteAudit(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return



	if(href_list["givemenu"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["givemenu"])
			usr.client.Give_Other(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//privatemessage
	if(href_list["privatemessage"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["privatemessage"])
			usr.client.cmd_admin_pm(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//giveobj
	if(href_list["giveobj"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["giveobj"])
			usr.client.Give_Object_Menu(M)
			//usr.client.Give(M)
			//file("AdminLog.log")<<"[usr]([usr.key] gave [M] to [usr] [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//assess
	if(href_list["assess"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["assess"])
			usr.client.mob.Get_Assess(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//kill
	if(href_list["kill"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["kill"])
			usr.client.Kill(M)
			//file("AdminLog.log")<<"[usr]([usr.key] admin killed [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//knockout
	if(href_list["knockout"])
		var/mob/M = locate(href_list["knockout"])
		usr.client.Knockout(M)
			//file("AdminLog.log")<<"[usr]([usr.key] admin KOed [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"

//send to spawn
	if(href_list["sendToSpawn"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["sendToSpawn"])
			usr.client.sendToSpawn(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//starter boost
	if(href_list["starterboost"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["starterboost"])
			M.GetStarterBoost()
			logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] the [M.Race] [M.Class] a starter boost.",2)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
/*
//Ranks tab
	if(href_list["rankstab"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["rankstab"])
			M.RanksTab()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
*/

//Server tab
	if(href_list["servertab"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["servertab"])
			M.ServerTab()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
/*
//Rewards tab
	if(href_list["rewardstab"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["rewardstab"])
			M.RewardsTab()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
*/
//redo stats
	if(href_list["statredo"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["statredo"])
			M.contents+=new/obj/Redo_Stats
			logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] the [M.Race] [M.Class] Redo Stats.",2)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//Cap Stats
	if(href_list["CapStats"])
		if(src.level >=2)
			var/mob/M = locate(href_list["CapStats"])
			M.CapStats()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//MakeEC
	if(href_list["MakeEC"])
		if(src.level >=2)
			var/mob/M = locate(href_list["MakeEC"])
			M.MakeEC()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//alter stats
	if(href_list["alterstats"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["alterstats"])
			usr.client.Reward(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

	if(href_list["XYZTele"])
		if(src.level >=1)
			var/mob/M = locate(href_list["XYZTele"])
			usr<<"This will send the mob you choose to a specific XYZ location."
			var/xx=input("X Location? Current is [M.x]") as num
			var/yy=input("Y Location? Current is [M.y]") as num
			var/zz=input("Z Location? Current is [M.z]") as num
			switch(input(usr, "Are you sure?") in list ("Yes", "No",))
				if("Yes")
					M.loc=locate(xx,yy,zz)
					logAndAlertAdmins("[key_name_admin(usr)] used XYZTeleport on [M] to ([M.x],[M.y],[M.z])",2)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//XYZ Playerfor(var/Admin_Help_Object/O in AdminHelps) if(O.UniqueID == "[inID]") AdminHelps.Remove(O)
	if(href_list["adminhelpresolve"])
		if(src.level >=1)
			var/UID = locate(href_list["adminhelpresolve"])
			for(var/Admin_Help_Object/O in AdminHelps) if(O.UniqueID == "[UID]") AdminHelps.Remove(O)
			usr.client.HttpPost(
				// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
				"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",

				/*
				[content] is required and can't be blank.
					It's the message posted by the webhook.

				[avatar_url] and [username] are optional.
					They're taken from your key.
					They override the webhook's name and avatar for the post.
				*/
				list(
					content = "``RESOLVED``",
					username = "[UID]"
				)
			)
//Player options
	if (href_list["adminplayeropts"])
		var/mob/M = locate(href_list["adminplayeropts"])
		if(!ismob(M))
			return
		var/dat = "<html><head><title>Options for [M.key]</title></head>"
		var/foo = "\[ "
		if(M.client)
			if(level>=3) foo += text("<A HREF='?src=\ref[src];prom_demot=\ref[M.client]'>Promote/Demote</A> | ")
			//foo += text("<A href='?src=\ref[src];mute2=\ref[M]'>Mute: [M.client.muted ? "Muted" : usr.client.sfIsMuted(M.client ? "Muted" : "Voiced"]</A> | ")
			foo += text("<A href='?src=\ref[src];mute2=\ref[M]'>Mute: [M.client.muted ? "Muted" : usr.sfIsMuted(M.client) ? "Muted" : "Voiced"]</A> | ")
			foo += text("<A href='?src=\ref[src];givemenu=\ref[M]'>Give Menu</A> | ")
			foo += text("<A href='?src=\ref[src];privatemessage=\ref[M]'>Private Message</A> | ")
			if (Players.Find(M))
				foo += text("<A HREF='?src=\ref[src];observe=\ref[M]'>Watch</A> | ")
				foo += text("<A HREF='?src=\ref[src];sendToSpawn=\ref[M]'>Send to Spawn</A> | ")
				foo += text("<A HREF='?src=\ref[src];assess=\ref[M]'>Assess</A> | ")
				foo += text("<A HREF='?src=\ref[src];giveobj=\ref[M]'>Give Obj</A> | ")
				foo += text("<A HREF='?src=\ref[src];kill=\ref[M]'>Kill</A> | ")
				foo += text("<A HREF='?src=\ref[src];knockout=\ref[M]'>Knockout</A> | ")
//				if(level>=2) foo += text("<A HREF='?src=\ref[src];CapStats=\ref[M]'>Cap Stats</A> | ")
				foo += text("<A HREF='?src=\ref[src];heal=\ref[M]'>Heal</A> | ")
				foo += text("<A HREF='?src=\ref[src];revive=\ref[M]'>Revive</A> | ")
				foo += text("<A HREF='?src=\ref[src];readmind=\ref[M]'>Player Journal</A> | ")
				foo += text("<A HREF='?src=\ref[src];getlog=[M.lastKnownKey];portion=0'>Check Logs</A> | ")
				foo += text("<A HREF='?src=\ref[src];emoteaudit=\ref[M]'>Mark Emote Audit</A> | ")
				foo += text("<A href='?src=\ref[src];subtlemessage=\ref[M]'>IC Message</A> | ")
				foo += text("<A href='?src=\ref[src];summon=\ref[M]'>Summon</A> | ")
				foo += text("<A href='?src=\ref[src];jumpto=\ref[M]'>Jump to</A> | ")
				foo += text("<A href='?src=\ref[src];XYZTele=\ref[M];'>XYZ Teleport</A> | ")
				if(level>=2) foo += text("<A href='?src=\ref[src];command=edit;target=\ref[M];type=view;'>Edit</A> | ")
				//foo += text("<A HREF='?src=\ref[src];starterboost=\ref[M]'>Starter Boost</A> | ")
				//foo += text("<A HREF='?src=\ref[src];statredo=\ref[M]'>Give Redo Stats</A> | ")
				//foo += text("<A HREF='?src=\ref[src];alterstats=\ref[M]'>Alter Stats</A> | ")
		foo += text("<A href='?src=\ref[src];boot2=\ref[M]'>Boot</A> | ")
		foo += text("<A href='?src=\ref[src];newban=\ref[M]'>Ban</A> \]")
		dat += text("<body>[foo]</body></html>")
		usr << browse(dat, "window=adminplayeropts;size=500x130")

//Kael works from here
//Give Build
	if(href_list["GiveBuild"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["GiveBuild"])
			usr.Give_Build(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Give Control Point
	if(href_list["ControlPoint"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["ControlPoint"])
			usr.Assign_Control_Point(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Give Power Mate
	if(href_list["PowerMate"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["PowerMate"])
			usr.Remove_Power_Mate(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Give Transformation
	if(href_list["Transformation"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["Transformation"])
			usr.client.Grant_Transformation(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Give Rank
//	if(href_list["Rank"])
//		if(src.level >= 1)
//			var/mob/M = locate(href_list["Rank"])
//			usr.client.Give_Rank(M)
//		else
//			alert("You cannot perform this action. You must be of a higher administrative rank!")
//			return
//Give Rare
	if(href_list["Rare"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["Rare"])
			usr.client.allow_rares(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Remove Combat Flag
	if(href_list["RemoveCombatFlag"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["RemoveCombatFlag"])
			usr.RemoveCombat(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Force Reincarnate
	if(href_list["ForceReincarnate"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["ForceReincarnate"])
			usr.Force_Reincarnate(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Give Anger
	if(href_list["GiveAnger"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["GiveAnger"])
			usr.Grant_Anger(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Warning
	if(href_list["Warning"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["Warning"])
			usr.Warn(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//UnSummon
	if(href_list["UnSummon"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["UnSummon"])
			usr.client.returnmob(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//RPMode
	if(href_list["RPMode"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["RPMode"])
			usr.RPMode(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Reset Stat Multipliers
	if(href_list["ResetStatMultipliers"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["ResetStatMultipliers"])
			usr.RemoveBuffs(M)
			usr.Reset_StatMultipliers(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//Reset WP
	if(href_list["WPRestore"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["WPRestore"])
			var/tmp/WPRestoration
			WPRestoration=input("To what WP you want him to set at") as num
			if(WPRestoration>M.MaxWillpower)
				WPRestoration=M.MaxWillpower
			M.Willpower=WPRestoration
			M.Health=WPRestoration
			log_admin("[key_name(usr)] used AdminHeal on [key_name(M)]")
			alertAdmins("[key_name(usr)] used AdminHeal on [key_name(M)]")
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//Give EXP
	if(href_list["GiveEXP"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["GiveEXP"])
			var/EXPGrant=0
			if(usr.Confirm("Grant EXP to [M]?"))
				EXPGrant			=input("How much EXP?") as num
				M.EXP				+=EXPGrant
				M.EXPCurrentCycle	+=EXPGrant
				M.EXPLifetime		+=EXPGrant
			logAndAlertAdmins("[src] has give [EXPGrant] EXP to [M].")
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return