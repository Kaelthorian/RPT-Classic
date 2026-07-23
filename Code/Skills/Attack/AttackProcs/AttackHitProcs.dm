proc/ZanzoComboRoll(mob/M,mob/Target)
//	world<<"ZanzoComboRoll [M.ClashRoll]"
	var/ZanzoCombo			= round((M.OffMod * M.SpdMod) / 2)
	M.ClashRoll				= TRUE
	Target.ClashRoll		= TRUE
	while(ZanzoCombo)
		if(M)
			mark1
			var/turf/W=locate(Target.x+rand(-1,1),Target.y+rand(-1,1),M.z)
			if(W)
				if(istype(W,/turf/Special/Blank))
					goto mark1
				if(!W.density)
					for(var/atom/x in W) if(x.density)
						goto mark1
					HitEffect(M)
					flick(M.CustomZanzokenIcon,M)
					hearers(10,M)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

					M.loc=W
					M.dir=get_dir(M,Target)
					Target.dir=get_dir(Target,M)

					ZanzoCombo--
					if(CheckStopClash(M,Target))
						ZanzoCombo=0
//					world<<"ZanzoComboRoll [ZanzoCombo]"
					ClashHitDodge(M,Target)
		if(ZanzoCombo<=0)
			M.ClashRoll		= FALSE
			Target.ClashRoll= FALSE
			sleep(1)

		sleep(1)

proc/PushingRoll(mob/M,mob/Target)
//	world<<"PushingRoll [M.ClashRoll]"
	M.client.ClashRoll			= TRUE
	Target.client.ClashRoll		= TRUE

	M.PushingRoll		= round((M.StrMod*4))
//	world<<"PushingRoll [M.PushingRoll]"
	while(M.PushingRoll)

		step(Target,M.dir)
		step(M,M.dir)

		M.dir=get_dir(M,Target)
		Target.dir=get_dir(Target,M)

		PushingEffect(M,Target)
		flick("Attack",M)
		hearers(10,M)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

		M.PushingRoll--

		if(CheckStopClash(M,Target))
			M.PushingRoll=0

//		world<<"PushingRoll [M.PushingRoll]"
		ClashHitDodge(M,Target)
		sleep(2)
		if(M.PushingRoll<=0)
			sleep(2)
			M.client.ClashRoll		= FALSE
			Target.client.ClashRoll	= FALSE
			sleep(1)

proc/PushingPunchRoll(mob/M,mob/Target)
//	world<<"PushingPunchRoll [M.ClashRoll]"
	M.client.ClashRoll			= TRUE
	Target.client?.ClashRoll	= TRUE

	M.PushingPunchRoll		= round((M.StrMod * 2))

	M.icon_state="Attack"
	hearers(10,M)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)

	while(M.PushingPunchRoll)
//		world<<"PushingPunchRoll [M.PushingPunchRoll]"
		step(Target,M.dir)
		step(M,M.dir)

		M.dir=get_dir(M,Target)
		Target.dir=get_dir(Target,M)

		PushingEffect(M,Target)

		M.PushingPunchRoll--

		if(CheckStopClash(M,Target))
			M.PushingPunchRoll=0

		ClashHitDodge(M,Target)

		sleep(2)

		if(M.PushingPunchRoll<=0)
			sleep(2)
			M.client.ClashRoll		= FALSE
			Target.client.ClashRoll	= FALSE
			M.icon_state=""
			sleep(1)

proc/TugWarRoll(mob/M,mob/Target)
//	world<<"ClashRoll [M.ClashRoll]"
	M.client.ClashRoll			= TRUE
	Target.client?.ClashRoll	= TRUE

	M.TugWarRoll		= round((M.OffMod * M.SpdMod))
	var/WhoPush
//	world<<"TugWarRoll [M.TugWarRoll]"
	while(M.TugWarRoll)
		WhoPush = rand(0,1)
//		world<<"I'm in the loop"
//		world<<"TugWarRoll [M.TugWarRoll]"
		if(WhoPush)
//			world<<"WhoPush [WhoPush]"
			step(M,Target.dir)
			step(Target,Target.dir)

			Target.dir=get_dir(Target,M)
			M.dir=get_dir(M,Target)

			PushingEffect(Target,M)
			flick("Attack",Target)
			hearers(10,M)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

			M.TugWarRoll--
//			world<<"TugWarRoll [M.TugWarRoll]"
			ClashHitDodge(Target,M)
			if(CheckStopClash(M,Target))
				M.TugWarRoll=0
			sleep(1)

		if(!WhoPush)
//			world<<"WhoPush2 [WhoPush]"

			step(Target,M.dir)
			step(M,M.dir)

			M.dir=get_dir(M,Target)
			Target.dir=get_dir(Target,M)

			PushingEffect(M,Target)
			flick("Attack",M)
			hearers(10,M)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

			M.TugWarRoll--
			if(CheckStopClash(M,Target))
				M.TugWarRoll=0
//			world<<"TugWarRoll [M.TugWarRoll]"
			ClashHitDodge(M,Target)

			sleep(1)

		sleep(2)
		if(M.TugWarRoll<=0)
//			world<<"I'm iout of the loop"
			sleep(2)
			M.client.ClashRoll		= FALSE
//			world<<"I'm iout of the loop 1[M.client.ClashRoll]"
			Target.client.ClashRoll	= FALSE
//			world<<"I'm iout of the loop 2 [Target.client.ClashRoll]"
			sleep(1)



proc/FistRoll(mob/M,mob/Target)
//	world<<"FistRoll [M.ClashRoll]"

	M.ClashRoll			= TRUE
	Target.ClashRoll 	= TRUE

	M.dir=get_dir(M,Target)
	Target.dir=get_dir(Target,M)
	Target.loc=M.loc

	sleep(1)
	Target.pixel_x		= -10
	M.pixel_x			= 10

	Target.icon_state	= "Attack"
	M.icon_state		= "Attack"

	ImpactDust(Target,M.dir)
	ImpactDust(Target.dir,M.Target)

	ShockwaveScale(Target,100000,1)
	var/startx=M.x-1
	var/starty=M.y-1
	var/endx=M.x+1
	var/endy=M.y+1
	if(startx<1) startx=1
	if(starty<1) starty=1
	if(endx>world.maxx) endx=world.maxx
	if(endy>world.maxy) endy=world.maxy
	var/placer=startx
	var/placery=starty
	spawn()
		while(placery<endy+1)

			if(placery==starty)
				var/turf/C=new /turf/atom/Ground/Dirt(locate(placer,placery,M.z))
				EnvironmentUpdate(C)
			else if(placer==startx||placer==endx)
				var/turf/C=new /turf/atom/Ground/Dirt(locate(placer,placery,M.z))
				EnvironmentUpdate(C)
			else if(placery==endy)
				var/turf/C=new /turf/atom/Ground/Dirt(locate(placer,placery,M.z))
				EnvironmentUpdate(C)
			if(placer>=endx)
				placer=startx
				placery++
			else
				if(placery>starty&&placery<endy) placer=endx
				else placer++
			sleep(0)

	M.Screen_Shake(2,8)
	ImpactDust(Target,M.dir)
	ImpactDust(Target.dir,M.Target)
	ShockwaveScale(Target,100000,1)

	//Stage2
	sleep(10)
	startx=M.x-2
	starty=M.y-2
	endx=M.x+2
	endy=M.y+2
	if(startx<1) startx=1
	if(starty<1) starty=1
	if(endx>world.maxx) endx=world.maxx
	if(endy>world.maxy) endy=world.maxy
	placer=startx
	placery=starty
	spawn()
		while(placery<endy+1)

			if(placery==starty)
				var/turf/C=new /turf/atom/Ground/Dirt(locate(placer,placery,M.z))
				EnvironmentUpdate(C)
			else if(placer==startx||placer==endx)
				var/turf/C=new /turf/atom/Ground/Dirt(locate(placer,placery,M.z))
				EnvironmentUpdate(C)
			else if(placery==endy)
				var/turf/C=new /turf/atom/Ground/Dirt(locate(placer,placery,M.z))
				EnvironmentUpdate(C)
			if(placer>=endx)
				placer=startx
				placery++
			else
				if(placery>starty&&placery<endy) placer=endx
				else placer++
			sleep(0)
	M.Screen_Shake(2,8)
	ImpactDust(Target,M.dir)
	ImpactDust(Target.dir,M.Target)
	ShockwaveScale(Target,100000,1)
	//Stage3
	sleep(1)
	startx=M.x-1
	starty=M.y-1
	endx=M.x+1
	endy=M.y+1
	if(startx<1) startx=1
	if(starty<1) starty=1
	if(endx>world.maxx) endx=world.maxx
	if(endy>world.maxy) endy=world.maxy
	placer=startx
	placery=starty
	spawn()
		while(placery<endy+1)

			if(placery==starty)
				var/turf/C=new /turf/atom/DirtLow(locate(placer,placery,usr.z))
				EnvironmentUpdate(C)
			else if(placer==startx||placer==endx)
				var/turf/C=new /turf/atom/DirtLow(locate(placer,placery,usr.z))
				EnvironmentUpdate(C)
			else if(placery==endy)
				var/turf/C=new /turf/atom/DirtLow(locate(placer,placery,usr.z))
				EnvironmentUpdate(C)
			if(placer>=endx)
				placer=startx
				placery++
			else
				if(placery>starty&&placery<endy) placer=endx
				else placer++
			sleep(0)
	M.Screen_Shake(2,8)
	ImpactDust(Target,M.dir)
	ImpactDust(Target.dir,M.Target)
	ShockwaveScale(Target,100000,1)
	sleep(10)


	M.icon_state		= ""
	Target.icon_state	= ""

	M.ClashRoll			= FALSE
	Target.ClashRoll 	= FALSE

	Target.pixel_x		= 0
	M.pixel_x			= 0

