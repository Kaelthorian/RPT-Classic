mob/Admin1/verb/Refund_Skill(mob/M in Players)

	var/TierFilter
	var/Skill/Answer=input("What skill you want to delete?") in M.contents
	if(Answer.Tier == 0)
		M<<"That is not a skill"
	else
		TierFilter= Answer.Tier
		del(Answer)

	if(TierFilter == 1)
		Again
		var/SkillChoice = input("Select what Skill you want (T1)")in ListSkillT1
		if(SkillChoice == "Cancel")
			return
		if((locate(SkillChoice)in M))
			M<<"You already have that skill!"
			goto Again
		M.contents	+=new SkillChoice
		var/Skill/SS=locate(SkillChoice)in M
		SkillTierSelector(SS,1)
		switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
			if("I don't want this skill")
				del(SS)
				goto Again
		M<<"<span class=announce>You have learned [SS.name]"

	if(TierFilter == 2)
		Again
		var/SkillChoice = input("Select what Skill you want (T2)")in ListSkillT2
		if(SkillChoice == "Cancel")
			return
		if((locate(SkillChoice)in M))
			M<<"You already have that skill!"
			goto Again
		M.contents	+=new SkillChoice
		var/Skill/SS=locate(SkillChoice)in M
		SkillTierSelector(SS,2)
		switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
			if("I don't want this skill")
				del(SS)
				goto Again
		M<<"<span class=announce>You have learned [SS.name]"

	if(TierFilter == 3)
		Again
		var/SkillChoice = input("Select what Skill you want (T3)")in ListSkillT3
		if(SkillChoice == "Cancel")
			return
		if((locate(SkillChoice)in M))
			M<<"You already have that skill!"
			goto Again
		M.contents	+=new SkillChoice
		var/Skill/SS=locate(SkillChoice)in M
		SkillTierSelector(SS,3)
		switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
			if("I don't want this skill")
				del(SS)
				goto Again
		M<<"<span class=announce>You have learned [SS.name]"

	if(TierFilter == 4)
		Again
		var/SkillChoice = input("Select what Skill you want (T4)")in ListSkillT4
		if(SkillChoice == "Cancel")
			return
		if((locate(SkillChoice)in M))
			M<<"You already have that skill!"
			goto Again
		M.contents	+=new SkillChoice
		var/Skill/SS=locate(SkillChoice)in M
		SkillTierSelector(SS,4)
		switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
			if("I don't want this skill")
				del(SS)
				goto Again
		M<<"<span class=announce>You have learned [SS.name]"