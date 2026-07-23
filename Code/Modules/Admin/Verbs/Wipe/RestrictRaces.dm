mob/Admin3/verb
	Restrict_Races()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/Choice=input(usr,"Which race would you like to toggle?") in list("Saiyan","Human","Tuffle","Makyo","Spirit Doll","Namekian","Changeling","Android","Oni","Demon","Kaio","Demigod","Alien","Elite","Heran","Cancel")
		if(Choice=="Cancel") return
		var/result=5
		switch(Choice)
			if("Saiyan") if(usr.Confirm("Toggle [Choice]? (Currently [AllowSaiyan])"))
				AllowSaiyan=!AllowSaiyan
				result=AllowSaiyan
			if("Tuffle") if(usr.Confirm("Toggle [Choice]? (Currently [AllowTuffle])"))
				AllowTuffle=!AllowTuffle
				result=AllowTuffle
			if("Makyo") if(usr.Confirm("Toggle [Choice]? (Currently [AllowMakyo])"))
				AllowMakyo=!AllowMakyo
				result=AllowMakyo
			if("Spirit Doll") if(usr.Confirm("Toggle [Choice]? (Currently [AllowSD])"))
				AllowSD=!AllowSD
				result=AllowSD
			if("Namekian") if(usr.Confirm("Toggle [Choice]? (Currently [AllowNamek])"))
				AllowNamek=!AllowNamek
				result=AllowNamek
			if("Changeling") if(usr.Confirm("Toggle [Choice]? (Currently [AllowChangeling])"))
				AllowChangeling=!AllowChangeling
				result=AllowChangeling
			if("Android") if(usr.Confirm("Toggle [Choice]? (Currently [AllowAndroid])"))
				AllowAndroid=!AllowAndroid
				result=AllowAndroid
			if("Oni") if(usr.Confirm("Toggle [Choice]? (Currently [AllowOni])"))
				AllowOni=!AllowOni
				result=AllowOni
			if("Demon") if(usr.Confirm("Toggle [Choice]? (Currently [AllowDemon])"))
				AllowDemon=!AllowDemon
				result=AllowDemon
			if("Kaio") if(usr.Confirm("Toggle [Choice]? (Currently [AllowKaio])"))
				AllowKaio=!AllowKaio
				result=AllowKaio
			if("Demigod") if(usr.Confirm("Toggle [Choice]? (Currently [AllowDemigod])"))
				AllowDemigod=!AllowDemigod
				result=AllowDemigod
			if("Alien") if(usr.Confirm("Toggle [Choice]? (Currently [AllowAlien])"))
				AllowAlien=!AllowAlien
				result=AllowAlien
			if("Elite") if(usr.Confirm("Toggle [Choice]? (Currently [AllowElite])"))
				AllowElite=!AllowElite
				result=AllowElite
			if("Human") if(usr.Confirm("Toggle [Choice]? (Currently [AllowHuman])"))
				AllowHuman=!AllowHuman
				result=AllowHuman
			if("Heran") if(usr.Confirm("Toggle [Choice]? (Currently [AllowHeran])"))
				AllowHeran=!AllowHeran
				result=AllowHeran
		if(result!=5) logAndAlertAdmins("[src.key] Toggled [Choice] spawning to [result]",2)