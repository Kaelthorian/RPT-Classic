Skill/Spell
	Lightning_Bolt

//		DMGT			= DMG_TIER_2
//		CDT				= CD_TIER_2
//		EDT				= ED_TIER_2
//		KBT				= KB_TIER_4
		DMGSOURCE_STR	= DMGS_TIER_3
		WEAPON			= NO
		LT				= HEAD
		UL				= HEAD

		desc="This is a bolt of lightning."
		//var/Active=0
		var/tmp/CostOnUse=0
		var/Power=0
		verb/Lightning_Bolt()
			set category = "Skills"
			if(usr.RPMode) return
			if(SkillSafeCheckUnarmed(usr,src))
				//TESTINGREPLACE
				return
			if(CostOnUse)
				usr << "You are no longer casting this spell."
				CostOnUse=0
				Power=0
				return
			if(usr.Magic_Level >= 25)
				//var/Y = (Year/10) + 1
				var/Cost = 5000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				var/PowerC = usr.BP*usr.Magic_Potential*rand(1,3)
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				CostOnUse = Actual
				Power = PowerC
				CD=CDCalculation(src,usr)
				CDTick(usr)
				for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=teal>[usr] begins to conjure a spell.")
				return