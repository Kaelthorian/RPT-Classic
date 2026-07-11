/mob/verb/listen_looc()
	set name = ".ToggleLOOC"
	set hidden=1
	if(src.client)
		src.listen_looc= !src.listen_looc
		if(src.listen_looc) src << "You are now listening to messages on the Local OOC channel."
		else src << "You are no longer listening to messages on the Local OOC channel."