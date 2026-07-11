Skill/Buff/Ascend
	RequiresApproval=0
	buffslot=0
	BP=1.3
	Spd=1.25
	Off=1.25
	Def=1.25
	TimedBuff=450

	buffon="ascends!"
	buffoff="returns to normal."
	icon='Ultra_Instinct.dmi'
	New()
		..()
		icon-=rgb(100,100,100)
	/*GetDescription()
		return "While using this your BP increases by [BP]x, Speed by [Spd]x and Offense by [Off]x for 45 seconds. 30 minute cooldown."
		..()*/
	verb/Ascend()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		if(!Using)
			if(usr.ssj==1)
				usr.overlays.Remove(usr.hair,usr.SSjHair,usr.USSjHair,usr.SSjFPHair,usr.SSj2Hair,usr.SSj3Hair,usr.SSj4Hair,usr.SSGFPHair,usr.SSGSSHair,usr.SSRHair,usr.SSGHair)
				usr.overlays+=usr.USSjHair
				buffon="transforms into an ascended Super Saiyan!"
			else if(usr.ssj==2)
				usr.overlays.Remove(usr.hair,usr.SSjHair,usr.USSjHair,usr.SSjFPHair,usr.SSj2Hair,usr.SSj3Hair,usr.SSj4Hair,usr.SSGFPHair,usr.SSGSSHair,usr.SSRHair,usr.SSGHair)
				usr.overlays+=usr.SSj3Hair
				usr.Super_Saiyan_3_Effects()
				buffon="goes even further beyond!"
			else if(usr.ssj==5) buffon="transforms into a form beyond Super Saiyan God Super Saiyan!"
			else if(usr.Oozaru)
				buffon="transforms into a Super Saiyan Oozaru!"
				if(usr.Class=="Legendary") usr.icon='oozaruhayatelssj.dmi'
				else usr.icon='oozaruhayatessj.dmi'
			else buffon="ascends!"
			CD=1200
			CDTick(usr)
			use(usr,'Electric_Blue.dmi')