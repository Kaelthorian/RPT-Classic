Skill/Misc/AimForTheHeart//adds stagger to attacks for next 20 seconds

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD



	desc="Causes all of your attacks for the next 8 seconds to deal 10% damage, but it is dealt as pure WP damage instead of HP."
	verb/Aim_For_The_Heart()
		set category="Skills"
		if(usr.RPMode) return
		usr.HeartAiming=5
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s stance adapts as they aim for the heart.")
		CD=(1+Modifier(usr))/CDT
		CDTick(usr)