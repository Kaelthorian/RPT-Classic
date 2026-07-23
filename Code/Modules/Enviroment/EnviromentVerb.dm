mob/var/MakeWalls	=0
mob/var/MakeWater	=0
mob/var/MakeDirt	=0
mob/var/MakeDirtLow	=0
mob/var/MakeHole	=0

////////////////////////////////////////////////////////
mob/Admin1/verb/MakeWalls()
	set category="Event Admin"
	if(usr.MakeWalls==1)
		usr.MakeWalls	=0
		usr<<"You will not make walls when you click now"
	else
		usr.MakeWalls	=1
		usr.MakeWater	=0
		usr.MakeDirtLow	=0
		usr.MakeDirt	=0
		usr<<"You will make walls when you click now"

mob/Admin1/verb/MakeWater()
	set category ="Event Admin"
	if(usr.MakeWater==1)
		usr.MakeWater	=0
		usr<<"You will not make Water when you click now"
	else
		usr.MakeWater	=1
		usr.MakeWalls	=0
		usr.MakeDirtLow	=0
		usr.MakeDirt	=0
		usr.MakeHole	=0
		usr<<"You will make Water when you click now"

mob/Admin1/verb/MakeDirt()
	set category ="Event Admin"
	if(usr.MakeDirt==1)
		usr.MakeDirt	=0
		usr<<"You will not make Dirt when you click now"
	else
		usr.MakeDirt	=1
		usr.MakeWalls	=0
		usr.MakeWater	=0
		usr.MakeDirtLow	=0
		usr.MakeHole	=0
		usr<<"You will make Dirt when you click now"

mob/Admin1/verb/MakeDirtLow()
	set category ="Event Admin"
	if(usr.MakeDirtLow==1)
		usr.MakeDirtLow	=0
		usr<<"You will not make DirtLow when you click now"
	else
		usr.MakeDirtLow	=1
		usr.MakeWalls	=0
		usr.MakeWater	=0
		usr.MakeDirt	=0
		usr.MakeHole	=0
		usr<<"You will make DirtLow when you click now"

mob/Admin1/verb/MakeHole()
	set category ="Event Admin"
	if(usr.MakeHole==1)
		usr.MakeHole	=0
		usr<<"You will not make Hole when you click now"
	else
		usr.MakeHole	=1
		usr.MakeWalls	=0
		usr.MakeWater	=0
		usr.MakeDirt	=0
		usr.MakeDirtLow	=0
		usr<<"You will make Hole when you click now"

////////////////////////////////////////////////////////
mob/Admin1/verb/WallFixing()
	set category ="Debug"
	TurfWallDetector(500,src)

mob/Admin1/verb/EdgeFixing()
	set category ="Debug"
	EdgeFixWorld(500,src)

mob/Admin1/verb/DirtLowFixing()
	set category ="Debug"
	DirtLowFixWorld(500,src)

mob/Admin1/verb/WaterFixing()
	set category ="Debug"
	WaterRiver(500,src)

mob/var/tmp/MapEdit=0

mob/Admin1/verb/MapEdit()
	set category = "Event Admin"
	if(usr.MapEdit)
		usr.MapEdit	=0
		src<<"You no longer delete items while clicking."
	else
		usr.MapEdit	=1
		src<<"You can now click and delete objs made by you."


obj/Props/
	Click()
		if(usr.MapEdit)
			if(src.Builder == usr.name)
				DeleteSaveItem(src)
				del(src)
			if(!src.Builder)
				DeleteSaveItem(src)
				del(src)
			if(usr.AdminMode)
				DeleteSaveItem(src)
				del(src)

turf
	Click()
		if(usr.MakeWalls==1)
			var/turf/atom/TestWall/S = new(src)
			EnvironmentUpdate(S)

		if(usr.MakeWater==1)
			var/turf/atom/Water/S = new(src)
			EnvironmentUpdate(S)

		if(usr.MakeDirt==1)
			var/turf/atom/Ground/Dirt/S = new(src)
			EnvironmentUpdate(S)

		if(usr.MakeDirtLow==1)
			var/turf/atom/DirtLow/S = new(src)
			EnvironmentUpdate(S)

		if(usr.MakeHole==1)
			var/turf/atom/Hole/S = new(src)
			EnvironmentUpdate(S)
			UnderVisContent()