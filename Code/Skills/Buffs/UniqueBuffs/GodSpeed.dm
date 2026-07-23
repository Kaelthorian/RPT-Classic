Skill/Buff/Godspeed
	BP=1.4
	Spd=1.3
	Def=1.3
	energydrain=0.5
	buffon="begins using their God-like speed."
	buffoff="refrains from using their God-like speed."

	var/tmp/Clicks=0
	icon='SSj3ElectricTobiUchiha.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, increases Speed by [Spd]x, Offense by [Off]x, and Defense by [Def]x."
		..()*/
	verb/Godspeed()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/PurpleCloak)