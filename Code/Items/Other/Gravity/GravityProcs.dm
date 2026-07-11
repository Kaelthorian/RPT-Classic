mob/proc/Gravity()
	set waitfor=0
	if(src)
		Gravity=1
		var/turf/A=loc
		if(A&&isturf(A))
			if(A.Gravity<1) A.Gravity=1
			if(A.Gravity>PlanetGravity()) Gravity=A.Gravity
			else Gravity=PlanetGravity()

mob/proc/PlanetGravity()
	if(z==1&&Gravity<EarthGrav) return  EarthGrav
	else if(z==2&&Gravity<NamekGrav) return NamekGrav
	else if(z==3&&Gravity<VegetaGrav) return VegetaGrav
	else if(z==19&&Gravity<HellGrav) return HellGrav
	else if(z==6&&Gravity<DarkPlanetGrav) return DarkPlanetGrav
	else if(z==5&&Gravity<ArconiaGrav) return ArconiaGrav
	else if(z==4&&Gravity<IceGrav) return IceGrav
	else if(z==11&&Gravity<AfterlifeGrav) return AfterlifeGrav
	else return 1

mob/proc/StartingGrav()
	if(!BeenGivenStartingGrav&&GravMastered<Gravity)
		GravMastered=Gravity
		BeenGivenStartingGrav=1

mob/proc/Gravity_Gain() if(!RPMode) if(!afk)
	if(adminDensity) return
	var/DMG = 1.5*((((Gravity*2)/GravMastered)-2)**2)
	TakeDamage("Gravity", DMG)
	if(Gravity>GravMastered)
		if(Gravity>GravMastered*1.5) Increase_GainMultiplier(10)
		else Increase_GainMultiplier(5)
		if(attacking) GravMastered+=(0.095)*(Gravity/GravMastered)
		else if(icon_state=="Train") GravMastered+=(0.05)*(Gravity/GravMastered)       //Enable this to turn on gravity mastery gains when standing in gravity.
		else if(KOd==0)  GravMastered+=(0.025)*(Gravity/GravMastered)
		if(Gravity>PlanetGravity()) GravMastered+=(0.05)*(Gravity/GravMastered)