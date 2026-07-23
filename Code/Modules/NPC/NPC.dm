mob/NPC
	Saibamans
		SwimmingInv	= 1
		Saibaman_Blue
			icon	= 'Blue Saiba.dmi'
			BPMod	= 1
			StrMod	= 0.50
			EndMod	= 0.50
			SpdMod	= 0.50
			OffMod	= 0.50
			DefMod	= 0.50

		Saibaman_Brown
			icon	='Brown Saiba.dmi'
			BPMod	= 1
			StrMod	= 0.75
			EndMod	= 0.75
			SpdMod	= 0.75
			OffMod	= 0.75
			DefMod	= 0.75

		Saibaman_Black
			icon	='Dark Saiba.dmi'
			BPMod	= 1
			StrMod	= 4
			EndMod	= 4
			SpdMod	= 4
			OffMod	= 4
			DefMod	= 4

		Saibaman_Pink
			icon	='Pink Saiba.dmi'
			BPMod	= 1
			StrMod	= 3
			EndMod	= 3
			SpdMod	= 3
			OffMod	= 3
			DefMod	= 3

		Saibaman_Red
			icon	='Red Saiba.dmi'
			BPMod	= 1
			StrMod	= 2
			EndMod	= 2
			SpdMod	= 2
			OffMod	= 2
			DefMod	= 2

		Saibaman_Green
			icon	='Green Saiba.dmi'
			BPMod	= 1
			StrMod	= 1
			EndMod	= 1
			SpdMod	= 1
			OffMod	= 1
			DefMod	= 1


mob/NPC/var
	InAction	= 0
	NestID		= 0

mob/NPC/Bump(mob/A)
	AttackProc()

proc
	ActionPointNPC(mob/NPC/R)
		R.BP=MaxBP/2

		if(R.InAction)
			return

		if(R.Target)
			AttackNPC(R)

		if(R.Target)
			MoveToTargetNPC(R)

		if(!R.Target)
			WanderNPC(R)

		if(!R.Target)
			TargetNPC(R)

	WanderNPC(mob/NPC/R)
		R.InAction=1
		if(prob(50))
			step_rand(R)
		R.InAction=0

	AttackNPC(mob/NPC/R)
		R.InAction=1
		if(!R.Target)
			R.InAction=0
			return
		if(R.Target in get_step(R,R.dir))
			R.AttackProc()
		R.InAction=0

	MoveToTargetNPC(mob/NPC/R)
		R.InAction=1
		step_towards(R,R.Target)

		if(R.z!=R.Target.z)
			R.Target=0

		if(R.Target.KOd)
			R.Target=0

		R.InAction=0

	TargetNPC(mob/NPC/R)
		R.InAction=1
		for(var/mob/T in oview(2,R))
			if(!istype(T,/mob/NPC/))
				if(!T.KOd)
					R.Target=T
		R.InAction=0

	WaveAttackNPC()
		var/mob/Target=pick(Players)

		if(Target.KOd||Target.afk)
			return
		else
			return Target




proc/NPCLoop()
	set background = 1
	while(1)

		for(var/mob/NPC/R)
			ActionPointNPC(R)

		sleep(5)



obj/SaibaNest
	icon	= 'SaibaNest.dmi'
	Bolted	= 1

	var
		SaibaIn		= 0
		SaibaTotal	= 0
		NestID		= 0

proc
	NestLoop(var/obj/T)

	SpawnNPC(var/obj/T)
		var/mob/NPC/Saibamans/Saibaman_Green/R = new(T)
		R.BP=MaxBP

	SaibaIn(var/obj/T,mob/NPC/R)




	SaibaOut(var/obj/T,mob/NPC/R)




proc/NPCLoopNest()
	while(1)
		for(var/obj/SaibaNest/T)
			NestLoop(T)
		sleep(5)



