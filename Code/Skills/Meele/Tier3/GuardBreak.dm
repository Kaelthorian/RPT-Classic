Skill/Unarmed/T3/Guard_Break//adds stagger to attacks for next 20 seconds

	UB1="War"
	UB2="Fists of Fury"

	desc="Causes all of your melee attacks that land for the next 20 seconds to reduce the opponent's endurance and defense by 10% for 5 seconds."

//	DMGT			= DMG_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Guard_Break()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		usr.GuardBreaking=14
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s stance adapts as they try to disrupt their opponent's guard.")
		CD= DEBUFF_CD
		CDTick(usr)
		usr.Ki= EnergyCalculation(src,usr)