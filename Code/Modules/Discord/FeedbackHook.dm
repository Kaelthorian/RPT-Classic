/*
var/global/WorldBugReports = 1


mob/verb

	BugReport()
		set hidden = 1
		set instant = 1
		if((winget(client,"bugreport","is-visible")=="true"))
			winshow(client,"bugreport",0)
			return
		winshow(client,"bugreport",1)
		winset(client, "bugreport.emoteinput", "focus=true")


	BugReportS()
		set hidden = 1
		var/m=winget(usr, "bugreport.emoteinput", "text")
		m = copytext(sanitize_n(m), 1, MAX_DISCORD_LEN)
		winshow(client,"bugreport",0)
		winset(usr.client, "bugreport.emoteinput", "text=")
		BugReportHook(usr,m)



proc/BugReportHook(mob/Reporter,var/Bug)
	var/ReporterKey = Reporter.key
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discordapp.com/api/webhooks/671153515032477704/9ls9M_fzU7B0GZ3xMjR8xnciFbgX5_07zCV3k8phICJpLRLlSYztvffjKiYRcJwv57NN",
					list(
						content = "**In-Game Bug Report**: [WorldBugReports] \n\n Bug Report: [Bug]",
						username = "[ReporterKey]"
					)
				)
	usr<<"Bug Report submitted to the Discord!"*/
//	WorldBugReports++