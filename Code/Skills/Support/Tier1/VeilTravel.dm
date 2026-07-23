Skill/Support/Veil_Travel
	desc="This is your natural power of traveling back to the afterlife and/or your summoner."
	var/LastUsed
	verb/Veil_Travel()
		set category="Other"
//		world<<"CD:[LastUsed]"																			//Debug tool
		if(usr.isGrabbing==1)																			//If you are grabbing
			usr<<"You can't teleport while grabbing someone"											//no cheating
			return																						//Full stop
		if(locate(/obj/items/Artifact) in usr)															//If they have an artifact
			usr<<"The energy from the artifact is not letting you traveling."							//msg
			return																						//stop
		if(locate(/obj/items/Magic_Ball) in usr)														//If they have a DB
			usr<<"The energy from the dragonball is not letting you traveling"							//msg
			return																						//Stop
		if(usr.Dispelled>=(Year+(Month*0.01)))
			usr<<"Your soul is still recovering from the dispel."
		if(LastUsed>=(Year+(Month*0.01)))																//CD check
			usr<<"You lack the energy to travel , wait until year [LastUsed]"							//info for user
//			world<<"CD:[LastUsed]"																		//Debug tool
			return																						//full stop
		if(!usr.Confirm("Are you sure you want to teleport?")) return
		if(usr.z!=11)																					//if you are not in the AL , aka z 11
			usr.x=250																					//tp
			usr.y=250																					//tp
			usr.z=11																					//tp
			usr<<"Your return back home once more."														//info for player
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Used Veil Travel and went to the afterlife\n")
			LastUsed=Year+(Month*0.01)+1																//CD set up
//			world<<"CDz:[LastUsed]"																		//Debug tool
			return																						//full stop
		for(var/mob/player/A)																			//for all the players in the world
			if(A.ckey==usr.SummonedBy)																	//If the player have the same ckey as my summoner
				usr.loc=A.loc																			//TP to summoner
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Used Veil Travel and went to the summoner\n")
				LastUsed=(Year+(Month*0.01))+1															//CD set up
//				world<<"CDs:[LastUsed]"																	//Debug tool
				return																					//full stop
		usr<<"Your summoner energy signature is too weak for you to sense it or you have no summoner."	//info for user
//		world<<"CD:[LastUsed]"																			//Debug tool