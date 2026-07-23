/client/proc/Set_Spawns()
	set category="Admin"
	set name = "Set Spawns"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/list/Choices=new
	Choices.Add("Human","Kanassa","Yardrat","Saiyan","Changeling","Oni","Makyo","Namek","Tuffle","Demigod","Dead People","Heran","Alien","Demon","Kaio", "Cancel")

	switch(input("Choose a spawn to set") in Choices)
		if("Cancel")
			return
		if("Dead People")
			var/X = input(usr,"Enter the X location for the dead people spawn.") as num
			var/Y = input(usr,"Enter the Y location for the dead people spawn.") as num
			var/Z = input(usr,"Enter the Z location for the dead people spawn.") as num
			if(!usr.Confirm("Set the Dead People spawn to [X], [Y], [Z]?")) return
			DEADX=X
			DEADY=Y
			DEADZ=Z
			Save_Spawns()
			logAndAlertAdmins("[key_name(usr)] set the Kaio / Demon / Souls spawn to be [X],[Y],[Z].")
		if("Human")
			var/X = input(usr,"Enter the X location for the Human spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Human spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Human spawn.") as num
			HumanSpawn="[X],[Y],[Z]"
		if("Kanassa")
			var/X = input(usr,"Enter the X location for the Kanassa spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Kanassa spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Kanassa spawn.") as num
			KanassaSpawn="[X],[Y],[Z]"
		if("Yardrat")
			var/X = input(usr,"Enter the X location for the Yardrat spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Yardrat spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Yardrat spawn.") as num
			YardratSpawn="[X],[Y],[Z]"
		if("Demigod")
			var/X = input(usr,"Enter the X location for the Demigod spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Demigod spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Demigod spawn.") as num
			DemigodSpawn="[X],[Y],[Z]"
		if("Oni")
			var/X = input(usr,"Enter the X location for the Oni spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Oni spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Oni spawn.") as num
			OniSpawn="[X],[Y],[Z]"
		if("Alien")
			var/X = input(usr,"Enter the X location for the Alien spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Alien spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Alien spawn.") as num
			AlienSpawn="[X],[Y],[Z]"
		if("Tuffle")
			var/X = input(usr,"Enter the X location for the Tuffle spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Tuffle spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Tuffle spawn.") as num
			TuffleSpawn="[X],[Y],[Z]"
		if("Namek")
			var/X = input(usr,"Enter the X location for the Namek spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Namek spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Namek spawn.") as num
			NamekianSpawn="[X],[Y],[Z]"
		if("Saiyan")
			var/X = input(usr,"Enter the X location for the Saiyan spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Saiyan spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Saiyan spawn.") as num
			SaiyanSpawn="[X],[Y],[Z]"
		if("Changeling")
			var/X = input(usr,"Enter the X location for the Icer spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Icer spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Icer spawn.") as num
			IcerSpawn="[X],[Y],[Z]"
		if("Heran")
			var/X = input(usr,"Enter the X location for the Heran spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Heran spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Heran spawn.") as num
			HeranSpawn="[X],[Y],[Z]"
		if("Makyo")
			var/X = input(usr,"Enter the X location for the Makyo spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Makyo spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Makyo spawn.") as num
			MakyoSpawn="[X],[Y],[Z]"
		if("Demon")
			var/X = input(usr,"Enter the X location for the Demon spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Demon spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Demon spawn.") as num
			DemonSpawn="[X],[Y],[Z]"
		if("Kaio")
			var/X = input(usr,"Enter the X location for the Kaio spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Kaio spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Kaio spawn.") as num
			KaioSpawn="[X],[Y],[Z]"
	Save_Spawns()