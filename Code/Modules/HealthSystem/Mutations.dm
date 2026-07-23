






mob/proc/Mod_Variance(forced=0)
	if(!forced)
		Mutations=new/list()
		MutationNumber=0
		FBMAt=1000000
		GeneticDecline=Decline
		GeneticMagic_Potential=Magic_Potential
		GeneticInt_Mod=Int_Mod
		GeneticBPMod=BPMod
		GeneticFBMMult=FBMMult
		GeneticMaxAnger=BaseMaxAnger
		GeneticKiMod=KiMod
		GeneticStrMod=StrMod
		GeneticEndMod=EndMod
		GeneticSpdMod=SpdMod
		GeneticOffMod=OffMod
		GeneticDefMod=DefMod
		GeneticRegeneration=BaseRegeneration
		GeneticRecovery=BaseRecovery
		GeneticDeathRegen=Regenerate
	if(Offspring) if(Racial_Stats<3) Racial_Stats=3
	if(Offspring) while(Racial_Stats>0)
		var/rr=rand(1,8)
		switch(rr)
			if(1) if(!UniqueMutation)
				BPMod*=1.05
				Racial_Stats--
				Mutations+="BP Mod"
				MutationNumber++
				UniqueMutation=1
			if(2) if(!UniqueMutation)
				if(Race!="Android"&&BaseMaxAnger>100)
					BaseMaxAnger*=1.05
					Racial_Stats--
					Mutations+="Max Anger"
					MutationNumber++
					UniqueMutation=1
			if(3) if(StrMod>1.5)
				StrMod*=1.1
				Racial_Stats--
				Mutations+="Strength Mod"
				MutationNumber++
			if(4) if(EndMod>1.5)
				EndMod*=1.1
				Racial_Stats--
				Mutations+="Endurance Mod"
				MutationNumber++
			if(5) //if(SpdMod>1)
				SpdMod*=1.1
				Racial_Stats--
				Mutations+="Speed Mod"
				MutationNumber++
			/*if(6) if(StrMod>1.5)
				StrMod*=1.1
				Racial_Stats--
				Mutations+="Strength Mod"
				MutationNumber++*/
			if(6) if(OffMod>1.5)
				OffMod*=1.1
				Racial_Stats--
				Mutations+="Offense Mod"
				MutationNumber++
			if(7) if(DefMod>1.5)
				DefMod*=1.1
				Racial_Stats--
				Mutations+="Defense Mod"
				MutationNumber++
			if(8) if(!UniqueMutation)
				BaseRecovery*=1.1
				Racial_Stats--
				Mutations+="Recovery"
				MutationNumber++
				UniqueMutation=1
mob/proc/GetMutation()
	var/GotIt=1
	while(GotIt)
		var/rr=rand(1,8)
		switch(rr)
			if(1) if(!UniqueMutation)
				BPMod*=1.05
				GotIt--
				Mutations+="BP Mod"
				MutationNumber++
				UniqueMutation=1
			if(2) if(!UniqueMutation)
				if(Race!="Android"&&BaseMaxAnger>100)
					BaseMaxAnger*=1.05
					Racial_Stats--
					Mutations+="Max Anger"
					MutationNumber++
					UniqueMutation=1
			if(3)
				GeneticStrMod*=1.1
				GotIt--
				Mutations+="Strength Mod"
				MutationNumber++
			if(4)
				GeneticEndMod*=1.1
				GotIt--
				Mutations+="Endurance Mod"
				MutationNumber++
			if(5)
				GeneticSpdMod*=1.1
				GotIt--
				Mutations+="Speed Mod"
				MutationNumber++
			if(6)
				GeneticOffMod*=1.1
				GotIt--
				Mutations+="Offense Mod"
				MutationNumber++
			if(7)
				GeneticDefMod*=1.1
				GotIt--
				Mutations+="Defense Mod"
				MutationNumber++
			if(8) if(!UniqueMutation)
				BaseRecovery*=1.1
				GotIt--
				Mutations+="Recovery"
				MutationNumber++
				UniqueMutation=1





