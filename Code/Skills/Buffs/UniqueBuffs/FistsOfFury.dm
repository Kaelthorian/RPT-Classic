Skill/Buff/FistsOfFury
	buffon="begins using Fists of Fury."
	buffoff="stops using Fists of Fury."
	BP=1.4
	Off=1.3
	Def=1.3
	energydrain=0.5
//		Spd=1.25
	icon='GaoGaoFists.dmi'
	layer=MOB_LAYER+1

	/*GetDescription()
		return "Using this unlocks your normally latent inner combat proticals.  You cease being anything but a killing machine until your energy depletes or your primary drive re-engages. ([BP]x BP, [Off]x Offense, and [Def]x Defense)"
		..()*/
	verb/Fists_Of_Fury()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,0,0)
