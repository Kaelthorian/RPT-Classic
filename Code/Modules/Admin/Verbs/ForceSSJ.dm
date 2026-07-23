/client/proc/ForceSSJ(mob/M in Players)
	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	if(M.Race!="Saiyan") if(M.Race!="Half-Saiyan") if(M.Race!="Part-Saiyan") return
	if(usr.Confirm("Give [M] the next SSj level? (They have [M.HasSSj])"))// return
		if(usr.Confirm("Make it drainless?")) M.FirstTransDrainless=1
		var/Gave="SSj"
		if(M && M.client)	//Do the checks in the reverse of what you'd assume
			if(M.HasSSj < 1)
				M.HasSSj = 1
				usr<<"Unlocked [M]s SSj."
			else if(M.HasSSj < 2)
				M.HasSSj = 2
				Gave="SSj 2"
				usr<<"Unlocked [M]s SSj 2."
			else if(M.Class!="Legendary")
				var/list/SSjs=list()
				if(!M.HasSSj4)SSjs+="SSj4"
				//if(M.HasSSj<3) SSjs+="SSj3"
				SSjs+="Cancel"
				var/C=input("Give them...") in SSjs
				switch(C)
					if("Cancel")return
					if("SSj3")
						Gave="SSj 3"
						M.HasSSj = 3
						usr<<"Unlocked [M]s SSj 3."
					if("SSj4")
						M.HasSSj4=1
						Gave="SSj 4"
						M.SSj4()
						usr<<"Unlocked [M]s SSj 4. (Perm)"
			else
				alert("[M] already has their forms fully unlocked!")
				return
			log_admin("[key_name(src)] granted [key_name(M)] [Gave]")
			alertAdmins("[key_name(src)] granted [key_name(M)] [Gave]!")
			if(!First_SSJ) if(usr.Confirm("Unleash the Hell Gates of the First SSj?"))
				First_SSJ="[M.name] ([M.key])"
				for(var/mob/K in Players) if(K.MaxKi>=5000) K.ICOut("You feel a great wave of power somewhere in the universe.")
				alertAdmins("[key_name(src)] unleashed the first SSj, [M]!")
			else if(!First_SSJ2&&M.HasSSj==2) if(usr.Confirm("Unleash the Hell Gates of the First SSj2?"))
				First_SSJ2="[M.name] ([M.key])"
				for(var/mob/K in Players) if(K.MaxKi>=5000) K.ICOut("You feel a great wave of power somewhere in the universe.")
				alertAdmins("[key_name(src)] unleashed the first SSj2, [M]!")