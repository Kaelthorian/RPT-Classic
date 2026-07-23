Skill/Unarmed/T4/CriticalEdge//adds stagger to attacks for next 20 seconds

	UB1="Bushido"
	UB2="Bestial Wrath"

	desc="Causes all of your melee attacks that land for the next 20 seconds to have a 50% chance to be a critical strike for 133% damage."


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Critical_Edge()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		usr.CriticalEdge=14
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s stance adapts as they aim to land a critical blow.")
		CD= DEBUFF_CD
		CDTick(usr)
		usr.Ki= EnergyCalculation(src,usr)