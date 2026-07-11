proc/NewPortHook()
	var/ServerAddress="byond://[world.internet_address]:[world.port]"
	if(!TestServerOn)if(world.host=="RT Production")
		usr.client.HttpPost(
						// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
						"https://discord.com/api/webhooks/894013467567214624/mXGpDf6V1jREDK_LdDPtP4crNaElIOlB1tHwe0fN2-60We9HMyWLFTfcxMMrjkG-3xry",

						/*
						[content] is required and can't be blank.
							It's the message posted by the webhook.

						[avatar_url] and [username] are optional.
							They're taken from your key.
							They override the webhook's name and avatar for the post.
						*/
						list(
							content = "**Server Open** \n @everyone Server is live at [ServerAddress]",
						)
					)
		world<<"<span class=\"announce\"> Discord notified of world address!</span>"

proc/LogHook(var/text)if(!TestServerOn)
	text=html_decode(text)
	usr.client.HttpPost(
					"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",
					list(
						content = "Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")] \n ```[text]```",
					)
				)