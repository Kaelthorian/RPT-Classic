mob/proc/AssignRaceStats()
	KBResist=0
	FBMAchieved=0
	switch(Race)
//		if("Android") Android(1)
		if("Human") Human(1)
		if("Majin") Majin(1)
		if("Bio-Android") Bio(1)
		if("Demigod") Demigod(1)
		if("Makyojin") Makyojin(1)
		if("Kaio") Kaio(1)
//		if("Spirit Doll") Doll(1)
		if("Tuffle") Tuffle(1)
		if("Oni") Oni(1)
		if("Changeling")
			switch(Class)
				if("Cooler") Cooler(1)
				if("King Kold") Kold(1)
				if("Undefined Class") Changeling(1)
		if("Demon") Demon(1)
//		if("Alien") Alien(1)
		if("Heran") SpacePirate(1)
		if("Yardrat") Yardrat(1)
		if("Kanassa") Kanassa(1)
		if("Namekian")
			if(Class=="Ancient") AncientNamekian(1)
			else Namekian(1)
		if("Saiyan")
			if(Class=="Legendary") LSSJ(1)
			else Low(1)






