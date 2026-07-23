mob/Admin2/verb
	Destroy_Planet()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/PlanetCs=list()
		if(Alien)PlanetCs+="Alien"
		if(Desert)PlanetCs+="Desert"
		if(Jungle)PlanetCs+="Jungle"
		if(Ocean)PlanetCs+="Ocean"
		if(DarkPlanet) PlanetCs+="DarkPlanet"
		if(Earth) PlanetCs+="Earth"
		if(Namek) PlanetCs+="Namek"
		if(Vegeta) PlanetCs+="Vegeta"
		if(Arconia) PlanetCs+="Arconia"
		if(Ice) PlanetCs+="Ice"
		if(SpaceStation) PlanetCs+="Space Station"
		if(AlienMoon)PlanetCs+="AlienMoon"
		if(EarthMoon)PlanetCs+="EarthMoon"
		if(ArconiaMoon)PlanetCs+="ArconiaMoon"
		if(IceMoon)PlanetCs+="IceMoon"
		if(VegetaMoon)PlanetCs+="VegetaMoon"
		PlanetCs+="Cancel"
		var/Planet=input("Destroy which alien planet or moon?") in PlanetCs
		if(!Confirm("Destroy [Planet]?")) return
		switch(Planet)
			if("Earth")
				Earth=0
				for(var/obj/Planets/Earth/A) del(A)
			if("Namek")
				Namek=0
				for(var/obj/Planets/Namek/A) del(A)
			if("Vegeta")
				Vegeta=0
				for(var/obj/Planets/Vegeta/A) del(A)
			if("Arconia")
				Arconia=0
				for(var/obj/Planets/Arconia/A) del(A)
			if("Ice")
				Ice=0
				for(var/obj/Planets/Ice/A) del(A)
			if("Dark Planet")
				DarkPlanet=0
				for(var/obj/Planets/DarkPlanet/A) del(A)
			if("Space Station")
				SpaceStation=0
				for(var/obj/Planets/SpaceStation/A) del(A)
			if("Alien")
				Alien=0
				for(var/obj/Planets/Alien/A) del(A)
			if("Desert")
				Desert=0
				for(var/obj/Planets/Desert/A) del(A)
			if("Jungle")
				Jungle=0
				for(var/obj/Planets/Jungle/A) del(A)
			if("Ocean")
				Ocean=0
				for(var/obj/Planets/Ocean/A) del(A)
			if("AlienMoon")
				AlienMoon=0
				for(var/obj/Planets/AlienMoon/A) del(A)
			if("EarthMoon")
				EarthMoon=0
				for(var/obj/Planets/EarthMoon/A) del(A)
			if("ArconiaMoon")
				ArconiaMoon=0
				for(var/obj/Planets/ArconiaMoon/A) del(A)
			if("IceMoon")
				IceMoon=0
				for(var/obj/Planets/IceMoon/A) del(A)
			if("VegetaMoon")
				VegetaMoon=0
				for(var/obj/Planets/VegetaMoon/A) del(A)
		log_admin("[key_name(usr)] destroyed [Planet]. (Only deletes planet obj in space)")
		alertAdmins("[key_name_admin(usr)] destroyed [Planet]. (Only deletes planet obj in space)", 1)