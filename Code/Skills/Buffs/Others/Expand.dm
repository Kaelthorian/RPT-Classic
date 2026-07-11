

mob/var
	HasExpand5=0

Skill/Buff/Expand
	buffon="'s muscles suddenly expand"
	buffoff="stops enhancing their muscles."
	Str=1.15
	End=1.25
	Spd=0.8
	Off=0.9
	Def=0.85

	buffslot=0

	var/Icon
	/*GetDescription(mob/Getter)
		return "Expand gives [Str]x Strength, [End]x Endurance, [Spd]x Speed, [Off]x Offense and [Def]x Defense."
		..()*/
	verb/Expand()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		if(usr.HasExpand5)End=1.35
		if(!Using)
			if(!MakyoStar)BP=1
			if(usr.Race=="Makyojin"&&MakyoStar)BP=1.1
		use(usr,null,0,0,0,0,0,0,0,0,0)




