proc/EXPHook(mob/Appointer,mob/Appointee)
	var/UserKey = Appointer.key
	var/TargetKey = Appointee.key
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",
					list(
						content = "**EXP Granted** \n ```Rank: [Appointer]([UserKey]) \nTarget: [Appointee]([TargetKey])\nCurrent EXP: [Appointee.EXP]```",
						username = "[Appointer] the [Appointer.Rank]"
					)
				)
proc/AlignmentHook(mob/Appointer,mob/Appointee,AppointedAlignment)
	var/UserKey = Appointer.key
	var/TargetKey = Appointee.key
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discord.com/api/webhooks/894010237399482408/baIC3W61VgITHME2Nw5ibZkIsXCECOV3ZL0W-c0IjzkUc6efXaet2H9u5iz5wW6wAj83",
					list(
						content = "**Marked as [AppointedAlignment]** \n ```Rank: [Appointer]([UserKey]) \nTarget: [Appointee]([TargetKey])\nAlignment: [AppointedAlignment]\nCurrent Alignment: [Appointee.AlignmentNumber]```",
						username = "[Appointer] the [Appointer.Rank]"
					)
				)

proc/OOCChat(mob/A,var/text)
	text=html_decode(text)
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discord.com/api/webhooks/990422666848645191/wybjZK2U4P6r--hagyani_9i_tXfs6aYD5eN6greeJRTIC4dyUAsuSp23m40-tvp6g4G",
					list(
						content = "OOC:[text]",
						username = "[A.ckey]"
					)
				)