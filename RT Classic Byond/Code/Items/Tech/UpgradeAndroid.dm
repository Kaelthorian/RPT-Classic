Skill/Technology/Upgrade_Android

	verb/Upgrade_Android()
		set category="Other"
		if(usr.RPMode) return
		if(Year<2)
			usr<<"It has to be past year 2 to do this"
			return
		var/list/Choices=new
		Choices+="Cancel"
		//Choices+=usr
		for(var/mob/A in get_step(usr,usr.dir)) if(A.Race=="Android") Choices+=A
		if(usr.Race=="Android") Choices+=usr
		var/mob/A=input("Choose a target") in Choices
		if(A=="Cancel") return
		var/Max=round(usr.Int_Level)
		if(A.AndroidLevel>=Max)
			usr<<"They are already too advanced."
			return
		var/Amount=input(usr,"Choose which level to upgrade them to. [A.AndroidLevel] - [Max]. Each level grants 0.25% passive BP.") as num
		if(Amount>Max) Amount=Max
		if(Amount<A.AndroidLevel) return
		var/Cost=((((Amount-A.AndroidLevel)*1250000))+5000000)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(Cost<0) Cost=0
		for(var/obj/Resources/R in usr)
			if(R.Value<Cost)
				usr<<"You need [Commas(Cost)]$ to do this."
				return
			switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
				if("No") return
			R.Value-=Cost
			switch(alert(A,"[usr] wants to upgrade you to level [Amount], do you accept? Each level grants 0.25% passive BP.","Android Upgrade","Yes","No"))
				if("Yes")
					A.AndroidLevel = Amount
					view(usr) << "[A] accepts the offer from [usr] to be upgraded to level [A.AndroidLevel]."
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has upgraded [A] to level [A.AndroidLevel]")
					alertAdmins("[key_name(usr)] has upgraded [key_name(A)] to level [Amount]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has upgraded [A] to level [A.AndroidLevel].\n")
				if("No") view(usr)<<"[A] declines the offer from [usr] to be upgraded."
