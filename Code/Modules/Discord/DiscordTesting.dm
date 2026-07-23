/* Demonstrates using a Discord Webhook to forward chat messages from your game to a Discord text channel.

	Discord's Intro to Webhooks:
		https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks

	Discord's dev docs for webhooks:
		https://discordapp.com/developers/docs/resources/webhook

	* Discord rate-limits webhooks, so messages will fail to send if used too frequently.
		This can be worked around; you can modify HttpPost to get the response which includes
		rate limit info when it occurs. But I won't be doing that here.

		Rate limits doc:
			https://discordapp.com/developers/docs/topics/rate-limits
*/

client
	// I made key_info literally just to grab your member icon URL from the hub.
	var key_info/key_info

	New()
		key_info = new(key)
		return ..()

	verb
		// Basic chat command, but with an added webhook.
		say(text as message)
			set category = null
			world << "<b>[src]</b>: [html_encode(text)]"

			// Send the message to the Discord webhook.
			HttpPost(
				/* Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					It's best to use a global const for this and keep it secret so others can't use it.
				*/
				"https://discordapp.com/api/webhooks/webhook.id/webhook.token",

				/*
				[content] is required and can't be blank.
					It's the message posted by the webhook.

				[avatar_url] and [username] are optional.
					They're taken from your key.
					They override the webhook's name and avatar for the post.
				*/
				list(
					content = text,
					avatar_url = key_info.IconURL(),
					username = key
				)
			)
/* A function to allow clients to send HTTP POST requests.
	Because world.Export() doesn't support POST yet.
*/
client
	New()
		// Enable sending HTTP POST requests by sending hidden JavaScript to the client.
		src << browse({"<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<script>
				function post(url, data) {
					if(!url) return;
					var http = new XMLHttpRequest;
					http.open('POST', url);
					http.setRequestHeader('Content-Type', 'application/json');
					http.send(data);
				}
			</script>"}, "window=http_post_browser")
		winshow(src, "http_post_browser", FALSE)
		return ..()
/* Key info is the data you see when you go to the format=text page of a BYOND key.

	Example of format=text: my own key info.

		http://www.byond.com/members/Kaiochao&format=text
*/

