mob/var/ExtraOvers
Skill/Buff/Adaptive

	EDT				= ED_TIER_4
	KBT				= KB_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	RequiresApproval=0
	buffslot=0
	Def=1.25
	End=1.25
	Regen=1.25

	TimedBuff=300
	buffon="shifts their stance as they adapt to the situation."
	buffoff="stops adapting to the situation."
	/*GetDescription()
		return "This technique will draw upon your natural adaptability. You will enter a defensive posture and improvise to gain the upper hand. ([End]x Endurance, [Def]x Defense and [Regen]x Regen for 30 seconds. Cost to activate, but no drain. 240 second cooldown.)"
		..()*/
	verb/Adaptive()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		if(!Using)
			CD=BUFF_CD
			CDTick(usr)
			usr.Ki=(usr.Ki-EDT)
			use(usr)






