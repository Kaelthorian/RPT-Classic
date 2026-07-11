proc/ZanzoDodgeRoll(mob/M,mob/Target)
//	world<<"ZanzoDodgeRoll [M.ClashRoll]"
	M.ClashRoll				= TRUE
	Target.ClashRoll		= TRUE

	mark1
	var/turf/W=locate(M.x+rand(-1,1),M.y+rand(-1,1),M.z)
	if(W)
		if(istype(W,/turf/Special/Blank))
			goto mark1
		if(!W.density)
			for(var/atom/x in W) if(x.density) goto mark1

			flick(M.CustomZanzokenIcon,M)
			Target.AfterImage()

			hearers(10,M)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)

			Target.loc=W
			Target.dir=get_dir(Target,M)

		M.ClashRoll	= FALSE
		Target.ClashRoll= FALSE

proc/ZappingRoll(mob/M,mob/Target)
//	world<<"ZappingRoll [M.ClashRoll]"
	M.ClashRoll			= TRUE
	Target.ClashRoll	= TRUE

	Again
	var/turf/TT= pick(oview(5,M))

	if(istype(TT,/turf/atom/TestWall/))
		goto Again

	if(istype(TT,/turf/Upgradeable/Walls/))
		goto Again

	if(istype(TT,/turf/Upgradeable/Roofs/))
		goto Again

	if(istype(TT,/turf/))

		M.x=TT.x+(rand(-1,1))
		M.y=TT.y+(rand(-1,1))
		Target.x=TT.x
		Target.y=TT.y

		if(Target.x==M.x)
			M.x=TT.x+(rand(-1,1))
		if(Target.x==M.x)
			M.y=TT.y+(rand(-1,1))

		M.dir=get_dir(M,Target)
		Target.dir=get_dir(Target,M)

		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE

		hearers(10,usr) << sound(pick('Zanzoken1.mp3','Zanzoken2.mp3','Zanzoken3.mp3'),volume=20)
		sleep(1)
		hearers(10,usr) << sound(pick('Zanzoken1.mp3','Zanzoken2.mp3','Zanzoken3.mp3'),volume=20)
	else
		goto Again


proc/SideJumpRoll(mob/M,mob/Target)
	M.ClashRoll			= TRUE
	Target.ClashRoll	= TRUE




proc/TotalBlockRoll(mob/M,mob/Target)
	M.ClashRoll			= TRUE
	Target.ClashRoll	= TRUE

	HitEffect(M,Target)

proc/SimpleDodgeRoll(mob/M,mob/Target)
	M.ClashRoll			= TRUE
	Target.ClashRoll	= TRUE

	var/OldLocTarget = Target.loc

	if(M.dir== NORTH || M.dir == SOUTH)
		M.pixel_x += pick(-10,10)

		sleep(1)
		Target.loc=M.loc
		M.loc= OldLocTarget

	if(M.dir== WEST || M.dir == EAST)
		M.pixel_y += pick(-10,10)

		sleep(1)
		Target.loc=M.loc
		M.loc= OldLocTarget



	sleep(1)
	M.pixel_y = 0
	M.pixel_x = 0

	M.dir=get_dir(M,Target)

	M.ClashRoll			= FALSE
	Target.ClashRoll	= FALSE
