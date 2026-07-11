

Skill/Spell/Conjure

	desc="This will conjure a demon from Hell to serve you.  Make sure your contract is specific enough to control it. Summoning a demon removes part of your ki. (Allows someone to create a Demon. You may add a password)"
	verb/Conjure()
		set category="Other"
		var/Cost = 390000000
		var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
		usr << "Base cost for this spell is [Commas(Cost)] mana per level. Your magic potential means it costs [Commas(Actual)] mana per level for you."
		for(var/obj/Mana/M in usr) if(M.Value > Actual) if(usr.Confirm("Attempt to summon a demon for [Actual] mana?"))
			M.Value -= Actual
			view(src)<<"[usr] begins to summon a demon!"
			var/obj/Baby/A=new
			A.Race="Demon Contract"
			A.loc=usr.loc
			A.icon='fx.dmi'
			A.icon_state="chaos gate"
			A.name="Demonic Contract ([usr])"
			A.Builder=usr.name
			usr.AlignmentNumber-=1
			usr.AlignmentCalibrate()
			if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Demon Contract",null) as text
			hearers(100,usr) << sound(pick('imhere1.ogg','behindyou1.ogg','behindyou2.ogg','farnoise.ogg','growl1.ogg','growl2.ogg','growl3.ogg','iseeyou1.ogg','iseeyou2.ogg','lookup1.ogg','lookup2.ogg','overhere1.ogg','overhere2.ogg','overhere3.ogg','turnaround1.ogg','turnaround2.ogg','veryfarnoise.ogg','overhere3.ogg'),volume=20)
			usr << "Something else went through as you attempt to summon the demon..."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Made a demon")


Skill/Technology/Create_Artificial_Angel

	desc="This will create a 'perfect' being. This is science's attempt at creating a being of divine nature. (Allows someone to create a Kaio. You may add a password)"
	verb/Create_Artificial_Angel()
		set category="Other"
		var/Cost = 390000000
		var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
		usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
		for(var/obj/Resources/M in usr) if(M.Value > Actual) if(usr.Confirm("Attempt to create an artificial angel for [Actual] resources?"))
			M.Value -= Actual
			view(src)<<"[usr] begins to create an artificial angel!"
			var/obj/Baby/A=new
			A.Race="Artificial Angel"
			A.loc=usr.loc
			A.icon='fx.dmi'
			A.icon_state="astral gate"
			A.Builder=usr.name
			A.name="Artificial Angel ([usr])"
			if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Artificial Angel",null) as text
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Made a Kaio")

obj/ConjureContractObj
	var/SoulKey
	var/SoulName
	var/SoulDate
	var/LastSummon
	var/Contract
	Click()
		..()
		usr<<"Demon Contract Information: [SoulName], Date Acquired: [SoulDate]<br> Contract: [Contract]"
		if(usr.RPMode) return
		var/list/Choices=new
		Choices.Add("Summon","DeConjure","Cancel")
		var/Choice=input(usr,"Choose your action","Soul Contract") in Choices
		switch(Choice)
			if("DeConjure") if(usr.Confirm("This will destroy the contract. Continue?"))
				for(var/mob/Demon in Players) if(Demon.key==SoulKey) if(Demon.ConjuredKey==usr.key)
					Demon<<"[usr] has sent you back from whence you came."
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has deconjured [key_name(Demon)]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has deconjured [key_name(Demon)].\n")
					Demon.saveToLog("|| ([Demon.x], [Demon.y], [Demon.z]) | [key_name(Demon)] has been deconjured by [key_name(usr)]. \n")
					var/image/I=image(icon='Black Hole.dmi',icon_state="full")
					flick(I,Demon)
					Demon.loc=locate(Demon.ConjureX,Demon.ConjureY,Demon.ConjureZ)
					flick(I,Demon)
					Demon.Conjured=0
					Demon.ConjuredKey=null
					spawn() del(src)
			if("Summon")
				if(LastSummon+0.3<Year)
					for(var/mob/M in Players) if(M.key==SoulKey)
						if(M.z==10||M.LethalCombatTracker)
							usr<<"They can not be reached at this time..."
							return
						alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Conjure Contract summoned [key_name(M)]")
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Conjure Contract summoned [key_name(M)]")
						M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Conjure Contract summoned [key_name(M)]")
						M<<"You feel a strange sensation as the person with your contract is summoning you..."
						for(var/mob/MM in view(15,M)) MM<<"[M] begins to glow as they are summoned away."
						M.overlays+='holybolt.dmi'
						sleep(15)
						M.overlays-='holybolt.dmi'
						M.loc=usr.loc
						LastSummon=Year
				else usr<<"You may only summon them once every four months."


mob/var/Contracted=0
obj/SoulContractObj
	var/SoulKey
	var/SoulName
	var/SoulLevel
	var/SoulDate
	var/SoulExpire
	var/LastKO
	var/LastSummon
	var/Contract
	Click()
		..()
		usr<<"Soul Contract Information: [SoulName], Date Acquired: [SoulDate]<br> Contract: [Contract]"
		if(usr.RPMode) return
		var/list/Choices=new
		Choices.Add("Destroy Contract","Force Submit","Cancel")
		var/Choice=input(usr,"Choose your action","Soul Contract") in Choices
		switch(Choice)
			if("Destroy Contract")
				for(var/mob/M in Players) if(M.key==SoulKey) M.Contracted=0
				spawn() del(src)
			if("Force Submit")
				for(var/mob/M in view(20)) if(M.key==SoulKey)
					alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract KOd [key_name(M)]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract KOd [key_name(M)]")
					M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract KOd [key_name(M)]")
					M<<"You feel a strange sensation as the person with your soul is forcing you to submit..."
					for(var/mob/MM in view(20,M)) MM<<"[M] begins to glow as they are forced to submit."
					M.overlays+='Laser Particles.dmi'
					sleep(15)
					M.overlays-='Laser Particles.dmi'
					M.KO(usr)
					LastKO=Year
			if("Summon")
				if(LastSummon+0.3<Year)
					for(var/mob/M in Players) if(M.key==SoulKey)
						if(M.z==10||M.LethalCombatTracker)
							usr<<"They can not be reached at this time..."
							return
						alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract summoned [key_name(M)]")
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract summoned [key_name(M)]")
						M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract summoned [key_name(M)]")
						M<<"You feel a strange sensation as the person with your soul is summoning you..."
						for(var/mob/MM in view(15,M)) MM<<"[M] begins to glow as they are summoned away."
						M.overlays+='holybolt.dmi'
						sleep(15)
						M.overlays-='holybolt.dmi'
						M.loc=usr.loc
						LastSummon=Year
				else usr<<"You may only summon them once every four months."

Skill/Support/Soul_Contract

	desc="Used to create a soul contract over someone.  You can use this when offering mortals training or skills in exchange for dominion over their soul."
	verb/Make_Soul_Contract()
		set category="Other"
		desc="Makes a soul contact."
		var/list/Demons=new/list
		Demons+="Cancel"
		for(var/mob/player/M in oview(1,usr)) if(M.client) Demons.Add(M)
		var/mob/Choice=input("Make a contract for who?") in Demons
		if(Choice!="Cancel")
			if(Choice.Contracted==1)
				usr<<"[Choice] has already been contracted!"
				return
			else
				var/Reason=input("Input the contract you want to propose to [Choice], allowing them to decide wether to agree or not. (Formatted as \"[usr] wishes to exchange your mortal soul for : Reason.\"") as message
				spawn switch(input(Choice,"[usr] wishes to exchange your mortal soul for :\n [Reason]", "Soul Contract", text) in list ("No", "Yes",))
					if("Yes")
						if(usr)
							alert("[Choice] has agreed to give up their soul in exchange for [Reason].")
							//("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contracted [key_name(Choice)] \nContract: [Reason]")
							alertAdmins("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contracted [key_name(Choice)] \nContract: [Reason]")
							oview(usr)<<"[usr] signs a contract with [Choice]"
							usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contracted [key_name(Choice)] \nContract: [Reason]")
							usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contracted [key_name(Choice)] \nContract: [Reason]")
							Choice.Contracted=1
							var/obj/SoulContractObj/SC=new
							SC.SoulKey=Choice.key
							SC.SoulName=Choice.real_name
							SC.SoulLevel=1
							SC.SoulDate=Year
							SC.SoulExpire=Year+10
							SC.Contract="[Reason]"
							SC.name="[Choice]'s Contract"
							usr.contents+=SC
					else if(usr) usr<<"[Choice] has denied the contract."


/*		if(M.KOd==0)
			switch(alert(M,"[usr] wants to extract your DNA, allow it?","Genetic Sequencer","Yes","No"))
				if("Yes") Go=1
		else Go=1
		if(Go)*/
