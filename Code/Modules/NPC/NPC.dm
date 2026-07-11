mob/NPC/proc
	NPCCount()
		for(var/obj/Nest/S)
			if(S.AmountOfNPCInside<S.AmountOfNPCMax)
				S.AmountOfNPCInside++

	NPCSpawn()
		for(var/obj/Nest/R)
			for(var/mob/M in oview(R,3))
				while(R.AmountOfNPCInside>R.AmountOfNPCOutside)
					var/mob/NPC/N = new(R)
					N.loc=R.loc
					R.AmountOfNPCInside--
					sleep(20)



mob/NPC
	Test
		icon


obj/Nest
	desc		="A nest of some sort , it smells like something live in there"
	icon		='ForceFieldGen.dmi'
	Health		=1.#INF
	density 	=1
	Savable 	=1
	Grabbable	=0

	var/AmountOfNPCMax
	var/AmountOfNPCInside
	var/AmountOfNPCOutside