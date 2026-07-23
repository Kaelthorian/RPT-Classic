proc/TrainingHook(mob/Teacher,mob/Student,Skill/Learnin)if(!TestServerOn)
	var/RankTitle = Teacher.Rank
	var/UserName = Teacher.name
	var/UserKey = Teacher.key
	var/TargetName = Student.name
	var/TargetKey = Student.key
	var/Skill = Learnin
	var/YearCompleted = Year + 1
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",

					/*
					[content] is required and can't be blank.
						It's the message posted by the webhook.

					[avatar_url] and [username] are optional.
						They're taken from your key.
						They override the webhook's name and avatar for the post.
					*/
					list(
						content = "**Marked as Student** \n ```Teacher: [UserName]([UserKey]) the [RankTitle] \nStudent: [TargetName]([TargetKey])\nYear: [global.Year]\nSkill: [Skill]\nApproved: [YearCompleted]```",
						username = "[UserName] the [RankTitle]"
					)
				)


proc/SuccessionHook(mob/Appointer,mob/Appointee,AppointedRank)if(!TestServerOn)
	var/UserKey = Appointer.key
	var/TargetKey = Appointee.key
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",
					list(
						content = "**Marked as Successor** \n ```Original Rank: [Appointer]([UserKey]) \nSuccessor: [Appointee]([TargetKey])\nRank: [AppointedRank]\nYear: [global.Year]```",
						username = "[Appointer] the [AppointedRank]"
					))


//SuccessionHook(usr,M,M.Rank,KitHas.Join(", "))







proc/TeachingHook(mob/Teacher,mob/Student,Skill/Learnin)
	var/RankTitle = Teacher.Rank
	var/UserName = Teacher.name
	var/UserKey = Teacher.key
	var/TargetName = Student.name
	var/TargetKey = Student.key
	var/Skill = Learnin
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",

					/*
					[content] is required and can't be blank.
						It's the message posted by the webhook.

					[avatar_url] and [username] are optional.
						They're taken from your key.
						They override the webhook's name and avatar for the post.
					*/
					list(
						content = "**Teaching Student** \n ```Teacher: [UserName]([UserKey]) the [RankTitle] \nStudent: [TargetName]([TargetKey])\nSkill: [Skill]\nYear Taught: [global.Year]```",
						username = "[UserName] the [RankTitle]"
					)
				)




/*
NEED VARS FOR:
	Rank
	User Key
	User Name
	Target Key
	Target Name
	Current Year
	Projected Year of Completion
	Skill Being Taught

*/