mob/Admin1/verb

	Reward_Roleplay_Power()
		set category="Admin Other"
		if(usr.Confirm("Grant [M] Roleplay Power?"))
			M<<"You have been rewarded 5% Roleplay Power."
			M.RPPower+=0.05
			logAndAlertAdmins("[M] has been rewarded 5% RP Power by [usr] and now has [M.RPPower] RP Power.")
			var/addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> [usr.key] rewarded [M] ([M.key]) +5% RP power and now has [M.RPPower] RP Power.<br><hr>"
			M.mind.store_memory(addedMemory)