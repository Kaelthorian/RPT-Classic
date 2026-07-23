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







