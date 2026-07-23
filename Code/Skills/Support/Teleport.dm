Skill/Support/Teleport

	desc="Teleport to any planet instantly. This will drain all your energy. Anyone who is beside \
	you will be taken with you if Realm Teleport is enabled. (Once every 3 years. Grab chains are not allowed and anyone abusing this will be stripped of their rank.)"
	var/LastUse=0
	verb/Realm_Teleport()
		set category="Other"
		if(usr.RPMode) return
		/*if(usr.z==8)
			usr<<"You can not teleport out of this place."
			return*/
		if(usr.MaxKi<3000)
			usr<<"You do not have enough energy to use this."
			return
		if(usr.Ki<usr.MaxKi)
			usr<<"You need full energy to use this."
			return
		var/list/Planets=new
		Planets.Add("Cancel","Afterlife")
		if(usr.KPAuthorized) Planets.Add("???")
		if(RealmTeleport||usr.IgnoreRealmTeleport) Planets.Add("Arconia","Earth","Namek","Vegeta","Ice","Desert","Jungle","Alien","Ocean","Dark Planet")
		//else if(usr.RPPower>1.2) Planets.Add("Arconia","Earth","Namek","Vegeta","Ice","Desert","Jungle","Alien")
		var/image/I=image(icon='Black Hole.dmi',icon_state="full")
		I.icon+=rgb(rand(0,255),rand(0,255),rand(0,255))
		var/CHOICE=input("Choose a realm") in Planets
		if(CHOICE!="Afterlife"&&CHOICE!="???"&&CHOICE!="Cancel")
			if(Year<LastUse+1)
				usr<<"You cannot use this until year [LastUse+1] you last used it."
				return
			if(Year<5)
				usr<<"You must wait until atleast Year 5 to Teleport."
				return
		switch(CHOICE)
			if("Afterlife")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(245,119,8)
				CHOICE="Afterlife"
			if("Arconia")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(364,253,5)
				CHOICE="Arconia"
				LastUse=Year
			if("Earth")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,1)
				CHOICE="Earth"
				LastUse=Year
			if("Namek")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(279,372,2)
				CHOICE="Namek"
			if("Vegeta")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(333,462,3)
				CHOICE="Vegeta"
				LastUse=Year
			if("Ice")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(246,227,4)
				CHOICE="Ice"
			if("Desert")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(112,123,14)
				CHOICE="Desert"
				LastUse=Year
			if("Jungle")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(108,370,14)
				CHOICE="Jungle"
				LastUse=Year
			if("Android")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(238,429,9)
				CHOICE="Android"
				LastUse=Year
			if("Alien")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(342,79,14)
				CHOICE="Alien"
				LastUse=Year
			if("Dark Planet")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(290,107,6)
				CHOICE="Dark Planet"
				LastUse=Year
			if("???")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(400,400,10)
				CHOICE="???"
				LastUse=Year
			if("Cancel") return
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Kaio Teleport to go to planet [CHOICE].\n")
		usr.Ki=0

Skill/Support/DemonTeleport

	desc="Teleport to any planet instantly. This will drain all your energy. Anyone who is beside uou will be taken with you if Makyo Star is  enabled. (3 Year CD. When the Makyo Star is NOT out, you must grab the other person. Grab chains are not allowed and anyone abusing this will be stripped of their rank.)"
	var/LastUse=0
	verb/Realm_Teleport()
		set category="Other"
		if(usr.RPMode) return
		if(usr.z==8)
			usr<<"You can not teleport out of this place."
			return
		if(usr.MaxKi<3000)
			usr<<"You do not have enough energy to use this."
			return
		if(usr.Ki<usr.MaxKi)
			usr<<"You need full energy to use this."
			return
		var/list/Planets=new
		Planets.Add("Cancel","Afterlife","Hell","Arconia","Earth","Namek","Vegeta","Ice","Desert","Jungle","Alien","Ocean","Dark Planet")
		var/image/I=image(icon='Black Hole.dmi',icon_state="full")
		I.icon+=rgb(rand(0,255),rand(0,255),rand(0,255))
		var/CHOICE=input("Choose a realm") in Planets
		if(CHOICE!="Afterlife"&&CHOICE!="???"&&CHOICE!="Cancel"&&CHOICE!="Hell")
			if(Year<LastUse+2)
				usr<<"You cannot use this until year [LastUse+2] after you last used it."
				return
			if(Year<5)
				usr<<"You must wait until atleast Year 5 to Teleport."
				return
		switch(CHOICE)
			if("Afterlife")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(245,119,18)
				CHOICE="Afterlife"
			if("Hell")
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(254,255,19)
				CHOICE="Afterlife"
			if("Arconia")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(364,253,5)
				CHOICE="Arconia"
				LastUse=Year
			if("Earth")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,1)
				CHOICE="Earth"
				LastUse=Year
			if("Namek")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(279,372,2)
				CHOICE="Namek"
			if("Vegeta")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(333,462,3)
				CHOICE="Vegeta"
				LastUse=Year
			if("Ice")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(246,227,4)
				CHOICE="Ice"
			if("Desert")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(112,123,14)
				CHOICE="Desert"
				LastUse=Year
			if("Jungle")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(108,370,14)
				CHOICE="Jungle"
				LastUse=Year
			if("Ocean")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(370,80,14)
				CHOICE="Jungle"
				LastUse=Year
			if("Android")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(238,429,9)
				CHOICE="Android"
				LastUse=Year
			if("Alien")
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(342,79,14)
				CHOICE="Alien"
				LastUse=Year
			if("Dark Planet")
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(290,107,6)
				CHOICE="Dark Planet"
				LastUse=Year
			if("Cancel") return
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Demon Teleport to go to planet [CHOICE].\n")
		usr.Ki=0