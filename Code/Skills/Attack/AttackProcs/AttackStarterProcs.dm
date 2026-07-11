proc/DashRoll(mob/M,mob/Target)
	var/Dashing
	if(Dashing)return
	M.client.ClashRoll			= TRUE
	Target.client.ClashRoll		= TRUE
	var/Steps = 15
	Dashing=1
	while(Steps)
		Steps--
		if(Target in get_step(M,M.dir))
			Steps=0
			Dashing=0
			M.client.ClashRoll			= FALSE
			Target.client.ClashRoll		= FALSE
			if(prob(50))
				JumpOutRoll(M,Target)
		step_to(M,Target,0,96)
		if(Steps<0)
			Steps=0
		if(!Steps)
			M.client.ClashRoll			= FALSE
			Target.client.ClashRoll		= FALSE
			Dashing=0
		sleep(1)


proc/ZanzoInRoll(mob/M,mob/Target)
	M.ClashRoll				= TRUE
	Target.ClashRoll		= TRUE
	if(M)
		mark1
		var/turf/W=locate(Target.x+rand(-1,1),Target.y+rand(-1,1),M.z)
		if(W)
			if(istype(W,/turf/Special/Blank))
				goto mark1
			if(!W.density)
				for(var/atom/x in W) if(x.density)
					goto mark1
				M.AfterImage()
				M.loc=W
				M.dir=get_dir(M,Target)
				Target.dir=get_dir(Target,M)

				hearers(10,usr) << sound(pick('Zanzoken1.mp3','Zanzoken2.mp3','Zanzoken3.mp3'),volume=20)

			M.ClashRoll				= FALSE
			Target.ClashRoll		= FALSE