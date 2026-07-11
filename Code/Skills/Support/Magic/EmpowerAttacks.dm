Skill/Spell

	Empowered_Attacks

//		EDT				= ED_TIER_2
		WEAPON			= NO
		LT				= HEAD
		UL				= HEAD

		desc="This will cause all team mates within 5 tiles to receive empowered attacks for 15 seconds. (70% chance to occur, Fire deals burn damage, Wind grants homing charges and chance for lightning bolt, Ice slows and chance for stagger movement)"
		/*icon='Flaming_Purple_fists.dmi'
		New()
			..()
			icon+=rgb(rand(0,75),rand(0,75),rand(0,75))*/
		verb/Empower_Attacks()
			set category="Skills"
			for(var/T in SkillBanned)
				if(src.name == T)
					usr.CombatOut("This skill is temporaly banned.")
					return
			if(usr.RPMode) return
			if(usr.KOd) return
			var/Cost = 2000000
			var/Actual = round(initial(Cost)/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets)))
			usr << "Base cost for this skill is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
			for(var/obj/Mana/M in usr)
				if(M.Value > Actual)
					M.Value-=Actual
					CD=BUFF_CD
					CDTick(usr)
					usr.Ki=EnergyCalculation(src,usr)
					for(var/mob/A in view(usr,5)) if(A.Team==usr.Team)
						A.Element=pick("Fire","Wind","Ice")
						A.ElementTicks=13
						A.overlays+=/Icon_Obj/Customization/Auras/Sparkles
						for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses Empowered Attacks on [A]")
						hearers(10,usr)<<sound('magic.ogg',volume=20)
				else
					usr << "You do not have [Commas(Actual)] mana to spare in order to use the Empowered Attacks."
					return