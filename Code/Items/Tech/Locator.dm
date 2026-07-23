obj/items
	Locator
		icon='Cell Phone.dmi'
		desc="Use this to detect where your drills or pylons are located."
		verb/Locate()
			if(usr.CanPing)
				usr.CanPing=0
				spawn(100) usr.CanPing=1
				for(var/obj/Mana_Pylon/MP) if(MP.Builder=="[ckey(usr.key)]") usr<<"Pylon located at: [MP.x], [MP.y], [MP.z]"
				for(var/obj/Drill/MP) if(MP.Builder=="[ckey(usr.key)]") usr<<"Drill located at: [MP.x], [MP.y], [MP.z]"
			else usr<<"You must wait."
