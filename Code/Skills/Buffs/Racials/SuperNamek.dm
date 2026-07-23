
//Tier2Drain

Skill/Buff/Super_Namekian
	RequiresApproval=0
	BP=1.5
	Spd=1.25
	Off=1.4
	Def=1.4
	buffon="begins to harness the power of a Super Namekian."
	buffoff="stops harnessing the power of a Super Namekian."

	icon='SNj Elec.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Super_Namekian()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)













