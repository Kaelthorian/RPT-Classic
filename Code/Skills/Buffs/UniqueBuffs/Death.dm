Skill/Buff/Death
	//Death
	BP=1.6

	energydrain=0.5
	buffon="uses the Aura of Death."
	buffoff="stops using the Aura of Death."
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x. Also causes you to ignore limb damage."
		..()*/
	verb/Death()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/PaleAura,0,0,1)