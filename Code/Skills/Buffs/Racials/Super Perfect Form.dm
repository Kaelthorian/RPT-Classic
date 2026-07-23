


Skill/Buff/SuperPerfectForm
	BP=1.3
	RequiresApproval=0
	Str=1.2
	Pow=1.2
	End=1.2
	Spd=1.1
	Off=1.2
	Def=1.2
	buffon="begins using Super Perfect Form."
	buffoff="stops using Super Perfect Form."

	var/tmp/Clicks=0
	icon='Judgement_fitted.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Strength by [Str]x, Force by [Pow]x while increasing Offense by [Off]x, Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	verb/Super_Perfect_Form()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)






mob/proc/Bio_Forms()
	if(!Semiperfect_Form && EXPLifetime>=2400 && Base/BPMod >= 100000 && Race=="Bio-Android" && Absorbed>=1)
		Semiperfect_Form=1
		BPMod*=1.3
		if(icon=='Bio Android 1.dmi') icon='Bio Android 2.dmi'
		if(icon=='Bio1.dmi') icon='Bio2.dmi'
		if(icon=='Bio Android 1yellow.dmi') icon='Bio Android 2 yellow.dmi'
		if(icon=='BioAndroid1(Spore).dmi') icon='BioAndroid2(Spore).dmi'
		if(icon=='BioAndroid1r.dmi') icon='BioAndroid2r.dmi'


	else if(!Perfect_Form&& EXPLifetime>=3500 && Base/BPMod >= 1000000 && Race=="Bio-Android" && Absorbed>=2)
		Perfect_Form=1
		BPMod*=1.9
		if(icon=='Bio Android 2.dmi') icon='Bio Android 3.dmi'
		if(icon=='Bio2.dmi') icon='Bio3.dmi'
		if(icon=='Bio Android 2 yellow.dmi') icon='Bio Android 3yellow.dmi'
		if(icon=='BioAndroid2(Spore).dmi') icon='BioAndroid3(Spore).dmi'
		if(icon=='BioAndroid2r.dmi') icon='BioAndroid3r.dmi'
		spawn() for(var/Skill/Misc/Absorb_Bio/B in src) del(B)


