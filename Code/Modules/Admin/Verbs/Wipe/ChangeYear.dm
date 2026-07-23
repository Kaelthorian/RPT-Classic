mob/Admin4/verb
	Change_Year()
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<4) return
		var/NYear=input("Enter a year. The current is [Year]") as num
		if(!usr.Confirm("Are you sure?")) return
		Year=round(NYear)
		var/Mn=input("Enter a month. 1-12") as num
		if(Mn<2) Mn=1
		if(Mn>12) Mn=12
		Mn=round(Mn)
		Month=Mn
		MonthCycle=1
		logAndAlertAdmins("[src.key] set the year to [YearOutput()]",2)
