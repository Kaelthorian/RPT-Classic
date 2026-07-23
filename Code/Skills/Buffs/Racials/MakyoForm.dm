Skill/Buff/MakyoForm
	RequiresApproval = 0
	buffon="transforms into a giant."
	buffoff="reverts from their transformation."
	BP=1.5
	End=1.3
	Off=1.2

	icon='Judgement_fitted.dmi'
	New()
		icon-=rgb(rand(1,100),rand(1,100),rand(1,100))
		..()
	/*GetDescription()
		return "Makyo Transformation: [BP]x BP [End]x End [Off]x Off"
		..()*/
	verb/Makyo_Transform()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)
