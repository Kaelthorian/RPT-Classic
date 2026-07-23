mob/var/tmp/Watching

/mob/verb/LookAround()
	set category = "Other"
	if(src.Watching)
		src.Watching=0
		for(var/mob/player/M in Players) if(M.Observer==usr.key) M.Observer=null
		src.reset_view(null)
		usr << "You stop watching."
		return
	var/mob/A=input(usr,"Choose someone to observe.") as mob in oviewers(20)
	if(A==usr.name || !A)
		usr<<"There is no one to watch."
		return
	usr << "You are now watching [A]."
	A<<"You feel how [usr.name] is watching."
	usr.LookAroundProc(A)


mob/proc/LookAroundProc(mob/M)
	if(M==src)
		//Observee=null
		for(var/mob/player/MM in Players)
			if(MM.Observer==usr.key)
				MM.Observer=null
		src.reset_view(null)//client.eye=src
	else
		src.reset_view(M)

	src.Watching=1
	while(src.Watching)
		if((M in oviewers(40,src))==0)
			src.Watching=0
			src.reset_view(null)
			for(var/mob/player/E in Players) if(E.Observer==usr.key) E.Observer=null
			usr<<"You lost the line of sight"
		sleep(10)