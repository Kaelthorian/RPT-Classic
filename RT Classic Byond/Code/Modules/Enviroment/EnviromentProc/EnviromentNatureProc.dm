
proc/NatureGrowthGrass()
	set background=1
	for(var/turf/atom/Ground/Grass/E in world)
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
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 2)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= pick('GrassOverlay3.dmi','GrassOverlay1.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 3)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= pick('GrassOverlay3.dmi','GrassOverlay1.dmi','GrassOverlay1.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 4)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= pick('GrassOverlay3.dmi','GrassOverlay2.dmi','GrassOverlay1.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 5)
			if(prob(15))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= pick('GrassOverlay4.dmi','GrassOverlay2.dmi','GrassOverlay5.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 6)
			if(prob(10))
				var/obj/Nature/Bush/T = new(E)
				T.icon		= pick('BushOverlay.dmi','BushOverlay1.dmi','BushOverlay2.dmi','BushOverlay3.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
			if(prob(10))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= 'GrassOverlay.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 7)
			if(prob(10))
				var/obj/Nature/Bush/T = new(E)
				T.icon		= pick('BushOverlay.dmi','BushOverlay1.dmi','BushOverlay2.dmi','BushOverlay3.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
			if(prob(10))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= 'GrassOverlay.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 8)
			if(prob(15))
				var/obj/Nature/Tree/T = new(E)
				T.icon		= 'TreeOverlay.dmi'
				T.pixel_x	= -16
				T.pixel_y	= -16
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
			if(prob(25))
				var/obj/Nature/Grass/T = new(E)
				T.icon		= 'GrassOverlay.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore

proc/NatureGrowthDirt()
	set background=1
	for(var/turf/atom/Ground/Dirt/E in world)
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
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 2)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 3)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= pick('RockSmall1.dmi','RockSmall2.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 4)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= pick('RockSmall1.dmi','RockSmall2.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 5)
			if(prob(5))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= pick('RockSmall1.dmi','RockSmall2.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 6)
			if(prob(10))
				var/obj/Nature/RockMedium/T = new(E)
				T.icon		= pick('RockMedium3.dmi','RockMedium2.dmi','RockMedium.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
			if(prob(10))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall2.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 7)
			if(prob(10))
				var/obj/Nature/RockMedium/T = new(E)
				T.icon		= pick('RockMedium.dmi','RockMedium1.dmi','RockMedium2.dmi')
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
			if(prob(10))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
		if(Growth == 8)
			if(prob(5))
				var/obj/Nature/RockBig/T = new(E)
				T.icon		= 'RockBig.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore
			if(prob(10))
				var/obj/Nature/RockSmall/T = new(E)
				T.icon		= 'RockSmall.dmi'
				T.pixel_x	= rand(-5,5)
				T.pixel_y	= rand(-5,5)
				T.SaveItem(T)
				MapNatureScoreSaved += T.NatureScore




proc/SandSpawn()
	set background=1
	for(var/turf/atom/Ground/Grass/E in world)
		for(var/turf/atom/Water/T in block(locate(E.x-1,E.y-1,E.z),locate(E.x+1,E.y+1,E.z)))
			if(prob(10))
				if(istype(get_step(E,SOUTH),/turf/atom/Ground/Sand))
					E.overlays--
					Turfs		+=E
				if(istype(get_step(E,NORTH),/turf/atom/Ground/Sand))
					E.overlays--
					Turfs		+=E
				if(istype(get_step(E,EAST),/turf/atom/Ground/Sand))
					E.overlays--
					Turfs		+=E
				if(istype(get_step(E,WEST),/turf/atom/Ground/Sand))
					E.overlays--
					Turfs		+=E

			if(prob(15))
				var/turf/atom/Ground/Sand/S = new(T)
				S.name	= "Sand"
				Turfs		+=S
				if(prob(25))
					for(var/turf/atom/Water/TT in block(locate(S.x-1,S.y-1,S.z),locate(S.x+1,S.y+1,S.z)))
						var/turf/atom/Ground/Sand/SS = new(TT)
						SS.name	= "Sand"
						Turfs		+=SS
						if(prob(25))
							for(var/turf/atom/Water/TTT in block(locate(SS.x-1,SS.y-1,S.z),locate(SS.x+1,SS.y+1,SS.z)))
								var/turf/atom/Ground/Sand/SSS = new(TTT)
								SSS.name	= "Sand"
								Turfs		+=SSS


proc/NatureGrowthSand()
	set background=1
	for(var/turf/atom/Ground/Sand/E in world)
		if(prob(5))
			var/obj/Nature/Palm/T = new(E)
			T.icon		= 'PalmOverlay.dmi'
			T.pixel_x	= rand(-5,5)
			T.pixel_y	= rand(-5,5)
			T.SaveItem(T)
			MapNatureScoreSaved += T.NatureScore


