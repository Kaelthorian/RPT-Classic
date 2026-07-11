Skill/Buff/Kaioken
	buffon="emits a bright red aura."
	buffoff="stops using Kaioken."
	BP=2
	healthdrain=1
	layer=MOB_LAYER+1
	icon = 'Kaioken New.dmi'
	/*GetDescription()
		return "Kaioken is a skill you can master up to 20x. Each level grants you 1.05x BP up to 2x BP from level 20 at the cost of draining health. More mastery will decrease the HP drain."
		..()*/
	verb/Kaioken()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr)


atom/proc/Body_Parts()
	var/Amount=6
	var/list/Turfs=new
	for(var/turf/A in view(src)) if(!A.density) Turfs+=A
	while(Amount&&Turfs)
		if(locate(/turf) in Turfs)
			var/obj/Body_Part/A=new
			A.name="[src] chunk"
			A.loc=pick(Turfs)
			Amount-=1
			break
		else return

obj/Body_Part
	icon='Body Parts.dmi'
	Savable=0
	New()
		spawn(rand(2000,4000)) del(src)
		pixel_y+=rand(-16,16)
		pixel_x+=rand(-16,16)
		dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)