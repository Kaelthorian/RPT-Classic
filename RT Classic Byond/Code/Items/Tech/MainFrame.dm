obj/items
	Main_Frame
		icon = 'Technology64x64.dmi'
		icon_state = "LargeConsole1"
		Health = 10000000000000000000
		//var/Res=3000000
		Bolted = 1
		Grabbable = 0
		density = 1
		Click()
			usr<<"The Android Ship has [AndroidRes] remaining resources."
			if(src in range(1,usr))
				for(var/obj/items/I in src)
					I.loc = usr.loc
					view(6,usr) << "[usr] removes a [I] from [src]."
					alertAdmins("[key_name(usr)] removed a [I] from [src]</b>!")
//					hearers(6,usr) << 'pop.wav'
					break
		verb/Use()
			set src in range(1,usr)
			if(usr.Race == "Android")
				switch(input(usr, "Placing 10'000'000 resources into the mainframe will produce an Android Upgrade Component and the mothership will store 5'000'000. Are you sure you want to continue?") in list("No", "Yes"))
					if("Yes")
						for(var/obj/Resources/R in usr)
							if(R.Value >= 10000000)
								R.Value -= 10000000
								AndroidRes+=5000000
								var/obj/items/Android_Upgrade/AU = new
								AU.loc = usr.loc
								alertAdmins("[key_name(usr)] placed 10'000'000 resources into the [src] and it created a [AU].</b>!")
								view(6)<<"<font color=red> [usr] placed 10'000'000 resources into the [src] and it created a [AU]."
								usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] placed 10'000'000 resources into the [src] and it created a [AU]..\n")
								return