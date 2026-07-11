Skill/Spell/Alter_Perception

	desc="Allows someone to choose a new name, gender and base icon.  It will also give them a new energy signature. (This will 'break' other people's contacts with them)"
	verb/Alter_Perception()
		set src=usr.contents
		set category="Skills"
		var/list/Whoers=list()
		for(var/mob/player/P in view(usr)) Whoers+=P
		var/mob/Choice=input("Cast [src] on who?") in Whoers
		var/Cost = 50000000
		var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
		usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
		if(usr.Confirm("Would you like to cast [src] on [Choice]?"))
			switch(alert(Choice,"[usr] wants to cast [src] on you. Allow it?","New Identity","Yes","No"))
				if("Yes")
					for(var/obj/Mana/MM in usr)
						if(MM.Value > Actual)
							logAndAlertAdmins("[usr] used [src] on [Choice].",1)
							for(var/mob/player/MMM in view(usr)) MMM.BuffOut("[usr] has cast [src] on [Choice]!")
							Choice.ChangeIdentity()
							MM.Value -= Actual
						else
							usr<<"Not enough mana."
							return