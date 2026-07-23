Skill/Buff/Focus
	BP=1
	Spd=1.3
//	Regen=1.15

	buffon="begins focusing their energy."
	buffoff="stops focusing."

	icon='blue elec.dmi'
	/*GetDescription()
		return "Using this ability drains a constant amount of energy, the drain will be less depending on \
	your max energy and recovery. While using this your BP increases by [BP]x, Speed by [Spd]x and Regeneration by [Regen]x for as long as your energy holds out or you stop using the form."
		..()*/
	verb/Focus()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,0,0)
