Skill/Technology/Cyborize

	verb/Cyberize()
		set category="Other"
		if(usr.PowerArmorOn) return
		var/list/Choices=new
		Choices+="Cancel"
		Choices+=usr
		if(usr.HasWeHaveTheTechnology) for(var/mob/player/P in oview(usr)) Choices+=P
		var/mob/A=input("Choose a target") in Choices
		if(A=="Cancel") return
		if(A.Dead)
			usr<<"Dead people cannot get cybernetic implants."
			return
		if(A.Majinized==1)
			usr<<"His mind is too broken to survive the transformation."
			return
		if(A.Race=="Bio Android")
			usr<<"His body is too advance and perfect to try and change it."
			return
//		var/Max=round(usr.HasIntMiles)
//		var/Amount=input(usr,"Choose which level to Cyberize them to. 0(0 will remove Cyberize) - 1. (Changes the reduction from Int MPs from 7.5% per level to 0% but disables power armor and gundams.)") as num
//		if(Amount>Max) Amount=Max
//		if(Amount>1)Amount=1
		if(usr.PowerArmorOn) return
		if(A.Cyborg == 1)
			if(usr.Confirm("Do you want to remove their cyberization?"))
				switch(alert(A,"[usr] wants to remove your cyberization. Accept?","Cyberize Remove","Yes","No"))
					if("Yes")
						A.Cyborg = 0
						view(usr) << "[A] accepts the offer from [usr] to have their cyberization removed."
						//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has removed [A]'s cyberization.")
	//					alertAdmins("[key_name(usr)] has cyberized [key_name(A)] granting an additional [Amount] BP")
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has removed [A]'s cyberization.\n")
						return
					if("No")
						view(usr)<<"[A] declines the offer from [usr] to have their cyberization removed."
						return
//		if(Amount<A.AndroidLevel) return
		if(usr.PowerArmorOn) return
//		var/Cost=((((Amount-A.AndroidLevel)*2500000000))+2500000)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Cost=(((2500000000))+2500000)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(Cost<0) Cost=0
		for(var/obj/Resources/R in usr)
			if(R.Value<Cost)
				usr<<"You need [Commas(Cost)]$ to do this."
				return
			switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
				if("No") return
			if(usr.PowerArmorOn) return
			R.Value-=Cost
			switch(alert(A,"[usr] wants to make you a cyborg , do you allow him to do it?","Cyberize","Yes","No"))
				if("Yes")
					A.Cyborg = 1
					A.KO(A)
					if(usr.HasWeHaveTheTechnology)
						for(var/BodyPart/BP in A)
							BP.Cybernetic=1
							if(BP.MaxHealth<usr.Int_Level) BP.MaxHealth=usr.Int_Level
							A.CyberLimb(BP)
							A.Injure_Heal(200,BP,1)
							A.Injure_Heal(200,BP,1)
							view(usr)<<"[usr] has successfully replaced [A]'s [BP] with a cybernetic version."
					view(usr) << "[A] accepts the offer from [usr] to be Cyberized."
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Cyberized [A] to level [A.AndroidLevel]")
//					alertAdmins("[key_name(usr)] has cyberized [key_name(A)] to level [Amount] BP")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Cyberized [A]\n")
				if("No") view(usr)<<"[A] declines the offer from [usr] to be Cyberized."