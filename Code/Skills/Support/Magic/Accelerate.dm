Skill/Spell
	Accelerate

//		EDT				= ED_TIER_2
//		KBT				= KB_TIER_4
//		DMGSOURCE_STR	= DMGS_TIER_3
		WEAPON			= NO
		LT				= HEAD
		UL				= HEAD

		desc="Grants someone the speed buff, which negates slows and increases hit chance and movement speed."
		verb/Accelerate()
			set category = "Skills"
			if(usr.RPMode) return
			if(usr.Magic_Level >= 5)
				var/Cost = 1000000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.Ki=(usr.Ki-EDT)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
							Acceleration(A,usr.Magic_Potential*5,10*usr.Magic_Potential)
							CD=BUFF_CD
							CDTick(usr)
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to accelerate [A]")
							//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] spell healed [key_name(A)]")
							usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] accelerated [key_name(A)].\n")
							A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was accelerated by [key_name(usr)].\n")
							hearers(10,usr)<<sound('magic.ogg',volume=20)
							break
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Accelerate spell."
						return