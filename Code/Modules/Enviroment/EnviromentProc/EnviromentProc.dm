proc/EdgeFixWorld(var/Range,var/Source)
	set background=1
	for(var/turf/atom/Ground/Grass/E in view(Range,Source))

		//1
		if(istype(get_step(E,SOUTH),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456"
			E.overlays+=image(ES)
			E.EdgeSouth = SOUTH
			del(ES)
		if(istype(get_step(E,NORTH),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456D"
			E.overlays+=image(ES)
			E.EdgeNorth = NORTH
			del(ES)
		if(istype(get_step(E,EAST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258"
			E.overlays+=image(ES)
			E.EdgeEast = EAST
			del(ES)
		if(istype(get_step(E,WEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258D"
			E.overlays+=image(ES)
			E.EdgeWest = WEST
			del(ES)
		//1D
		if(istype(get_step(E,SOUTHEAST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="124"
			E.overlays+=image(ES)
			E.EdgeSouthEast = SOUTHEAST
			del(ES)
		if(istype(get_step(E,SOUTHWEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="236"
			E.overlays+=image(ES)
			E.EdgeSouthWest = SOUTHWEST
			del(ES)
		if(istype(get_step(E,NORTHEAST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="478"
			E.overlays+=image(ES)
			E.EdgeNorthEast = NORTHEAST
			del(ES)
		if(istype(get_step(E,NORTHWEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="689"
			E.overlays+=image(ES)
			E.EdgeNorthWest = NORTHWEST
			del(ES)
		//2
		if(istype(get_step(E,EAST),/turf/atom/Water) && istype(get_step(E,SOUTHEAST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,EAST),/turf/atom/Water) && istype(get_step(E,NORTHEAST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,WEST),/turf/atom/Water) && istype(get_step(E,SOUTHWEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258D"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,WEST),/turf/atom/Water) && istype(get_step(E,NORTHWEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258D"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,SOUTH),/turf/atom/Water) && istype(get_step(E,SOUTHEAST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,SOUTH),/turf/atom/Water) && istype(get_step(E,SOUTHWEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTH),/turf/atom/Water) && istype(get_step(E,NORTHEAST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456D"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTH),/turf/atom/Water) && istype(get_step(E,NORTHWEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456D"
			E.overlays+=image(ES)
			del(ES)
		//InsideOut
		if(istype(get_step(E,NORTHWEST),/turf/atom/Water) && istype(get_step(E,NORTH),/turf/atom/Water) && istype(get_step(E,WEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="1245"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTH),/turf/atom/Water) && istype(get_step(E,NORTHEAST),/turf/atom/Water) && istype(get_step(E,EAST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="2356"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,WEST),/turf/atom/Water) && istype(get_step(E,SOUTHWEST),/turf/atom/Water) && istype(get_step(E,SOUTH),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="4578"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,EAST),/turf/atom/Water) && istype(get_step(E,SOUTH),/turf/atom/Water) && istype(get_step(E,SOUTHWEST),/turf/atom/Water))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="5689"
			E.overlays+=image(ES)
			del(ES)

proc/DirtLowFixWorld(var/Range,var/Source)
	set background=1
	for(var/turf/atom/Ground/E in view(Range,Source))

		//1
		if(istype(get_step(E,SOUTH),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTH),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456D"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,EAST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,WEST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258D"
			E.overlays+=image(ES)
			del(ES)
		//1D
		if(istype(get_step(E,SOUTHEAST),/turf/atom/DirtLow) && !istype(get_step(E,SOUTH),/turf/atom/TestWall))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="124"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,SOUTHWEST),/turf/atom/DirtLow) && !istype(get_step(E,SOUTH),/turf/atom/TestWall))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="236"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTHEAST),/turf/atom/DirtLow) && !istype(get_step(E,NORTH),/turf/atom/TestWall))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="478"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTHWEST),/turf/atom/DirtLow) && !istype(get_step(E,NORTH),/turf/atom/TestWall))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="689"
			E.overlays+=image(ES)
			del(ES)
		//2
		if(istype(get_step(E,EAST),/turf/atom/DirtLow) && istype(get_step(E,SOUTHEAST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,EAST),/turf/atom/DirtLow) && istype(get_step(E,NORTHEAST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,WEST),/turf/atom/DirtLow) && istype(get_step(E,SOUTHWEST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258D"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,WEST),/turf/atom/DirtLow) && istype(get_step(E,NORTHWEST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="258D"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,SOUTH),/turf/atom/DirtLow) && istype(get_step(E,SOUTHEAST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,SOUTH),/turf/atom/DirtLow) && istype(get_step(E,SOUTHWEST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTH),/turf/atom/DirtLow) && istype(get_step(E,NORTHEAST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456D"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTH),/turf/atom/DirtLow) && istype(get_step(E,NORTHWEST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="456D"
			E.overlays+=image(ES)
			del(ES)
		//InsideOut
		if(istype(get_step(E,NORTHWEST),/turf/atom/DirtLow) && istype(get_step(E,NORTH),/turf/atom/DirtLow) && istype(get_step(E,WEST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="1245"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,NORTH),/turf/atom/DirtLow) && istype(get_step(E,NORTHEAST),/turf/atom/DirtLow) && istype(get_step(E,EAST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="2356"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,WEST),/turf/atom/DirtLow) && istype(get_step(E,SOUTHWEST),/turf/atom/DirtLow) && istype(get_step(E,SOUTH),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="4578"
			E.overlays+=image(ES)
			del(ES)
		if(istype(get_step(E,EAST),/turf/atom/DirtLow) && istype(get_step(E,SOUTH),/turf/atom/DirtLow) && istype(get_step(E,SOUTHWEST),/turf/atom/DirtLow))
			var/obj/ES= new
			ES.icon='Edgess.dmi'
			ES.color=rgb(79,72,67)
			ES.icon_state="5689"
			E.overlays+=image(ES)
			del(ES)

proc/RemoveOverlaysTurf(var/Range,var/Source)
	set background=1
	for(var/turf/atom/E in view(Range,Source))
		E.overlays--


proc/EnvironmentCheck(var/Range,var/Source)
	set background=1
	for(var/turf/atom/TestWall/E in view(Range,Source))
		if(E.EnvironmentHealth < 0)
			var/turf/atom/Ground/Dirt/S		= new(E)
			EnvironmentUpdate(S)
			Turfs +=S

	for(var/turf/atom/Ground/Dirt/E in view(Range,Source))
		if(E.EnvironmentHealth < 0)
			var/turf/atom/DirtLow/S		= new(E)
			EnvironmentUpdate(S)
			Turfs +=S

	for(var/turf/atom/DirtLow/E in view(Range,Source))
		if(E.EnvironmentHealth < 0)
			var/turf/atom/Hole/S		= new(E)
			EnvironmentUpdate(S)
			Turfs +=S


proc/TurfCorrector(turf/atom/S)
	set background=1
//1x

	if(S.TurfNorth			== TRUE)
		S.icon_state		="8"

	if(S.TurfEast			== TRUE)
		S.icon_state		="6"

	if(S.TurfWest			== TRUE)
		S.icon_state		="4"

	if(S.TurfSouth			== TRUE)
		S.icon_state		="2"

//2x
	if(S.TurfNorth			== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="82"

	if(S.TurfWest			== TRUE && S.TurfEast		== TRUE)
		S.icon_state		="46"

	if(S.TurfEast			== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="62"

	if(S.TurfWest			== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="42"

	if(S.TurfNorth			== TRUE && S.TurfEast		== TRUE)
		S.icon_state		="86"

	if(S.TurfNorth			== TRUE && S.TurfWest		== TRUE)
		S.icon_state		="84"

//3x
	if(S.TurfNorth			== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="862"

	if(S.TurfNorth			== TRUE && S.TurfWest		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="842"

	if(S.TurfNorth			== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE)
		S.icon_state		="846"

	if(S.TurfWest			== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="462"

	if(S.TurfEast			== TRUE && S.TurfSouthEast	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="623"

	if(S.TurfWest			== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="412"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfWest		== TRUE)
		S.icon_state		="784"

	if(S.TurfNorth			== TRUE && S.TurfNorthEast	== TRUE && S.TurfEast		== TRUE)
		S.icon_state		="896"

//4x
	if(S.TurfNorth			== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="8462"

	if(S.TurfNorth			== TRUE && S.TurfNorthEast	== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="8962"

	if(S.TurfNorth			== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE)
		S.icon_state		="8946"

	if(S.TurfNorth			== TRUE && S.TurfEast		== TRUE && S.TurfSouthEast	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="8623"

	if(S.TurfWest			== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="4623"

	if(S.TurfNorth			== TRUE && S.TurfWest		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="8412"

	if(S.TurfWest			== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="4612"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfWest		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="7842"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE)
		S.icon_state		="7846"

//5x
	if(S.TurfNorth			== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="89462"

	if(S.TurfNorth			== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="84623"

	if(S.TurfNorth			== TRUE && S.TurfNorthEast	== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="89623"

	if(S.TurfNorth			== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="84612"

	if(S.TurfWest			== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="46123"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE)
		S.icon_state		="78946"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfWest		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="78412"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="78462"

//6x
	if(S.TurfNorth			== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="894623"

	if(S.TurfNorth			== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="846123"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="789462"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="784612"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="789412"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="784623"

	if(S.TurfNorth			== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="894612"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="78412"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfNorthEast	== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="89623"

//7x
	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="7846123"

	if(S.TurfNorth			== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="8946123"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE)
		S.icon_state		="7894612"

	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast	== TRUE)
		S.icon_state		="7894623"

//8x
	if(S.TurfNorthWest		== TRUE && S.TurfNorth		== TRUE && S.TurfNorthEast	== TRUE && S.TurfWest		== TRUE && S.TurfEast		== TRUE && S.TurfSouthWest	== TRUE && S.TurfSouth		== TRUE && S.TurfSouthEast		== TRUE)
		S.icon_state		="78946123"

proc/TurfWallDetector(var/Range,var/Source)
	set background=1
	for(var/turf/atom/TestWall/E in view(Range,Source))

		E.TurfNorthEast		= FALSE
		E.TurfNorth			= FALSE
		E.TurfNorthWest		= FALSE
		E.TurfEast			= FALSE
		E.TurfWest			= FALSE
		E.TurfSouthEast		= FALSE
		E.TurfSouth			= FALSE
		E.TurfSouthWest		= FALSE

		if(istype(get_step(E,SOUTH),/turf/atom/TestWall))
			E.TurfSouth		= TRUE

		if(istype(get_step(E,NORTH),/turf/atom/TestWall))
			E.TurfNorth		= TRUE

		if(istype(get_step(E,WEST),/turf/atom/TestWall))
			E.TurfWest		= TRUE

		if(istype(get_step(E,EAST),/turf/atom/TestWall))
			E.TurfEast		= TRUE

		if(istype(get_step(E,NORTHEAST),/turf/atom/TestWall))
			E.TurfNorthEast	= TRUE

		if(istype(get_step(E,NORTHWEST),/turf/atom/TestWall))
			E.TurfNorthWest	= TRUE

		if(istype(get_step(E,SOUTHEAST),/turf/atom/TestWall))
			E.TurfSouthEast	= TRUE

		if(istype(get_step(E,SOUTHWEST),/turf/atom/TestWall))
			E.TurfSouthWest	= TRUE

		TurfCorrector(E)

proc/TurfHoleDetector(var/Range,var/Source)
	set background=1
	for(var/turf/atom/Hole/E in view(Range,Source))

		E.TurfNorthEast		= FALSE
		E.TurfNorth			= FALSE
		E.TurfNorthWest		= FALSE
		E.TurfEast			= FALSE
		E.TurfWest			= FALSE
		E.TurfSouthEast		= FALSE
		E.TurfSouth			= FALSE
		E.TurfSouthWest		= FALSE

		if(istype(get_step(E,SOUTH),/turf/atom/Hole))
			E.TurfSouth		= TRUE

		if(istype(get_step(E,NORTH),/turf/atom/Hole))
			E.TurfNorth		= TRUE

		if(istype(get_step(E,WEST),/turf/atom/Hole))
			E.TurfWest		= TRUE

		if(istype(get_step(E,EAST),/turf/atom/Hole))
			E.TurfEast		= TRUE

		if(istype(get_step(E,NORTHEAST),/turf/atom/Hole))
			E.TurfNorthEast	= TRUE

		if(istype(get_step(E,NORTHWEST),/turf/atom/Hole))
			E.TurfNorthWest	= TRUE

		if(istype(get_step(E,SOUTHEAST),/turf/atom/Hole))
			E.TurfSouthEast	= TRUE

		if(istype(get_step(E,SOUTHWEST),/turf/atom/Hole))
			E.TurfSouthWest	= TRUE

		TurfCorrector(E)

proc/TurfLavaDetector(var/Range,var/Source)
	set background=1
	for(var/turf/atom/Lava/E in view(Range,Source))

		E.TurfNorthEast		= FALSE
		E.TurfNorth			= FALSE
		E.TurfNorthWest		= FALSE
		E.TurfEast			= FALSE
		E.TurfWest			= FALSE
		E.TurfSouthEast		= FALSE
		E.TurfSouth			= FALSE
		E.TurfSouthWest		= FALSE

		if(istype(get_step(E,SOUTH),/turf/atom/Lava))
			E.TurfSouth		= TRUE

		if(istype(get_step(E,NORTH),/turf/atom/Lava))
			E.TurfNorth		= TRUE

		if(istype(get_step(E,WEST),/turf/atom/Lava))
			E.TurfWest		= TRUE

		if(istype(get_step(E,EAST),/turf/atom/Lava))
			E.TurfEast		= TRUE

		if(istype(get_step(E,NORTHEAST),/turf/atom/Lava))
			E.TurfNorthEast	= TRUE

		if(istype(get_step(E,NORTHWEST),/turf/atom/Lava))
			E.TurfNorthWest	= TRUE

		if(istype(get_step(E,SOUTHEAST),/turf/atom/Lava))
			E.TurfSouthEast	= TRUE

		if(istype(get_step(E,SOUTHWEST),/turf/atom/Lava))
			E.TurfSouthWest	= TRUE

		TurfCorrector(E)
