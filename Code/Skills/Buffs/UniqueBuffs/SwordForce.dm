Skill/Buff/Bushido
	BP=1.4
	Spd=1.2
	Str=1.2
	Off=1.25
//	energydrain=0.5

	buffon="begins to harness the power of a true swordsman."
	buffoff="stops using Bushido."
	var/tmp/Clicks=0
	icon='SatsuiAura2.dmi'
	layer=MOB_LAYER+1

	/*GetDescription(mob/Getter)
		return "While using this your Strength is multiplied by [Str]x, your BP by [BP]x, Speed by [Spd]x and Offense by [Off]x."
		..()*/
	New()
		src.icon+=rgb(rand(1,115),rand(1,115),rand(1,115))
		..()
	verb/Bushido()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,1)

