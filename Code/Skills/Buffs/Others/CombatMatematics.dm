Skill/Buff/Combat_Mathematics

	EDT				= ED_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	RequiresApproval=0
	buffslot=0
	Off=1.2
	Str=1.2
	Pow=1.2
	TimedBuff=300

	buffon="shifts their stance as they seem to be calculating their next moves."
	buffoff="stops calculating their next moves."
	/*GetDescription()
		return "This technique will draw upon your natural intellect and calculate the precise movements to make in order to land a critical blow. ([Off]x Offense and [Str]x Strength for 30 seconds. Cost to activate, but no drain. 240 second cooldown.)"
		..()*/
	verb/Combat_Mathematics()
		set category="Skills"

		if(SkillSafeCheckBuff(usr,src))

			return

		if(!Using)
			CD=BUFF_CD
			CDTick(usr)
			usr.Ki=EnergyCalculation(src,usr)
			use(usr)