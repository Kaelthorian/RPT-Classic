obj/items
	Security_Camera
		desc="This is a Security Camera. A frequency can be set, along with a password. Can be observed using a Security Monitor."
		layer=MOB_LAYER+10
		Health=100000
		icon='tech security systems.dmi'
		icon_state="camera"
		//var/display = 1
		Frequency=100
		Savable = 1
		Click()
			if(usr.client.eye==src)
				usr.reset_view()
				return
			/*if(src.Bolted)
				for(var/obj/items/Scanner/B in usr)
					if(B.Frequency&&B.Frequency==src.Frequency&&B.suffix)
						switch(input(usr, "Do you want to snap your view to this camera or toggle the display on the contacts it has saved?") in list("View Camera", "Toggle Contacts"))
							if("View Camera")
								usr.reset_view(src)
								usr << "Now viewing [src]. Click the camera to reset your view."
								return
							if("Toggle Contacts")
								if(src.display)
									src.display = 0
									usr << "Contacts for this camera have been toggled off."
									return
								else
									src.display = 1
									usr << "Contacts for this camera have been toggled on."
									return*/
		New()
			..()
			src.detections = list()
			spawn(10) if(src) src.Sweep()
		proc/Sweep()
			set waitfor=0
			if(src.z)if(src.Bolted)
				for(var/mob/M in view(20,src))
					var/Logged = 0
					for(var/obj/items/A in M)
						if(A.Password==src.Frequency) Logged = 1
						if(A.Frequency==src.Frequency) Logged = 1
					for(var/obj/Contact/O in src.detections)
						if(O.Signature == M.Signature) Logged = 1
					if(Logged == 0)
						var/obj/Contact/X = new
						X.suffix = null
						X.Signature = M.Signature
						X.name = "Intruder Detected [YearOutput()]"
						if(M.icon)
							X.appearance=M.appearance
						src.detections += X
			sleep(150)
			if(src) src.Sweep()
		verb/Review_Stored_Footage()
			set src in oview(1)
			var/p=input("Input password.") as text
			if(p == src.Password)
				winclone(usr, "GenericSheet", "StoredFootage")
				winshow(usr.client,"StoredFootage",1)
				winset(usr.client,"StoredFootage.Grid","cells=0x0;title=\"Stored Footage\"")
				var/Row=0
				for(var/obj/Contact/S in src.detections)
					Row++
					usr << output(S, "StoredFootage.Grid:1,[Row]")
			else
				usr << "Wrong password."

		verb/Set_Password()
			set src in oview(1)
			if(!Password)
				Password=input("Choose a password for this device.") as text
				usr << "Password set."
				return
			else
				usr << "This device already has a password set."
				return
		verb/Bolt()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				Bolted=1
				Shockwaveable=0
				range(20,src)<<"[usr] bolts the [src] to the ground."

				return
			if(Bolted) if(src.Builder=="[usr.real_name]")
				range(20,src)<<"[usr] unbolts the [src] from the ground."
				Bolted=0
				Shockwaveable=1

				return
		verb/Frequency()
			set src in oview(1)
			var/p=input("Input password.") as text
			if(p == src.Password)
				Frequency=input("Choose a frequency. It can be text and/or numbers. When someone is detected near the Security Camera it will send a notification to this frequency alerting those on the channel that someone is near by.") as text
				usr << "Frequency set for [Frequency]."
				return
			else
				usr << "Wrong password."
				return