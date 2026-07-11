proc/WaterRiver(var/Range,var/Source)
	set background=1
	var/WaterRunning = 0
	if(WaterRunning)
		return
	for(var/turf/atom/E in view(Range,Source))
		if(istype(E , /turf/atom/DirtLow))
			if(istype(get_step(E,NORTH),/turf/atom/Water))
				var/turf/atom/Water/S 	= new(E)
				S.WaterSource			= 0
				S.WaterConnected		= 1
				for(var/turf/atom/EE in view(1,S))
					if(istype(EE , /turf/atom/DirtLow))
						WaterRiver(1,S)
						EdgeFixWorld(1,S)
						DirtLowFixWorld(1,S)
						return
				return
			if(istype(get_step(E,EAST),/turf/atom/Water))
				var/turf/atom/Water/S 	= new(E)
				S.WaterSource			= 0
				S.WaterConnected		= 1
				for(var/turf/atom/EE in view(1,S))
					if(istype(EE , /turf/atom/DirtLow))
						WaterRiver(1,S)
						EdgeFixWorld(1,S)
						DirtLowFixWorld(1,S)
						return
				return
			if(istype(get_step(E,WEST),/turf/atom/Water))
				var/turf/atom/Water/S 	= new(E)
				S.WaterSource			= 0
				S.WaterConnected		= 1
				for(var/turf/atom/EE in view(1,S))
					if(istype(EE , /turf/atom/DirtLow))
						WaterRiver(1,S)
						EdgeFixWorld(1,S)
						DirtLowFixWorld(1,S)
						return
				return
			if(istype(get_step(E,SOUTH),/turf/atom/Water))
				var/turf/atom/Water/S 	= new(E)
				S.WaterSource			= 0
				S.WaterConnected		= 1
				for(var/turf/atom/EE in view(1,S))
					if(istype(EE , /turf/atom/DirtLow))
						WaterRiver(1,S)
						EdgeFixWorld(1,S)
						DirtLowFixWorld(1,S)
						return
				return
			if(istype(get_step(E,NORTHEAST),/turf/atom/Water))
				var/turf/atom/Water/S 	= new(E)
				S.WaterSource			= 0
				S.WaterConnected		= 1
				for(var/turf/atom/EE in view(1,S))
					if(istype(EE , /turf/atom/DirtLow))
						WaterRiver(1,S)
						EdgeFixWorld(1,S)
						DirtLowFixWorld(1,S)
						return
				return
			if(istype(get_step(E,SOUTHEAST),/turf/atom/Water))
				var/turf/atom/Water/S 	= new(E)
				S.WaterSource			= 0
				S.WaterConnected		= 1
				for(var/turf/atom/EE in view(1,S))
					if(istype(EE , /turf/atom/DirtLow))
						WaterRiver(1,S)
						EdgeFixWorld(1,S)
						DirtLowFixWorld(1,S)
						return
				return
			if(istype(get_step(E,SOUTHWEST),/turf/atom/Water))
				var/turf/atom/Water/S 	= new(E)
				S.WaterSource			= 0
				S.WaterConnected		= 1
				for(var/turf/atom/EE in view(1,S))
					if(istype(EE , /turf/atom/DirtLow))
						WaterRiver(1,S)
						EdgeFixWorld(1,S)
						DirtLowFixWorld(1,S)
						return
				return
		else
			return

proc/DryLand(var/Range,var/Source)
	for(var/turf/atom/E in view(Range,Source))
		if(istype(E , /turf/atom/Water))
			if(E.WaterSource == 1)
				WaterRiver(1,E)
				EdgeFixWorld(1,E)
				DirtLowFixWorld(1,E)
				return
			else
				var/turf/atom/DirtLow/S		= new(E)
				EdgeFixWorld(1,S)
				DirtLowFixWorld(1,S)
				DryLand(1,S)
				return

proc/WaterConnections(var/Range,var/Source)
	for(var/turf/atom/E in view(Range,Source))
		if(istype(E , /turf/atom/Water))
			if(E.WaterSource == 1)
				return
			if(E.WaterSource == 0)
				DryLand(1,E)

proc/WaterDesignation()
	set background=1
	for(var/turf/atom/Water/E in world)
		var/WaterDeepLow	= 0
		var/WaterDeepMedium	= 0
		var/WaterDeepHigh 	= 0

//Low Water Check
		if(istype(get_step(E,SOUTH),/turf/atom/Ground/Grass))
			WaterDeepLow++

		if(istype(get_step(E,NORTH),/turf/atom/Ground/Grass))
			WaterDeepLow++

		if(istype(get_step(E,WEST),/turf/atom/Ground/Grass))
			WaterDeepLow++

		if(istype(get_step(E,EAST),/turf/atom/Ground/Grass))
			WaterDeepLow++

		if(istype(get_step(E,NORTHEAST),/turf/atom/Ground/Grass))
			WaterDeepLow++

		if(istype(get_step(E,NORTHWEST),/turf/atom/Ground/Grass))
			WaterDeepLow++

		if(istype(get_step(E,SOUTHEAST),/turf/atom/Ground/Grass))
			WaterDeepLow++

		if(istype(get_step(E,SOUTHWEST),/turf/atom/Ground/Grass))
			WaterDeepLow++

//Medium Water Check
		if(istype(get_step(E,SOUTH),/turf/atom/Water))
			WaterDeepMedium++

		if(istype(get_step(E,NORTH),/turf/atom/Water))
			WaterDeepMedium++

		if(istype(get_step(E,WEST),/turf/atom/Water))
			WaterDeepMedium++

		if(istype(get_step(E,EAST),/turf/atom/Water))
			WaterDeepMedium++

		if(istype(get_step(E,NORTHEAST),/turf/atom/Water))
			WaterDeepMedium++

		if(istype(get_step(E,NORTHWEST),/turf/atom/Water))
			WaterDeepMedium++

		if(istype(get_step(E,SOUTHEAST),/turf/atom/Water))
			WaterDeepMedium++

		if(istype(get_step(E,SOUTHWEST),/turf/atom/Water))
			WaterDeepMedium++

//High Water Check
		if(istype(get_step(E,SOUTH),/turf/atom/Water))
			if(E.WaterLevel == "Medium")
				WaterDeepHigh++

		if(istype(get_step(E,NORTH),/turf/atom/Water))
			if(E.WaterLevel == "Medium")
				WaterDeepHigh++

		if(istype(get_step(E,WEST),/turf/atom/Water))
			if(E.WaterLevel == "Medium")
				WaterDeepHigh++

		if(istype(get_step(E,EAST),/turf/atom/Water))
			if(E.WaterLevel == "Medium")
				WaterDeepHigh++

		if(istype(get_step(E,NORTHEAST),/turf/atom/Water))
			if(E.WaterLevel == "Medium")
				WaterDeepHigh++

		if(istype(get_step(E,NORTHWEST),/turf/atom/Water))
			if(E.WaterLevel == "Medium")
				WaterDeepHigh++

		if(istype(get_step(E,SOUTHEAST),/turf/atom/Water))
			if(E.WaterLevel == "Medium")
				WaterDeepHigh++

		if(istype(get_step(E,SOUTHWEST),/turf/atom/Water))
			if(E.WaterLevel == "Medium")
				WaterDeepHigh++

		if(WaterDeepLow)
			return
		if(WaterDeepMedium==9)
			E.color=rgb(20,116,184)
		if(WaterDeepHigh)
			E.color=rgb(29,91,134)

proc/WaterDesignationLow()
	set background=1
	for(var/turf/atom/Water/E in world)
		var/WaterDeepLow	= 0
		for(var/turf/atom/Water/T in block(locate(E.x-1,E.y-1,E.z),locate(E.x+1,E.y+1,E.z)))
			if(istype(T,/turf/atom/Ground/Grass))
				WaterDeepLow++
		if(WaterDeepLow)
			E.SwimingDifficulty=2
//		sleep(1)

proc/WaterDesignationMedium()
	set background=1
	for(var/turf/atom/Water/E in world)
		var/WaterDeepMedium	= 0
		for(var/turf/atom/Water/T in block(locate(E.x-2,E.y-2,E.z),locate(E.x+2,E.y+2,E.z)))
			if(istype(T,/turf/atom/Water))
				WaterDeepMedium++
		if(WaterDeepMedium==25)
			E.color=rgb(20,116,184)
			E.SwimingDifficulty=3
			E.WaterLevel="Medium"
//		sleep(1)

proc/WaterDesignationHigh()
	set background=1
	for(var/turf/atom/Water/E in world)
		var/WaterDeepHigh 	= 0
		for(var/turf/atom/Water/T in block(locate(E.x-2,E.y-2,E.z),locate(E.x+2,E.y+2,E.z)))
			if(istype(T,/turf/atom/Water))
				if(T.WaterLevel=="Medium")
					WaterDeepHigh++
		if(WaterDeepHigh==25)
			E.color=rgb(29,91,134)
			E.SwimingDifficulty=100
//		sleep(1)

proc/WaterLevelCheck()
	set background=1
	WaterDesignationLow()
//	sleep(100)
	WaterDesignationMedium()
//	sleep(100)
	WaterDesignationHigh()