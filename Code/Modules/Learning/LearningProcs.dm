mob/proc/Remove_Duplicate_Moves()
	var/tmp/list/Moves=new
	for(var/Skill/O in src) if(!istype(O,/Skill))
		for(var/Skill/Oo in src) if(Oo!=O) if(Oo.type==O.type) del(Oo)
		if(O.type in Moves) del(O)
		else if(O in Moves) del(O)
		else Moves+=O.type
	var/tmp/list/Langs=new
	for(var/Language/L in src)
		for(var/Language/Oo in src) if(Oo!=L) if(Oo.type==L.type) if(Oo.ID==L.ID) del(Oo)
		if(L.type in Langs) del(L)
		else if(L in Langs) del(L)
		else Langs+=L.type

proc/MPGiver(var/mob/W,CC)
	for(var/TT in W.vars)
		if(TT==CC)
			W.vars[TT] = 1
			return

proc/SkillCheckLearning(mob/Q,var/Skill/K)
	var/SkillCheck=0
//	world<<"Skill Check"
	for(var/R in Q.contents)
		if(istype(R,K))
			SkillCheck=1
//			world<<"Skill No [K]"

	if(SkillCheck==0)
		Q.contents+=K
//		world<<"Skill [K]"
