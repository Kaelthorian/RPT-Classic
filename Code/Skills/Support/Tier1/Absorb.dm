obj/MajinAbsorbReleaser
	var
		SendX
		SendY
		SendZ
		MajinKey

mob/proc/MajinAbsorbRelease()
	for(var/obj/MajinAbsorbReleaser/Maj in MajinAbsorbRemove) if(MajinAbsorbed==Maj.MajinKey)
		MajinAbsorbed=0
		loc=locate(Maj.SendX,Maj.SendY,Maj.SendZ)
		for(var/Skill/Support/ObserveAbsorber/OA in src) del(OA)

Skill/Misc/Absorb
	var/LastUse = 0

	desc="This allows you to add the power of a person you absorb into your own. This bonus BP caps at +30% Base BP. The Release option lets you release the power you have absorbed. \
	Absorb does have disadvantages, it will reduce your healing and energy recovery ticks by 50% at full absorb BP. Also if your a living creature you cannot absorb androids, unless you yourself are a bio-android."
	verb/Release_Absorb()
		set category="Other"
		switch(input("Are you sure you want to release this absorbed power?") in list("No","Yes"))
			if("Yes")
				usr<<"You release all your absorbed power"
				usr.Absorb=0
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Other"
		if(!M.client) return
		if(Year-M.YearCreated<3)
			usr<<"A save must be atleast three years old to absorb."
			return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd|M.KOd==0) return
		if(M.Race=="Android")
			usr<<"You can not absorb an android."
			return
		if(usr.Lethality!=1)usr.Lethality=1
		if(M.Willpower>0) return
		if(Year<LastUse+1)
			usr<<"You cannot use this until year [LastUse+1]"
			return
		if(usr.Absorb>=usr.Base)
			view(usr)<<"[usr] attempts to absorb [M], but finds that they cannot hold any more power"
			return
		view(usr)<<"[usr] absorbs [M]!"
		var/AbsorbBP=M.Base
		usr.Absorb+=AbsorbBP
		LastUse =Year
		var/Absorb_Max = usr.Base*0.3
		if(usr.Absorb>Absorb_Max) usr.Absorb=Absorb_Max
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has Absorbed [key_name(M)] for [AbsorbBP] power.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has absorbed [key_name(M)] for [AbsorbBP] power.\n")
		usr.Health=(usr.Willpower/usr.MaxWillpower)*100
		usr.Ki=usr.MaxKi
		M.Absorbed = 1
		spawn M.Death(usr)
		hearers(10,usr) << sound('Pop.wav',volume=20)

Skill/Misc/Absorb_Android
	var/LastUse = 0

	desc="This allows you to destroy another Android for a portion of their Base and Energy. (+25% of their Base/Energy) 1 year CD"
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Other"
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd|M.KOd==0) return
		if(usr.Race!="Android") return
		if(M.Willpower>0) return
		if(Year-M.YearCreated<3)
			usr<<"A save must be atleast three years old to absorb."
			return
		if(M.Race!="Android")
			usr<<"You can only absorb other androids."
			return
		if(usr.Lethality!=1)usr.Lethality=1
		if(Year<LastUse+1)
			usr<<"You cannot use this until year [LastUse+1]"
			return
		view(usr)<<"[usr] android absorbs [M]!"
		LastUse=Year
		var/AbsorbBP=M.Base
		usr.Absorb+=AbsorbBP
		var/Absorb_Max = usr.Base*0.3
		if(usr.Absorb>Absorb_Max) usr.Absorb=Absorb_Max
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has Android Absorbed [key_name(M)] for [AbsorbBP] power.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has android absorbed [key_name(M)] for [AbsorbBP].\n")
		usr.Health=(usr.Willpower/usr.MaxWillpower)*100
		usr.Ki=usr.MaxKi
		M.Absorbed = 1
		spawn M.Death(usr)
		hearers(10,usr) << sound('Pop.wav',volume=20)
Skill/Misc/Absorb_Bio
	var/LastUse = 0

	desc="This allows your to absorb the power of a defeated enemy. You get a Base BP boost equal to 30% of the absorbed person's base, 10% of their Max Ki and 10% of their lifespan. (1 year CD)"
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Other"
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd|M.KOd==0) return
		if(usr.Race!="Bio-Android") return
		if(M.Willpower>0) return
		if(Year-M.YearCreated<3)
			usr<<"A save must be atleast three years old to absorb."
			return
		if(Year<LastUse+1)
			usr<<"You cannot use this until year [LastUse+1]"
			return
		if(usr.Lethality!=1)usr.Lethality=1
		view(usr)<<"[usr] absorbs [M]!"
		var/AbsorbBP=M.Base
		usr.Absorb+=AbsorbBP
		var/Absorb_Max = usr.Base*0.3
		if(usr.Absorb>Absorb_Max) usr.Absorb=Absorb_Max
		LastUse=Year
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has bio Absorbed [key_name(M)] for [AbsorbBP] power.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has bio absorbed [key_name(M)] for [AbsorbBP]  BP!.\n")
		usr.Health=(usr.Willpower/usr.MaxWillpower)*100
		usr.Ki=usr.MaxKi
		M.Absorbed += 1
		spawn M.Death(usr)
		spawn usr.Bio_Forms()
		hearers(10,usr) << sound('Pop.wav',volume=20)
Skill/Misc/Absorb_Majin
	var/LastUse = 0

	desc="This allows your to absorb the power of a defeated enemy. You will absorb them into your being and utilize their power while they remain within you. (Locked in a TFR like map. \
Granted option to reincarnate or wait out your death, when they will be released.) You get a Base BP boost equal to 20% of the absorbed person's base and you gain Absorb BP equal to half their Base, for a total of 60% of their power. (1 year CD)"
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Other"
		if(Year-M.YearCreated<3)
			usr<<"A save must be atleast three years old to absorb."
			return
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd|M.KOd==0) return
		if(usr.Race!="Majin") return
		if(M.Willpower>0) return
		if(Year<LastUse+1)
			usr<<"You cannot use this until year [LastUse+1]"
			return
		if(usr.Lethality!=1)usr.Lethality=1
		if(M.MajinAbsorbed==usr.key)
			usr<<"You have already absorbed their power and are unable to gain any further benefit."
			M.Death(usr)
			spawn M.loc=locate(250,250,8)
			LastUse =Year
			alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has majin Absorbed [key_name(M)] but got no bonus due to already absorbing them..")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has majin absorbed [key_name(M)] but got no bonus due to already absorbing them..\n")
			return
		view(usr)<<"[usr] absorbs [M]!"
		var/AbsorbBP=M.Base
		usr.Absorb+=AbsorbBP
		var/Absorb_Max = usr.Base*0.3
		if(usr.Absorb>Absorb_Max) usr.Absorb=Absorb_Max
		var/Mutes=2
		fig1
		if(Mutes)if(usr.MutationNumber<round(usr.EXPLifetime/400))
			Mutes-=1
			var/X=pick("Strength Mod","Endurance Mod","Speed Mod","Offense Mod","Defense Mod","Recovery","Max Anger","BP Mod")
			if(M.MutationNumber) X=pick(M.Mutations)
			switch(X)
				if("BP Mod")
					usr.BPMod*=1.05
					usr.Mutations+="BP Mod"
					usr.MutationNumber++
				if("Max Anger")
					usr.BaseMaxAnger*=1.05
					usr.Mutations+="Max Anger"
					usr.MutationNumber++
				if("Strength Mod")
					usr.StrMod*=1.1
					usr.Mutations+="Strength Mod"
					usr.MutationNumber++
				if("Endurance Mod")
					usr.EndMod*=1.1
					usr.Mutations+="Endurance Mod"
					usr.MutationNumber++
				if("Speed Mod")
					usr.SpdMod*=1.1
					usr.Mutations+="Speed Mod"
					usr.MutationNumber++
				if("Offense Mod")
					usr.OffMod*=1.1
					usr.Mutations+="Offense Mod"
					usr.MutationNumber++
				if("Defense Mod")
					usr.DefMod*=1.1
					usr.Mutations+="Defense Mod"
					usr.MutationNumber++
				if("Recovery")
					usr.BaseRecovery*=1.1
					usr.Mutations+="Recovery"
					usr.MutationNumber++
			if(X) usr<<"([X] Mutation Stolen!)"
			alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has majin Absorbed [key_name(M)] for [AbsorbBP] power. ([X] Mutation)")
			goto fig1
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has majin absorbed [key_name(M)] for [AbsorbBP].\n")
		usr.Health=(usr.Willpower/usr.MaxWillpower)*100
		usr.Ki=usr.MaxKi
		spawn M.Death(usr,"[usr.key]")
		spawn M.contents+=new/Skill/Support/ObserveAbsorber
		spawn M.loc=locate(283,214,17)
		hearers(10,usr) << sound('Pop.wav',volume=20)
	verb/Release()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Race!="Majin") return
		var/list/Choices=list()
		for(var/mob/player/M in Players) if(M.MajinAbsorbed==usr.key) Choices+=M
		Choices+="Cancel"
		var/mob/CC=input(usr,"Choose someone to release.","Majin Absorb") in Choices
		if(CC=="Cancel") return
		else if(usr.Confirm("Release [CC]? (You will lose your Absorb BP)"))
			usr.Absorb=0
			alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has majin released [key_name(CC)]")
			CC.loc=locate(usr.x,usr.y,usr.z)
			for(var/Skill/Support/ObserveAbsorber/OA in CC) del(OA)
			CC.MajinAbsorbed=null


Skill/Misc/Absorb_Energy

	var/LastUse = 0
	desc="You may use this in place of an injure when you win a round of combat. This will steal 15% of their max ki and add it to your own in addition to stealing 10% of their decline age and adding it to your own."
	verb/Energy_Absorb(mob/M in get_step(usr,usr.dir))
		set category="Skills"
		if(usr.RPMode) return
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd)return
		if(M.KOd==0) return
		if(M.Willpower>30)
			usr<<"They must be at 30 Willpower or below."
			return
		if(Year-M.YearCreated<3)
			usr<<"A save must be atleast three years old to absorb."
			return
		if(Year<LastUse+1)
			usr<<"You cannot use this until year [LastUse+2]"
			return
		view(usr)<<"[usr] absorbs some of [M]'s energy!"
		M << "You feel weaker, as if some years of your life were suddenly stolen or consumed..."
		var/AbsorbNRG
		var/AbsorbD
		AbsorbNRG=M.MaxKi*0.15
		AbsorbD=M.Decline/10
		usr.BaseMaxKi+=AbsorbNRG
		usr.Decline+=AbsorbD
		M.MaxKi-=AbsorbNRG
		M.Decline-=AbsorbD
		usr.Ki=usr.MaxKi
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has Absorbed [key_name(M)]'s energy.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Absorbed  some of [key_name(M)]'s energy!.\n")
		LastUse =Year
		usr.Ki=usr.MaxKi
		M.Absorbed = 1
		spawn M.Death(usr)
		hearers(10,usr) << sound('Pop.wav',volume=20)

