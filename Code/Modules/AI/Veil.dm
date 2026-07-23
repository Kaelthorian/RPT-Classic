var/Veil 				= 50
var/DemonicTravel		= 0
var/AngelicalTravel		= 0
var/VeilState			= "Close"
var/NormalTravel		= 0


proc/VeilCheck()
	if(Veil <0)

proc/VeilLose()
	Veil--
	for(var/mob/player/A in Players)
		if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
			A<<"<big><b><font color=red>The veil of the afterlife has grow weaker.</b></big>"

proc/VeilWin()
	Veil++
	for(var/mob/player/A in Players)
		if(A.z==11 || A.Race=="Kaio" || A.Race=="Demon"||A.Magic_Potential>5)
			A<<"<big><b><font color=red>The veil of the afterlife has grow stronger.</b></big>"