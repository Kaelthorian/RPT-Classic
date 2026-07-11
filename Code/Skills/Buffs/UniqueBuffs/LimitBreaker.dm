Skill/Buff/LimitBreaker
	buffon="begins to exceed their limit!"
	buffoff="'s limitations return to normal."
	Regen=1.1
	Spd=1.1
	End=1.1
	Off=1.1
	Def=1.1
	BP=1.45

//	energydrain=0.5
	/*GetDescription(mob/Getter)
		return "This will give you [Regen]x Regen, [Spd]x Spd and [BP]x BP."
		..()*/
	icon='Flame Aura.dmi'
	pixel_x=-32
	pixel_y=-8
	layer=MOB_LAYER+3
	verb/Limit_Breaker()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr,null,0,0,0,0,0,0)
