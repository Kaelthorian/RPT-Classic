Skill/Buff/Super_Maximum_Light_Speed_Mode
	RequiresApproval = 0
	BP=1.5
	Spd=1.5

	buffon="activates Super Maximum Light Speed Mode!"
	buffoff="reverts from their Super Maximum Light Speed Mode."
	icon = 'Purple Cloak.dmi'
	pixel_x=-32
	pixel_y=-32
/*	New()
		icon-=rgb(rand(1,100),rand(1,100),rand(1,100))
		..()*/
	/*GetDescription()
		return "Super Maximum Light Speed Mode: [BP]x BP [Spd]x Spd"
		..()*/
	verb/Fasty_Zoom_Zoom()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,0)
