Skill/Misc/T3/KiHammer
	UB1="Bushido"
	UB2="Arcane Power"
	icon='Ki hammer.dmi'
	layer=MOB_LAYER+1


	desc="Makes your melee attacks damage with Force instead of Strength. (Counts as +80% BP weapon, but reduces Speed and Offense by 20%. Doesn't work with other ki-weapon moves.)"
	New()
		icon+=rgb(rand(35,200),rand(35,200),rand(35,200))
		..()
	verb/Toggle_Ki_Hammer()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
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
		if(usr.KiHammer)
			usr.KiHammer = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1)
			usr.KiHammer = 1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] forms a massive hammer of weaponized ki around their hand!")
			return