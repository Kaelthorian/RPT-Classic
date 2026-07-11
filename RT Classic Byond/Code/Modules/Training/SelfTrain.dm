mob/var/tmp/Training
mob/verb/Train()
	set category="Other"

	if(usr.icon_state=="Meditate"||usr.Flying||usr.KOd||usr.icon_state=="KB"||usr.attacking||usr.afk||usr.isGrabbing||usr.IsBlocking||usr.DashAttacking||usr.Meditate||usr.Study) return

	if(usr.SelectionScreen == 1)
		usr<<"You can't do this while deciding what to study."
		return

	if(!usr.Training)
		usr.Training=1
		usr<<"You begin to train."
		dir=SOUTH
		icon_state="Train"
	else
		usr.Training=0
		usr<<"You stop training."
		icon_state=""
		return

	if(usr.Ki!=usr.MaxKi)
		usr<<"You must have 100% of your energy to start training"
		icon_state=""
		usr.Training=0
		return
	usr.Ki--

	while(usr.Training)

//FBM check
		usr.FBMCheck()
		HighestBPCheck()

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
		if(!usr.Training)
			usr<<"You stop training."
			return
		sleep(50)