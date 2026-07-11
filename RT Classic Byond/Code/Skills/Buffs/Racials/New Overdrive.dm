Skill/Buff/Overdrive
	RequiresApproval = 0
	buffon="begins using Overdrive."
	buffoff="stops using Overdrive."
	Str=1.35
	Pow=1.35
	BP=1.5
	var/tmp/Clicks=0
	pixel_x = -22
//	pixel_y = -32
	icon = 'BuuAura.dmi'
	layer=MOB_LAYER+1

	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Str by [Str]x and Force by [Pow]x"
		..()*/
	verb/Overdrive()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)


