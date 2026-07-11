Skill/Support/Give_Power

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	var/LastUse = 0

	UB1="Machine Force"
	UB2="Channel"

	desc="You can transfer your health and energy to someone right beside you by clicking them. It will \
	knock your character out. The person can exceed 100% power if you have enough health and energy \
	to give to them. The effect is only temporary, because health and energy do not stay above 100% \
	for long.(Max bp someone can get from this is 30%)"
	verb/Give_Power()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.KOd) return
		if(usr.Lethality!=1)
			usr << "You must be set for Lethal Combat to do this!"
			return
		if(usr.Willpower<35)
			usr << "You do not have the Willpower to do this!"
			return
		if(Year<LastUse+0.1)
			usr<<"You cannot use this until year [LastUse+0.1] after you last used it"
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			if(A.GotPower==1) return
			LastUse=Year
			usr.Willpower-=30
			A.HealDamage("Give Power ([usr])", round(usr.Health*0.35,0.5))
			A.Ki+=usr.Ki*1.3
			A.GotPower=1
		//	usr.KO("giving power to [A]")
			usr.Health*=0.75
			usr.Ki*=0.01
			A.Power_Giving_Reset()
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gives [key_name(A)] their power")
