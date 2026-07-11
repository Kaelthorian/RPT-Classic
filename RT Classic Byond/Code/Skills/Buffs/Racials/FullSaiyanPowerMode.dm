Skill/Buff/Full_Saiyan_Power_Mode
	RequiresApproval=0
	BP=1.55
	End=1.0
	Str=1.0
	Pow=1.0
	Off=1.0
	Def=1.0
	buffon="begins to harness the power of a true saiyan."
	buffoff="stops harnessing the power of a true saiyan."

	icon='SNj Elec.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Full_Saiyan_Power_Mode()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)