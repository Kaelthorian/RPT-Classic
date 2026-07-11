mob/Admin1/verb/Give_Skill(mob/M in Players)

	switch(input("Do you want your [src] to knock away the people they hit?") in list("SkillT1","SkillT2","SkillT3","SkillT4","SkillBuff"))


		if("SkillT1")
			Again
			var/SkillChoice = input("Select what Skill you want (T1)")in ListSkillT1
			if(SkillChoice == "Cancel")
				return
			if((locate(SkillChoice)in M))
				usr<<"You already have that skill!"
				goto Again
			contents	+=new SkillChoice
			var/Skill/SS=locate(SkillChoice)in M
			SkillTierSelector(SS,1)
			switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
				if("I don't want this skill")
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		if("SkillT2")
			Again
			var/SkillChoice = input("Select what Skill you want (T2)")in ListSkillT2
			if(SkillChoice == "Cancel")
				return
			if((locate(SkillChoice)in M))
				usr<<"You already have that skill!"
				goto Again
			contents	+=new SkillChoice
			var/Skill/SS=locate(SkillChoice)in M
			SkillTierSelector(SS,2)
			switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
				if("I don't want this skill")
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		if("SkillT3")
			Again
			var/SkillChoice = input("Select what Skill you want (T3)")in ListSkillT3
			if(SkillChoice == "Cancel")
				return
			if((locate(SkillChoice)in M))
				usr<<"You already have that skill!"
				goto Again
			contents	+=new SkillChoice
			var/Skill/SS=locate(SkillChoice)in M
			SkillTierSelector(SS,3)
			switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
				if("I don't want this skill")
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		if("SkillT4")
			Again
			var/SkillChoice = input("Select what Skill you want (T4)")in ListSkillT4
			if(SkillChoice == "Cancel")
				return
			if((locate(SkillChoice)in M))
				usr<<"You already have that skill!"
				goto Again
			contents	+=new SkillChoice
			var/Skill/SS=locate(SkillChoice)in M
			SkillTierSelector(SS,4)
			switch(alert("[SS.desc]",,"I want this skill","I don't want this skill"))
				if("I don't want this skill")
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"

		if("SkillBuff")
			Again
			var/SkillChoice = input("Select what Buff you want")in BuffSkillList
			if(SkillChoice == "Cancel")
				return
			if((locate(SkillChoice)in src))
				usr<<"You already have that Buff!"
				goto Again
			contents	+=new SkillChoice
			var/Skill/SS=locate(SkillChoice)in M
			switch(alert("[SS.desc]",,"I want this Buff","I don't want this Buff"))
				if("I don't want this skill")
					del(SS)
					goto Again
			src<<"<span class=announce>You have learned [SS.name]"