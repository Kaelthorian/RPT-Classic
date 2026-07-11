mob/Admin4/verb
	Change_Wipe_Day()
		set category="Gains"
		if(!usr.client.holder||usr.client.holder.level<4) return
		var/NYear=input("Enter a WipeDay. The current is [WipeDay]") as num
		if(!usr.Confirm("Are you sure?")) return
		WipeDay=round(NYear)
		WipeDayProgress=0
		logAndAlertAdmins("[src.key] set the WipeDay to [WipeDay]",2)