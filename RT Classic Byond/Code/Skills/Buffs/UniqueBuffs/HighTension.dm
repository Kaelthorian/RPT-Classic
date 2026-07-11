Skill/Buff/High_Tension
	BP=1.4
	Str=1.3
	End=1.3

	energydrain=0.5
	buffon="puts their body under considerable tension and powers up."
	buffoff="releases the tension in their body."
	var/tmp/Clicks=0
	layer=MOB_LAYER+1
//	pixel_x = -32
//	pixel_y = -32
	//icon = 'Pink Cloak.dmi'
	icon='Judgement_fitted.dmi'
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Strength by [Str]x and Endurance by [End]x."
		..()*/
	verb/High_Tension()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/PinkCloak)
