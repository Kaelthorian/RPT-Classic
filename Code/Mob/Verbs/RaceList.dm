/mob/verb/
	Races()
		//set category="Other"
		var/HigestNumber= 0
		var/Saiyan		= 0
		var/Tuffle		= 0
		var/Human		= 0
		var/SD			= 0
		var/Namek		= 0
		var/Changeling	= 0
		var/Android		= 0
		var/Oni			= 0
		var/Demon		= 0
		var/Kaio		= 0
		var/Demigod		= 0
		var/Alien		= 0
		var/Heran		= 0
		var/Yardrat		= 0
		var/Kanassa		= 0
		var/Makyo		= 0

		for(var/mob/player/S in Players)
			if(S.Race== "Saiyan")
				Saiyan++
			if(S.Race== "Tuffle")
				Tuffle++
			if(S.Race== "Human")
				Human++
			if(S.Race== "Makyo")
				Makyo++
			if(S.Race== "SD")
				SD++
			if(S.Race== "Namek")
				Namek++
			if(S.Race== "Changeling")
				Changeling++
			if(S.Race== "Android")
				Android++
			if(S.Race== "Oni")
				Oni++
			if(S.Race== "Demon")
				Demon++
			if(S.Race== "Kaio")
				Kaio++
			if(S.Race== "Demigod")
				Demigod++
			if(S.Race== "Alien")
				Alien++
			if(S.Race== "Heran")
				Heran++
			if(S.Race== "Yardrat")
				Yardrat++
			if(S.Race== "Kanassa")
				Kanassa++

		HigestNumber = max(Saiyan,Tuffle)

		usr.AllOut("[A.HigestNumber]")
