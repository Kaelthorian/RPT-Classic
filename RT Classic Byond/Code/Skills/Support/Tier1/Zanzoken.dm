Skill/Zanzoken
	UB1="Godspeed"
	UB2="Kaioken"
	desc="Zanzoken allows you to instantly move to another location within a short range. \
	To use it, simply click the spot you want to go to, within sight, and your character will teleport there. (3 Charges Max)"
	var/tmp/Charges=3
	icon='Zanzoken.dmi'


	var/Zon=0
	verb/Toggle_Zanzoken()
		set category="Other"
		if(Zon)
			Zon = 0
			usr.BuffOut("Zanzoken toggled off.")
			return
		else
			Zon = 1
			usr.BuffOut("Zanzoken toggled on.")
			return

	verb/Toggle_Combo()
		set category="Other"
		if(usr.attacking) return
		if(!usr.Warp)
			usr.BuffOut("Combo Toggle On. (Increases attack speed by 5x but reduced damage per attack to 1/5.)")
			usr.Warp=1
			usr.attacking=1
			spawn(4) usr.attacking=0
		else
			usr.BuffOut("Combo Toggle Off. (Normal attack speed and damage.)")
			usr.Warp=0
			usr.attacking=1
			spawn(4) usr.attacking=0



	verb/Customize_Zanzoken_Icon()
		set category="Other"
		if(usr.Confirm("Do you want to have custom icon for your Zanzoken?"))

			var/ICO=input("Select an icon to use.","Custom Zanzoken Icon") as null|icon
			if(!ICO)
				return 0
			var/size = length(ICO)
			Size(size)
			if(length(ICO) > iconsize)
				alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
				return 0
			else
				usr << "Icon accepted!"
				usr.CustomZanzokenIcon=ICO

		else
			var/CC=input("Choose a default zanzoken icon") in list("Default","Male Shadow","Female Shadow","Black Hole","Lightning","Flame","Flame2","Flame3","Leaf","Light","Tech","Rune","Snow","Thorn","Water","Wind","Cherry")

			switch(CC)
				if("Default") usr.CustomZanzokenIcon='Zanzoken.dmi'
				if("Male Shadow") usr.CustomZanzokenIcon='Male Shadow.dmi'
				if("Female Shadow") usr.CustomZanzokenIcon='Female Shadow.dmi'
				if("Black Hole") usr.CustomZanzokenIcon='Black Hole.dmi'
				if("Lightning") usr.CustomZanzokenIcon='Lightning Zanzo.dmi'
				if("Flame") usr.CustomZanzokenIcon='Flame Zanzo.dmi'
				if("Flame2") usr.CustomZanzokenIcon='Flame2 Zanzo.dmi'
				if("Flame3") usr.CustomZanzokenIcon='Flame3 Zanzo.dmi'
				if("Leaf") usr.CustomZanzokenIcon='Leaf Zanzo.dmi'
				if("Light") usr.CustomZanzokenIcon='Light Zanzo.dmi'
				if("Tech") usr.CustomZanzokenIcon='Tech Zanzo.dmi'
				if("Water") usr.CustomZanzokenIcon='Water Zanzo.dmi'
				if("Rune") usr.CustomZanzokenIcon='Rune Zanzo.dmi'
				if("Snow") usr.CustomZanzokenIcon='Snow Zanzo.dmi'
				if("Thorn") usr.CustomZanzokenIcon='Thorn Zanzo.dmi'
				if("Wind") usr.CustomZanzokenIcon='Wind Zanzo.dmi'
				if("Cherry") usr.CustomZanzokenIcon='Cherry Zanzo.dmi'