
mob/var
	FBMAchieved=0
	FBMAt=1000000
	HybridFBM=0
	FBMMult=1
	AscensionMult=1
	//AscensionAchieved=0



mob/proc/FBMCheck()
/*
	if(Global_Trans)
		if(Race=="Alien"&&!HasAlienTrans&&Base/BPMod>=Tier1Req)
			HasAlienTrans=1
			src<<"You have awoken a dormant power deep within yourself."
			contents+=new/Skill/Buff/AlienTransformation
		if(Race=="Kanassa"&&!HasAlienTrans&&Base/BPMod>=Tier1Req)
			HasAlienTrans=1
			src<<"You have awoken a dormant power deep within yourself."
			contents+=new/Skill/Buff/AlienTransformation
		if(Race=="Half-Alien"&&!HasAlienTrans&&Base/BPMod>=Tier1Req)
			HasAlienTrans=1
			src<<"You have awoken a dormant power deep within yourself."
			contents+=new/Skill/Buff/AlienTransformation
		if("Makyo Transform"in LearnList)
			if(Base/BPMod>Tier1Req&&!locate(/Skill/Buff/MakyoForm) in src)
				contents+=new/Skill/Buff/MakyoForm
				src<<"You have learned your races transformation."
		if("Physics Simulation" in LearnList)
			if(Base/BPMod>=Tier1Req&&!locate(/Skill/Buff/PhysicsSimulation) in src)
				contents+=new/Skill/Buff/PhysicsSimulation
				src<<"...Your mind is your most powerful weapon. Through extensive wisdom and intelligence, you have earned the ability to simulate battles within your mind. The process is taxing and can only be done for so long, but its power is virtually unrivaled."
		if("Third Eye" in LearnList)
			if(Base/BPMod>Tier1Req&&!locate(/Skill/Buff/Third_Eye) in src)
				contents+=new/Skill/Buff/Third_Eye
				src<<"You acquired the ability to unlock your third eye chakra."
		if(Race=="Demigod")
			if(Base/BPMod>=Tier1Req&&!(locate(/Skill/Buff/Pantheon) in src)) // Mumit added BPMod division
				contents+=new/Skill/Buff/Pantheon
				src<<"You have awoken your inner God. You can channel the power of your ancestors!"
		if("Mystic" in LearnList)
			if(Base>Tier1Req&&!(locate(/Skill/Buff/Mystic) in src)) // Mumit added BPMod division
				contents+=new/Skill/Buff/Mystic
				src<<"You have awoken your race's natural ability. (Mystic)"
		if("Majin" in LearnList)
			if(Base>Tier1Req&&!(locate(/Skill/Buff/Sin_Force) in src)) // Mumit added BPMod division
				contents+=new/Skill/Buff/Sin_Force
				src<<"You have awoken your race's natural ability. (Majin)"
		if("Giant Mode" in LearnList)
			if(Base/BPMod>Tier1Req&&!locate(/Skill/Buff/Giant_Mode) in src)
				src<<"You have awakened your race's hidden technique... Use it wisely."
				contents+=new/Skill/Buff/Giant_Mode
		if("Super Maximum Light Speed Mode" in LearnList)
			if(Base/BPMod>Tier1Req&&!(locate(/Skill/Buff/Super_Maximum_Light_Speed_Mode)in src))
				contents+=new/Skill/Buff/Super_Maximum_Light_Speed_Mode
				src<<"<span class=announce>You feel as though you can push your limits even further..."
/*		if("Swell" in LearnList)
			if(Base/BPMod>=Tier1Req&&!(locate(/Skill/Buff/SwoleDoll) in src))
				contents+=new/Skill/Buff/SwoleDoll
				src<<"<span class=announce>You have awakened to the true power of the Doll. You have survived through hardship and have EARNED true power."
*/
		if(Race=="Spirit Doll")
			if(Base/BPMod>=Tier1Req&&!(locate(/Skill/Buff/SoulDoll) in src))
				contents+=new/Skill/Buff/SoulDoll
				src<<"<span class=announce>You have awakened to the true power of the Doll. You have survived through hardship and have EARNED true power."


//		if(Perfect_Form==1&&!Regenerate&&!(locate(/Skill/Buff/SuperPerfectForm) in src))
//			contents+=new/Skill/Buff/SuperPerfectForm
//			src<<"You have utterly shattered your limitations. Due to your extreme training and high levels of power, you have awakened another evolution...."
//			alertAdmins("[src] has unlocked Super Perfect Form")
//		if(Perfect_Form==1&&Base/BPMod>Tier4Req&&!(locate(/Skill/Buff/SuperPerfectForm) in src))
//			contents+=new/Skill/Buff/SuperPerfectForm
//			src<<"You have utterly shattered your limitations. Due to your extreme training and high levels of power, you have awakened another evolution...."
//			alertAdmins("[src] has unlocked Super Perfect Form")
//Racial Transformations


	if(Race=="Namekian")
		if(Year>=21&&!SNj&&!locate(/Skill/Buff/Super_Namekian) in src)
			contents+=new/Skill/Buff/Super_Namekian
			src<<"You have tapped into potential long thought lost to your people. While your immediate combat prowess has not improved by much, your awareness of your surroundings has dramatically increased. (SNj Unlocked.)"
	if(Race=="Android")
		if(Year>=21&&!locate(/Skill/Buff/Overdrive) in src)
			contents+=new/Skill/Buff/Overdrive
			src<<"You got Overdrive."
	if(Race=="Changeling") if(Year>=21&&HasForm==0) // Mumit added BPMod division
		src<<"You have awoken a dormant power deep within yourself."
		contents+=new/Skill/Buff/ChangelingTransformation
		HasForm=1 // gives form 2 to all changelings
	if (Race=="Changeling"&&Class=="Cooler"&&(Base/BPMod>=Tier1Req)&&HasForm<=1)
		HasForm=2 // gives form 3
		src<<"You've learned unleash more of your natural power, unlocking your third form."
	if (Race=="Changeling"&&Class=="Cooler"&&(Base/BPMod>=Tier2Req)&&HasForm<=2)
		HasForm=3 // gives form 4
		src<<"You've learned to unleash even more of your true natural power, unlocking your fourth form."
	if (Race=="Changeling"&&Class=="Cooler"&&FBMAchieved==1&&HasForm<=3)
		HasForm=4 // gives form 5
		src<<"You've learned to unleash your true natural power, unlocking your fifth and final form."

	if(!FBMAchieved&&Base/BPMod>FBMAt)
		BPMod*=FBMMult
		FBMAchieved=1
		src<<"You are not sure how, but something is different about you now..."
		if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan")
			if(!HasSSj)
				src<<"Your body has awakened to a great new power.  You can feel your body using your natural aptitude for rage and channeling it into something greater..."
				HasSSj=1
		/*if(Race=="Android") if(!locate(/Skill/Buff/FistsOfFury) in src)
			contents+=new/Skill/Buff/FistsOfFury
			src<<"You have awoken a newfound power."*/
		if(Race=="Heran"||Race=="Half-Heran") if(!HasBojack)
			HasBojack=1
			src<<"Your body has awakened to a great new power.  You can feel your body using your natural aptitude for rage and channeling it into something greater..."
		if(Race=="Tuffle")
			src.Int_Mod+=0.5
			src<<"You are one of the few Tuffles who was born with a special mental mutation.  Through much meditation you have learned how to exploit this mutation to your own benefit, increasing your mental capabilities!"
			src<<"Your intelligence soars to super-human heights!"
		if(Race=="Makyojin"||Race=="Half-Makyojin")
			src.Magic_Potential+=0.5
			src<<"Your skill with the arcane grows higher than ever before!"
		if(Race=="Alien") if(!HasAlienTrans) HasAlienTrans=1
	if(Global_SSJ2)
		if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan")
			if(HasSSj<2&&SSjDrain>=300&&Year>31)
				src<<"You have managed to achieve the next level of Super Saiyan."
				HasSSj=2
		if(Race=="Heran"||Race=="Half-Heran") if(HasBojack<2&&SSjDrain>=300&&Year>31)
			HasBojack=2
			src<<"Your body has awakened to an even greater power.  You have unlocked Super Bojack."



	if(Global_Ascension==1&&(Base/BPMod)>Tier6Req)
		/*if(Race=="Saiyan"&&HasSSGSS==0&&SSj2Drain>=300&&SSjDrain>=300&&MaxGodKi>1.5)
			HasSSGSS=1
			src<<"You have been granted SSGSS. Use it wisely."
			contents+=new/Skill/Buff/SSGSS
			//for(var/mob/player/MM in view(15,src)) MM<<'Carl_Orff_35_SEC.wav'
			logAndAlertAdmins("[src] has unlocked SSGSS.",2)*/
		if("Humanism" in LearnList)
			if(Race=="Human"&&Base/BPMod>Tier6Req&&!locate(/Skill/Buff/Humanism) in src)
				contents+=new/Skill/Buff/Humanism
				src<<"You have resisted the temptation of Post Humanism and holding onto your Humanity has lead to an even greater power..."
				logAndAlertAdmins("[src] has unlocked Humanism")
		if(Race=="Kaio"&&!locate(/Skill/Buff/Angelic_Grace) in src)
			contents+=new/Skill/Buff/Angelic_Grace
			src<<"You feel as though you can nearly unlock the true depths of your power..."
		if(Race=="Demon"&&!locate(/Skill/Buff/Demonic_Fury) in src)
			contents+=new/Skill/Buff/Demonic_Fury
			src<<"You feel as though you can nearly unlock the true depths of your power..."
		if(Race=="Changeling"&&FBMAchieved==1)
			if(HasForm>=1&&HasForm<5)
				src<<"You feel as though you can nearly unlock the true depths of your power..."
				src.HasForm=5


/*
	if(Global_GodKi==1&&(Base/BPMod)>Tier6Req)
		if(Race=="Kaio"&&Rank=="Kaio") for(var/Skill/Buff/Mystic/M in src) M.Super=1
		if(Race=="Demon"&&Rank=="Demon") for(var/Skill/Buff/Sin_Force/M in src) M.Super=1
		if(AscensionMult>1&&FBMAchieved==1)
			BPMod*=AscensionMult
			FBMAchieved=2
			src<<"You have achieved a power beyond your previous limits. You have ascended even further beyond!"
			alertAdmins("[src] has unlocked their second ascension!")
	if(Global_GodKi==1&&Global_GodKiTrain&&Race=="Android")
		if(AscensionMult>1&&FBMAchieved==1)
			BPMod*=AscensionMult
			FBMAchieved=2
			src<<"You have achieved a power beyond your previous limits. You have ascended even further beyond!"
			alertAdmins("[src] has unlocked their second ascension!")*/




*/