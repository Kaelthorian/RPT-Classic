
Skill/Buff/Shadow_King
	BP=1.4
	End=1.25
	Anger=1.25
	Regen=1.25
	buffslot=1
	energydrain=0.5
	buffon="taps into other-worldly power!"
	buffoff="stops tapping into other-worldly power."
	/*GetDescription()
		return "Shadow King counts as 2 Buff Slots. It grants [BP]x BP, [End]x Endurance, [Anger]x Anger and [Regen]x Regeneration."
		..()*/
	//var/LastUse=0
	verb/Shadow_King()
		set category="Skills"
		use(usr)
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		usr.Shadow_Overlays(Using)



mob/proc/Shadow_Overlays(add=0)
	var/image/A=image(icon='Okage.dmi',icon_state="1",layer=MOB_LAYER+2,pixel_y=32)
	var/image/B=image(icon='Okage.dmi',icon_state="2")
	underlays.Remove('Okage.dmi',A)
	overlays-=B
	if(add)
		underlays.Add('Okage.dmi',A)
		overlays+=B







mob/var/DisableRegen=0

Skill/Buff/ArcanePower

	BP=1.4
	Str=1.1
	Pow=1.1
	End=1.1
	Off=1.1
	Def=1.1
	Spd=1.1
	Recov=1.1
	buffslot=1
	energydrain=0.5
	icon='Arcane Power (1).dmi'
	buffon="displays tremendous magical power!"
	buffoff="stops their display of arcane power."
	New()
		..()
		icon=pick('Arcane Power (1).dmi','Arcane Power (2).dmi')
	/*GetDescription()
		return "Will of the Dead counts as 2 Buff Slots. It grants [BP]x BP, [Str]x Strength, [Pow]x Force and disables Regeneration while active. It has no drain."
		..()*/
	//var/LastUse=0
	verb/Arcane_Power()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr, null, 0, 0)






















