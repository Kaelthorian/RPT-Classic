mob/proc/GetStance()
	var/Skill/MartialArt/MA=new
	MA.Builder="[ckey] ([real_name])"
	MA.YearDeveloped=round(Year)
	contents+=MA

mob/var/StanceOn=0
mob/var/StanceCore=0
Skill/MartialArt

	var
		buffon="starts using Kung Fu." // set a string for when the buff is turned on
		buffoff="stops using Kung Fu." // same for when its turned off
		buffslot = 0 // set this to 0 to not take a buff slot, 1 to take one
		PointsSpent=0
		PointsHas=5
		PointsCan=5
		YearDeveloped=0
		MasteryLevel="Master"
		StrMult=1
		EndMult=1
		SpdMult=1
		PowMult=1
		OffMult=1
		DefMult=1
		StanceCore="None"
		tmp/Cuzin=0
	verb/Customize_Stance()
		set category="Other"
		if(Cuzin) return
		if(Using)
			usr<<"You can not do this while using the stance."
			return
		//	Cuzin=0
		Cuzin=1
/*
		if(usr.Confirm("Refund points?"))
			Cuzin=1
			StrMult=1
			EndMult=1
			SpdMult=1
			PowMult=1
			OffMult=1
			DefMult=1
			PointsSpent=0
			PointsHas=PointsCan
*/
		//if(Builder=="[usr.ckey] ([usr.real_name])")
		StanceCore=input("Choose a core principle of this stance.") in list("Skill (+3% Accuracy and Evasion)","Power (+5% Damage Caused)","Resilience (-5% Damage Taken)","Speed (-10% Refire)")
		if(usr.Confirm("Change the Stance Name?"))
			usr<<"Do not use this to give a name that is against the rules or somehow blank names."
			name=input(usr) as text
			if(!name||name==" "||name=="  ") name="Super Mega Kung Fu"
		if(usr.Confirm("Change the description?")) desc=input(usr) as text
		if(usr.Confirm("Change the buffon message?")) buffon=input(usr) as text
		if(usr.Confirm("Change the buffoff message?")) buffoff=input(usr) as text
		Marker1
		if(PointsHas>0&&PointsSpent<PointsCan)
			if(!usr.Confirm("Invest points? ([PointsHas] points remaining)"))
				Cuzin=0
				return
			else
				var/Pinc=input(usr,"Choose which stat","Customize Stance") in list("Strength","Endurance","Speed","Force","Offense","Defense")
				switch(Pinc)
					if("Strength")
						if(StrMult<1.2)
							StrMult+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Endurance")
						if(EndMult<1.2)
							EndMult+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Speed")
						if(SpdMult<1.2)
							SpdMult+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Force")
						if(PowMult<1.2)
							PowMult+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Offense")
						if(OffMult<1.2)
							OffMult+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Defense")
						if(DefMult<1.2)
							DefMult+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
		if(PointsHas>0&&PointsSpent<PointsCan)  goto Marker1
		Cuzin=0


	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		if(MasteryLevel!="Master") return
		if(StanceCore=="None")
			usr<<"You must first set the core of this stance"
			return
		var/masterFlag
		for(var/Skill/MartialArt/MAA in A)
			if(MAA.Builder==Builder&&MAA.StanceCore==StanceCore)
				usr<<"They already possess this stance."
				return
		src.desc += "<br>You taught this to [A] on year [Year]."
		view(usr)<<"[usr] taught [A] the [src] martial art."
		A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was taught  the [src] martial art by [key_name(usr)]")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] taught [key_name(A)]  the [src] martial art")
		logAndAlertAdmins("[key_name(usr)] tried to teach [key_name(A)] the [src] stance.",2)
		var/Skill/MartialArt/MA=new
		MA.YearDeveloped=Year
		MA.name=name
		MA.Builder=Builder
		MA.buffon=buffon
		MA.buffoff=buffoff
		MA.StanceCore=StanceCore
		MA.PointsHas=3
		MA.PointsCan=3
		A.contents+=MA
		MA.MasteryLevel="Novice"
		if(masterFlag)MA.MasteryLevel=masterFlag
		MA.desc += "<br>You were taught this at year [Year] from [usr]."


	proc
		use(mob/user)
			if(!ismob(user)) return
			if(user.RPMode) return
			if(user.KOd) return // probably want a better test for KO
			//if(user.Ki < user.MaxKi * KiNeeded) return
			if(!Using)
				if(buffslot && user.BuffNumber >= user.BuffLimit)
					user << "You are already using too many buffs."
					return
				if(PointsSpent>5)
					view(usr)<<"[usr] is using a bugged stance with more than 5 points spent and needs to be fixed via ahelp before they can use their stance."
					return
				buff(user)
			else debuff(user)
		buff(mob/user) if(!Using)
			if(!ismob(user)) return
			if(user.Stance) return
			var/buff = "Custom Stance ([src])"
			if(buffslot) user.BuffNumber++
			user.Stance=name
			user.StanceLevel=MasteryLevel
			user.Buffs += buff
			Using = 1
			user.StrMult*=src.StrMult
			user.EndMult*=src.EndMult
			user.SpdMult*=src.SpdMult
			user.PowMult*=src.PowMult
			user.OffMult*=src.OffMult
			user.DefMult*=src.DefMult

			switch(StanceCore)
				if("Skill (+3% Accuracy and Evasion)")user.StanceCore=1
				if("Power (+5% Damage Caused)")user.StanceCore=2
				if("Resilience (-5% Damage Taken)")user.StanceCore=3
				if("Speed (-10% Refire)")user.StanceCore=4
//				if("Recovery (+50% Recovery Ticks)")user.StanceCore=5
			if(isicon(icon)) user.overlays += icon
			if(buffon) for(var/mob/player/M in view(usr)) M.BuffOut("[user] [buffon]")
			if(MasteryLevel=="Novice") user<<"</Font color=red>You are using a novice stance and lose 5% damage and accuracy as a result.</font color>"
		debuff(mob/user) if(Using)
			if(!ismob(user)) return
			var/buff = "Custom Stance ([src])"
			if(buffslot) user.BuffNumber--
			user.Stance=null
			user.StanceLevel=null
			user.Buffs -= buff
			Using = 0
			user.StrMult/=src.StrMult
			user.EndMult/=src.EndMult
			user.SpdMult/=src.SpdMult
			user.PowMult/=src.PowMult
			user.OffMult/=src.OffMult
			user.DefMult/=src.DefMult

			user.StanceCore=0
			if(isicon(icon)) user.overlays -= icon
			if(buffoff) for(var/mob/player/M in view(usr)) M.BuffOut("[user] [buffoff]")

	verb/Toggle_Stance()
		set category = "Skills"
		use(usr)

