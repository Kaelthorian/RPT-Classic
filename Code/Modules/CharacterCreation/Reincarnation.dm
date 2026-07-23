var/list/Reincarnations=new
var/Reincarnation_Status = "Off"
obj/ReincarnationObj
	var/EXP

mob/proc/Reincarnation()
	var/obj/ReincarnationObj/A=new
	RemoveBuffs()
	A.name					=key
	A.EXP					=round(EXPLifetime*0.7)

	Reincarnations += A

	var/mob/player/B = new
	B.key=key
	client.Choose_Login()
	//spawn del(src)

mob/var/Reincarnated=0

mob/proc/Check_Incarnates() for(var/obj/ReincarnationObj/A in Reincarnations) if(A.name==key)
	EXP						=A.EXP
	EXPLifetime				=EXP

	Reincarnated=1
	Body()
	del(A)


Skill/Support/Reincarnate

	desc="This can be used to reincarnate someone into an entirely different race, but they keep their \
	stats, but they are reproportioned to match the new mods of that race."
	verb/Reincarnate(mob/M in oview(1,usr))
		set src=usr.contents
		set category="Skills"
		if(usr.RPMode) return
		switch(input(M,"[usr] has offered to help reincarnate you into another body and mind, this will purify your spirit and erase your memories, starting your life in the living world all over again. You will keep your power and some of your skills, but re-proportioned for the new race you choose. If you hit yes it will be too late to turn back. Do you want to do this?") in list("No","Yes"))
			if("Yes")
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has reincarnated [key_name(M)]")
				alertAdmins("[key_name(usr)] has reincarnated [key_name(M)]")
				view(usr) << "[usr] has reincarnated [M]"
				M.Reincarnation()
			if("No") view(M) << "[M] declined reincarnation from [usr]"

mob/proc/DeathBasedReincarnation()
	switch (input(src,"You have died more than twice and your soul is now too weak to continue living. Would you like to continue on to the Final Realms, or reincarnate to a new character?") in list("Continue to the Final Realms","Reincarnate to a New Character"))
		if("Reincarnate to a New Character")
			Reincarnation()
			logAndAlertAdmins("[key_name(src)] died and went to the TFR and chose to reincarnate.")
		if("Continue to the Final Realms")
			for(var/mob/M in Players) if(M.client && M.client.holder) M.AllOut("<b><font color=red>(Reincarnation)</font color> <A HREF='?src=\ref[M.client.holder];privatemessage=\ref[src]'>[src.key]</a href>(<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>) : Died and went to TFR and did not reincarnate</b>")


mob/proc/NewGameReincarnation()
	switch (input(src,"Would you like to continue on to the Final Realms, or reincarnate to a new character?") in list("Continue to the Final Realms","Reincarnate to a New Character"))
		if("Reincarnate to a New Character")
			Reincarnation()
			logAndAlertAdmins("[key_name(src)] died and went to the TFR and chose to reincarnate.")
		if("Continue to the Final Realms")
			for(var/mob/M in Players) if(M.client && M.client.holder) M.AllOut("<b><font color=red>(Reincarnation)</font color> <A HREF='?src=\ref[M.client.holder];privatemessage=\ref[src]'>[src.key]</a href>(<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>) : Died and went to TFR and did not reincarnate</b>")