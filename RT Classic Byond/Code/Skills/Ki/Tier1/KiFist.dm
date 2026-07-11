Skill/Misc/T1/KiFists
	icon='Flaming_Purple_fists.dmi'


	desc="This will give your unarmed attacks +30% Force damage, but 70% Strength. (Doesn't work with other ki-weapon moves. Counts as  +18% BP.)"
	New()
		icon+=rgb(rand(0,225),rand(0,225),rand(0,225))
		..()
	verb/Toggle_Ki_Fists()
		set category="Other"
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
			return
		if(usr.SpiritSword)
			usr<<"This can not be used with Spirit Sword"
			return
		if(usr.KiHammer)
			usr<<"This can not be used with Ki Hammer"
			return
		if(usr.SwordOn)
			usr<<"You can't do this with a weapon."
			return
		if(usr.HammerOn)
			usr<<"You can't do this with a weapon."
			return
		if(usr.GlovesOn)
			usr<<"You can't do this with a weapon."
			return

		usr.KiFists=!usr.KiFists
		if(usr.KiFists)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] activated Ki Fists.")
			usr.overlays += image(src,layer=MOB_LAYER+EFFECTS_LAYER+1)
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] deactivated Ki Fists.")
			usr.overlays -= image(src,layer=MOB_LAYER+EFFECTS_LAYER+1)

