turf/Del()
	var/Type=type
	if(InitialType) Type=InitialType
	spawn InitialType=Type
	Builder=null
	if(Turfs) Turfs-=src
	//if(!Turfs|!Turfs.len) Turfs=null
	..()
turf/var/InitialType

var
	Earth=1
	EarthMoon=1
	Namek=1
	Vegeta=1
	VegetaMoon=1
	Arconia=1
	ArconiaMoon=1
	Ice=1
	IceMoon=1
	Desert=1
	Jungle=1
	Android=1
	Alien = 1
	AlienMoon=1
	SpaceStation=1
	Ocean=1
	DarkPlanet=1



turf
	proc
		Wave(var/Amount,var/Chance)
			spawn if(src) while(Amount)
				Amount-=1
				for(var/turf/T in oview(src,5))
					if(prob(10)&&!T.density&&!T.Water)FightingDirt(T)
					if(prob(Chance)) spawn(rand(0,10)) missile(pick('Haze.dmi','Electric_Blue.dmi','Dust.dmi'),src,T)
				sleep(3)

/turf/meltingrock
	name = "Super-heated rock"
	icon = 'nuclearfire.dmi'
	icon_state = "1"
	Buildable = 0
	New()
		icon_state = pick("1", "2", "3")
		dir = pick(cardinal)
		spawn(rand(16,64))
			var/turf/moltenrock/rock = new /turf/moltenrock(locate(src.x,src.y,src.z))
			Turfs-=src
			Turfs+=rock
		..()
/turf/moltenrock
	name = "Super-heated rock"
	icon = 'Turfs1.dmi'
	icon_state = "lava"
	Buildable = 0
	New()
		icon_state = pick("lava", "lava2", "lava3", "lava4", "lava5", "ash", "ash2", "ash3", "ash4", "ash5")
		..()
obj/Lightning_Strike
	Savable=0
	var/Power = 0
	var/Dest = null
	density = 0
	New()
		var/image/A=image(icon='Lightning Strike.dmi',icon_state="Front",layer=99)
		var/image/B=image(icon='Lightning Strike.dmi',pixel_y=32,layer=99)
		var/image/C=image(icon='Lightning Strike.dmi',pixel_y=64,layer=99)
		var/image/D=image(icon='Lightning Strike.dmi',pixel_y=96,icon_state="End",layer=99)
		overlays.Add(A,B,C,D)
		spawn()
//			hearers(12,src) << 'lightning01.wav'
			src.Bolt()
		if(!src.Power) spawn(150) if(src) del(src)
	proc
		Bolt()
			set waitfor=0
			if(src.z) src.loc = locate(src.x,src.y-1,src.z)
			if(src.loc == src.Dest)
				Crater(src)
				for(var/obj/O in range(0,src))
					if(O != src)
						O.TakeDamage(src, 100, "Lightning")
						if(istype(O,/obj/Door)) O.TakeDamage(src, src.Power*10, "Lightning")
						if(O.Flammable)
							O.Burning = 1
							O.Burn(O.Health)
						if(O.Health <= 1) del(O) // Mumit attempt to fix infinite fire
				for(var/mob/M in range(0,src))
					M.TakeDamage(src, (Power)/(M.BP), "Lightning")
				var/turf/T = src.loc
				if(T) T.Wave(1,5)
				del(src)
			sleep(1)
			spawn(0) if(src) src.Bolt()
/*
Skill/Misc/Planet_Destroy
	desc="This will destroy an entire planet. Don't use it without a really good reason."
	verb/Planet_Destroy()
		set category="Other"
		if(usr.RPMode) return
		if(!(usr.z in list(1,2,3,4,5,7)))
			usr<<"Ahelp to destroy this."
			return
		if(usr.z==1&&!Earth) return
		if(usr.z==2&&!Namek) return
		if(usr.z==3&&!Vegeta) return
		if(usr.z==5&&!Arconia) return
		if(usr.z==4&&!Ice) return
		if(usr.z==6&&!DarkPlanet) return
		if(usr.z==7&&!SpaceStation) return
		switch(input("Destroy the planet?") in list("No","Yes"))
			if("Yes")
				alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has started Planet Destroy  on [usr.z == 1 ? "Earth" : usr.z == 2 ? "Namek" : usr.z == 3 ? "Vegeta" : usr.z == 5 ? "Ice" : usr.z ==6?"Dark Planet" : usr.z==7 ? "Space Station" : "Not somewhere they're supposed to! WTF?" ].")
				Crater(usr)
				spawn Destroy_Planet(usr.z)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has started Planet Destroy on [usr.z == 1 ? "Earth" : usr.z == 2 ? "Namek" : usr.z == 3 ? "Vegeta" : usr.z == 5 ? "Ice" : usr.z ==6?"Dark Planet" : usr.z==7 ? "Space Station" : "Not somewhere they're supposed to! WTF?" ].\n")
*/


