mob/Admin1/verb

	Who_Has()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/C=input("Who...") in list("Too Many MPs","Professions","Realm Teleport","How Many","Kill Count","Mutations","EXP","Relics","Who EC","Unspent MPs","Precog","Sizes","Racial Power","Planets","Space Building","Riches","Offspring","Unlocked","RP Power","Dead","SSj","Milestones","FBM","Capped","God Ki","Transformations","Cancel")
		switch(C)
			if("Realm Teleport")usr.Who_Ignores_Realm_Teleport()
			if("How Many")usr.Who_How_Many()
			if("Mutations")usr.Who_Mutation_Check()
			if("Offspring")usr.Who_Offspring()
			if("Unlocked")usr.Who_Unlocked()
			if("RP Power")usr.Who_RPPower()
			if("EXP")usr.Who_EXP()
			if("Dead")usr.Who_Dead()
			if("SSj")usr.Who_SSJ()
			if("Milestones")usr.Who_Milestones()
			if("FBM")usr.Who_FBM()
			if("Capped")usr.Who_Is_BP_Capped()
			if("God Ki")usr.Who_God_Ki()
			if("Transformations")usr.Who_Transformation()
			if("Racial Power") usr.WhoRacialPower()
			if("Unspent MPs") usr.WhoUnspentMPs()
			if("Who EC")usr.Who_EC()
			if("Precog") usr.WhoPrecog()
			if("Riches") usr.WhoTooMuchMoney()
			if("Too Many MPs") usr.WhoTooManyMP()
			if("Professions") usr.Who_Professions()
			if("Planets") usr.WhoPlanets()
			if("Kill Count") usr.KillCountWho()

mob/proc
	Who_Ignores_Realm_Teleport()
		set category="Admin Other"
		for(var/mob/M in Players) if(M.IgnoreRealmTeleport) usr<<"[M] ignores Realm Teleport"
	Who_EC()
		for(var/mob/M in Players) if(M.EventCharacter) usr<<"[M] is an EC made on year [M.EventCharacter] and expected to die year [M.EventCharacter+3] - [M.EventCharacter+5]."
	WhoUnspentMPs()
		for(var/mob/M in Players) if(M.MilestonePoints) usr<<"[M] has [M.MilestonePoints] ([M.Race])"
	KillCountWho()
		set category="Admin Other"
		for(var/mob/player/M in Players) if(M.Kills)
			usr<<"[M] has killed [M.Kills] people."
	WhoTooManyMP()
		for(var/mob/M in Players)
			if(M.TotalMilestonePoints>Year+3) usr<<"[M] has [M.TotalMilestonePoints] MP "
	WhoPrecog()
		for(var/mob/M in Players) if(M.Precognition) usr<<"[M] has Precognition ([M.Race])"
	WhoRacialPower()
		for(var/mob/M in Players) if(M.RacialPowerAdd) usr<<"[M] has [M.RacialPowerAdd] add ([M.Race])"
	WhoTooMuchMoney()
		for(var/mob/M in Players)
			for(var/obj/Resources/R in M) if(R.Value>50000000)  usr<<"[M] has [R.Value] resouces"
			for(var/obj/Mana/R in M) if(R.Value>50000000)  usr<<"[M] has [R.Value] mana"
		for(var/obj/Mana/R in world) if(R.z) if(R.Value>50000000)  usr<<"[R.Value] mana ([R.x],[R.y],[R.z])"
		for(var/obj/Resources/R in world) if(R.z) if(R.Value>50000000)  usr<<"[R.Value] resouces ([R.x],[R.y],[R.z])"
	Who_Professions()
		var/Mining=0
		var/Smithing=0
		var/Fishing=0
		var/Cooking=0
		for(var/mob/M in Players)
			if(M.Cooking_Level>5)
				Cooking++
				usr<<"[M] has [M.Cooking_Level] Cooking."
			if(M.Fishing_Level>5)
				Fishing++
				usr<<"[M] has [M.Fishing_Level] Fishing."
			if(M.Mining_Level>5)
				Mining++
				usr<<"[M] has [M.Mining_Level] Mining."
			if(M.Smithing_Level>5)
				Smithing++
				usr<<"[M] has [M.Smithing_Level] Smithing."
		usr<<"There are [Cooking] Cooks."
		usr<<"There are [Fishing] Fishermen."
		usr<<"There are [Mining] Miners."
		usr<<"There are [Smithing] Blacksmithers."
	Who_How_Many()
		set category="Admin Other"
		var/list/Pcount=list()
		for(var/mob/M in Players)
			if(M.client.computer_id in Pcount) continue
			else Pcount+=M.client.computer_id
		for(var/client/C in world)
			if(C.computer_id in Pcount) continue
			else Pcount+=C.computer_id
		usr<<"[Pcount.len] unique players."
	Who_Mutation_Check()
		set category="Admin Other"
		for(var/mob/M in Players) if(M.MutationNumber>0) usr<<"[M]: [M.MutationNumber]"
	Who_Offspring()
		set category="Admin Other"
		var/Offs=0
		var/Droids=0
		var/SDs=0
		for(var/mob/M in Players)
			if(M.Offspring)
				Offs++
				usr<<"[M] is an Offspring [M.Parents]"
			if(M.Builder)
				if(M.Race=="Android")Droids++
				if(M.Race=="Spirit Doll") SDs++
				usr<<"[M] is an [M.Race] [M.Builder]"
		usr<<"There are [Offs] Offspring and [Droids] Androids and [SDs] Spirit Dolls."
	Who_Unlocked()
		set category="Admin Other"
		for(var/mob/M in Players) if(isnum(M.PotentialUnlocked))
			if(M.PotentialUnlocked==1) usr<<"[M] (Unlock Potential)"
			if(M.PotentialUnlocked==2) usr<<"[M] (Dark Blessing)"
			if(M.PotentialUnlocked==3) usr<<"[M] (Book of Power)"
	Who_RPPower()
		set category="Admin Other"
		for(var/mob/M in Players) if(isnum(M.RPPower)) if(M.RPPower>1) usr<<"[M]: [M.RPPower]"
		for(var/mob/M in Players) if(isnum(M.RPPowerAdd)) if(M.RPPowerAdd>=1) usr<<"[M]: [M.RPPowerAdd] (ADD)"
	Who_Dead()
		set category="Admin Other"
		var/Deads=0
		for(var/mob/M in Players) if(M.Dead)
			Deads++
			usr<<"[M] is Dead [M.KeepsBody ? "(Body)" : ""]"
		usr<<"There are [Deads] dead people."
	Who_SSJ()
		set category="Admin Other"
		var/SSJs=0
		var/SSJ2s=0
		var/SSJ3s=0
		var/SSJ4s=0
		var/SSBs=0
		for(var/mob/M in Players) if(M.HasSSj)
			SSJs++
			usr<<"[M] has SSJ [M.HasSSj]"
			if(M.HasSSj>=2) SSJ2s++
			if(M.HasSSj>=3) SSJ3s++
			if(M.HasSSj4) SSJ4s++
			if((M.Base/M.BPMod)>Tier6Req) SSBs++
		usr<<"There are [SSJs] SSjs."
		usr<<"There are [SSJ2s] SSj2s."
		usr<<"There are [SSJ3s] SSj3s."
		usr<<"There are [SSJ4s] SSj4s."
		usr<<"There are [SSBs] SSBs."
		var/BJ2s
		for(var/mob/M in Players) if(M.HasBojack==2)
			BJ2s++
			usr<<"[M] has Super Bojack."
		usr<<"There are [BJ2s] Super Bojacks."
	WhoPlanets()
		set category="Admin Other"
		var/Earth=0
		var/Namek=0
		var/Vegeta=0
		var/Arconia=0
		var/Icer=0
		var/DarkPlanet=0
		var/SpaceStation=0
		var/AlienP=0
		var/AL=0
		for(var/mob/M in Players) if(M.z)
			switch(M.z)
				if(1)Earth++
				if(2)Namek++
				if(3)Vegeta++
				if(4)Icer++
				if(5)Arconia++
				if(6)DarkPlanet++
				if(7)SpaceStation++
				if(14)AlienP++
				if(8||10||11)AL++
		usr<<"Earth [Earth]"
		usr<<"Namek [Namek]"
		usr<<"Vegeta [Vegeta]"
		usr<<"Arconia [Arconia]"
		usr<<"Icer [Icer]"
		usr<<"DarkPlanet [DarkPlanet]"
		usr<<"SpaceStation [SpaceStation]"
		usr<<"AlienP [AlienP]"
		usr<<"AL [AL]"
	Who_EXP()
		for(var/mob/player/P in Players) if(P.EXP) usr<<"[P] has [P.EXP] EXP."
	Who_Milestones()
		set category="Admin Other"
		var/list/ListOfMPs=list()
		for(var/mob/player/P in Players) for(var/Milestone/MP in P) ListOfMPs["[MP]"]++//ListOfMPs.Add("[MP]"=1)
		for(var/P in ListOfMPs) usr<<"[P] : [ListOfMPs[P]]"
	Who_FBM()
		set category="Admin Other"
		var/FBMs=0
		var/FBM2s=0
		for(var/mob/M in Players)
			if(M.FBMAchieved==1)
				FBMs++
				usr<<"[M] has ascended ([M.BPMod])"
			if(M.FBMAchieved==2)
				FBM2s++
				usr<<"[M] has ascended further beyond! ([M.BPMod])"
		usr<<"[FBMs] people have ascended."
		usr<<"[FBM2s] people have ascended further beyond."
	Who_Is_BP_Capped()
		set category="Admin Other"
		var/Capps=0
		for(var/mob/M in Players)
			if(M.Base/M.BPMod>=TrueBPCap*0.9)
				Capps++
				usr<<"[M] is BP Capped ([M.Base])"
		usr<<"[Capps] people have capped BP."
	Who_God_Ki()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/GodKis=0
		for(var/mob/M in Players) if(M.MaxGodKi)
			GodKis++
			usr<<"[M] : [M.MaxGodKi] x God Ki"
		usr<<"There are [GodKis] people with God Ki."
	Who_Transformation()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/mob/M in Players)
			if(M.ssj==1&&M.SSjDrain<300) usr<<"[M] (SSj)"
			else if(M.ssj==1) usr<<"[M] (SSj FP)"
			else if(M.ssj==2) usr<<"[M] (SSj2)"
			else if(M.ssj==3) usr<<"[M] (SSj3)"
			else if(M.ssj==4) usr<<"[M] (SSj4)"
			else if(M.ssj==5)
				if(M.SSGSSColor=="Rose") usr<<"[M] (SSGR)"
				else usr<<"[M] (SSGSS)"
			else if(M.Form==1) usr<<"[M] (Form 2)"
			else if(M.Form==2) usr<<"[M] (Form 3)"
			else if(M.Form==3) usr<<"[M] (Form 4)"
			else if(M.AlienTrans==1)usr<<"[M] (Alien Trans)"
			else
				if(M.Bojack==1) usr<<"[M] (Bojack)"
				if(M.Bojack==2) usr<<"[M] (Super Bojack)"
			if(M.SNj)  usr<<"[M] (SNj)"
			if(M.ismystic) usr<<"[M] (Mystic)"
			if(M.ismajin) usr<<"[M] (Sin Force)"