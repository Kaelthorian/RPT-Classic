obj/items/HealingPylon
	desc="This will emit a healing burst once every minute."
	Health=1500
	density=1
	Savable=1
	Grabbable=0
	Grabbable = 1
	pixel_x=-66
	Bolted = 1
	layer = 2
	icon='Orb_of_Conquests-1.dmi'
	var/HealLoop=0
	verb/Activate()
		set src in view(1)
		if(!HealLoop)
			HealLoop=1
			HealingBurst()
			view(usr)<<"[src] activated."
	verb/Deactivate()
		set src in view(1)
		if(HealLoop)
			HealLoop=0
			view(usr)<<"[src] deactivated."
	proc/HealingBurst() while(src)
		view(src)<<"<font color=#FFFF00>[src] emits a healing burst."
		animate(src, icon_state="Capturing", time = 20)
		for(var/mob/A in view(src,5)) if(A.client)
			if(A.Willpower<=0) A.WillpowerRestore()
			if(A.Willpower<A.MaxWillpower&&A.Willpower>0) A.Willpower++
			if(A.KOd) A.Un_KO()
			A.Health += 20
			A.overlays+='Nanites.dmi'
			spawn(5) A.overlays-='Nanites.dmi'
			A.BuffOut("The [src] heals you.")
			if(A.Health>A.Willpower) A.Health=A.Willpower
			for(var/BodyPart/P in A)
				if(usr.Magic_Level>70)  if(P.Health<=P.MaxHealth) A.Injure_Heal(25,P,1)
				else  if(P.Health<=P.MaxHealth) A.Injure_Heal(20,P)
//			A.Heal_Zenkai()
		animate(src, icon_state="", time = 0)
		sleep(600)