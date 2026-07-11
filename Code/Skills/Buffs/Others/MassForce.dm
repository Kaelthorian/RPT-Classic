Skill/Buff/T1/MassForce
	buffon="begins focusing their energy into their survivability."
	buffoff="stops focusing their energy into their survivability."
	BP=1
	End=1.25
	desc="This buff will boost your End by 1.25."


	icon='Judgement_fitted.dmi'
	New()
		icon-=rgb(rand(1,100),rand(1,100),rand(1,100))
		..()
	/*GetDescription()
		return "Muscle Force: [BP]x BP [Str]x Str [Pow]x Force"
		..()*/
	verb/Mass_Force()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,0,0)
