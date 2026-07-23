Skill/Unarmed/T1/Block


	desc="Reduces your Speed and Defense by 20% for 5 seconds in exchange for +40% Endurance. This will also increase chance to deflect projectiles by 30% and give 30% flat damage reduction for the duration."

//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_1
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	verb/Block()
		set category="Skills"
		if(usr.RPMode) return
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		usr.Blocking=3
		if(usr.SwordOn||usr.HammerOn||usr.KiBlade) for(var/mob/player/P in view(usr)) P.BuffOut("[usr] raises their weapon to block an attack.")
		else  for(var/mob/player/P in view(usr)) P.BuffOut("[usr] raises their hands to block an attack.")
		usr.Ki=(usr.Ki-EDT)
		CD=(1+Modifier(usr))/CDT
		CDTick(usr)
