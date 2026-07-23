var/MaxBP				= 0
var/tmp/HighestBP		= 0
var/tmp/HighestBPBase	= 0
var/TrainingTic			= 0

proc/HighestBPCheck()
	for(var/mob/M in Players)
		HighestBPBase = (M.Base/M.BPMod)
		if(HighestBPBase > HighestBP)
			HighestBP = HighestBPBase
