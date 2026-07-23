mob/verb/AFK()
	//set category = "Other"
	usr.TRIGGER_AFK()

mob/proc/AFKAdd()
		var/image/_overlay = image('afktag.dmi',layer=MOB_LAYER+EFFECTS_LAYER+1) // In order to get pixel offsets to stick to overlays we create an image
		overlays += _overlay
mob/proc/AFKRemove()
		var/image/_overlay = image('afktag.dmi',layer=MOB_LAYER+EFFECTS_LAYER+1) // not sure if the equipped thing is an icon/object so
		overlays -= _overlay
mob/proc/TRIGGER_AFK(var/A=0)
	if(src.insideTank)
		src << "Unable to go afk inside a cloning tank."
		return
	/*if(src.insidePhylactery)
		src << "Unable to go afk while using a Phylactery."
		return*/
	if(src.afk)
		/*for(var/obj/Rank/R in Rankings)
			if(R.Rank_Key)
				var/mob/M = null
				if(src.key == R.Rank_Key)
					M = src
				if(M)
					if(istext(R.Rank_AFK)) R.Rank_AFK = 0
					R.Rank_AFK_Total += R.Rank_AFK
					R.Rank_AFK = 0*/
		view(15) << "<span class=announce>[src.name] came back from AFK.</span>"
		AFKRemove()
		src.afk=0
		usr.saveToLog("[src] has returned from AFK!")
		//src.name=copytext(name,7,0)
		return
	if(src.afk==0)
		AFKAdd() // overlays the AFK image on player
		src.afk=1 // so it can effect it when they press AFK again and makes them immobile
		src.Went_Afk = 1
		spawn(100)
			if(src) src.Went_Afk = 0
		for(var/mob/player/M in view(15))
			if(M.client)
				if(A)
					M<<"<span class=announce>[src] has automatically been set to AFK!</span>"
				else
					M<<"<span class=announce>[src] has set themselves to AFK!</span>"
		if(A) saveToLog("[src] has automatically been set to AFK!")
		else saveToLog("[src] has set themselves to AFK!")

		//src.name="(AFK) [src.name]"
		return