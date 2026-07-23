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
----
	Wave=1
	icon='Beam3.dmi'

	KiReq=1.1
	WaveMult=0.9
	ChargeRate=1
	MaxDistance=20 //Move delay x40
	MoveDelay=3
	Piercer=0
	luminosity=2
	Shockwave=1
	Experience=100
	var/Master=0
	New()
		BeamDescription()
		..()	//Beams are bright...

	DMGT			= DMG_TIER_1
	CDT				= CD_TIER_1
	EDT				= ED_TIER_1
	KBT				= KB_TIER_1
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	verb/Beam()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging||A.streaming) return
		if(Master==1) usr.Beam_Macro(src,1)
		else usr.Beam_Macro(src)
	verb/Ki_Settings()
		set category="Other"
		if(usr.HasBeamExpert) if(usr.Confirm("Toggle Beam Expert? Causes beams to be 3 tiles but deal 75% damage. (Currently [Master])"))
			Master=!Master
			usr<<"Beam Expert: [Master]"
		var/BM=input("Would you like [src] to fire immediately or to charge?") in list("Immediate","Charge")
		if(BM=="Immediate") BeamMode=0
		else BeamMode=1
		switch(input("Do you want your [src] to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0



Skill/Attacks/proc/BeamDescription() desc="[src] drains [KiReq]x energy to use. Does [WaveMult]x \
damage. Charges higher every [ChargeRate] second(s). Has a range of [round(MaxDistance/MoveDelay)]. \
And moves at [round(100/MoveDelay)] kilometers an hour."



Skill/Buff/proc/GetDescription()
	var/returnDesc="[src] |"
	if(BP!=1)returnDesc+="[BP]x BP |"
	if(istype(src,/Skill/Buff/Bound_Weapon))
		returnDesc+="+[20+((WeaponLevel-1)*10)]% Weapon BP |"
	if(Str!=1)returnDesc+="[Str]x Strength |"
	if(End!=1)returnDesc+="[End]x Endurance |"
	if(Spd!=1)returnDesc+="[Spd]x Speed |"
	if(Pow!=1)returnDesc+="[Pow]x Force |"
	if(Off!=1)returnDesc+="[Off]x Offense |"
	if(Def!=1)returnDesc+="[Def]x Defense |"
	if(Regen!=1)returnDesc+="[Regen]x Regeneration |"
	if(Recov!=1)returnDesc+="[Recov]x Recovery |"
	if(Anger!=1)returnDesc+="[Anger]x Anger |"
	if(KiNeeded)returnDesc+="[KiNeeded*100]% Ki Required |"
	if(energydrain)returnDesc+="[energydrain]% Energy Drain |"
	if(healthdrain)returnDesc+="[healthdrain]x Health Drain |"
	if(buffslot)returnDesc+=" Uses [buffslot] buffslot(s)"
	return returnDesc

Skill/Attacks/Beams/var/BeamMode=1