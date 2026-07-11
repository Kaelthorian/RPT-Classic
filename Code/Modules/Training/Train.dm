mob/proc/Heal_Zenkai()
//	if(ZenkaiPower<Base*0.3)
//		var/Amount=1
//		if(ZenkaiPower) Amount=(Base/(ZenkaiPower*5))**2
//		if(Amount>10) Amount=10
//		var/increase=Amount*100*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*GainMultiplier
//		ZenkaiPower+=increase*BPCapCheck()
//		Base+=increase*BPCapCheck()
//	if(Race=="Saiyan")
//		var/Amount=1
//		if(ZenkaiPower) Amount=(Base/(ZenkaiPower*5))
//		if(Amount>10) Amount=10
//		var/Multiplier=1
//		if(KOd) Multiplier=10
//		var/increase=Amount*5*Multiplier*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*GainMultiplier
//		ZenkaiPower+=increase*BPCapCheck2()
//		Base+=increase*BPCapCheck2()

mob/proc/Zenkai()
//	if(ZenkaiPower<Base*0.3)
//		var/Amount=1
//		if(ZenkaiPower) Amount=(Base/(ZenkaiPower*5))
//		if(Amount>10) Amount=10
//		var/Multiplier=1
//		if(KOd) Multiplier=10
//		var/increase=Amount*10*Multiplier*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*GainMultiplier
//		ZenkaiPower+=increase*BPCapCheck()
//		Base+=increase*BPCapCheck()
//	if(Race=="Saiyan")
//		var/Amount=1
//		if(ZenkaiPower) Amount=(Base/(ZenkaiPower*5))
//		if(Amount>10) Amount=10
//		var/Multiplier=1
//		if(KOd) Multiplier=10
//		var/increase=Amount*1*Multiplier*BPMod*Zenkai*Regeneration*(1+Senzu)*GG*GainMultiplier
//		ZenkaiPower+=increase*BPCapCheck2()
//		Base+=increase*BPCapCheck2()



mob/proc/Death_Zenkai()
//	var/increase= 1*BPMod*Zenkai*Regeneration*GG*GainMultiplier //changed from 50000
//	Base+=increase*BPCapCheck()

mob/proc/CatchUp()
	var/Mult=1
	if(Year>25)
		if(StatRank>=40) Mult++
		if(StatRank>=60) Mult++
		if(StatRank>=80) Mult++
		if(WeightedStats<SoftStatCap*4.5) Mult+=0.5
	if(Year>40)
		if(StatRank>=70) Mult+=0.25
		if(StatRank>=40) Mult+=0.25
	if(HasUsedBookOfLessons+1>=Year) Mult+=5
	else if(HasFoodStatsTrain) Mult+=0.25
	if(HasVitamins) Mult+=0.1
	if(z==11||z==10) Mult+=0.25
	if(WeightedStats<SoftStatCap*3.5) Mult++
	if(WeightedStats<SoftStatCap*2.5) Mult*=1.25
	if(WeightedStats<SoftStatCap*1.5) Mult*=1.5
	if(WeightedStats>SoftStatCap*6.0) Mult*=1 // 1.0 -> 1.1
	if(WeightedStats>SoftStatCap*6.6) Mult*=1 //0.7 - 1.1 -> 1.2
	if(WeightedStats>SoftStatCap*7.2) Mult*=1 //0.7 - 1.2 -> 1.3
	if(WeightedStats>SoftStatCap*7.8) Mult=0
	return Mult

mob/proc/StatCapCheck(Stat)
	var/returner=0.9
	if(Stat>=SoftStatCap)
		returner=1
		if(Stat>SoftStatCap*1.1)
			returner = 1.1
			if(Stat>SoftStatCap*1.2)
				returner = 1.2
				if(Stat>=SoftStatCap*1.3)
					returner = 1.3
	return returner

mob/proc/IntCapCheck(Stat,Limit)
	var/returner=1
	if(HasMethyl) returner+=0.25
	if(InspiredTime>world.realtime) returner+=0.5
	if(RestedTime>world.realtime)returner+=0.25
	if(Stat>=(TechCap*0.8)+Limit)
		returner*=0.9
		if(Stat>=(TechCap*0.9)+Limit)
			returner*=0.9
			if(Stat>=TechCap+Limit)
				returner=0
	return returner

mob/proc/IntCatchUp()
	var/returner=1
	if(z==11||z==10) returner+=0.25
	if(Int_Mod<=2) return returner
	if(Int_Level<TechCap*0.7) returner*=1.1
	else if(Int_Level<TechCap*0.5) returner*=1.2
	else if(Int_Level<TechCap*0.3) returner*=1.3
	else if(Int_Level<TechCap*0.1) returner*=1.4
	return returner


mob/proc/MagicCatchUp()
	var/returner=1
	if(z==11||z==10) returner+=0.25
	if(Magic_Potential<=2) return returner
	if(Magic_Level<TechCap*0.7) returner*=1.1
	else if(Magic_Level<TechCap*0.5) returner*=1.2
	else if(Magic_Level<TechCap*0.3) returner*=1.3
	else if(Magic_Level<TechCap*0.1) returner*=1.4
	return returner



mob/proc/Increase_GainMultiplier(Amount=1)
	if(RestedTime>world.realtime)Amount+=0.5
	if(HasExponentialGrowth) Amount*=1+(HasExponentialGrowth*0.33)
	GainMultiplier+=0.005*Amount*GainMultRate*Weight

mob/proc/Attack_Gain()
	set waitfor=0
	ASSERT(src)
	if(!src) return
	if(src.Opp)if(ismob(src.Opp))
		var/mob/M = src.Opp
		if(M.Opp) if(M.Opp != src)
			return // (This fix was broken, so I re-fixed the fix. - Ginseng)If their Opponent is a player, but that player's opponent isn't them (i.e. reverse sparring) then they don't gain shit.
	var/BP_Gain=2
//	EZ++
//	EZCheck()
//	if(BPRank>65) BP_Gain*=1
//	if(ismob(Opp)) if(Opp.FBMAchieved&&!FBMAchieved) BP_Gain*=1
//	if(BPRank>40&&Year>20) BP_Gain*=1
	if(istype(Opp,/mob/player)) if(prob(70)) if(Opp.client)
		if(Opp.HasSSj||HasBojack||HasAlienTrans) SparSSj++
		if(Opp.FBMAchieved) SparAscended++
		if(Opp.MaxGodKi&&Opp.GodKiActive) SparGodKi++
		if(Global_SSJ) if(prob(SparSSj/1000))
			if(Race=="Saiyan"||Race=="Half-Saiyan") if(Opp.HasSSj&&!HasSSj) if(WipeDay>21)
				HasSSj=1
				usr<<"Fighting with [Opp] is beginning to pay off, you can feel your body growing accustomed to their level of power and you can feel a surge of energy deep within you. (SSj Unlocked)"
				logAndAlertAdmins("[src] unlocked SSj fighting with [Opp]",1)
			if(Race=="Heran"||Race=="Half-Heran") if(Opp.HasSSj&&!HasBojack||Opp.HasBojack&&!HasBojack) if(WipeDay>21)
				HasBojack=1
				usr<<"Fighting with [Opp] is beginning to pay off, you can feel your body growing accustomed to their level of power and you can feel a surge of energy deep within you. (Bojack Unlocked)"
				logAndAlertAdmins("[src] unlocked Bojack fighting with [Opp]",1)
		if(Global_SSJ2) if(prob(SparAscended/1000)&&Opp.FBMAchieved)
			if(HasSSj&&HasSSj<2&&Base/BPMod>=Tier5Req)
				HasSSj=2
				usr<<"Fighting with [Opp] is pushing your body to its absolute limits. You have awakened the ability to tap into a power even greater than Super Saiyan! (SSj 2 Unlocked)"
				logAndAlertAdmins("[src] unlocked SSj 2 fighting with [Opp]",1)
			if(HasBojack&&HasBojack<2&&Base/BPMod>=Tier5Req)
				HasBojack=2
				usr<<"Fighting with [Opp] is pushing your body to its absolute limits. You have awakened the ability to tap into a power even greater than Bojack! (Super Bojack Unlocked)"
				logAndAlertAdmins("[src] unlocked Super Bojack fighting with [Opp]",1)
		if(Global_SSJ) if(prob(SparSSj/500)||prob(SparAscended/100)) if(Opp.HasSSj||Opp.HasAlienTrans||Opp.HasBojack) if(Race=="Alien"||Race=="Kanassa"||Race=="Half-Alien") if(!HasAlienTrans)
			if(Base/BPMod>=Tier1Req)
				HasAlienTrans=1
				usr<<"Fighting with [Opp] is beginning to pay off, you can feel your body growing accustomed to their level of power and you can feel a surge of energy deep within you. (Transformation Unlocked)"
				logAndAlertAdmins("[src] unlocked Alien Trans fighting with [Opp]",1)
		if(Global_GodKi) if(Opp.GodKi>=1&&!MaxGodKi) if(prob(SparGodKi/200)||SparGodKi>1500) if(Opp.GodKiActive)
			usr<<"Fighting with [Opp] is beginning to pay off. You feel a tingling sensation within your gut as you tap into their otherwordly power... (God Ki Unlocked)"
			logAndAlertAdmins("[src] unlocked God Ki fighting with [Opp]",1)
			MaxGodKi=1
			for(var/mob/player/M in view(15,src)) M<<'Carl_Orff_35_SEC.wav'
			if(!locate(/obj/God_Ki) in usr) contents+=new/obj/God_Ki
//		if(Global_GodKiTrain) if(GodKi&&Opp.GodKi&&Opp.GodKiActive&&GodKiActive)if(prob(20)&&GodKi<MaxGodKi&&GodKi<Global_GodKiCap) GodKi+=0.015
//		if(src)
//			if(Opp.GainMultiplier>GainMultiplier) Increase_GainMultiplier(2)
//			if(Opp.GainMultiplier*0.9>GainMultiplier) if(prob(35))
//				if(prob(10)) src<<"You are learning from [Opp]'s experience and skill in combat. (Inspired)"
//				src.InspiredTime=world.realtime+10000
//				GainMultiplier+=Opp.GainMultiplier*0.05
//				if(DEBUGMATH) src<<"Gain Mult + [Opp.GainMultiplier*0.05] (Gain Mult Leech)"
//				if(GainMultiplier>Opp.GainMultiplier*0.9) GainMultiplier=Opp.GainMultiplier*0.9
//			if(Opp.Base/Opp.BPMod>Base/BPMod) if(!Opp.VillainTrain&&!VillainTrain)
//				BP_Gain*=1
//				var/Go=1
//				//if(Opp.Race=="Android") if(Race!="Android") Go=0
//				if(Go) if(!Lethality&&!Opp.Lethality) if((Opp.Base/Opp.BPMod)*0.7>Base/BPMod) if(prob(40))
//					var/BG=(Opp.Base/Opp.BPMod)*0.003
//					if(BG>Base*0.005) BG=Base*0.005
//					if(DEBUGMATH) src<<"Base + [BG] (Base Leeching) ([(Opp.Base/Opp.BPMod)*0.7] Leechable BP)"
//	if(SwordOn||HammerOn) PassiveSkillsIncrease(0,0.5,0,0.25)//ki,sword,unarmed,evasion
//	else if(KiBlade||KiHammer||SpiritSword||KiBow) PassiveSkillsIncrease(0.5,0,0,0.25)//ki,sword,unarmed,evasion
//	else if(KiFists) PassiveSkillsIncrease(0.25,0,0.25,0.25)//ki,sword,unarmed,evasion
//	else PassiveSkillsIncrease(0,0,0.5,0.25)//ki,sword,unarmed,evasion
//	if(Opp) Increase_GainMultiplier(3)
	if(Gravity>=GravMastered) if(prob(5)) src.Gravity_Gain()
//	StatRank()
	var/N = 20 * GravMulti
	if(Spar) N= 30 * GravMulti
	var/TrainingInc=1
	if(HasPracticalLearner) TrainingInc=1+(HasPracticalLearner*0.33)
	N*=TrainingInc
	var/PBAG=1
	if(ismob(Opp)) for(var/obj/Contact/CC in Opp) if(CC.Signature==Signature) if(CC.relation=="Disciple(+)")
		N+=5
		PBAG+=3
	if(ismob(Opp)) for(var/obj/Contact/CC in Opp) if(CC.Signature==Signature) if(CC.relation=="Rival")
		PBAG+=3
		N+=5
	if(DEBUGMATH) src<<"Base + [N*GG*BPMod*Weight*BP_Gain*sqrt(sqrt(BPRank))*GainMultiplier] (Spar Gain)"
	if(RacialPowerAdd) RacialPowerAdd-=(N*GG*BPMod*BP_Gain*sqrt(sqrt(BPRank))*GainMultiplier)*0.4
	Base+= N*GG*BPMod*BP_Gain*sqrt(sqrt(BPRank))*GainMultiplier
	Zanzoken+=0.05*ZanzoMod
//	if(prob(0.01*(BaseRegeneration+BaseRecovery))) Decline+=0.1

//	StatGains(Rate=PBAG*TrainingInc,Energy=1,Might=0.25,Endurance=0.25,Speed=1,Offense=1,Defense=1)






