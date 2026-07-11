proc/WorldFixEnviromentStarter()
	set background=1
	for(var/turf/R in world)
		RemoveOverlaysTurf(1,R)
		WaterConnections(1,R)
		EdgeFixWorld(1,R)
		TurfWallDetector(1,R)
		DirtLowFixWorld(1,R)
		TurfHoleDetector(1,R)
		TurfLavaDetector(1,R)
		WaterRiver(1,R)


proc/EnvironmentUpdate(var/R)
	set background=1
	RemoveOverlaysTurf(1,R)
	WaterConnections(1,R)
	EdgeFixWorld(1,R)
	TurfWallDetector(1,R)
	DirtLowFixWorld(1,R)
	TurfHoleDetector(1,R)
	TurfLavaDetector(1,R)
	WaterRiver(1,R)
	DamageOverlay(1,R)

proc/DamageEnviroment(var/MOB,var/Range)
	var/tmp/NotSave	= 0
	for(var/turf/atom/A in view(Range,MOB))
		if(A.z==1||A.z==3)
			return
		A.EnvironmentHealth = (A.EnvironmentHealth-25)
		A.overlays += pick('TurfDamageOverlay.dmi','TurfDamageOverlay1.dmi','TurfDamageOverlay2.dmi')


		//We save  the turf
		Turfs +=A
		//If is broken we adapteveryting around it
		if(A.EnvironmentHealth <= 0)
			EnvironmentCheck(1,A)


		//We save it inthe dmg turflist if is not in the list
		for(var/turf/S in DamagedTurfs)
			if(S==A)
				NotSave=1
		if(!NotSave)
			DamagedTurfs.Add(A)



proc/DamageOverlay(var/Range,var/turf/Source)
	for(var/turf/atom/A in view(1,Range))
		if(Source.EnvironmentHealth<100)
			Source.overlays += pick('TurfDamageOverlay.dmi','TurfDamageOverlay1.dmi','TurfDamageOverlay2.dmi')


proc/UnderVisContent()
	set background=1
	for(var/turf/atom/Hole/T)
		var/turf/UnderVisContent = locate (T.x,T.y,T.z-1)
		T.vis_contents+=UnderVisContent
	for(var/turf/atom/Sky/T)
		var/turf/UnderVisContent = locate (T.x,T.y,T.z-1)
		if(!UnderVisContent.Builder)
			T.vis_contents+=UnderVisContent


proc/UnderVisContentCorrector(mob/MM)
	set background=1
//	world<<"MM [MM]"
	var/turf/TT= locate (MM.x,MM.y,MM.z+1)
//	world<<"TT [TT]"
	TT.vis_contents = null

