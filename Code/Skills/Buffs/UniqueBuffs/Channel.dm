Skill/Buff/Channel
	BP=1.5
	Pow=1.25
	Spd=1.2

	energydrain=0.5
	buffon="begins channeling ki in their body."
	buffoff="stops channeling ki in their body."
	var/tmp/Clicks=0
	icon='ChannelIcon.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Force by [Pow]x and Speed by [Spd]x."
		..()*/
	verb/Channel()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/BlueCloak)