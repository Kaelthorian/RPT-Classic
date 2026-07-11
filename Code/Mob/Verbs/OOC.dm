/mob/verb/OOC(msg as text)
	set category = null//"Other"
	//set name = "OOC"
	if(IsGuestKey(usr.key))
		usr << "You are not authorized to communicate over these channels."
		return
	msg = gSpamFilter.sf_Filter(usr,msg)
	if(!msg) return
	else if(!ooc_allowed && !usr.client.holder) return
	else if(usr.client.muted) return
	if(findtext(msg, "byond://") && !usr.client.holder)
		usr << "<B>Advertising other servers is not allowed.</B>"
		alertAdmins("[key_name_admin(usr)] has attempted to advertise in OOC.")
		return
	if(findtextEx(msg, "pickle rick")||findtextEx(msg, "Pickle Rick")||findtextEx(msg, "Pickle rick")||findtextEx(msg, "pickle Rick")||findtextEx(msg, "rickle pick")||findtextEx(msg, "Rickle pick")||findtextEx(msg, "Rickle pick")||findtextEx(msg, "pIcKlE rIcK")||findtextEx(msg, "PiCkLe RiCk")||findtextEx(msg, "RiCkLe PiCk")||findtextEx(msg, "rIcKlE PiCk")||findtextEx(msg, "picklerick")||findtextEx(msg, "PICKLERICK")||findtextEx(msg, "pikel rick")||findtextEx(msg, "pikel rik")||findtextEx(msg, "pickle rik")||findtextEx(msg, "pklrk")||findtextEx(msg, "pkle rk")||findtextEx(msg, "pkle rck")||findtextEx(msg, "rick pickle")||findtextEx(msg, "Rick Pickle")||findtextEx(msg, "rickpickle")||findtextEx(msg, "kickle pick")||findtextEx(msg, "kickle rick")||findtextEx(msg, "rick kickle")||findtextEx(msg, "p1ck13 r1ck")||findtextEx(msg, "p1ck13r1ck")||findtextEx(msg, "p1ck13 r1c4")||findtextEx(msg, "p1c413 r1c4")||findtextEx(msg, "p1c413 r1ck")||findtextEx(msg, "p1c4l3 r1ck")||findtextEx(msg, "p1ck13")||findtextEx(msg, "p1ck1e")||findtextEx(msg, "p1c41e")||findtextEx(msg, "pick1e")||findtextEx(msg, "p1c47e")||findtextEx(msg, "p1c4le")||findtextEx(msg, "pic47e")||findtextEx(msg, "pick7e")||findtextEx(msg, "pick1e")||findtextEx(msg, "p1ckle")||findtextEx(msg, "pickl3")||findtextEx(msg, "pick3l")||findtextEx(msg, "pick31")||findtextEx(msg, "p1ck31")||findtextEx(msg, "nigger")||findtextEx(msg, "nigg3r")||findtextEx(msg, "n1gger")||findtextEx(msg, "n1gg3r")||findtextEx(msg, "ni44er")||findtextEx(msg, "ni443r")||findtextEx(msg, "ni4g3r")||findtextEx(msg, "nig43r")||findtextEx(msg, "n1443r")||findtextEx(msg, "n14g3r")||findtextEx(msg, "n1g43r")||findtextEx(msg, "Nigger"))
		alert(usr,"This joke isn't funny.")
		msg=pick("I am a lame person.","I wish I was funny","i have low iq","i like to lick batteries","i suffer from nocturnal urination","sometimes, i dream about cheese","yes i am also retarded","one time i accidentally pooped myself")
//	log_ooc("\[[time2text(world.realtime,"Day DD hh : mm : ss")]\] [usr.name]/[usr.key] : [msg]")
	var/nameline="<span class=\"[Font]\">"
	for(var/mob/C in Players) if(C.client) if(!locate(usr.lastKnownKey) in Ignores)
		if(C.client.listen_ooc)
			if(C.client.holder) C.AllOut("<font size=[C.TextSize] font color=[usr.TextColorOOC]>[C.Toggled_Timestamps ? "\[[time2text(world.realtime,"Day, hh : mm")]\]":""] <span class=\"adminooc\"><span class=\"prefix\">(OOC)</span>[BoosterTag][nameline] [usr.key][C.client.holder.SeeIC?"([usr.name])":""] (<A HREF='?src=\ref[C.client.holder];adminplayeropts=\ref[usr]'>X</A>)[OOCTag? " [OOCTag]":""]:</span></font> <span class=\"message\">[msg]</span></span>")
			else C.AllOut("<font size=[C.TextSize] font color=[usr.TextColorOOC]>[C.Toggled_Timestamps ? "\[[time2text(world.realtime,"Day, hh : mm")]\]":""] <span class=\"prefix\">(OOC)</span> [BoosterTag][nameline][usr.key][OOCTag? " [OOCTag]":""]:</span></font> <span class=\"message\">[msg]</span></span>")
		if (C.client.holder) C.OOCOut("<font size=[C.TextSize] font color=[usr.TextColorOOC]>[C.Toggled_Timestamps ? "\[[time2text(world.realtime,"Day, hh : mm")]\]":""] <span class=\"adminooc\"><span class=\"prefix\">(OOC)</span> [BoosterTag][nameline][usr.key]([usr.name]) (<A HREF='?src=\ref[C.client.holder];adminplayeropts=\ref[usr]'>X</A>)[OOCTag? " [OOCTag]":""]:</span></font> <span class=\"message\">[msg]</span></span>")
		else C.OOCOut("<font size=[C.TextSize] font color=[usr.TextColorOOC]>[C.Toggled_Timestamps ? "\[[time2text(world.realtime,"Day, hh : mm")]\]":""] <span class=\"ooc\"><span class=\"prefix\">(OOC)</span> [BoosterTag][nameline][usr.key][OOCTag? " [OOCTag]":""]:</span></font> <span class=\"message\">[msg]</span></span>")
	OOCChat(src,msg)