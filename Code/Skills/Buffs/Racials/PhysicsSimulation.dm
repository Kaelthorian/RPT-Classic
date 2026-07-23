Skill/Buff/PhysicsSimulation

	DMGT			= DMG_TIER_4
	CDT				= CD_TIER_4
	EDT				= ED_TIER_4
	KBT				= KB_TIER_4
	DMGSOURCE_STR	= ((DMGS_TIER_4*57.7)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_4*42.3)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	RequiresApproval=0
	BP=1.5
	Spd=1.25
	Off=1.25
	Def=1.25
	buffon="begins to process the battlefield and all of its potential outcomes in their powerful mind."
	buffoff="stops processing the battlefield."

	/*GetDescription()
		return "This technique is a display of the truly awesome power of the Tuffle mind. This technique is the natural evoltion of combat mathematics, as your are using your intellect to power your combat. While using this technique, your brain is working like a complex computer, calculating all possible outcomes of any given combat like a sandbox physics simulator.( [BP]x BP Mult, [Spd]x Spd, [Off]x Offense, and [Def]x Defense)"
		..()*/
	verb/Physics_Simulation()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		usr.FirstTransWPRestore(usr)
		use(usr,/Icon_Obj/Cloak/PowerCloak,0,0,0,0,0,0)