mob/var/tmp/Meditate
mob/var/tmp/MeditateStandUp
mob/verb/Meditate()
	set category="Other"
	if(usr.Flying||usr.KOd||usr.icon_state=="KB"||usr.attacking||usr.afk||usr.isGrabbing||usr.IsBlocking||usr.DashAttacking||usr.Training||usr.Study) return

	if(usr.SelectionScreen == 1)
		usr<<"You can't do this while deciding what to study."
		return
	if(usr.MeditateStandUp)
		return
	if(!usr.Meditate)
		usr.Meditate=1
		usr<<"You begin to meditate."
		dir=SOUTH
		icon_state="Meditate"
	else
		usr.MeditateStandUp=1
		usr<<"You prepare to stand up."
		sleep(20)
		usr.Meditate=0
		usr.MeditateStandUp=0
		usr<<"You stop meditating."
		icon_state=""
		return

//	HighestBPCheck()
	usr.Learn()

	while(usr.Meditate)
//FBM check
		usr.FBMCheck()
		HighestBPCheck()
//Ki regeneration while meditating
		DebugLogsTraining("----------------------------------------","Training")
		if(usr.Ki<usr.MaxKi)
			usr.Ki= usr.Ki+(0.1*usr.MaxKi*usr.Recovery)
			if(usr.Ki>usr.MaxKi)
				usr.Ki=usr.MaxKi

		MaxBP=TrueBPCap*(400000/150)**(Year/40)
		DebugLogsTraining("MaxBP		= [MaxBP]","Training")
		DebugLogsTraining("HighestBP	= [HighestBP]","Training")
//		DebugLogsTraining("HighestBPBase	= [HighestBPBase]","Training")
		TrainingTic = ((MaxBP - (usr.Base/usr.BPMod)) * 0.0003)
		DebugLogsTraining("TrainingTic	= [TrainingTic * usr.BPMod]","Training")

		if((usr.Base/usr.BPMod) < (HighestBP * 0.95))
			TrainingTic *= 1.5
			DebugLogsTraining("TrainingTic*1.5	= [TrainingTic * usr.BPMod]","Training")
		if((usr.Base/usr.BPMod) < (HighestBP * 0.9))
			TrainingTic *= 2
			DebugLogsTraining("TrainingTic*2	= [TrainingTic * usr.BPMod]","Training")
		if((usr.Base/usr.BPMod) < (HighestBP * 0.8))
			TrainingTic *= 2
			DebugLogsTraining("TrainingTic*2	= [TrainingTic * usr.BPMod]","Training")
		if(RaceEraCurrent == usr.Race)
			TrainingTic *= 1.05
			DebugLogsTraining("TrainingTic*1.05	= [TrainingTic * usr.BPMod]","Training")
		if(usr.EXPLifetime > MaxEXPReward- 50)
			TrainingTic *= 0.8
			DebugLogsTraining("TrainingTic*0.8	= [TrainingTic * usr.BPMod]","Training")
		if((usr.Base/usr.BPMod) >= MaxBP)
			TrainingTic *= 0
			DebugLogsTraining("TrainingTic*0	= [TrainingTic * usr.BPMod]","Training")








		DebugLogsTraining("TrainingTic Total= [TrainingTic * usr.BPMod]","Training")
		DebugLogsTraining("[usr.name]'Base		= [usr.Base/usr.BPMod]","Training")
		DebugLogsTraining("Total	TrainingTic * usr.BPMod:[TrainingTic * usr.BPMod]+ Base:[usr.Base]= [(usr.Base + (TrainingTic * usr.BPMod ))/usr.BPMod] ","Training")
		usr.Base= usr.Base + (TrainingTic * usr.BPMod )
		if(!usr.Meditate)
			usr<<"You stop meditating."
			return
		sleep(50)