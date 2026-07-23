/client/proc/Reward(var/mob/player/A in Players)
	set name = "Alter Stats"
	set category = "Admin"
	//src<<"This is NOT the channel for rewarding RP. Rewards are done all at once through the rewards tab."

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	if(!A)
		A = input("Select a player to reward") in Players
	if(!A)
		alert("Canceled rewarding!")
		return
	var/list/Options = new
	Options.Add("Cancel")
	Options.Add("Battle Power","Stats", "Energy","Intelligence","Magic", "Resources","Mana", "RP Power","Gravity Mastery","Milestone Points","Max Willpower","Max HP","Alignment")
	if(src.holder.level >= 2)
		Options.Add("Gain Multiplier","BP Mod")
	switch(input(src,"Give what?") in Options)
		if("Cancel")
			alert("Canceled rewarding!")
			return
		if("Gravity Mastery")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Amount=input(src,"What do you want to set their GravMastered to?\nTheir current level is: [A.GravMastered])") as num
			if(!Amount)
				return
			var/oldenergy = A.GravMastered
			A.GravMastered=Amount
			logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s GravMastered from [Commas(oldenergy)] to [Commas(Amount)]",2)



		if("Alignment")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Boost=input(src,"[A] the [A.Race]'s [A.AlignmentNumber] (-10 Very Evil to +10 Very Good)") as num
			if(!Boost)
				return
			if(Boost>10) Boost=10
			if(Boost<-10) Boost=-10
			logAndAlertAdmins("[key_name(src)] brought [key_name(A)] the [A.Race] from [A.AlignmentNumber]x to [Commas(Boost)] alignment",2)
			A.AlignmentNumber=Boost

		if("Gain Multiplier")
			if(src.holder.level < 2)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Boost=input(src,"[A] the [A.Race]'s Gain Mult is currently at [Commas(A.GainMultiplier)]x. Input what \
			amount you want them to have.") as num
			if(!Boost)
				return
			logAndAlertAdmins("[key_name(src)] brought [key_name(A)] the [A.Race] from [Commas(A.GainMultiplier)]x to [Commas(Boost)]x Gain Mult",2)
			A.GainMultiplier=Boost
		if("Magic")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			switch(alert(src,"Reward Magic Levels or Experience?",,"Levels","Experience","Cancel"))
				if("Cancel")
					return
				if("Levels")
					var/oldlevel = A.Magic_Level
					var/Amount=input(src,"How many levels do you want to give them?\nTheir current level is: [A.Magic_Level] ([A.Magic_XP]/[A.Magic_Next])") as num
					if(Amount<=0){src<<"Levels were not raised.";return}
					A.medrewardmagic=Amount
					var/c
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s Magic Level from [oldlevel] to [oldlevel+Amount].",2)
					if(A.magicfocus!="Magical Skill") {A.magicfocus="Magical Skill";c=1}
					A << "Your magic level is being raised, please wait a moment."
					while(A&&A.Magic_Level<(oldlevel+Amount))
						sleep(50)

					if(c)A.magicfocus=0
					A.medrewardmagic=0
					A << "All done."

				if("Experience")
					var/Amount=input(src,"How much Magic XP do you want to give them?\nTheir current level is: [A.Magic_Level] ([A.Magic_XP]/[A.Magic_Next])") as num
					if(Amount<=0){src << "No EXP was given.";return}
					A.Magic_XP += Amount
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s magic XP by [Amount]",2)
		if("Intelligence")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			switch(alert(src,"Reward Intelligence Levels or Experience?",,"Levels","Experience","Cancel"))
				if("Cancel")
					return
				if("Levels")
					var/oldlevel = A.Int_Level
					var/Amount=input(src,"How many levels do you want to give them?\nTheir current level is: [A.Int_Level] ([A.Int_XP]/[A.Int_Next])") as num
					if(Amount<=0){src<<"Levels were not raised.";return}
					A.medreward=Amount
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s Intelligence Level from [oldlevel] to [oldlevel+Amount].",2)
					var/c
					if(A.ifocus!="Intelligence") {A.ifocus="Intelligence";c=1}

					A << "Your intelligence level is being raised, please wait a moment."

/*
					for(var/i=0, i < Amount, i++)
						A.Int_XP = 40*(A.Int_Next/A.Add)
						sleep(20)
*/
					while(A&&A.Int_Level<(oldlevel+Amount))
						sleep(50)

					if(c)A.ifocus=0
					A.medreward=0

					A << "All done."

				if("Experience")
					var/Amount=input(src,"How much Intelligence XP do you want to give them?\nTheir current level is: [A.Int_Level] ([A.Int_XP]/[A.Int_Next])") as num
					if(Amount<=0){src << "No EXP was given.";return}
					A.Int_XP += Amount
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s Intelligence XP by [Amount]",2)

		if("Stats")

			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return

			var/Player_Count = length(Players)
			var/Str_Total=0
			var/End_Total=0
			var/Spd_Total=0
			var/Off_Total=0
			var/Def_Total=0

			for(var/mob/player/P in Players)

				var/str = (P.StrMod<1 ? P.StrMod+1 : P.StrMod)
				var/end = (P.EndMod<1 ? P.EndMod+1 : P.EndMod)
				var/spd = (P.SpdMod<1 ? P.SpdMod+1 : P.SpdMod)
				var/off = (P.OffMod<1 ? P.OffMod+1 : P.OffMod)
				var/def = (P.DefMod<1 ? P.DefMod+1 : P.DefMod)

				Str_Total+=P.StrMod/str
				End_Total+=P.EndMod/end
				Spd_Total+=P.SpdMod/spd
				Off_Total+=P.OffMod/off
				Def_Total+=P.DefMod/def

			var/list/statslist= list("Strength","Endurance","Speed","Offense","Defense","Everything","Cancel")
			var/statchoice=input(src,"Which stat ") in statslist

			switch(statchoice)
				if("Strength")
					var/Stat_Average=Str_Total/Player_Count
					var/Amount=input(src,"Set their [statchoice] to?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] from [Commas(A.StrMod)] to [Commas(Amount)]",2)
					A.StrMod=Amount

				if("Endurance")
					var/Stat_Average=End_Total/Player_Count
					var/Amount=input(src,"Set their [statchoice] to?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] from [Commas(A.EndMod)] to [Commas(Amount)]",2)
					A.EndMod=Amount

				if("Speed")
					var/Stat_Average=Spd_Total/Player_Count
					var/Amount=input(src,"Set their [statchoice]  to?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] from [Commas(A.SpdMod)] to [Commas(Amount)]",2)
					A.SpdMod=Amount


				if("Offense")
					var/Stat_Average=Off_Total/Player_Count
					var/Amount=input(src,"Set their [statchoice] to?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] from [Commas(A.OffMod)] to [Commas(Amount)]",2)
					A.OffMod=Amount

				if("Defense")
					var/Stat_Average=Def_Total/Player_Count
					var/Amount=input(src,"Set their [statchoice] to?\nAverage is [Commas(Stat_Average)]") as num
					if(!Amount)
						return
					logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s [statchoice] from [Commas(A.DefMod)] to [Commas(Amount)]",2)
					A.DefMod=Amount

				if("Everything")
					var/list/S2= list("Strength","Endurance","Speed","Offense","Defense")
					for(var/A2 in S2)
						var/Amount=input(src,"Set their [A2]?") as num
						if(Amount<0) Amount=0
						switch(A2)
							if("Strength")
								logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s [A2] from [Commas(A.StrMod)] to [Commas(Amount)]",2)
								A.StrMod=Amount
							if("Endurance")
								logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s [A2] from [Commas(A.EndMod)] to [Commas(Amount)]",2)
								A.EndMod=Amount
							if("Speed")
								logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s [A2] from [Commas(A.SpdMod)] to [Commas(Amount)]",2)
								A.SpdMod=Amount
							if("Offense")
								logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s [A2] from [Commas(A.OffMod)] to [Commas(Amount)]",2)
								A.OffMod=Amount
							if("Defense")
								logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s [A2] from [Commas(A.DefMod)] to [Commas(Amount)]",2)
								A.DefMod=Amount
				else return
		if("Milestone Points")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Amount=input(src,"How many Milestone Points do you want to give them? They already have [A.MilestonePoints]") as num
			if(!Amount)
				return
			if(Amount <= 0)
				Amount = 0
				return
			A.MilestonePoints += Amount
			A.TotalMilestonePoints += Amount
			logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s Milestone Points by [Amount].",2)

		if("Battle Power")
			var/Player_Count=0
			var/Average_Power=0
			var/Strongest_Power=0
			for(var/mob/player/B in Players) if(B.Race==A.Race&&B.Class==A.Class)
				Player_Count++
				Average_Power+=B.Base
				if(B.Base>Strongest_Power) Strongest_Power=B.Base
			Average_Power/=Player_Count
			var/Boost=input("Base: [Commas(A.Base)]. Race: [A.Race] [A.Class]. Average: [Commas(Average_Power)]. \
			Strongest: [Commas(Strongest_Power)]. Total Online: [Player_Count]. Recommended for Class 2: \
			[Commas(Average_Power*1.2)]. Recommended for Class 3: [Commas(Average_Power*1.5)]") as num
			if(!A) return
			if(round(A.Base)==Boost) return
			logAndAlertAdmins("[key_name(src)] brought [key_name(A)] the [A.Race] [A.Class] from [Commas(A.Base)] to [Commas(Boost)] base",2)
			A.Base=Boost
		if("Energy")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Amount=input(src,"What do you want to set their Maximum Ki to?\nTheir current level is: [A.BaseMaxKi])") as num
			if(!Amount)
				return
			var/oldenergy = A.BaseMaxKi
			A.BaseMaxKi=Amount
			logAndAlertAdmins("[key_name(src)] raised [key_name(A)]'s energy from [Commas(oldenergy)] to [Commas(Amount)]",2)
		if("Max Willpower")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Amount=input(src,"What do you want to set their MAXIMUM Willpower to?\nTheir current level is: [A.MaxWillpower])") as num
			if(!Amount)
				return
			var/oldenergy = A.MaxWillpower
			A.MaxWillpower=Amount
			logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s Max Willpower from [Commas(oldenergy)] to [Commas(Amount)]",2)
		if("Max HP")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Amount=input(src,"What do you want to set their MAXIMUM HP to?\nTheir current level is: [A.MaxHealth])") as num
			if(!Amount)
				return
			var/oldenergy = A.MaxHealth
			A.MaxHealth=Amount
			logAndAlertAdmins("[key_name(src)] changed [key_name(A)]'s Max HP from [Commas(oldenergy)] to [Commas(Amount)]",2)
		if("Resources")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/curamount
			for(var/obj/Resources/R in A) curamount=R.Value
			var/Amount=input(src,"How many resources?\nThey currently have: [curamount]") as num
			if(!Amount)
				return
			for(var/obj/Resources/R in A) R.Value+=Amount
			logAndAlertAdmins("[key_name(src)] gave [A] [Commas(Amount)]$",2)
		if("Mana")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/curamount
			for(var/obj/Mana/R in A) curamount=R.Value
			var/Amount=input(src,"How much mana? They currently have: [curamount]") as num
			if(!Amount)
				return
			for(var/obj/Mana/R in A) R.Value+=Amount
			logAndAlertAdmins("[key_name(src)] gave [A] [Commas(Amount)] mana",2)
		if("BP Mod")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Boost=input(src,"[A] the [A.Race]'s BP Mod is currently at [A.BPMod]x. Input what amount you want them to have.") as num
			if(!Boost)
				return
			logAndAlertAdmins("[key_name(src)] brought [key_name(A)] the [A.Race] from [A.BPMod]x to [Boost]x BP Mod",2)
			A.BPMod=Boost
		if("RP Power")
			if(src.holder.level < 1)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			var/Boost=input(src,"[A] the [A.Race]'s RP Power is currently at [A.RPPower]x. Input what amount you want them to have.","RP Power Reward",A.RPPower) as num
			if(!Boost)
				return
			logAndAlertAdmins("[key_name(src)] brought [key_name(A)] the [A.Race] from [A.RPPower]x to [Boost]x RP Power",2)
			A.RPPower=Boost



