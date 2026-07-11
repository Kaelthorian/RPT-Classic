obj/items
	Magic_Scanner
		icon='Kensei.dmi'
		var/Scan=1
		var/Range=5
		layer=6
		//var/Detects
		//var/CanDetect

		desc="Equipping this will open a tab that allows you to see the battle power of all people within the scanner's range and detection capabilities."
		Click()
			if(locate(src) in usr)
				for(var/obj/items/Magic_Scanner/X in usr) if(X!=src) if(X.suffix) return
				for(var/obj/items/Scanner/X in usr) if(X!=src) if(X.suffix) return
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
					var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays -= _overlay
					suffix=null
					usr.ScouterOn=0
		verb
			Upgrade()
				set src in view(1)
				if(usr.Magic_Level<Tech)
					usr<<"This is too advanced for you to mess with."
					return
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Cost=20000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
				var/Max_Upgrade=(A.Value/Cost)+Tech
				if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
				var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magic (Max Upgrade cannot exceed Magic), and how much mana you have. So if the maximum is less than your magic then it is instead due to not having enough mana to upgrade it higher than the said maximum. Max Scan BP is based upon the Magic Mod of the person who upgrades it.") as num
				if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
				if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
				if(Upgrade<1) Upgrade=1
				Upgrade=round(Upgrade)
				if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
					if("No") return
				Cost*=Upgrade-Tech
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough mana to upgrade it to level [Upgrade]"
					return
				view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
				A.Value-=Cost
				Tech=Upgrade
				if(Scan<(1.75*Upgrade)**(usr.Magic_Potential*0.85)) Scan=(1.75*Upgrade)**(usr.Magic_Potential*0.85)
				if(Scan<50*Upgrade) Scan=50*Upgrade
				Range=5*Upgrade
				desc="Level [Tech] [src] ([Commas(Scan)] BP)"