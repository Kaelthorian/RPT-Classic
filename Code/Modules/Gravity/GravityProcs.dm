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

mob/proc/Gravity()
	set waitfor=0
	if(src)
		Gravity=1
		var/turf/A=loc
		if(A&&isturf(A))
			if(A.Gravity<1) A.Gravity=1
			if(A.Gravity>PlanetGravity()) Gravity=A.Gravity
			else Gravity=PlanetGravity()


proc/GravityUpdate(mob/A,turf/B)
	A.Gravity=B.Gravity










