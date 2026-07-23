
mob/var/HasThornsOn=0

Skill/Buff/BestialWrath
	BP=1.45
	End=1
	Off=1
	Regen=1.3

	buffon="unleashes their Bestial Wrath."
	buffoff="tames their Wrath."
	energydrain=0.5
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	icon='Rising Rocks.dmi'
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x. Also causes your damager to take 35% of the damage they cause you but no more than 5 per tick and no less than 0.05 per tick."
		..()*/
	verb/Bestial_Wrath()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,/Icon_Obj/Cloak/LSSJCloak,0,0,0,1)


