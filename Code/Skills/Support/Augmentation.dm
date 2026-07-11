
//var/list/AugmentedMortals=new




/*
mob/proc/Shadow_Crush(mob/M)
	if(Ki<100) return
	usr.Ki=max(0,Ki-100)
	M.TakeDamage(src, ((Pow*BP)/(M.Res*M.BP)), "Shadow Crush")
	//M.Health-=1*((Pow*BP)/(M.Res*M.BP))
	M.KB=rand(3,6)
	new/Icon_Obj/Effects/explosion(M.loc)
	while(M.KB>1&&M)
		if(M.client) M.icon_state="KB"
		M.KB-=1
		M.Knockback()
		step_away(M,usr,50)
		sleep(1)
	if(M&&M.icon_state!="KO") M.icon_state=""

Skill/Buff/AugmentedMaster
	var/LastUse=0
	var/UnusedAugments=3
	var/TotalAugments=3
	BP=1.6
	Recov=1.2
	GetDescription()
		return "[BP]x BP and your energy levels affect your current BP much less than normal. (100-70% instead of 100-0% scaling based on current energy)"
		..()
	verb/Augmented_Master()
		set category="Skills"
		if(usr.RPMode) return
		if(!Using)
			if(usr.BuffNumber>=usr.BuffLimit)
				usr.BuffOut("You are already using too many buffs.")
				return
			Using=1
			usr.BPMult*=BP
			usr.RecovMult*=Recov
			usr.KiDoesNotAffectBP=1
			usr.BuffNumber++
			usr.Buffs+="Augmented Master"
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s power suddenly increases greatly!")
		else usr.AugmentMasterRevert()
	verb/Augment()
		set category="Skills"
		if(Year<LastUse+1)
			usr<<"You cannot use this until year [LastUse+1]"
			return
		if(!UnusedAugments)
			usr<<"You have no remaining augmentation slots."
			return
		var/list/People=new
		for(var/mob/A in view(usr)) if(A.client&&!(locate(/Skill/Buff/AugmentedMaster) in A)&&!(locate(/Skill/Buff/MachineForce) in A)) if(A.Race!="Kaio"&&A.Race!="Demon"&&A.Race!="Android") if(!A.AndroidLevel) People+=A
		//People+=usr
		var/mob/A=input("Augment who? (Can not Augment Kaio/Demon/Android or Cyberized)") in People
		if(A.BlackWaterPower)
			usr<<"The Black Water Mist makes them immune."
			return
		switch(alert(A,"[usr] wants to augment you with artificial power. This will changed you into something else entirely. You will also lose the ability to mate. Accept?","Augment","Yes","No"))
		//switch(input(A,"[usr] wants to augment you with artificial power.  This will changed you into something else entirely. You will also lose the ability to mate. Do you accept?") in list("Yes","No"))
			if("No")
				view(usr)<<"[A] declines the offer from [usr]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [A] declines the offer from [usr]. (AugmentedPower)\n")
				A.saveToLog("|  | ([A.x], [A.y], [A.z]) [A] declines the offer from [usr]. (AugmentedPower)\n")
			if("Yes")
				view(usr)<<"[A] accepts [usr]'s offer"
				LastUse=Year
				//A.Sterile=1
				var/obj/Stun_Chip/B=new
				A.contents+=B
				B.CanRemove=0
				UnusedAugments--
				B.Password="Super Mega Password"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [A] accepts the offer from [usr]. (AugmentedPower)\n")
				A.saveToLog("|  | ([A.x], [A.y], [A.z]) [A] accepts the offer from [usr]. (AugmentedPower)\n")
				if(!(locate(/Skill/Buff/MachineForce) in A)) A.contents+=new/Skill/Buff/MachineForce
				//("[key_name(usr)] augmented [key_name(A)]")
				logAndAlertAdmins("[key_name(usr)] gave [key_name(A)] Augmented Power",2)

/*
	verb/End_Augmentation()
		set category="Skills"
		if(usr.RPMode) return
		var/list/People=new
		People+="Cancel"
		for(var/mob/player/A in Players) if(locate(/Skill/Buff/MachineForce) in A) People+=A
		var/mob/A=input("You can kill anyone who possesses Augmented powers instantly. Who do you want to kill? (You must still RP this)") in People
		if(A=="Cancel") return
		A.AugmentedPowerRevert()
		for(var/Skill/Buff/MachineForce/B in A) del(B)
		//usr.Shadow_Crush(A)
		//AugmentedMortals-=A.ckey
		if(UnusedAugments<TotalAugments) UnusedAugments++
		A.Death("the augmented power within them")
		logAndAlertAdmins("[key_name(usr)] killed [key_name(A)] with Augment Power!",2)*/
	verb/Knockout_Augmentation()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Confirm("Knockout those around you possessing augmented powers? (You must still RP this)"))
			view(usr)<<"[usr] activates their stun controls"
			for(var/mob/A in view(usr))
				A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their stun controls.\n")
				for(var/obj/Stun_Chip/B in A) if(B.Password=="Super Mega Password") A.KO("by stun chip!")
	/*verb/Detonate_Augmentation()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Confirm("Detonate someone around you possessing augmentation powers? (You must still RP this)"))
			var/list/People=new
			People+="Cancel"
			for(var/mob/A in view(usr)) if(locate(/Skill/Buff/MachineForce) in A) People+=A
			var/mob/B=input("You can force anyone with augmented powers around you to self destruct. Who do you choose? (You must still RP this)") in People
			if(B=="Cancel") return
			view(usr)<<"[usr] activates their remote detonator"
			for(var/mob/AA in view(usr))AA.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their remote detonator on [B].\n")
			B.Lethality=1
			B.move=0
			view(20)<<"[B] begins gathering all the energy around him into his body!"
			sleep(30)
			view(20)<<"The ground begins to shake fiercely around [B]!"
			sleep(30)
			if(B.KOd)
				B.move=1
				return
			view(12)<<"A huge explosion eminates from [B] and surrounds the area!"
			for(var/turf/T in view(B,14))
				if(prob(7)) sleep(1)
				if(T) spawn T.Self_Destruct_Lightning(rand(50,100))
				T.TakeDamage(B, 100*B.Pow, "Augment Detonate")
				//T.Health-=100*B.Pow
				spawn(rand(50,100)) {if(usr!=0) T.Destroy(B,B.key);else T.Destroy("Unknown","Unknown")}
				for(var/mob/M in T) if(M!=B)if(!M.afk)
					M.TakeDamage(B, ((B.BP+B.Pow)/(M.BP+M.Res))*120, "Augment Detonate")
					//M.Health-=((B.BP+B.Pow)/(M.BP+M.Res))*120
					if(M.Health<=0)
						if(M.Regenerate&&M.KOd==0) if(B.BP>M.BP*M.Regenerate) M.Absorbed=1
						spawn M.Death(B)
			B.Death("Self Destruct (Augment [usr])")
			B.AugmentedPowerRevert()
			for(var/Skill/Buff/MachineForce/AP in B) del(AP)
			//AugmentedMortals-=B.ckey
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Self Destruct (Augment [usr])")
			B.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Self Destruct (Augment [usr]).\n")
			B.Ki=0
			B.move=1*/

mob/proc/AugmentMasterRevert() for(var/Skill/Buff/AugmentedMaster/AP in src) if(AP.Using)
	BuffNumber--
	Buffs-="Augmented Master"
	AP.Using=0
	KiDoesNotAffectBP=0
	BPMult/=AP.BP
	RecovMult/=AP.Recov
	for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s power returns to normal.")


*/

