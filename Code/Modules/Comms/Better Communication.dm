mob/verb/StopPing()
	set hidden=1
	winset(usr.client, "mainwindow","flash=0")
mob/var/tmp/CanPing=1
mob/verb/Alert_Player(mob/M in oview(12))
	//set category="Other"
	if(!M.client) return
	if(!CanPing) return
	CanPing=0
	winshow(M.client,"Ping",1)
	winset(M, "mainwindow","flash=-1")
	M<<output("From: [usr]","Ping.From")
	spawn(300) CanPing=1
mob/verb/Point_To(mob/M in oview(12))
//	set category="Other"
	if(!M.client) return
	if(!CanPing) return
	CanPing=0
	for(var/mob/O in view(usr)) O.AllOut("[usr] points at [M]")
	spawn(300) CanPing=1
/*
mob/verb/Appreciate(mob/M in oview(12))
//	set category="Other"
	if(!M.client) return
	if(!CanPing) return
	CanPing=0
	for(var/mob/O in view(usr)) O.AllOut("[usr] appreciates [M]")
	spawn(300) CanPing=1
*/
mob/verb/Set_Target(var/mob/M in oview(20))
	set category="Other"
	usr.Target=M
	if(Target) usr<<"Target Acquired ([M])"

mob/verb/Clear_Target()
	set category="Other"
	if(usr.Target) Target=null

mob/proc/TargetCheck() if(ismob(Target))
	if(!src.client.holder)
		if(Target.KOd)
			if(client) src.BuffOut("You lose track of [Target] due being knockdown.")
			Target=null
//		if(Target.z!=z)
//			if(client) src.BuffOut("You lose track of [Target] due to their distance from you.")
//			Target=null
		if(get_dist(src,Target)>30)
			if(client) src.BuffOut("You lose track of [Target] due to their distance from you.")
			Target=null


mob/proc
	AllOut(text)
		src<<output("[text]","output")
		src<<output("[text]","output2")
		src<<output("[text]","output3")
	BuffOut(text)
		src<<output("[text]","output")
		src<<output("[text]","output2")
		src<<output("[text]","output3")
		src<<output("[text]","IC.ICoutput")
		src<<output("[text]","IC2.ICoutput2")
		src<<output("[text]","IC3.ICoutput3")
		src<<output("[text]","Combat.Combatoutput")
		src<<output("[text]","Combat2.Combatoutput2")
		src<<output("[text]","Combat3.Combatoutput3")
	ICOut(text)
		src<<output("[text]","output")
		src<<output("[text]","output2")
		src<<output("[text]","output3")
		src<<output("[text]","IC.ICoutput")
		src<<output("[text]","IC2.ICoutput2")
		src<<output("[text]","IC3.ICoutput3")
	OOCOut(text)
		src<<output("[text]","OOC.OOCoutput")
		src<<output("[text]","OOC2.OOCoutput2")
		src<<output("[text]","OOC3.OOCoutput3")
	CombatOut(text)
		src<<output("[text]","Combat.Combatoutput")			//src<<output("[text]","Combat.Combatoutput")
		src<<output("[text]","Combat2.Combatoutput2")		//src<<output("[text]","Combat2.Combatoutput2")
		src<<output("[text]","Combat3.Combatoutput3")		//src<<output("[text]","Combat3.Combatoutput3")
	HelpOut(text)
		src<<output("[text]","Help.helpoutput")
	AdminOut(text)
		src<<output("[text]","output")
		src<<output("[text]","output2")
		src<<output("[text]","output3")
		src<<output("[text]","Help.helpoutput")
	DebugLogs(text)
		src<<output("[text]","DebugLog")
	DebugLogsSaves(text)
		src<<output("[text]","DebugLogsSaves")
	DebugLogsTraining(text)
		src<<output("[text]","DebugLogsTraining")