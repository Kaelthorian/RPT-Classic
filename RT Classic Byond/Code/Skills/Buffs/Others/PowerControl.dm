var/PowerControlCap=12.5
mob/var/TargetPower

proc/PULoop(mob/A)
	var/tmp/IsPu
	if(IsPu)
		return
	while(A.BPpcnt<=A.TargetPower)
		IsPu=1
		A.BPpcnt+= max(2,A.Recovery)*(1+A.HasPCExpert)
		sleep(5)
		if(A.BPpcnt>A.TargetPower)
			A.BPpcnt=A.TargetPower
			IsPu=0
			A.BuffOut("You reach [A.TargetPower]% power and stop powering up.")
			A.Cancel_PowerControl()
			A.AuraOverlays()
			break

Event/Timer/PowerControl
	var/tmp/mob/player
	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 50)
		src.player = D
	fire()
		..() // Make sure we allow the /Event/Timer fire() to do it's thing.
//		world<<"Here"
		if(player.KOd){player.Cancel_PowerControl();player.BuffOut("You are no longer able to hold your power");player=null;return}
		//spawn(5) hearers(6,player) << 'Power_Control_Continuous.wav'
		var/PUCap=100+((PowerControlCap+(player.HasControlOfPower*3))*player.Recovery)
		if(player.ismystic) PUCap+=10
		for(var/Skill/Buff/Power_Control/A in player.contents) if(!player.RPMode)
			if(player.KOd&&A.Powerup)
				A.Powerup=0
				player.AuraOverlays()
				player.Cancel_PowerControl()
				player=null
				return
			if(A.Powerup&&A.Powerup!=-1)
				if(A.Powerup==3)
					if(player.BPpcnt<A.TargetPower) player.BPpcnt += max(2,player.Recovery)*(1+player.HasPCExpert)
					else
						A.Powerup=0
						player.BuffOut("You reach [A.TargetPower]% power and stop powering up.")
						player.AuraOverlays()
						player.Cancel_PowerControl()
						if(player.BPpcnt>PUCap) player.BPpcnt=PUCap
						player=null
						//if(player.BPpcnt>100+(PowerControlCap*player.Recovery)) player.BPpcnt=100+(PowerControlCap*player.Recovery)
						return
				if(player.icon_state=="Meditate"&&player.BPpcnt>=99){player.BPpcnt=100;return}
				else if(player.BPpcnt<PUCap)
					if(player.HasPCExpert)player.BPpcnt += max(2,player.Recovery*1.5)*1.5
					else player.BPpcnt += max(2,player.Recovery*1.5)
			else if(A.Powerup==-1) player.BPpcnt*=0.9

//		if(player.KOd==0&&player.BPpcnt>100) if(!player.RPMode)
//			var/Drain=1.5*(player.BPpcnt-100)
//			if(player.Ki>=Drain*3) player.Ki=max(0,player.Ki-Drain)
		/*	else
				player.BPpcnt=100
				for(var/Skill/Buff/Power_Control/A in player.contents) A.Powerup=0
				player<<"You run out of energy."
				player.AuraOverlays()
				player.Cancel_PowerControl()
				player=null*/

mob/var/tmp/Event/Timer/PowerControl/powercontrol_event = null

mob/proc/Cancel_PowerControl()
	if (src.powercontrol_event)
		src.powercontrol_event.player=null
		spawn src.AuraOverlays()
		src.powercontrol_event = null
		for(var/Skill/Buff/Power_Control/A in src) A.Powerup=0


Skill/Buff/Power_Control
	icon='Aura.dmi'
	layer=MOB_LAYER+2


	buffslot=0
	buffon=""
	buffoff=""
	desc="This will allow you to power up and down.  This increases your BP% at the cost of a passive energy drain the higher you go.  When you power down, you instead gain additional energy per tick.  You can use Power Stabalize to return to 100% power if you aren't at it.  You can use Set Target Power to set a % you want to power up to if you use Power Stabalize while at 100% power."
	var/Powerup=0
	var/TargetPower=100
	verb/Set_Target_Power()
		set category="Other"
		set src = usr.contents
		if(Powerup)
			usr<<"You can not do this while powering up."
			return
		else
			var/PUCap=100+((PowerControlCap+(usr.HasControlOfPower*3))*usr.Recovery)
			if(usr.ismystic) PUCap+=10
			var/NewT=input(usr,"What level would you like to power up to when toggling power stabilize? (100-[PUCap])") as num
			if(NewT<100) return
			if(NewT>PUCap) NewT=PUCap
			TargetPower=NewT
			usr.TargetPower=NewT
			usr.BuffOut("New Target Power Level set to [TargetPower].")
	verb/Power_Up()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		if(usr.Cyborg) return
		if(usr.RPMode) return
		if(usr.KOd) return

		switch(Powerup)
			if(-1)
				usr.BuffOut("You stop powering down")
				Powerup=0
				usr.Cancel_PowerControl()
			if(0)
				SmallDust(usr)
//				usr.powercontrol_event = new(skills_scheduler, usr)
//				kills_scheduler.schedule(usr.powercontrol_event, 50)
				Powerup=1
				usr.BuffOut("You begin powering up")
				usr.AuraOverlays()
//					usr.PC_Drain()
				PULoop(usr)
				if(src) spawn usr.Power_Effects(src)
			else
				if(usr.Race=="Saiyan"||usr.Race=="Half-Saiyan"||usr.Race=="Part-Saiyan")
					if((usr.Base/usr.BPMod)>Tier6Req&&!usr.ssj) usr.SSGSS()
					else if(!usr.ssj&&usr.HasSSj > 0) usr.SSj()
					else if(!usr.ssj) if(Global_SSJ) usr.SSj() // else if(!usr.ssj&&usr.Anger>=usr.MaxAnger) if(Global_SSJ) usr.SSj()
					else if(usr.HasSSj > 1&&usr.ssj == 1&&usr.SSjDrain>=300) usr.SSj2()
				else
					usr.Changeling_Forms()
					usr.Bojack()
					usr.BojackSSj2()
					usr.BojackSSj()


	verb/Power_Down()
		set category="Skills"
		set src = usr.contents
		if(usr.Cyborg) return
		if(usr.RPMode) return
		if(usr.KOd) return
		switch(Powerup)
			if(-1) usr.Cancel_Transformation()
			if(1)
				Powerup=0
				usr.BuffOut("You stop powering up")
				usr.Cancel_PowerControl()
			else
				if(isnull(usr.powercontrol_event))
					usr.powercontrol_event = new(skills_scheduler, usr)
					skills_scheduler.schedule(usr.powercontrol_event, 50)
				Powerup=-1
				usr.BuffOut("You begin powering down")
				hearers(2,usr)<<sound('PowerStabi.mp3',volume=10)

	verb/Power_Stabilize()
		set category="Skills"
		set src = usr.contents
		if(usr.Cyborg) return
		if(usr.RPMode) return
		if(usr.KOd) return
		if(usr.BPpcnt==100&&Powerup==0)
			if(isnull(usr.powercontrol_event))
				usr.powercontrol_event = new(skills_scheduler, usr)
				skills_scheduler.schedule(usr.powercontrol_event, 50)
				SmallDust(usr)
				Powerup=3
				usr.BuffOut("You begin powering up to [TargetPower]%")
				hearers(10,usr)<<sound('PowerStabi.mp3',volume=10)
				usr.AuraOverlays()
				if(src) spawn usr.Power_Effects(src)
				PULoop(usr)
			return
		//TargetPower
		switch(Powerup)
			if(-1) usr.BuffOut("You stop powering down and return to full power.")
			if(1) usr.BuffOut("You stop powering up and return to full power.")
			else usr.BuffOut("You return to full power.")
		Powerup=0
		hearers(2,usr)<<sound('PowerStabi.mp3',volume=10)
		usr.Cancel_PowerControl()
		usr.BPpcnt=100
		usr.AuraOverlays()


mob/proc/Power_Effects(Skill/Buff/Power_Control/A) while(A.Powerup>=1)
	var/Sleep=1600
	if(BP>1000) Sleep=1200
	if(BP>10000) Sleep=800
	if(BP>100000) Sleep=500
	if(BP>1000000) Sleep=300
	if(BP>10000000) Sleep=100
	for(var/turf/B in range(10,src)) if(prob(2)&&A.Powerup>=1)
		B.Rising_Rocks()
		sleep(Sleep*0.1)
	sleep(Sleep)



mob/proc/PC_Drain()
	set background=1
	set waitfor=0
	if(KOd==0&&BPpcnt>100)//&&(_powcontrol.Powerup==0||isnull(_powcontrol.Powerup))

		var/PUCap=100+((PowerControlCap+(HasControlOfPower*3))*Recovery)
		if(ismystic) PUCap+=10
		if(BPpcnt>PUCap) BPpcnt=PUCap
		var/Drain=0.25*((BPpcnt-100)**1.2)/Recovery
		if(BPpcnt>100+(12.5*Recovery)) Drain*=1.1
		if(BPpcnt>100+(10*Recovery)) Drain*=1.1
		if(BPpcnt>100+(8*Recovery)) Drain*=1.1
		if(BPpcnt>100+(6*Recovery)) Drain*=1.1
		if(BPpcnt>100+(4*Recovery)) Drain*=1.1
		if(BPpcnt>100+(3*Recovery)) Drain*=1.1
		if(BPpcnt>100+(2*Recovery)) Drain*=1.1
		if(BPpcnt>100+(1*Recovery)) Drain*=1.1

		if(Ki>=Drain*3)
			if(!RPMode&&BPpcnt>100) Ki=max(0,Ki-Drain)
		else
			BPpcnt=100
			for(var/Skill/Buff/Power_Control/A in contents) A.Powerup=0
			if(Race in list("Saiyan","Half-Saiyan","Alien","Heran","Yardrat","Kanassa")) Cancel_Transformation()
			src << "You are too tired to hold the energy you gathered, your energy levels return to normal."
			Cancel_PowerControl()






var/tmp/EventScheduler/skills_scheduler = new()
var/tmp/EventScheduler/technology_scheduler = new()
var/tmp/EventScheduler/training_scheduler = new()
var/tmp/EventScheduler/LOGscheduler = new()
/**
 * Starts global schedulers for things like technology events etc. Break this and
 * you break digging, technology, training and meditation.
 */
proc/StartGlobalSchedulers()
	technology_scheduler.start() // Digging
	training_scheduler.start() // Training and meditation
	skills_scheduler.start() // Manages skills that require a loop of sorts.
	LOGscheduler.start()

//	Weather()


	//status_scheduler.start() // Status proc

/*
* Stop_Train_Dig_Schedulers()
* As the name suggests, it cancels training and digging,
* this isn't JUST for logging out, but for other events such as being KO'd as well.
*/

mob/proc/Stop_TrainDig_Schedulers()
	set waitfor=0
	set background=1
//	src.Cancel_Training()
//	src.Cancel_Digging()
//	src.Cancel_Meditation()

/*
* All important schedulers that are required to be stopped upon logout.
* Just call the Cancel_ procs in here, less of a hassle to go through the code
* since it's already placed properly.
*/

mob/proc/Cancel_Sched_OnLogout(var/mob/player/M)
	if(!M)
		//spawn src.Cancel_Status_Scheduler() // Status loop that checks health, etc, for that player.
		src.Stop_TrainDig_Schedulers()
		src.RevertAll()

	else if(M)
		//spawn M.Cancel_Status_Scheduler() // Status loop that checks health, etc, for that player.
		M.Stop_TrainDig_Schedulers()
		M.RevertAll()


/*
	__shift_down_events()
		var/list/result = null
		for (var/T in src.__scheduled_events)
			var/A = src.__scheduled_events[T]
			src.__scheduled_events.Remove(T)
			var/index = text2num(T)
			if (--index)
				src.__scheduled_events["[index]"] = A
			else
				result = A
		return result
*/