mob/Admin1/verb

	Reward_Experience(mob/M in Players)
		set category="Admin Other"
		if(usr.Confirm("Grant [M] +100 EXP? They were last rewarded year [M.LastEXPAssign]."))
			M<<"You have been rewarded 100 EXP."
			M.EXP+=100
			M.LastEXPAssign=Year
			logAndAlertAdmins("[M] has been rewarded +100 EXP by [usr].")
			var/addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> [usr.key] rewarded [M] ([M.key]) +100 EXP<br><hr>"
			M.mind.store_memory(addedMemory)