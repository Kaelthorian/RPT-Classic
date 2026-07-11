client
    var/tmp/ClashRoll = FALSE

    Move(loc, dir)
        if(ClashRoll)
            return
        ..()


mob/Move(NewLoc, Direct)
	if(RPMode) 							return
	if(afk){ src.TRIGGER_AFK(1);		return }
	if(KB>0 ) 							..()
	if(Frozen) 							return
	if(Training) 						return
	if(Animation)						return
	if(IsBlocking)						return
	if(move==0) 						return
	if(ClashRoll)						return
	if(!Target && ghostDens_check(src)) return ..()
	if(Meditate)						return
	if(KOd)								return
	if(EdgeMovementCheck(loc,usr)&& !Flying)		return

	else
		move=0
		Spinning=1

		var/TrueSpeed	= (SpdMod*BPMod*(BaseMaxAnger/100)*(1 + (BaseRecovery*0.125)))

		var/Delay		= (TrueSpeed/4.82)

		if(!istype(loc,/turf/atom/Water))
			Swimming = 0
			if(!Swimming)
				var/obj/W = new()
				W.icon = 'WaterTest.dmi'
				W.color = rgb(0,150,255,150)
				W.layer	= 9
				W.pixel_y = -16
				overlays -= W
				del(W)
				IsSwimming = 0
		if(istype(loc,/turf/atom/Water) && !Flying)
			if(Swimming>0 && !IsSwimming)
				var/obj/W = new()
				W.icon = 'WaterTest.dmi'
				W.color = rgb(0,150,255,150)
				W.layer	= 9
				W.pixel_y = -16
				overlays += W
				del(W)
				IsSwimming = 1
			var/turf/atom/Water/TT = locate(x,y,z)
			Swimming = TT.SwimingDifficulty
		if(z==3) Delay*=0.7
//		if(Health>0&&!undelayed&&Health<60) Delay*=60/max(1,Health)
		if(Flying) density = 0
		for(var/Skill/Attacks/A in src) if(A.charging&&A.NoMove==0) Delay*=2
//		if(Health<20) Delay*=(20/max(1,Health))
		if(Slow) Delay+=Slow
		if(Stagger)
			Delay+=15
			StaggerCheck(src)
		if(BonusSpeed) Delay-=BonusSpeed
		if(HasEpinephrine) Delay*=0.5
		if(Swimming)
			Delay *= Swimming
			Ki-=Swimming
			if(Ki<=0)
				KO(usr)
		if(HasFleetOfFoot&&!Flying) Delay-=HasFleetOfFoot*0.05
		if(Delay <= 0.2) Delay=0.2
		if(Delay >=250) Delay=250
		if(ClashRoll)
//			world<<"Delay 1"
			Delay=1
		spawn(round(Delay,0.1)) move=1
		if(istype(loc, /turf/Other/Stars))
			if(Flying)
				..()
		else
			..()
		if(adminDensity) density=0
		else density=1
		if(IsFishing)
			IsFishing=0
			usr<<"You stopped fishing."
		if(IsMining)
			IsMining=0
			usr<<"You stopped mining."
		if(LookingForSeeds)
			LookingForSeeds=0
			usr<<"You stopped looking for seeds."
		if(IsCooking)
			IsCooking=0
			usr<<"You were interrupted."
		if(Creating)
			usr<<"You were interrupted."
			Creating=0
		Save_Location()
		if(client)
			if(!KB && Target && !inertia_dir && istype(Target,/obj/Build))
				Build_Lay(Target,src)

			for(var/obj/items/Transporter_Pad/A in loc) A.Transport()
		if(Shadow) Shadow_Chase(src)//Makes the Shadow follow

mob/proc/Save_Location() if(z&&!Regenerating)
	src.savedX=x
	src.savedY=y
	src.savedZ=z

mob/verb
	lookN()
		set category=null
		set instant=1
		set name=".lookN"
		if(ClashRoll)						return
		if(move==0) return
		dir=1
	lookS()
		set category=null
		set instant=1
		set name=".lookS"
		if(ClashRoll)						return
		if(move==0) return
		dir=2
	lookE()
		set category=null
		set instant=1
		set name=".lookE"
		if(ClashRoll)						return
		if(move==0) return
		dir=4
	lookW()
		set category=null
		set instant=1
		set name=".lookW"
		if(ClashRoll)						return
		if(move==0) return
		dir=8
	lookNE()
		set category=null
		set instant=1
		set name=".lookNE"
		if(ClashRoll)						return
		if(move==0) return
		dir=5
	lookNW()
		set category=null
		set instant=1
		set name=".lookNW"
		if(ClashRoll)						return
		if(move==0) return
		dir=9
	lookSE()
		set category=null
		set instant=1
		set name=".lookSE"
		if(ClashRoll)						return
		if(move==0) return
		dir=6
	lookSW()
		set category=null
		set instant=1
		set name=".lookSW"
		if(ClashRoll)						return
		if(move==0) return
		dir=10



proc/EdgeMovementCheck(turf/atom/T,mob/M)
	M.Spinning=1
	if(T.EdgeSouth == M.dir)
		return 1
	if(T.EdgeWest == M.dir)
		return 1
	if(T.EdgeEast == M.dir)
		return 1
	if(T.EdgeNorth == M.dir)
		return 1
	if(T.EdgeSouthWest == M.dir)
		return 1
	if(T.EdgeSouthEast == M.dir)
		return 1
	if(T.EdgeNorthEast == M.dir)
		return 1
	if(T.EdgeNorthWest == M.dir)
		return 1
	else
		return 0

client/North()
	set instant = 1
	if(ClashRoll)						return
	if(mob.Spinning==0)return
	if(mob.Allow_Move(NORTH)) return ..()
client/South()
	set instant = 1
	if(ClashRoll)						return
	if(mob.Spinning==0)return
	if(mob.Allow_Move(SOUTH)) return ..()
client/East()
	set instant = 1
	if(ClashRoll)						return
	if(mob.Spinning==0)return
	if(mob.Allow_Move(EAST)) return ..()
client/West()
	set instant = 1
	if(ClashRoll)						return
	if(mob.Spinning==0)return
	if(mob.Allow_Move(WEST)) return ..()
client/Northwest()
	set instant = 1
	if(ClashRoll)						return
	if(mob.Spinning==0)return
	if(mob.Allow_Move(NORTHWEST)) return ..()
client/Northeast()
	set instant = 1
	if(ClashRoll)						return
	if(mob.Spinning==0)return
	if(mob.Allow_Move(NORTHEAST)) return ..()
client/Southwest()
	set instant = 1
	if(ClashRoll)						return
	if(mob.Spinning==0)return
	if(mob.Allow_Move(SOUTHWEST)) return ..()
client/Southeast()
	set instant = 1
	if(ClashRoll)						return
	if(mob.Spinning==0)return
	if(mob.Allow_Move(SOUTHEAST)) return ..()




mob/proc/Allow_Move(D)
	if(Frozen) return
	if(KB>1) return
	if(KOd) return
	if(StunCheck(src)) return 0
	if(icon_state in list("KB","Train","Meditate", "KO") || !move || Frozen) return 0
	dir=D
	for(var/Skill/Attacks/A in src) if(A.charging&&A.NoMove||A.streaming||A.Using) return 0
	if(grabberSTR) for(var/mob/A in view(1,usr)) if(A.GrabbedMob==usr&&A.isGrabbing==1)
		if(prob((Str*BP/grabberSTR)+5))
			for(var/mob/MV in view(usr))
				MV.CombatOut("[usr] breaks free of [A]!")
				MV.ICOut("[usr] breaks free of [A]!")
			A.isGrabbing=null
			attacking=0
			A.attacking=0
			grabberSTR=null
		else
			for(var/mob/MV in view(usr)) MV.CombatOut("[usr] struggles against [A]")
		return 0
	else if(S&&S.Fuel>0)
		if(!S.Moving)
			S.Moving=1
			S.MoveReset()
			if(S) if(S.z!=12) S.density=0
			step(S,D)
			if(S)
				if(S.last_move) S.inertia_dir = S.last_move
				if(S.z!=12) S.density=1
				S.Fuel()
		return 0
	for(var/atom/A in get_step(src,D)) if(A.density)
		if(!ghostDens_check(src)&&(!Flying))
			Bump(A)
			return 0
	for(var/mob/A in get_step(src,D)) if(A.Flying&&Flying) if(!ghostDens_check(src))return 0
	for(var/obj/Door/A in get_step(src,D)) if(A.density)
		Bump(A)
		if(!ghostDens_check(src))return 0
	if(!Flying)
		var/turf/T=get_step(src,D)
		if(T)
			if(!T.Enter(src)) return
			for(var/obj/Props/Edges/A in T) if(A.dir in list(turn(D,180),turn(D,225),turn(D,-225))) if(!ghostDens_check(src)&&(!Flying))return 0
			for(var/obj/Props/Edges/A in loc) if(A.dir in list(D,turn(D,45),turn(D,-45))) if(!ghostDens_check(src)&&(!Flying))return 0
	return 1

