obj/items/Stud_Finder
	icon='Lab.dmi'
	icon_state="Panel1"
	desc="Tells you the health remaining on a door, roof or wall."
	verb/Detect()
		if(usr.CanPing)
			usr.CanPing=0
			for(var/obj/Door/A in get_step(usr,usr.dir)) range(5,usr) << "(Door) Stud Finder: [A] has [A.Health] remaining."
			var/turf/T=get_step(usr,usr.dir)
			if(istype(T,/turf/Upgradeable)) range(5,usr) << "Stud Finder: [T] has [T.Health] remaining."
			spawn(20) usr.CanPing=1
		else usr<<"On cool down."