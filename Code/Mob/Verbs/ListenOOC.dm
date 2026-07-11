/mob/verb/listen_ooc()
	set name = ".ToggleOOC"
	set hidden=1
	if(src.client)
		src.client.listen_ooc = !src.client.listen_ooc
		listen_ooc=src.client.listen_ooc
		if (src.client.listen_ooc) src << "You are now listening to messages on the OOC channel."
		else src << "You are no longer listening to messages on the OOC channel."