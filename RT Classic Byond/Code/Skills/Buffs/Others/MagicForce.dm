
Skill/Buff/T1/MagicForce
	buffon="begins using Magic Force."
	buffoff="stops using Magic Force."
	BP=1
	Pow=1.25
//	Str=0.8
	desc="This buff will boost your Force by 1.25."

	icon='blackflameaura.dmi'
	layer=MOB_LAYER+1


	/*GetDescription(mob/Getter)
		return "Using this ability drains a constant amount of energy. While using this your BP increase by [BP]x, Force will increase by [Pow]x, but decrease your Strength by [Str]x."
		..()*/
	New()
		src.icon+=rgb(rand(1,225),rand(1,225),rand(1,225))
		..()
	verb/Magic_Force()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,0,0)
