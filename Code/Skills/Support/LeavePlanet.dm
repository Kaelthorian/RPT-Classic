Skill/Misc/Leave_Planet/verb/Leave_Planet()
	set category="Other"
	var/lr = list(1,2,3,4,5,6,7,14,15)
	if(usr.z in lr)
		if(!usr.Confirm("Are you sure you want to use Leave Planet? (30 second delay)")) return
		CD=8000
		CDTick(usr)
		usr<<"Leaving in 30 seconds."
		spawn(300)
			Liftoff(usr)
			spawn(10) if(usr.z!=12) usr.z=12
	else usr<<"You may not Leave Planet from here."