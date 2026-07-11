Skill/Attacks/Beams/Buster_Cannon
	UB1="War"
	UB2="Fungal Plague"
	Wave=1
	icon='CorkScrew.dmi'
	KiReq=1
	WaveMult=1.5
	ChargeRate=0.5
	MaxDistance=30
	Shockwave=1
	MoveDelay=2.5
	Piercer=0
	luminosity=3
	NoMove=1


	New()
		BeamDescription()
		..()
	verb/Buster_Cannon()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		/*for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return*/
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		usr.Beam_Macro(src,0,0)
	verb/Ki_Settings()
		set category="Other"
		var/BM=input("Would you like [src] to fire immediately or to charge?") in list("Immediate","Charge")
		if(BM=="Immediate") BeamMode=0
		else BeamMode=1
		switch(input("Do you want your [src] to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
