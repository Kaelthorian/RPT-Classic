mob/var/tmp/DeathAnger=0
mob/var/Emotion="<font color=#FFFFCC>Calm</font>"
mob/var/FirstTransWP=0


mob/proc/FirstTransWPRestore(mob/P,check=1) if(P.FirstTransWP<check)
	for(var/mob/player/M in view(P)) M.BuffOut("[P] has their willpower restored as they transend to new heights!")
	if(P.Willpower<P.MaxWillpower-20)P.Willpower=P.MaxWillpower-20
	P.FirstTransWP++
	if(P.Health<P.Willpower)P.Health=P.Willpower
mob/proc/Anger(DA=0) if(!Anger_Restoration)
	Anger_Restoration=1
	if(Anger<MaxAnger+(DeathAnger*35))
		if(Race!="Android")
			Anger=MaxAnger+(DeathAnger*35)
	EmotionCheck()
	if(DA)
		BeenDeathAngry++
	if(Global_SSJ)
		if(Race=="Saiyan"||Race=="Half-Saiyan") if(WipeDay>=21&&!HasSSj)
			HasSSj=1
			usr<<"You can feel your body growing to a new level of power and you can feel a surge of energy deep within you. (SSj Unlocked)"
			logAndAlertAdmins("[src] unlocked SSj",1)
		if(Race=="Heran"||Race=="Half-Heran")if(WipeDay>=21&&!HasBojack)
			HasBojack=1
			usr<<"You can feel your body growing to a new level of power and you can feel a surge of energy deep within you. (Bojack Unlocked)"
			logAndAlertAdmins("[src] unlocked Bojack",1)
		if(Race=="Alien"||Race=="Kanassa"||Race=="Half-Alien") if(!HasAlienTrans&&Base/BPMod>=Tier1Req)
			HasAlienTrans=1
			usr<<"You can feel your body growing to a new level of power and you can feel a surge of energy deep within you. (Transformation Unlocked)"
			logAndAlertAdmins("[src] unlocked Alien Trans",1)
	if(Global_SSJ2)
		if(HasSSj&&HasSSj<2&&WipeDay>=31)
			HasSSj=2
			usr<<"You have awakened the ability to tap into a power even greater than Super Saiyan! (SSj 2 Unlocked)"
			logAndAlertAdmins("[src] unlocked SSj 2",1)
		if(HasBojack&&HasBojack<2&&WipeDay>=31)
			HasBojack=2
			usr<<"You have awakened the ability to tap into a power even greater than Bojack! (Super Bojack Unlocked)"
			logAndAlertAdmins("[src] unlocked Super Bojack",1)


mob/proc/Calm()
	if(RPMode) return
	Anger=100
	Emotion="<font color=#FFFFCC>Calm</font>"
	if(!LethalCombatTracker)DeathAnger=0
	Anger_Restoration=0

mob/proc/Add_Anger(DamageTaken) if(Anger<MaxAnger+(DeathAnger*35))
	if(HasSaltOfTheEarth) DamageTaken*=2
	Anger+=(DamageTaken)*(MaxAnger/100)
	if(Anger>MaxAnger+(DeathAnger*35))Anger=MaxAnger+(DeathAnger*35)

mob/var/SecondWindCD=0
mob/var/RefuseToDieCD=0
mob/var/BurningDesireCD=0
mob/var/BurningDesireAttacks=0
mob/var/tmp/SWTF=0
mob/proc/DecisiveRegen()
	var/HH=0.05*(MaxHealth)
	HealDamage("Decisive Blow Dealt", HH)

mob/proc/SecondWind()
	if(!SecondWindCD)
		Anger()
		if(Health<50) Health=50
		if(Ki<MaxKi*0.5) Ki=MaxKi*0.5
		if(HasAsLongAsMyHeartBeats) SecondWindCD=450
		else SecondWindCD=600
		for(var/mob/M in view(src)) M.BuffOut("[src] steadies themselves and catches a second wind!")
		spawn(5) if(Health<50) Health=50
		spawn(10) if(Health<50) Health=50
		spawn(15) if(Health<50) Health=50
//	else src<<"You are too injured to ready yourself for combat. (Second Wind on CD)"

mob/proc/RefuseToDie()
//	if(!RefuseToDieCD&&LethalCombatTracker&&EventCharacter<1)
//		Anger()
//		if(Willpower<50) Willpower=50
//		if(Health<50) Health=50
//		if(Ki<MaxKi*0.5) Ki=MaxKi*0.5
//		RefuseToDieCD=60000
//		HasRefusedToDie++
//		if(HasRefuseToLose) RefuseToDieCD-=54000
//		for(var/mob/M in view(src)) M.BuffOut("[src] gathers the last of their willpower and refuses to die!")
//		spawn(5) if(Health<50) Health=50
//		spawn(10) if(Health<50) Health=50
//		spawn(15) if(Health<50) Health=50
mob/proc/BurningDesireForVictory()
	if(!BurningDesireCD&&LethalCombatTracker)
//		Anger()
//		if(Willpower<50) Willpower=50
//		Health=30
//		if(Ki<MaxKi*0.5) Ki=MaxKi*0.5
//		BurningDesireCD=60000
//		if(HasRefuseToLose) BurningDesireCD-=54000
		BurningDesireAttacks=3
//		HasBurnedForVictory++
		for(var/mob/M in view(src)) M.BuffOut("[src]'s burning desire for victory allows them to continue fighting! Their resolve will empower their next few attacks!")
//		spawn(5) if(Health<30) Health=30
//		spawn(10) if(Health<30) Health=30
//		spawn(15) if(Health<30) Health=30
mob/proc/EmotionCheck()
	var/OldEmotion=Emotion
	if(Anger<(((MaxAnger-100)/5)+100)) Emotion="<font color=#FFFFCC>Calm</font>"
	if(Anger>(((MaxAnger-100)/5)+100)) Emotion="<font color=#FF6699>Annoyed</font>"
	if(Anger>(((MaxAnger-100)/2.5)+100)) Emotion="<font color=#FF6600>Slightly Angry</font>"
	if(Anger>(((MaxAnger-100)/1.66)+100)) Emotion="<font color=#CC3300>Angry</font>"
	if(Anger>(((MaxAnger-100)/1.25)+100)) Emotion="<font color=#FF0000>Very Angry</font>"
	if(Anger>100) if(AndroidLevel||Race=="Android") Emotion="<font color=#00FFFF>Erratic and Unpredictable</font>"
	if(OldEmotion!=Emotion)
		for(var/mob/player/M in view(src)) M.CombatOut("[src] has become [Emotion]!")
		src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] gets angry!\n")



////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////New Anger System////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
mob/var

	list/HitterListNew = new()
	list/HitterListOld = new()
	AngerChance = 100
	LastHitter
	FailToAnger

mob/proc/AngerCheck()
	var/DiceRoll
	src.FailToAnger=0																//I don't think is needed at all but better be careful than sorry , set the fail to anger back to 0
	if(src.EventCharacter==1) return												//Filter for ECs so they don't proc this.
	if(src.LastHitter in src.Team.Members) return									//If the last guy who hitted you is in your team , return
	if(src.Team.Members.len == 2) src.AngerChance -= 20
	if(src.Team.Members.len == 3) src.AngerChance -= 40
	if(src.Team.Members.len == 4) src.AngerChance -= 60
	if(src.Team.Members.len == 5) src.AngerChance -= 80
	if(src.Team.Members.len >= 6) src.AngerChance -= 100
	DiceRoll=rand(1,100)															//Roll for the chance to anger
//	world<<"DiceRoll: [DiceRoll]/ AngerChance: [src.AngerChance]"					//Debug tool
//	world<<"Last Hitter: [src.LastHitter.]"											//Debug tool
//	world<<"Last HitterListNew: [src.HitterListNew.len]"							//Debug tool
//	world<<"Last HitterListOld: [src.HitterListOld.len]"							//Debug tool
//	world<<"Last src HP: [src.Health]"
//	world<<"Last usr HP: [usr.Health]"
	if( DiceRoll <= AngerChance)													//Roll for the chance to anger
		if(src.LastHitter in src.HitterListNew)										//If the last guy who hitted me is in the list of the guys who is hitting me in Lethal
			if(src.Willpower >=50)													//and if my WP is above 50
				src.Health = 50														//Then heal me
			if(src.Willpower <50)													//And if my WP is below of 50
				src.Health = src.Willpower											//Then heal me
			src.HitterListNew.Remove(LastHitter)									//Remove the guy who anger me from the list of ppl who is hitting me
			src.HitterListOld.Add(LastHitter)										//Add the guy who anger me to the list of ppl who already anger me
//			world<<"Last src HP After: [src.Health]"
//			world<<"Last usr HP After: [usr.Health]"
//			world<<"Last HitterListNew after the heal: [src.HitterListNew.len]"		//Debug tool
//			world<<"Last HitterListOld after the heal: [src.HitterListOld.len]"		//Debug tool
			range(10,src)<<"<font color=#FF0000>[src.name] fixes their stance and prepares to continue fighting!</font>"
			src.AngerChance = 100													//Restore the anger chance to 100
			return
	range(10,src)<<"<font color=#FF0000>[src.name] attempts to fix his stance and fight back but blacksout.</font>"
	src.FailToAnger=1																//Set Fail to anger to 1 , so the game reads that you already try and fail and you don't loop forever until you roll and heal.
	src.AngerChance = 100															//Restore the anger chance to 100
//	world<<"Last HitterListNew after the heal: [src.HitterListNew.len]"				//Debug tool
//	world<<"Last HitterListOld after the heal: [src.HitterListOld.len]"				//Debug tool
	return
mob/proc/
	HitterListCheck(mob/M)															//List of hitters proc
		if(!src.LethalCombatTracker)												//If the Lethal Combat Tracker is 0
			src.LastHitter=0														//Set Last Hitter to 0
			return																	//Go back home amigo
		if(M in src.HitterListNew){ return TRUE}									//If the guy who last hitted me is already in the list then do nothing
		if(M in src.HitterListOld){ return TRUE}									//If the guy who is in the list of ppl who already ANGER me , do nothing.
		src.HitterListNew.Add(M)													//Add the guy to the list of persons who is hitting me in Lethal.
