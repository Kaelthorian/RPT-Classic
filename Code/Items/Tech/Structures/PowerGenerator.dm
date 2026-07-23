obj/Tech/Stations/var/Power
obj/Tech/Stations/Power_generator
	desc="This machine power up everything in a given range."
	Health=100
	density=1
	Savable=1
	Grabbable = 1
	Bolted = 0
	layer = 2
	icon='GravConsole.dmi'

	var/PowerGen=0

	verb/Turn_On()
		set src in oview(1)
		set category="Station"
		if(!PowerGen)
			for(var/obj/Tech/Stations/R in view(src,5))
				R.Power=1
				SaveItem(R)
			PowerGen=1
			SaveItem(src)

	verb/Turn_Off()
		set src in oview(1)
		set category="Station"
		if(PowerGen)
			for(var/obj/Tech/Stations/R in view(src,5))
				R.Power=0
				SaveItem(R)
			PowerGen=0
			SaveItem(src)
