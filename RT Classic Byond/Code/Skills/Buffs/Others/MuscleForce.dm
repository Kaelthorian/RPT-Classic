Skill/Buff/T1/MuscleForce
	buffon="begins focusing their energy into their muscles."
	buffoff="stops focusing their energy into their muscles."
	BP=1
	Str=1.25
	desc="This buff will boost your Str by 1.25."

//	Pow=0.8


	icon='Judgement_fitted.dmi'
	New()
		icon-=rgb(rand(1,100),rand(1,100),rand(1,100))
		..()
	/*GetDescription()
		return "Muscle Force: [BP]x BP [Str]x Str [Pow]x Force"
		..()*/
	verb/Muscle_Force()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,0,0)
