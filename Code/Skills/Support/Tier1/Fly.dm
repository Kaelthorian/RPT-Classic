mob/proc/Flight_Land() if(Flying)
	density=1
	if(src.KOd==0) icon_state=""
	//layer=MOB_LAYER
	var/image/_overlay = image(FlightAura) // not sure if the equipped thing is an icon/object so=
	_overlay.layer= MOB_LAYER+EFFECTS_LAYER
	overlays -= _overlay
	Flying=0
	for(var/Skill/Misc/Fly/A in src)
		if(A.overlays) overlays+=A.overlays
		A.Flying=0
mob/var/tmp/Flying=0
Skill/Misc/Fly


	desc="Obviously this lets you fly.  The more you use it the more you \
	master it .This will let you move much faster than you can by walking."
	var/tmp/Flying
	var/tmp/Clicks = 0
	verb/Fly()
		set category="Skills"
		if(usr.RPMode) return
		if(isobj(usr.loc)) return
		if(Clicks) return
		if(istype(locate (usr.x,usr.y,usr.z),/turf/atom/Hole))
			usr.z--
			goto A
		if(istype(locate (usr.x,usr.y,usr.z+1),/turf/atom/Hole))
			usr.z++
		A
		if(usr.z==3)
			if(locate (usr.x,usr.y,usr.z-1).Builder)
				usr<<"You can't land on the roof!"
				return
			usr.z=2
		Clicks = 1
		if(usr.KOd==0&&usr.icon_state!="Train"&&usr.icon_state!="Meditate")
			if(!usr.Flying&&!Flying)
				if(usr.Ki>=0)
					usr.Flying_Loop(src)
					usr.icon_state="Flight"
					hearers(10,usr)<<sound('Flying.wav',volume=20)
					if(usr.SuperFly)
						var/image/_overlay = image(usr.FlightAura) // not sure if the equipped thing is an icon/object so=
						_overlay.layer= MOB_LAYER+EFFECTS_LAYER
						usr.overlays += _overlay
					if(usr.icon=='Demon (10).dmi'||usr.icon=='Demon (15).dmi'||usr.icon=='Demon (16).dmi')
						overlays-=overlays
						overlays=usr.overlays
						usr.overlays-=usr.overlays
					Create_Shadow(usr) // Creates a shadow to give the appearance of floating above ground
					Flight(usr)	// Handles shadow's opacity; makes player bob up and down while flying
					if(usr.KB) usr.AerialRecovery()
					usr.layer=6
				else usr<<"You are too tired to fly."
			else
				usr.Flight_Land()
				usr.layer=5
				hearers(10,usr)<<sound('Landing.wav',volume=20)
		spawn(10) Clicks=0

	verb/Fly_Up()
		set category="Skills"
		if(locate (usr.x,usr.y,usr.z).Builder)
			usr<<"You can't fly up, there is roof above you!"
			return
		if(istype(locate (usr.x,usr.y,usr.z-1),/turf/atom/Hole))
			usr.z=1
		if(locate (usr.x,usr.y,usr.z-1).Builder)
			usr<<"You can't land on the roof!"
			return
		if(Flying && usr.z==2)
			usr.z=3

	verb/Ki_Settings()
		set category="Other"
		usr.SuperFly=!usr.SuperFly
		if(usr.SuperFly)
			if(Flying)
				var/image/_overlay = image(usr.FlightAura) // not sure if the equipped thing is an icon/object so=
				_overlay.layer= MOB_LAYER+EFFECTS_LAYER
				usr.overlays += _overlay
			usr<<"Super flight activated for when flying"
		else
			if(Flying)
				var/image/_overlay = image(usr.FlightAura) // not sure if the equipped thing is an icon/object so=
				_overlay.layer= MOB_LAYER+EFFECTS_LAYER
				usr.overlays -= _overlay
			usr<<"Super flight deactivated"


mob/proc/Flying_Loop(var/Skill/Misc/Fly/flySkillObj)
	if(flySkillObj)
		flySkillObj.Flying=1
		Flying=1
		spawn(20)
			if(src&&(client||adminObserve))
				if(Flying==1&&flySkillObj.Flying)
					icon_state="Flight"
					if(isobj(src.loc))
						src<< "You stop flying."
						Ki = max(0,Ki)	//don't want negatives
						Flight_Land()
						return
					if(src.loc == locate(0,0,0))
						src<< "You stop flying."
						Ki = max(0,Ki)	//don't want negatives
						Flight_Land()
						return
					if(Ki>25+(MaxKi*0.5/FlySkill/KiMod))  //&& client.inactivity<=3000
						if(!RPMode)
							icon_state="Flight"
							//layer=MOB_LAYER+1
							if(SuperFly)
								if(FlySkill<(2000*FlyMod)) FlySkill += (1*FlyMod)
							else
								if(FlySkill<(1000*FlyMod)) FlySkill += (0.2*FlyMod)
							Ki = max(0,Ki)
					else
						src<< "You stop flying."
						Ki = max(0,Ki)
						Flight_Land()
						return
				else
					Flight_Land()
					return
			src.Flying_Loop(flySkillObj)
	else return
