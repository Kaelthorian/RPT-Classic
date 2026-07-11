Skill/Attacks/Beams/Piercer
	UB1="War"
	Wave=1
	icon='Makkankosappo.dmi'
	KiReq=1.5
	WaveMult=0.9 // From 0.3
	ChargeRate=0.2
	MaxDistance=15
	MoveDelay=1
	Piercer=1
	luminosity=2

	NoMove=1
	New()
		BeamDescription()
		..()
	verb/Piercer()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		/*for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return*/
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		usr.Beam_Macro(src,0,1)
