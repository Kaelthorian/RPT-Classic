Skill/Misc/T2/KiBlade
	UB1="Bushido"
	UB2="Arcane Power"
	icon='Ki Blade.dmi'
	layer=MOB_LAYER+1


	desc="Makes your melee attacks damage with Force.(20% Strength and 80% Force. Counts as +30% BP. Doesn't work with other ki-weapon moves.)"
	New()
		icon+=rgb(rand(35,200),rand(35,200),rand(35,200))
		..()
	verb/Toggle_Ki_Blade()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.KiHammer)
			usr<<"This can not be used with Ki Hammer"
			return
		if(usr.SpiritSword)
			usr<<"This can not be used with Spirit Sword"
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
		if(usr.KiBlade)
			usr.KiBlade = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1)
			usr.KiBlade = 1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] forms a blade of weaponized ki around their hand!")
			return

