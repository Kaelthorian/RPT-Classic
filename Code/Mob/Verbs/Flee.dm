mob/verb/Flee()
	set category="Other"
//	usr<<"Flee rules have changed. (Essentially, all parties attempting to Flee use the flee command to get their 'speed' and then the chasers do the same.  If the chasers win, another round of combat happens, if those fleeing win, they can run away.)"
	var/Which=input("Fleeing or Chasing?") in list("Flee","Chase","Cancel")
	if(Which=="Cancel") return
	var/FromWho
	if(Which=="Chase") FromWho=input("Chase who?") as mob in oview(usr)
	var/FleeRoll=rand(1,20)
	var/RollAdd=0
	if(locate(/Skill/Misc/Fly) in usr) RollAdd++
	if(locate(/Skill/Zanzoken) in usr) RollAdd++
	if(locate(/Skill/Buff/Godspeed) in usr) RollAdd+=5
	if(locate(/Skill/Attacks/T3/SolarFlare) in usr) RollAdd+=2
	if(locate(/Skill/Support/Teleport) in usr) RollAdd+=4
	if(locate(/Skill/Attacks/Time_Freeze) in usr) RollAdd++
	else if(locate(/Skill/Support/DemonTeleport) in usr) RollAdd+=4
	else if(locate(/Skill/Support/InstantTransmission) in usr) RollAdd+=3
	else if(locate(/Skill/Spell/Create_Portal) in usr) RollAdd+=2
	else if(locate(/obj/items/Transporter_Watch) in usr) RollAdd+=2
	if(locate(/Skill/Support/Invisibility) in usr) RollAdd+=3
	else if(locate(/obj/items/Cloak_Controls) in usr) RollAdd+=2
	if(locate(/obj/items/Aspect_of_Flight) in usr) RollAdd+=3
	if(HasSwiftReflexes) RollAdd++
	if(HasDeftHands) RollAdd++
	if(HasCooldownMastery) RollAdd++
	if(HasZanzokenMaster) RollAdd++
	if(HasFlightMaster) RollAdd++
	if(Cyber_Right_Leg) RollAdd++
	if(Cyber_Left_Leg) RollAdd++
	if(Precognition) RollAdd+=3
	if(HasRapidDeployment)RollAdd+=2
	//if(HasBeastOfBurden) RollAdd--
	//if(HasSturdyBuild) RollAdd--
	RollAdd+=round(SpdMod*1.5)
	if(Willpower/MaxWillpower<0.7) RollAdd--
	if(Willpower/MaxWillpower<0.5) RollAdd--
	if(Willpower/MaxWillpower<0.3) FleeRoll=max(1,FleeRoll-4)
	if(Willpower/MaxWillpower<0.2) RollAdd--
	if(Willpower/MaxWillpower<0.1) RollAdd--
	for(var/obj/items/Artifact/A in src)
		if(locate(/obj/items/Artifact) in usr)
			RollAdd += A.ArtifactRollAdd
	for(var/mob/M in range(20,usr))
		if(Which=="Flee") M.AllOut("<font color = red>[usr] attempted to [Which] and got [FleeRoll+RollAdd+usr.FleeAdd] ([FleeRoll] + <font color=yellow>[RollAdd+usr.FleeAdd]<font color = red>) Note: All chase rolls will be considered IC. Do not use this as an opportunity to 'test' your chase roll. .")
		else M.AllOut("<font color = red>[usr] attempted to [Which] [FromWho] and got [FleeRoll+RollAdd+usr.FleeAdd] ([FleeRoll] + <font color=yellow>[RollAdd+usr.FleeAdd]<font color = red>) Note: All chase rolls will be considered IC. Do not use this as an opportunity to 'test' your chase roll. .")
		M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] attempted to Flee/Chase and got [FleeRoll+RollAdd+FleeAdd] ([FleeRoll] + [RollAdd+usr.FleeAdd])\n")

mob/verb/Test_Flee()
	set category="Other"
//	usr<<"Flee rules have changed. (Essentially, all parties attempting to Flee use the flee command to get their 'speed' and then the chasers do the same.  If the chasers win, another round of combat happens, if those fleeing win, they can run away.)"
	var/Which=input("Fleeing or Chasing?") in list("Flee","Chase","Cancel")
	if(Which=="Cancel") return
	var/FromWho
	if(Which=="Chase") FromWho=input("Chase who?") as mob in oview(usr)
	var/FleeRoll=rand(1,20)
	var/RollAdd=0
	if(locate(/Skill/Misc/Fly) in usr) RollAdd++
	if(locate(/Skill/Zanzoken) in usr) RollAdd++
	if(locate(/Skill/Buff/Godspeed) in usr) RollAdd+=5
	if(locate(/Skill/Attacks/T3/SolarFlare) in usr) RollAdd+=2
	if(locate(/Skill/Support/Teleport) in usr) RollAdd+=4
	if(locate(/Skill/Attacks/Time_Freeze) in usr) RollAdd++
	else if(locate(/Skill/Support/DemonTeleport) in usr) RollAdd+=4
	else if(locate(/Skill/Support/InstantTransmission) in usr) RollAdd+=3
	else if(locate(/Skill/Spell/Create_Portal) in usr) RollAdd+=2
	else if(locate(/obj/items/Transporter_Watch) in usr) RollAdd+=2
	if(locate(/Skill/Support/Invisibility) in usr) RollAdd+=3
	else if(locate(/obj/items/Cloak_Controls) in usr) RollAdd+=2
	if(locate(/obj/items/Aspect_of_Flight) in usr) RollAdd+=3
	if(HasSwiftReflexes) RollAdd++
	if(HasDeftHands) RollAdd++
	if(HasCooldownMastery) RollAdd++
	if(HasZanzokenMaster) RollAdd++
	if(HasFlightMaster) RollAdd++
	if(Cyber_Right_Leg) RollAdd++
	if(Cyber_Left_Leg) RollAdd++
	if(Precognition) RollAdd+=3
	if(HasRapidDeployment)RollAdd+=2
	//if(HasBeastOfBurden) RollAdd--
	//if(HasSturdyBuild) RollAdd--
	RollAdd+=round(SpdMod*1.5)
	if(Willpower/MaxWillpower<0.7) RollAdd--
	if(Willpower/MaxWillpower<0.5) RollAdd--
	if(Willpower/MaxWillpower<0.3) FleeRoll=max(1,FleeRoll-4)
	if(Willpower/MaxWillpower<0.2) RollAdd--
	if(Willpower/MaxWillpower<0.1) RollAdd--
	for(var/obj/items/Artifact/A in src)
		if(locate(/obj/items/Artifact) in usr)
			RollAdd += A.ArtifactRollAdd
	for(var/mob/M in range(20,usr))
		if(Which=="Flee") M.AllOut("<font color = green>[usr] attempted to [Which] and got [FleeRoll+RollAdd+usr.FleeAdd] ([FleeRoll] + <font color=red>[RollAdd+usr.FleeAdd]<font color = green>)THIS IS A TEST ROLL WILL NOT COUNT TOWARD IC ACTIONS")
		else M.AllOut("<font color = green>[usr] attempted to [Which] [FromWho] and got [FleeRoll+RollAdd+usr.FleeAdd] ([FleeRoll] + <font color=red>[RollAdd+usr.FleeAdd]<font color = green>)THIS IS A TEST ROLL WILL NOT COUNT TOWARD IC ACTIONS")
