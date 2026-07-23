mob/AdminToggles/verb
	Toggle_LOOC()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/Planets=new
		Planets.Add("Cancel")
		Planets+="Earth"
		Planets+="Namek"
		Planets+="Vegeta"
		Planets+="Arconia"
		Planets+="Ice"
		Planets+="Alien"
		Planets+="DarkPlanet"
		Planets+="Space Station"
		Planets+="The Final Realm"
		Planets+="Android Ship"
		Planets+="Alternate Earth"
		Planets+="EG Tower & Caves"
		Planets+="Space"
		Planets+="Empty Space"
		Planets+="Moons"
		Planets+="HBTC"
		Planets+="Ships/Realms/Majin"
		Planets+="Checkpoint"
		Planets+="Hell"
		Planets+="KS Planet"
		var/Pc=input("Toggle LOOC for what planet?") in Planets
		switch(Pc)
			if("Cancel") return
			if("Earth") looc_1=!looc_1
			if("Namek") looc_2=!looc_2
			if("Vegeta") looc_3=!looc_3
			if("Ice") looc_4=!looc_4
			if("Arconia") looc_5=!looc_5
			if("Dark Planet") looc_6=!looc_6
			if("Space Station") looc_7=!looc_7
			if("The Final Realm") looc_8=!looc_8
			if("Android Ship") looc_9=!looc_9
			if("Alternate Earth") looc_10=!looc_10
			if("EG Tower & Caves") looc_11=!looc_11
			if("Space") looc_12=!looc_12
			if("Empty Space") looc_13=!looc_13
			if("Alien") looc_14=!looc_14
			if("Moons") looc_15=!looc_15
			if("HBTC") looc_16=!looc_16
			if("Ships/Realms/Majin") looc_17=!looc_17
		logAndAlertAdmins("[usr.key] has toggled LOOC for [Pc].",2)