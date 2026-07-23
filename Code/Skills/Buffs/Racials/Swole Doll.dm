Skill/Buff/SoulDoll
	RequiresApproval = 0
	BP=1.5
	Pow=1.3
	Str=1.3
	Off=1.2
	Spd=1.2
	Def=1.2

	buffon="begins to harness the power of a Soul Spirit Doll."
	buffoff="'s energy returns to normal."
	var/tmp/Clicks=0
	icon='Burst.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "You have awakened to the true power of the Doll. You have survived through hardship and have EARNED true power.([BP]x BP, [Pow]x Force, [Off]x Offense, [Def]x Defense)"
		..()*/
	verb/Soul()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0)

