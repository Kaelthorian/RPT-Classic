obj/items
	Scanner
		icon='Scouter-Color.dmi'
		var/Scan=1
		var/Range=5
		var/Detects
		var/CanDetect
		var/Implant = 0
		desc="Equipping this will open a tab that allows you to see the battle power of all people within the scanner's range and detection capabilities. You can also use this to communicate with anyone else that has a scouter or communicator on the same frequency.  It will also speak out of any cameras on the same frequency."
		New()
			src.detections = list()
			src.Frequency = "[rand(1,1000)]"
		//	Scan=0.001*rand(450,710)
		Click()
			if(src.Implant)
				usr << "You can't remove that, it's part of you!"
				return
			if(locate(src) in usr)
				for(var/obj/items/Scanner/X in usr) if(X!=src) if(X.suffix) return
				for(var/obj/items/Magic_Scanner/X in usr) if(X!=src) if(X.suffix) return
				if(!suffix)
					usr<<"You put on the [src]."
					var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays += _overlay
					suffix="*Equipped*"
					usr.ScouterOn=Scan
				else
					usr<<"You take off the [src]."
					var/image/_overlay = image(icon) // not sure if the equipped thing is an icon/object so
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays -= _overlay
					suffix=null
					usr.ScouterOn=0
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

		verb
			Transmit(msg as text)
				var/AL=0
				if(usr.z in list(8,10,11,16,17)) AL=1
				for(var/mob/player/A in Players)if(!A.afk)
					var/TAL=0
					if(A.z in list(8,10,11,16,17)) TAL=1
					if(TAL==AL)
						for(var/obj/items/Scanner/B in A)
							if(B.suffix&&B.Frequency==Frequency)
								A.ICOut("<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,A)]''")
								A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")
						for(var/obj/items/Communicator/B in A)
							if(B.Frequency==Frequency)
								A.ICOut("<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,A)]'")
								A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")
				for(var/mob/player/C in view(10,usr.loc))if(!C.afk)
					C.ICOut("<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: [usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,C)]</span>")
				for(var/obj/items/Security_Camera/Ca in world) if(Ca.Frequency==Frequency)
					var/TAL=0
					if(Ca.z in list(8,10,11,16,17)) TAL=1
					if(TAL==AL)
						for(var/mob/player/CC in view(10,Ca)) CC.ICOut("<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,CC)]'</span>")
			Frequency()
				Frequency=input("Choose a frequency, it can be anything. It lets you talk to \
								others on the same frequency. Default is 1") as text
				if(Frequency == "Communication Matrix") //if(usr.AS_Droid == 0)
					usr << "This Frequency seems to be entirely blocking off your access."
					Frequency = "1"

			Detect()
				if(!CanDetect)
					usr<<"This feature is not installed. It can only be installed by a very intelligent person."
					return
				if(Detects) switch(input("Are you sure you want to reset detecting?") in list("No","Yes"))
					if("Yes") Detects=null
					if("No") return
				var/list/A=new
				for(var/obj/B in oview(1,usr)) A+=B
				if(!A)
					usr<<"You are not near an object to set the scanner to."
					return
				A+="Cancel"
				var/obj/B=input("Set to detect what type of object?") in A
				if(B=="Cancel") return
				Detects=B.type
				usr<<"Set to detect [B]"

			Upgrade()
				set src in view(1)
				if(usr.Int_Level<Tech)
					usr<<"This is too advanced for you to mess with."
					return
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=20000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
				var/Max_Upgrade=(A.Value/Cost)+Tech
				if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
				var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence and int mod (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
				if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
				if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
				if(Upgrade<1) Upgrade=1
				Upgrade=round(Upgrade)
				if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
					if("No") return
				Cost*=Upgrade-Tech
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
					return
				view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
				A.Value-=Cost
				Tech=Upgrade
				if((2*Upgrade)**(usr.Int_Mod*0.8)>Scan) Scan=(2*Upgrade)**(usr.Int_Mod*0.8)
				if(Scan<50*Upgrade) Scan=50*Upgrade
				Range=5*Upgrade
				if(Upgrade>=60) CanDetect=1
				desc="Level [Tech] [src] ([Commas(Scan)] BP)"