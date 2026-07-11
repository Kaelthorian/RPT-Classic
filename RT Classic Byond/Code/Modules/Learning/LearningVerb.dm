mob/verb/Self_Learn()
	set category	="Other"
	var/InSelection	= 0

	LevelCheck(usr)

	while(usr.SkillPointsT1>0 || usr.SkillPointsT2>0)
		if(InSelection)
			return
		InSelection = 1
//		world<<"SkillPointsT1 [SkillPointsT1]"
//		world<<"SkillPointsT2 [SkillPointsT2]"
		Again

		if(SkillPointsT1)
			var/SkillChoice = input("Select what Skill you want (T1)")in ListSkillT1 - "Cancel"
			if((locate(SkillChoice)in src))
				usr<<"You already have that skill!"
				goto Again
			contents	+=new SkillChoice
			usr.SkillPointsT1--
			var/Skill/SS=locate(SkillChoice)in usr
			SkillTierSelector(SS,1)
			switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
				if("I don't want this skill")
					usr.SkillPointsT1++
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		if(SkillPointsT2)
			var/SkillChoice = input("Select what Skill you want (T2)")in ListSkillT2 - "Cancel"
			if((locate(SkillChoice)in src))
				usr<<"You already have that skill!"
				goto Again
			contents	+=new SkillChoice
			usr.SkillPointsT2--
			var/Skill/SS=locate(SkillChoice)in usr
			SkillTierSelector(SS,2)
			switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
				if("I don't want this skill")
					usr.SkillPointsT2++
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		if(SkillPointsT3)
			var/SkillChoice = input("Select what Skill you want (T3)")in ListSkillT3 - "Cancel"
			if((locate(SkillChoice)in src))
				usr<<"You already have that skill!"
				goto Again
			contents	+=new SkillChoice
			usr.SkillPointsT3--
			var/Skill/SS=locate(SkillChoice)in usr
			SkillTierSelector(SS,3)
			switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
				if("I don't want this skill")
					usr.SkillPointsT3++
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		if(SkillPointsT4)
			var/SkillChoice = input("Select what Skill you want (T4)")in ListSkillT4 - "Cancel"
			if((locate(SkillChoice)in src))
				usr<<"You already have that skill!"
				goto Again
			contents	+=new SkillChoice
			usr.SkillPointsT4--
			var/Skill/SS=locate(SkillChoice)in usr
			SkillTierSelector(SS,4)
			switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
				if("I don't want this skill")
					usr.SkillPointsT4++
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		if(SkillPointsBuff)
			var/SkillChoice = input("Select what Buff you want")in BuffSkillList - "Cancel"
			if((locate(SkillChoice)in src))
				usr<<"You already have that Buff!"
				goto Again
			contents	+=new SkillChoice
			usr.SkillPointsBuff--
			var/Skill/SS=locate(SkillChoice)in usr
			switch(alert("[SS.desc]",,"I want this Buff","I don't want this Buff"))
				if("I don't want this skill")
					usr.SkillPointsBuff++
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		InSelection = 0

	usr << "There is nothing else for you to learn"
	InSelection = 0
