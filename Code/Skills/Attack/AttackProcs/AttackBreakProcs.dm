proc/ZanzoOutRoll(mob/M,mob/Target)
//	world<<"ZanzoOut [M.ClashRoll]"
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

		M.dir=get_dir(M,Target)
		Target.dir=get_dir(Target,M)
		M.ClashRoll		= FALSE
		Target.ClashRoll= FALSE

		hearers(10,usr) << sound(pick('Zanzoken1.mp3','Zanzoken2.mp3','Zanzoken3.mp3'),volume=20)
		sleep(1)
	else
		goto Again

proc/KockbackRoll(mob/M,mob/Target)
//	world<<"KockbackRoll [M.ClashRoll]"
	M.ClashRoll				= TRUE
	Target.ClashRoll		= TRUE

	Target.KB = rand(1,20)
	Target.KnockBack(M)

	hearers(10,usr)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

	M.ClashRoll				= FALSE
	Target.ClashRoll		= FALSE


proc/PushAwayRoll(mob/M,mob/Target)
	M.ClashRoll				= TRUE
	Target.ClashRoll		= TRUE



proc/JumpOutRoll(mob/M,mob/Target)
	M.client.ClashRoll			= TRUE
	Target.client.ClashRoll		= TRUE

	hearers(10,M)<<sound('JumpBack.mp3',volume=20)
	var/Leaps=5
	animate(M,pixel_z=12,time=3)
	Create_Shadow(M)
	var/matrix/State1=matrix()
	State1.Scale(0.9,0.45)
	animate(M.Shadow,alpha=190,transform=State1,time=3)
	while(Leaps)
		step_away(M,Target,5,0)
		M.dir=get_dir(M,M.Target)
		Leaps--
		sleep(1)
	animate(M,pixel_z=0,time=3)
	var/matrix/LandingState=matrix()
	LandingState.Scale(1,0.5)
	animate(M.Shadow,alpha=255,transform=LandingState,time=3)
	RemoveShadow(M)

	M.client.ClashRoll			= FALSE
	Target.client.ClashRoll		= FALSE