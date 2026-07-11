Skill/Buff/Bound_Weapon

	buffon="starts swinging Excalibur." // set a string for when the buff is turned on
	buffoff="puts away Excalibur." // same for when its turned off
	buffslot = 0 // set this to 0 to not take a buff slot, 1 to take one
	Str=1
	End=1
	Spd=0.9
	Pow=1
	Off=0.9
	Def=1
	var
		PointsSpent=0
		PointsHas=4
		PointsCan=4
		//CritCan=0
		//WeaponLevel=1
		tmp/Cuzin=0
	New()
		icon=pick('Spirit Sword.dmi','Soul Eater.dmi','Kingdom Key.dmi','Sam Sword.dmi','Sagefire Sword.dmi','DualScim.dmi','Double Helix Sword.dmi')
		if(prob(80)) icon+=rgb(rand(0,55),rand(0,55),rand(0,55))
		if(prob(80)) icon-=rgb(rand(0,55),rand(0,55),rand(0,55))
		..()
	verb/Customize_Bound_Weapon()
		set category="Other"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		if(Cuzin) return
		if(Using)
			usr<<"You can not do this while using the weapon."
			return
		Cuzin=1
		if(usr.Confirm("Refund points?"))
			Cuzin=1
			Str=1
			End=1
			Spd=0.9
			Pow=1
			Off=0.9
			Def=1
			CritCan=0
			WeaponLevel=1
			PointsSpent=0
			PointsHas=PointsCan
		if(usr.Confirm("Change the Bound Weapon Name?"))
			usr<<"Do not use this to give a name that is against the rules or somehow blank names."
			name=input(usr) as text
			if(!name||name==" "||name=="  ") name="Excalibur"
		if(usr.Confirm("Change the buffon message?")) buffon=input(usr) as text
		if(usr.Confirm("Change the buffoff message?")) buffoff=input(usr) as text
		Marker1
		if(PointsHas>0&&PointsSpent<PointsCan)
			if(!usr.Confirm("Invest points? ([PointsHas] points remaining)"))
				Cuzin=0
				return
			else
				var/Pinc=input(usr,"Choose which stat","Customize Bound Weapon") in list("Strength","Endurance","Speed","Offense","Defense","Can Crit","+10% Weapon BP")
				switch(Pinc)
					if("Strength")
						if(Str<1.2)
							Str+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Endurance")
						if(End<1.2)
							End+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Speed")
						if(Spd<1.2)
							Spd+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Force")
						if(Pow<1.2)
							Pow+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Offense")
						if(Off<1.2)
							Off+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Defense")
						if(Def<1.2)
							Def+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Can Crit")
						if(CritCan<2)
							CritCan++
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("+10% Weapon BP")
						WeaponLevel++
						PointsHas--
						PointsSpent++
		if(PointsHas>0&&PointsSpent<PointsCan)  goto Marker1
		Cuzin=0
	verb/Summon_Bound_Weapon()
		set category = "Other"
	//	use(usr,BoundWeapon=1)
		use(usr,0,0,0,0,0,0,0,0,0,BoundWeapon=1)

mob/var/BoundWeaponOn=0
Skill/Weapon/Bound_Weapon

	var
		buffon="starts swinging Excalibur." // set a string for when the buff is turned on
		buffoff="puts away Excalibur." // same for when its turned off
		buffslot = 0 // set this to 0 to not take a buff slot, 1 to take one
		PointsSpent=0
		PointsHas=2
		PointsCan=2
		YearDeveloped=0
		CritCan=0
		WeaponLevel=1
		StrMult=1
		EndMult=1
		SpdMult=1
		PowMult=1
		OffMult=1
		DefMult=1
		tmp/Cuzin=0






mob/proc/BWWillpowerDrain()
	Willpower-=0.01