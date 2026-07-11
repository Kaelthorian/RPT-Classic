Skill/Unarmed/T2/CatchTheBlade//adds stagger to attacks for next 20 seconds


	desc="Causes you to disarm your opponent for 16 seconds on their next attack against you. This will also cause a short stun on any attacker and cancel their attack. If you are wearing gauntlets, it also causes you to negate the attacks damage. (Only usable without a weapon.)"

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_2
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	verb/Catch_the_Swing()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		usr.CatchBladeActive=4
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr] prepares to catch their opponent's swing.")
		CD= CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki= EnergyCalculation(src,usr)
