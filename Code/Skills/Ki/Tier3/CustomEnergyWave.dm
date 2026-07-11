Skill/Attacks/Beams/CustomEnergyWave
	Wave=1
	icon='Beam3.dmi'

	KiReq=3.5
	WaveMult=0.5
	ChargeRate=4
	MaxDistance=10 //Move delay x40
	MoveDelay=4
	Piercer=0
	luminosity=2
	Shockwave=1

	var
		PointsSpent=0
		PointsHas=25
		PointsCan=25
		PointsKiReq=0//-0.5 per point
		PointsWaveMult=0 // +0.1 per point
		PointsChargeRate=0 // -0.3 per point
		PointsMaxDistance=0 //+4 per point
		PointsMoveDelay=0 // -0.5 per point
		PointsPiercer=0 // 10 points
		Creator=1
		nameSet=0
		Final=0
		tmp/Cuzin=0

	verb/Customize_Energy_Wave_Refund()
		set category=null//"Other"
		if(!Creator)
			usr<<"Only the creator can do this."
			return
		if(Final)
			usr<<"This has been finalized."
			return
		if(Using)
			usr<<"You can not do this while using the beam."
			return
		if(Cuzin) return
		if(usr.Confirm("Refund points?"))
			Cuzin=1
			PointsSpent=0
			PointsHas=PointsCan
			KiReq=5
			WaveMult=0.5
			ChargeRate=4
			MaxDistance=10 //Move delay x40
			Piercer=0
			MoveDelay=4
			Cuzin=0
	verb/Customize_Energy_Wave()
		set category=null//"Other"
		if(!Creator)
			usr<<"Only the creator can do this."
			return
		if(Final)
			usr<<"This has been finalized."
			return
		if(Cuzin) return
		if(Using)
			usr<<"You can not do this while using the stance."
			return
		Cuzin=1
		if(!nameSet)
			if(usr.Confirm("Change the Beam Name?"))
				usr<<"Do not use this to give a name that is against the rules or somehow blank names."
				name=input(usr) as text
				nameSet=1
				if(!name||name==" "||name=="  ") name="Super Mega Beam"
				//src.verbs += new/Skill/Attacks/Beams/CustomEnergyWave/proc/FireEW(src, "[name]")
		Marker1
		if(PointsHas>0&&PointsSpent<PointsCan)
			if(!usr.Confirm("Invest points? ([PointsHas] points remaining)"))
				Cuzin=0
				return
			else


				var/Pinc=input(usr,"Choose which stat","Customize Beam") in list("Drain (-0.5 per point)","Damage Mult (+0.1 per point)","Charge Rate (-0.5 per point)","Max Distance (+2 per point)","Move Delay (-0.25 per point)","Piercer (10 points)")
				switch(Pinc)
					if("Drain (-0.5 per point)")
						if(KiReq>1)
							KiReq-=0.5
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Damage Mult (+0.1 per point)")
						WaveMult+=0.1
						PointsHas--
						PointsSpent++
					if("Charge Rate (-0.5 per point)")
						if(ChargeRate>0.5)
							ChargeRate-=0.5
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Max Distance (+2 per point)")
						MaxDistance+=2
						PointsHas--
						PointsSpent++
					if("Move Delay (-0.25 per point)")
						if(MoveDelay>0.5)
							MoveDelay-=0.25
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Piercer (10 points)")
						if(Piercer==0&&PointsHas>=10)
							Piercer=1
							PointsHas-=10
							PointsSpent+=10
						else usr<<"This is already capped."
		BeamDescription()
		if(PointsHas>0&&PointsSpent<PointsCan)  goto Marker1
		Cuzin=0
		BeamDescription()



	New()
		BeamDescription()
		..()	//Beams are bright...
	verb/Fire_Custom_Energy_Wave()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging||A.streaming) return
		usr.Beam_Macro(src)
	verb/Ki_Settings()
		set category="Other"
		var/BM=input("Would you like [src] to fire immediately or to charge?") in list("Immediate","Charge")
		if(BM=="Immediate") BeamMode=0
		else BeamMode=1
		switch(input("Do you want your [src] to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
