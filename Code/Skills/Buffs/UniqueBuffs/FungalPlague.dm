Skill/Buff/FungalPlague
	//Famine
	BP=1.45
	Regen=1.3
	Recov=1.3
	energydrain=0.5

	buffon="erupts with fungal growths, the spores clouding the air."
	buffoff="loses  their fungal growths."
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	//icon='Pest.dmi'
	//pixel_x=-32
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Speed by [Spd]x, Regeneration by [Regen]x, and Recovery by [Recov]x. Also causes you to ignore limb damage."
		..()*/
	verb/Famine()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/DarkAura)
