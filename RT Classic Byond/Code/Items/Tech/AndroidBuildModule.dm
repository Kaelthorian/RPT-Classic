obj/items
	Android_Build_Module
		icon = 'Technology64x64.dmi'
		icon_state = "LargeConsole2"
		Health = 10000000000000000000
		//var/Res=3000000
		Bolted = 1
		Grabbable = 0
		density = 1
		verb/Use()
			var/DroidNumber = rand(1,1000)
			set src in range(1,usr)
			if(usr.Race == "Android"|| usr.Rank== "Mainframe")
				switch(input(usr, "Placing 10'000'000 resources into the mainframe will produce an Android and the mothership will store 5'000'000. Are you sure you want to continue?") in list("No", "Yes"))
					if("Yes")
						for(var/obj/Resources/R in usr)
							if(R.Value >= 10000000)
								R.Value -= 10000000
								AndroidRes+=5000000
								var/obj/items/Android_Chassis/AC = new
								AC.name = "Android - [DroidNumber]"
								AC.loc = locate(146,466,9)
								alertAdmins("[key_name(usr)] placed 10'000'000 resources into the [src] and it created an [AC].</b>!")
								view(6)<<"<font color=red> [usr] placed 10'000'000 resources into the [src] and it created a [AC]."
								usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] placed 10'000'000 resources into the [src] and it created a [AC]..\n")
								return