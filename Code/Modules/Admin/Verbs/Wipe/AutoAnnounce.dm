mob/Admin2/verb
	Auto_Announce()
		set category = "Admin"
		set desc="Announce your desires to the world... automatically!"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(autoannounce) if(usr.Confirm("Would you like to cancel the current auto announce?"))
			autoannounce=null
			return
		var/message= input(usr,"Global message to send:", "Auto Announce", autoannounce)  as message
		if(message)
			if(usr.client.holder.rank != "Owner" ) message = adminscrub(message,MAX_MESSAGE_LEN)
			autoannounce=message
			autoannouncedelay=input("How often, in minutes, would you like this to be announced? (30 minutes minimum, 180 minutes maximum)") as num
			autoannouncedelay=round(autoannouncedelay)
			if(autoannouncedelay<30) autoannouncedelay=30
			if(autoannouncedelay>180) autoannouncedelay=180

proc/AutoAnnounce()
	set waitfor =0
	set background=1
	while(1)
		if(autoannounce) world << "<span class=\"announce\"><b>Roleplay Tenkaichi (Auto) Announces:</b><br>[autoannounce]</center></span>"
		sleep(600*autoannouncedelay)