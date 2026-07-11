Skill/Spell
	Rejuvenate
		desc="Heals someone and removes 25 minutes of their Lethal Combat Tracker."
		verb/Rejuvenate()
			set category = "Skills"
			if(usr.RPMode) return
			if(usr.Magic_Level >= 5)
				var/Cost = 400000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.DrainKi("Rejuvenate", 0, 150)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
							if(A.Willpower<=0) A.WillpowerRestore()
							if(A.Willpower<A.MaxWillpower&&A.Willpower>0) A.Willpower++
							if(A.KOd) A.Un_KO()
							A.Health += 25
							A.LethalCombatTracker-=1000
							if(A.LethalCombatTracker<0)A.LethalCombatTracker=0
							if(A.Health>A.Willpower) A.Health=A.Willpower
							for(var/BodyPart/P in A)
								if(usr.Magic_Level>170)  if(P.Health<=P.MaxHealth) A.Injure_Heal(25,P,1)
								else  if(P.Health<=P.MaxHealth) A.Injure_Heal(20,P)
//							A.Heal_Zenkai()
							M.Value -= Actual
							CD=usr.Refire*4
							CDTick(usr)
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to heal [A]")
							//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] spell healed [key_name(A)]")
							usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] spell healed [key_name(A)].\n")
							A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was spell healed by [key_name(usr)].\n")
							hearers(10,usr)<<sound('magic.ogg',volume=20)
							break
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Heal spell."
						return