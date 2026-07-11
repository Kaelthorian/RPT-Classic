Skill/Spell
	Frost_Nova

//		DMGT			= DMG_TIER_2
//		CDT				= CD_TIER_2
//		EDT				= ED_TIER_2
//		KBT				= KB_TIER_4
		DMGSOURCE_STR	= DMGS_TIER_3
		WEAPON			= NO
		LT				= HEAD
		UL				= HEAD

		desc="This will emit a freezing aura around you that slows all enemies and damages them."
		verb/Frost_Nova()
			set category = "Skills"
			if(usr.RPMode) return
			if(usr.Magic_Level >= 55)
				var/Cost = 8000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.Ki=(usr.Ki-EDT)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						for(var/turf/T in orange(usr,2))
							T.overlays+='Ice Icon.dmi'
							spawn(30) T.overlays-='Ice Icon.dmi'
						for(var/mob/A in orange(usr,2))
							if(A!=usr) if(!A.afk)
								var/DamageDealt=(usr.BP*(1+(usr.Magic_Potential*2))/A.BP)
								M.TakeDamage(usr, DamageDealt, "Frost Nova")
								if(A.Health<=0) A.KO(usr)
							//Freeze effects
								Slow(A,5,20)//Stagger(A,5)
							M.Value -= Actual
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to cast Frost Nova")
						CD=CDCalculation(src,usr)
						CDTick(usr)
						hearers(10,usr)<<sound('magic.ogg',volume=20)
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Frost Nova spell."
						return