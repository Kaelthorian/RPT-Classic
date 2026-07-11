obj/Force_Field_Generator
	desc="Force field"
	icon		='ForceFieldGen.dmi'
	Health		=1.#INF
	density 	=1
	Savable 	=1
	Grabbable	=0

	var/Size	=3
	var/Power	=1000
	var/HPPower	=10000000000000000000000000
	var/InUse	=0
	verb
		Bolt()
			set src in oview(1)
			if(!Bolted)
				Bolted=1
				return
			else
				Bolted=0
		Settings()
			set src in oview(1)
			Size=input(usr,"Size?")as num
			Power=input(usr,"Power?")as num
			HPPower=input(usr,"HPPower?")as num
		Turn_On()
			set src in oview(1)
			if(InUse)
				return
			Bolted=1
			var/startx=src.x-Size
			var/starty=src.y-Size
			var/endx=src.x+Size
			var/endy=src.y+Size
			if(startx<1) startx=1
			if(starty<1) starty=1
			if(endx>world.maxx) endx=world.maxx
			if(endy>world.maxy) endy=world.maxy
			var/placer=startx
			var/placery=starty
			InUse=1
			while(placery<endy+1)
				//if(startx>=placer&&placer<=endx)
				if(placery==starty)
					var/turf/C=new /obj/Blocker/ForceField(locate(placer,placery,src.z))
					C.Health=HPPower
					spawn(Power+rand(10,50))
						del(C)
						InUse=0
						Bolted=0
				else if(placer==startx||placer==endx)
					var/turf/C=new /obj/Blocker/ForceField(locate(placer,placery,src.z))
					C.Health=HPPower
					spawn(Power+rand(10,50))
						del(C)
						InUse=0
						Bolted=0
				else if(placery==endy)
					var/turf/C=new /obj/Blocker/ForceField(locate(placer,placery,src.z))
					C.Health=HPPower
					spawn(Power+rand(10,50))
						del(C)
						InUse=0
						Bolted=0
				if(placer>=endx)
					placer=startx
					placery++
				else
					if(placery>starty&&placery<endy) placer=endx
					else placer++
				sleep(0)

		Turn_Off()
			set src in oview(1)
			if(InUse==0)
				return
			for(var/obj/Blocker/ForceField/A in range(src,Size))
				del(A)
			InUse=0





