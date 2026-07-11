Skill/Buff/War
	//War
	BP=1.4
	Str=1.2
	Pow=1.2
	End=1.1
	Off=1.2
	Def=1.1

	energydrain=0.5
	buffon="uses the Aura of War."
	buffoff="stops using the Aura of War."
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	icon='War.dmi'
	pixel_x=-32
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Strength by [Str]x, Force by [Pow]x, and Offense by [Off]x. Also causes you to ignore limb damage."
		..()*/
	verb/War()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
//		use(usr,/Icon_Obj/Cloak/RedAura,0,0,1)
		use(usr,null,0,0,0,0,0,1)