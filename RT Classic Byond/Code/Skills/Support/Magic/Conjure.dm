Skill/Spell/Summon_Demon
	desc="Perform a ritual of blood to summon a demon and help you."
	verb/Summon_Demon()
		set category="Other"
		var/Cost = 390000000																													//Skill price
		var/tmp/list/KaioOptions = new/list()																									//We make a list for kaios
		var/KaioAFK																																//check for kaios afk
		var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))														//Actual real price with the discounts
		KaioOptions.Add("Cancel")
		usr << "Base cost for this skill is [Commas(Cost)] Mana. Your magic skill means it costs [Commas(Actual)] Mana for you."				//We tell the user how much it will be
		for(var/mob/player/A)																													//For all the players
//			world<<"For all the Players"																										//Debug tool
			if(A.Race=="Demon" && A.z==11 && A.SummonedBy==null&& !A.Dead)																		//Who are a kaios , are in the AL and were not summoned yet
//				world<<"For all the kaios"																										//Debug tool
				if(A.afk==0)																													//If they are not AFK
					KaioOptions.Add("[A.name]")																									//Add them to the list of possible kaios to summon
//					world<<"KaioOptions:[KaioOptions]"																							//Debug tool
				if(A.afk==1)																													//If they are AFK
					KaioAFK++																													//+1 to the AFK kaio var
//					world<<"KaioAFK:[KaioAFK]"																									//Debug tool
		if(KaioAFK>0 && KaioOptions.len == 0)																									//If all the kaios are afk.
			usr<<"You try to summon a demon but all of them seems to be sleeping."																//Let the player know about it
			return																																//And we stop
		if(KaioOptions.len == 0)																												//If there are no kaios at all , not even afk
			usr<<"You try to summon a demon but it seems like no one hears you."																//Let the player know about it
			return																																//And we stop
		var/KaioPick=input("Choose who to summon") in KaioOptions																				//Pick who you want to summon
		for(var/mob/player/A)																													//For all the players in the game
			if(A.name==KaioPick)																												//If your name = the one the summoner picked
				var/x=input(A,"[usr.name] is trying to summon you , want to allow him to summon you?") in list("No","Yes")						//Want to be summoned?
				if(x!="Yes") 																													//Hell yeah I want , fuck AL
					usr<<"He refuse to get summoned by you."																					//Let him know what happened.
					return																														//Hell no , I love AL , said no one ever.
				if(A.isGrabbing)
					A<<"You can't grab someone while doing this"
					return
				for(var/obj/Mana/M in usr)																										//Time to pay
					if(M.Value > Actual)																										//You have enough money for it ?
						if(usr.Confirm("Attempt to summon a Demon for [Actual] resources?"))													//Good , you do , want to pay ?
//							world<<"Payday"																										//Debug Tool
							M.Value -= Actual																									//Paying...
							view(src)<<"[usr] begins to summon a demon!"																		//PRAY PRAY PRAY PRAY PRAY
							usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] summoned a Demon")									//Logs
							A.loc=usr.loc																										//We move the kaio to the summoner
							A.SummonedBy=usr.ckey																								//We mark the kaio like a cow with the summoner name.
				usr<<"You lack the money to summon."

//Totally not a copy paste from pray