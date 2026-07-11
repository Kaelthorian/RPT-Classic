Skill/Buff/Angelic_Grace
	RequiresApproval = 0
	BP=1.5
	Recov=1.25

	buffon="begins emitting a radiant energy."
	buffoff="stops releasing radiant energy."
	var/tmp/Clicks=0
	icon='Halo Custom.dmi'
	layer=MOB_LAYER+1
	New()
		icon+=rgb(50,50,50)
		..()
	GetDescription()
		return "Using this ability will increase your BP by [BP]x, Speed by [Spd]x, and Recovery by [Recov]x."
		..()
	verb/Angelic_Grace()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr)

