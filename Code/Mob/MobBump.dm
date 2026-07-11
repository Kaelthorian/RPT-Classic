mob/Bump(mob/A)
	if(ghostDens_check(src))
		A.density=0
		spawn(5) A.density=1
		return
	if(istype(A,/obj/Warper))
		src<<"Bumped a warper."
		var/obj/Warper/B=A
		loc=locate(B.gotox,B.gotoy,B.gotoz)
	if(client&&istype(A,/obj/Door)&&!OpeningDoor)
		var/obj/Door/B=A
		for(var/obj/items/Door_Pass/D in src) if(D.Password==B.Password)
			B.Open()
			return
		for(var/obj/items/Advanced_Door_Pass/D in src) if(D.Password==B.Password||D.Password2==B.Password||D.Password3==B.Password)
			B.Open()
			return
		if(B.Password)
			OpeningDoor=1
			var/Guess=input(src,"You must know the password to enter here") as text
			if(B) if(Guess!=B.Password)
				OpeningDoor=0
				return 0
		if(B) B.Open()
		OpeningDoor=0
		return
	if(istype(A,/turf/atom/TestWall/))
		if(isThrown)
			A.EnvironmentHealth = (A.EnvironmentHealth-1000)
			if(A.EnvironmentHealth <= 0)
				EnvironmentCheck(1,A)
				KB=0

	if(istype(A,/obj/Ships/Ship))
		var/obj/Ships/Ship/B=A
		if(B.Password)
			var/PA=input(src,"What is this ship's password?") as text
			if(PA!=B.Password)
				src<<"Wrong!"
				return
		if(B.Ship=="Ardent"||B.Ship=="Icebreaker")
			for(var/obj/Airlock/C in world) if(C.Ship==B.Ship)
				if(src.inertia_dir)
					src.inertia_dir=0	//If they entered from space\
					src.last_move=null
				loc=locate(C.x,C.y-1,C.z)
		else for(var/obj/Controls/MKIControls/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space\
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(istype(A,/obj/Ships/ShipMKII))
		var/obj/Ships/Ship/B=A
		if(B.Password)
			var/PA=input(src,"What is this ship's password?") as text
			if(PA!=B.Password)
				src<<"Wrong!"
				return
		for(var/obj/Controls/MKIIControls/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space\
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(istype(A,/obj/Ships/ShipMKIII))
		var/obj/Ships/Ship/B=A
		if(B.Password)
			var/PA=input(src,"What is this ship's password?") as text
			if(PA!=B.Password)
				src<<"Wrong!"
				return
		for(var/obj/Controls/MKIIIControls/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space\
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(istype(A,/obj/AndroidShip))
		var/obj/AndroidShip/B=A
		for(var/obj/AndroidAirlock/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space\
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(ismob(A)) if(!client|Oozaru)
//		MeleeAttack()
		if(sim&&A.Health<=20)
			A<<"Simulator: Simulation cancelled due to safety protocols."
			del(src)
		return
		//if(A&&istype(src,/NPC_AI)&&A.KOd&&prob(1)) spawn A.Death(src)
	if(istype(A,/obj/Planets))
		Bump_Planet(A,src)
		//src.Heart_Virus()
	if(istype(A,/obj/items/Soccer_Ball))
		if(!Flying)
			step_away(A,src)

	if(istype(A,/obj/Turfs/Glass))
		if(ghostDens_check(src)) return ..()
		else return
	/*if(istype(A,/obj/Door)) if(A.density)
		Bump(A)
		return 0*/
	if(istype(A,/obj/Blocker))
		return
	..()