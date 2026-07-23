mob/Admin1/verb

	Manual_Ban()
		set category="Admin"
		if(!usr.client.holder) return
		if(!usr.Confirm("Manual ban?")) return
		src << "To manual ban a player at least ONE of the pop ups need to be filled in."
		var/keyname = ckey(input(src, "What is the name of their BYOND key?","Keyname?","") as text)
		var/pc_id = input(src,"What is their IP or computer_id?","IP/PC_ID","") as text
		if(!keyname&&!pc_id){ src<<"Need atleast a key OR an IP OR a computer_id!"; return }
		switch(alert("Temporary Ban?",,"Yes","No"))
			if("Yes")
				var/mins = input(src,"How long (in minutes)?","Ban time",1440) as num
				if(!mins||mins==0||mins<0)
					return
				if(mins >= 525600) mins = 525599
				var/reason = input(usr,"Reason?","reason","Griefer") as text
				if(!reason)
					return
				AddBan(keyname, pc_id, reason, src.ckey, 1, mins)
				logAndAlertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis will be removed in [mins] minutes.",1)
				//alertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis will be removed in [mins] minutes.")
				//file("AdminLog.log")<<"[src]([src.key]) has temporarily manual banned [keyname] for [reason] for [mins] minutes at [time2text(world.realtime,"Day DD hh:mm")]\n"
			if("No")
				var/reason = input(usr,"Reason?","reason","Griefer") as text
				if(!reason)
					return
				AddBan(keyname, pc_id, reason, src.ckey, 0, 0)
				logAndAlertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis is a permanent ban.",1)
			//	alertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis is a permanent ban.")
				//file("AdminLog.log")<<"[src]([src.key]) has permanently manual banned [keyname] for [reason] at [time2text(world.realtime,"Day DD hh:mm")]\n"