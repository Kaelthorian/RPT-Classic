mob/proc/GetStarterBoost() if(!GotStarterBoost)
	if(Base<StarterBoostBP*BPMod&&StarterBoostBP*BPMod>FBMAt)
		FBMAt=1
		FBMCheck()
		Base=StarterBoostBP*BPMod
		usr<<"Starter boost FBM offset applied."
	else if(Base<StarterBoostBP*BPMod) Base=StarterBoostBP*BPMod
//	if(BaseMaxKi<StarterBoostEnergy*KiMod) BaseMaxKi=StarterBoostEnergy*KiMod
//	CapStats(0.5)
	src<<"You have been granted the starter boost for Year [round(Year)]."
	GotStarterBoost=1