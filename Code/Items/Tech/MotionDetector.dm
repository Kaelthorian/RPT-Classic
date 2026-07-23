obj/items
	Motion_Detector
		desc="This is a Motion Detector. A frequency can be set, along with a password. When someone is detected near this device, a message is sent to the frequency alerting those on the frequency channel about the intruder. It is able to detect cloaked people also, since the laser motion trackers are disturbed when the light is bent around the cloaker."
		layer=MOB_LAYER+10

		icon='tech security systems.dmi'
		icon_state="motion tracker"
		density=1
		Savable = 1
		var/Max=1
		Frequency=100
		var/cd = 0
		New()
			spawn(10) if(src) src.Scan()
		proc/Scan()
			if(src.z)
				for(var/mob/player/M in view(15,src)) if(!M.afk)
					var/Check=1
					for(var/obj/items/A in M)
						if(A.Password==src.Frequency) Check=0
						if(A.Frequency==src.Frequency) Check=0
					if(Check) for(var/mob/player/A in Players)
						for(var/obj/items/Scanner/B in A)
							if(B.Frequency) if(B.Frequency==src.Frequency) if(M != A)
								A<<"<font color=#FFFFFF>(Scanner Channel [src.Frequency])<font color=[A.TextColor]>[src] says, 'Warning! Intruder detected at [M.x],[M.y],[M.z]!' [YearOutput()]"
								A.saveToLog("|  | ([src.x], [src.y], [src.z]) | [key_name(A)] SCANNER: Warning! Intruder detected at [M.x],[M.y],[M.z]!\n")
						for(var/obj/items/Communicator/B in A)
							if(B.Frequency) if(B.Frequency==src.Frequency) if(M != A)
								A<<"<font color=#FFFFFF>(Scanner Channel [src.Frequency])<font color=[A.TextColor]>[src] says, 'Warning! Intruder detected at [M.x],[M.y],[M.z]!' [YearOutput()]"
								A.saveToLog("|  | ([src.x], [src.y], [src.z]) | [key_name(A)] SCANNER: Warning! Intruder detected at [M.x],[M.y],[M.z]!\n")
					break//src.cd = 30
			spawn(450) if(src) src.Scan()
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
		verb/Set_Password()
			set src in oview(1)
			if(!Password)
				Password=input("Choose a password for this device.") as text
				usr << "Password set."
				return
			else
				usr << "This device already has a password set."
				return
		verb/Frequency()
			set src in oview(1)
			var/p=input("Input password.") as text
			if(p == src.Password)
				Frequency=input("Choose a frequency. It can be text and/or numbers. When someone is detected near the Motion Tracker it will send a notification to this frequency alerting those on the channel that someone is near by.") as text
				usr << "Frequency set for [Frequency]."
				return
			else
				usr << "Wrong password."
				return