Skill/Misc/SpiritSword
	icon='Spirit Sword.dmi'
	layer=MOB_LAYER+1


	desc="Makes your melee attacks damage with Force.(Counts as a +60% BP weapon, but reduces Offense by 10%. Doesn't work with other ki-weapon moves.)"
	New()
		icon=pick('Spirit Sword.dmi','Soul Eater.dmi','Kingdom Key.dmi','Sam Sword.dmi','Sagefire Sword.dmi','DualScim.dmi','Double Helix Sword.dmi')
		if(prob(80)) icon+=rgb(rand(0,95),rand(0,95),rand(0,95))
		..()
	verb/Toggle_Spirit_Sword()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
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
		if(usr.SpiritSword)
			usr.SpiritSword = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1)
			usr.SpiritSword = 1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] turns their ki into a weapon made of life energy!")
			return