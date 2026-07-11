var/list/DamagedTurfs=new
var/MapNatureScoreCurrent = 0
var/MapNatureScoreSaved	= 0
//Add this to the Nature proc that already create them so we don't have to read all the map again.

proc/NatureScore()
	MapNatureScoreCurrent = MapNatureScoreSaved
	world<<"Map Nature Score = [MapNatureScoreCurrent]"

proc/RegenerateNature(var/turf/F)
	if(istype(F,/turf/atom/Ground/Grass))
		NatureGrowthGrassRegen(F)

	if(istype(F,/turf/atom/Ground/Dirt))
		NatureGrowthDirtRegen(F)

	if(istype(F,/turf/atom/Ground/Sand))
		NatureGrowthSandRegen(F)

//Loop to Heal the turfs that were in the list of damaged turfs
proc/NatureHealLoop()
    var/list/PotentialTurfs = new
    while(MapNatureScoreCurrent < MapNatureScoreSaved)
        for(var/turf/atom/R in world)
            if(R.name!="Water" || R.name!="TestWall")
                PotentialTurfs +=R
        RegenerateNature(pick(PotentialTurfs))
        sleep(1)

proc/TurfsHealLoop()
    for(var/turf/R in DamagedTurfs)
        R.EnvironmentHealth += (R.Health/5)
        if(R.EnvironmentHealth>=100)
            DamagedTurfs.Remove(R)

proc/NatureGrowthGrassRegen(var/Source)

	for(var/turf/atom/Ground/Grass/E in view(0,Source))
		var/Growth = 0

		if(istype(get_step(E,SOUTH),/turf/atom/Ground/Grass))
			Growth++

		if(istype(get_step(E,NORTH),/turf/atom/Ground/Grass))
			Growth++

		if(istype(get_step(E,WEST),/turf/atom/Ground/Grass))
			Growth++

		if(istype(get_step(E,EAST),/turf/atom/Ground/Grass))
			Growth++

		if(istype(get_step(E,NORTHEAST),/turf/atom/Ground/Grass))
			Growth++

		if(istype(get_step(E,NORTHWEST),/turf/atom/Ground/Grass))
			Growth++

		if(istype(get_step(E,SOUTHEAST),/turf/atom/Ground/Grass))
			Growth++

		if(istype(get_step(E,SOUTHWEST),/turf/atom/Ground/Grass))
			Growth++

		if(Growth == 1)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= 'GrassOverlay1.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 2)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= pick('GrassOverlay3.dmi','GrassOverlay1.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 3)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= pick('GrassOverlay3.dmi','GrassOverlay1.dmi','GrassOverlay1.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 4)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= pick('GrassOverlay3.dmi','GrassOverlay2.dmi','GrassOverlay1.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 5)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= pick('GrassOverlay4.dmi','GrassOverlay2.dmi','GrassOverlay5.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 6)
			if(prob(10))
				var/obj/Nature/Bush/T = new(E)
				T.icon		= pick('BushOverlay.dmi','BushOverlay1.dmi','BushOverlay2.dmi','BushOverlay3.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
			if(prob(10))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= 'GrassOverlay.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 7)
			if(prob(10))
				var/obj/Nature/Bush/T = new(E)
				T.icon		= pick('BushOverlay.dmi','BushOverlay1.dmi','BushOverlay2.dmi','BushOverlay3.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
			if(prob(10))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= 'GrassOverlay.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 8)
			if(prob(15))
				var/obj/Nature/Tree/T = new(E)
				T.icon		= 'TreeOverlay.dmi'
				T.pixel_x	= -16
				T.pixel_y	= -16
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
			if(prob(25))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= 'GrassOverlay.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore

proc/NatureGrowthDirtRegen(var/Source)

	for(var/turf/atom/Ground/Dirt/E in view(0,Source))
		var/Growth = 0

		if(istype(get_step(E,SOUTH),/turf/atom/Ground/Dirt))
			Growth++

		if(istype(get_step(E,NORTH),/turf/atom/Ground/Dirt))
			Growth++

		if(istype(get_step(E,WEST),/turf/atom/Ground/Dirt))
			Growth++

		if(istype(get_step(E,EAST),/turf/atom/Ground/Dirt))
			Growth++

		if(istype(get_step(E,NORTHEAST),/turf/atom/Ground/Dirt))
			Growth++

		if(istype(get_step(E,NORTHWEST),/turf/atom/Ground/Dirt))
			Growth++

		if(istype(get_step(E,SOUTHEAST),/turf/atom/Ground/Dirt))
			Growth++

		if(istype(get_step(E,SOUTHWEST),/turf/atom/Ground/Dirt))
			Growth++
		if(Growth == 1)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 2)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 3)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= pick('RockSmall1.dmi','RockSmall2.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 4)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= pick('RockSmall1.dmi','RockSmall2.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 5)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= pick('RockSmall1.dmi','RockSmall2.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 6)
			if(prob(10))
				var/obj/Nature/RockMedium/T = new(E)
				T.icon		= pick('RockMedium3.dmi','RockMedium2.dmi','RockMedium.dmi')
				T.name		= "Rock"
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
			if(prob(10))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall2.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 7)
			if(prob(10))
				var/obj/Nature/RockMedium/T = new(E)
				T.icon		= pick('RockMedium.dmi','RockMedium1.dmi','RockMedium2.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
			if(prob(10))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
		if(Growth == 8)
			if(prob(5))
				var/obj/Nature/RockBig/T = new(E)
				T.icon		= 'RockBig.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore
			if(prob(10))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreCurrent += T.NatureScore


proc/NatureGrowthSandRegen(var/Source)
	for(var/turf/atom/Ground/Sand/E in view(0,Source))
		if(prob(5))
			var/obj/Nature/Palm/T = new(E)
			T.icon		= 'PalmOverlay.dmi'
			T.pixel_x	= rand(-5,5)
			T.pixel_y	= rand(-5,5)
			T.SaveItem(T)
			MapNatureScoreCurrent += T.NatureScore