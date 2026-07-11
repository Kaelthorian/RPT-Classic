mob/Admin4/verb
	Set_Planet_Grav()
		set category = "Gains"
		var/list/Planets=list("Earth","Namek","Arconia","Vegeta","Dark Planet","Ice","Hell")
		var/PP=input("Change which planet's gravity?") in Planets
		if(usr.Confirm("Change [PP]s gravity?"))
			var/PN=input("Change [PP]s gravity to what? (1-1000)") as num
			if(PN<1) PN=1
			if(PN>100)PN=1000
			PN=round(PN)
			if(usr.Confirm("Change [PP]s gravity to [PN]?"))
				if(PP=="Earth")EarthGrav=PN
				if(PP=="Namek")NamekGrav=PN
				if(PP=="Arconia")ArconiaGrav=PN
				if(PP=="Vegeta")VegetaGrav=PN
				if(PP=="Dark Planet")DarkPlanetGrav=PN
				if(PP=="Ice")IceGrav=PN
				if(PP=="Hell")HellGrav=PN
				Save_Gain()
				alertAdmins("[key_name(usr)] editted [PP]s gravity to [PN]")
				log_admin("[key_name(usr)] editted [PP]s gravity to [PN]")