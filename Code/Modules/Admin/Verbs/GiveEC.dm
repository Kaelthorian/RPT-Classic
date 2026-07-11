mob/proc/
	Grant_Basic_EC_Stuff(mob/M in Players)
		set category="Admin"
		if(!usr.Confirm("Make them EC?")) return
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(usr.Confirm("Cap all [M]'s stats?"))
			M.CapStats()

			log_admin("[key_name(usr)] capped [M]'s stats.")
			alertAdmins("[key_name_admin(usr)] capped [M]'s stats.", 1)
		M.Zanzoken=1000
		M.FlySkill=5000
		M.UnarmedSkill=1000
		M.SwordSkill=1000
		M.KiManipulation=1000
		M<<"Your skills were all mastered."

		if(Base<StarterBoostBP*BPMod*2.5) Base=StarterBoostBP*BPMod*2.5
		//if(BaseMaxKi<StarterBoostEnergy*KiMod*2) BaseMaxKi=StarterBoostEnergy*KiMod*2
		if(usr.Confirm("Give them MPs?"))
			M.MilestonePoints=Year
			M.TotalMilestonePoints=Year
		/*if(usr.Confirm("Give them a stance?"))
			M.GetStance()
			logAndAlertAdmins("[src.key] has given [M] Custom Martial Arts.",2)*/
//		if(usr.Confirm("Give them a basic kit?"))
//			M.SpaceKing(0)
