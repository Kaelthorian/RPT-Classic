proc/DebugLogs(var/DebugText,var/Type)
	for(var/mob/player/S)
		if(S.ckey=="kael224"|| S.ckey=="ohsnapabear"|| S.ckey=="theskyla"|| S.ckey=="Mumit")
			if(Type == "Combat")
				S.DebugLogs("DEBUG LOG: [DebugText]")
			if(Type == "Saves")
				S.DebugLogsSaves("DEBUG LOG: [DebugText]")
			if(Type == "Training")
				S.DebugLogsTraining("DEBUG LOG: [DebugText]")

mob/Admin1/verb
	Debug_Window_Combat()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

		winshow(usr,"DebugLog",1)
	Debug_Window_Saves()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		winshow(usr,"DebugLogsSaves",1)
	Debug_Window_Training()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		winshow(usr,"DebugLogsTraining",1)
	Read_Save_File()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/Target= input("What serial number you are looking for?") as text
		for(var/obj/Look)
			if(Target == Look.Serial)
				usr<<"----------------------------"
				usr<<"Item Name		= [Look]"
				usr<<"Item Type		= [Look.type]"
				usr<<"Serial		= [Look.Serial]"
				usr<<"Builder		= [Look.Builder]"
				usr<<"Item Coords	= [Look.x],[Look.y],[Look.z]"
				usr<<"----------------------------"

