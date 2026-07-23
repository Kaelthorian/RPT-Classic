obj/Tech/Stations/Gravity_Generator
	desc="This machine will generate a gravity field around itself."
	Health=100
	density=1
	Savable=1
	Grabbable = 1
	Bolted = 0
	layer = 2
	icon='GravConsole.dmi'

	var/GravityState		=0
	var/GravityOutPut		=1
	var/GravityRange		=1
	var/GravityPower		=0

	verb/Bolt()
		set src in oview(1)
		set category="Station"

		if(!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."
			return
		if(Bolted)
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1
			return
		SaveItem(src)

	verb/Turn_On()
		set src in oview(1)
		set category="Station"

		if(GravityState)
			usr<<"The machine is already on"
			return
		if(!GravityPower)
			usr<<"The machine have no power"
			return
		var/image/I=image(icon='Gravity Field.dmi',layer=MOB_LAYER+1)
		for(var/turf/R in view(src,GravityRange))
			R.Gravity=GravityOutPut
			R.overlays+=I
		GravityState=1
		SaveItem(src)

	verb/Turn_Off()
		set src in oview(1)
		set category="Station"

		var/image/I=image(icon='Gravity Field.dmi',layer=MOB_LAYER+1)
		for(var/turf/R in view(src,GravityRange))
			R.Gravity=1
			R.overlays-=I
		GravityState=0
		SaveItem(src)

	verb/Set_Gravity()
		set src in oview(1)
		set category="Station"

		if(GravityState)return
		GravityOutPut=input("What amount of gravity you want to set it to?") as num
		SaveItem(src)

	verb/Set_Range()
		set src in oview(1)
		set category="Station"

		if(GravityState)return
		GravityRange=input("Whhat range you want to set the field?") as num
		SaveItem(src)