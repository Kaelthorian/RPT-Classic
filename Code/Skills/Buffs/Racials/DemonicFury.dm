Skill/Buff/Demonic_Fury
	RequiresApproval = 0
	BP=1.5
	Anger=1.2
	buffon="allows their rage to boil over!"
	buffoff="calms their fury."

	icon='Halo Custom 2.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Speed by [Spd]x and Anger by [Anger]x."
		..()*/
	verb/Demonic_Fury()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr)