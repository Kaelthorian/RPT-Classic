
/*var
  worldstarttime = 0
  worldstarttimeofday = 0*/
mob/player/Stat()

	ASSERT(src)  //null bug marker
	//var/Looting
	if(HasCreated)
		if(1)
			//Stats
			var/atom/E
			if(S) E=S
			else E=src

			statpanel("Status")
			if(statpanel("Status")) if(!afk)
				if(z==1)stat("The Ruler of this planet is [Z1ControllingRuler] from the [Z1ControllingFaction] faction.")
				if(z==2)stat("The Ruler of this planet is [Z2ControllingRuler] from the [Z2ControllingFaction] faction.")
				if(z==3)stat("The Ruler of this planet is [Z3ControllingRuler] from the [Z3ControllingFaction] faction.")
				if(z==4)stat("The Ruler of this planet is [Z4ControllingRuler] from the [Z4ControllingFaction] faction.")
				if(z==5)stat("The Ruler of this planet is [Z5ControllingRuler] from the [Z5ControllingFaction] faction.")
				if(z==6)stat("The Ruler of this planet is [Z6ControllingRuler] from the [Z6ControllingFaction] faction.")
				if(z==7)stat("The Ruler of this planet is [Z7ControllingRuler] from the [Z7ControllingFaction] faction.")
				if(z==18)
					stat("The Ruler of this planet is: [Z1ControllingRuler] from the [Z1ControllingFaction] faction.")
					stat("The Ruler of this planet is: [Z2ControllingRuler] from the [Z2ControllingFaction] faction.")
					stat("The Ruler of this planet is: [Z3ControllingRuler] from the [Z3ControllingFaction] faction.")
					stat("The Ruler of this planet is: [Z4ControllingRuler] from the [Z4ControllingFaction] faction.")
					stat("The Ruler of this planet is: [Z5ControllingRuler] from the [Z5ControllingFaction] faction.")
					stat("The Ruler of this planet is: [Z6ControllingRuler] from the [Z6ControllingFaction] faction.")
					stat("The Ruler of this planet is: [Z7ControllingRuler] from the [Z7ControllingFaction] faction.")
				if(EventCharacter)stat("Suggested Death Year","[EventCharacter+3] - [EventCharacter+5]")
				if(FusionTimer&&IsFusion)stat("<font color=#FF66FF>Fusion Timer</font>", "<font color=#FF66FF>[round((FusionTimer/40),0.5)] Minutes Remaining</font>")
				if(LethalCombatTracker) stat("<font color=#FF9966>Lethal Combat Tracker</font>", "<font color=#FF9966>[round((LethalCombatTracker/40)/1+(HasRapidDeployment*0.5),0.5)] Minutes Remaining</font>")
				if(HasFoodRegen) stat("<font color=#66CC33>Food Boost Active</font>", "<font color=#66CC33>[HasFoodRegen] ticks</font>")
				if(HasDrugs) stat("<font color=#33AACC>Drug Effects Active</font>", "<font color=#33AACC>[max(HasMorphine,HasPercocet,HasCialis,HasVitamins,HasMethyl,HasEpinephrine)] ticks</font>")
				stat("Age [round(Age,0.1)] \[Soul Age [round(Real_Age,0.1)]\]","[YearOutput()]")
				if(Race=="Android") stat("Components", "[Upgrade_Components]/25")
				if(Race=="Android") stat("Android Upgrade Level", "[AndroidLevel]")
				if(FBMAchieved==0) stat("Battle Power", "[ScouterOn?"[BP]":"???"]")
				if(GodKi) stat("God Ki", "<font color=#CCCC99>[GodKiActive ? "On":"Off"] ([GodKi] / [MaxGodKi])</font>")
				stat("Lethality", "[Lethality ? "On" : "Off"] [Spar ? "\[Pulling Punches\]" : ""]")
				stat("--------------------------")
				if(viewStats)
//					stat("+Energy:","[round(MaxKi)] ([KiMult] x) [StatCapCheck(BaseMaxKi/KiMod)<0.4?"<font color=#FF99FF>Max ([round(BaseMaxKi/KiMod)])</font>":StatCapCheck(BaseMaxKi/KiMod)<1?"<font color=#CCCC99>Overcapped ([round(BaseMaxKi/KiMod)])</font>":StatCapCheck(BaseMaxKi/KiMod)<1.5? "<font color=green>Capped ([round(BaseMaxKi/KiMod)])</font>":"<font color=yellow>Uncapped ([round(BaseMaxKi/KiMod)])</font>"]")
					stat("Energy:","[MaxKi] ([KiMult] x)")
					stat("Strength:","[StrMod*StrMult] ([StrMult] x)")
					stat("Force:","[StrMod*PowMult] ([PowMult] x)")
					stat("Endurance:","[EndMod*EndMult] ([EndMult] x)")
					stat("Speed:","[SpdMod*SpdMult] ([SpdMult] x)")
					stat("Offense:","[OffMod*OffMult] ([OffMult] x)")
					stat("Defense:","[DefMod*DefMult] ([DefMult] x)")


					stat("")
					stat("[ifocus=="Intelligence"?"+":""]Intelligence:","[Int_Level] ([Int_Mod] x) ([Commas(Int_XP)] / [Commas(40*(Int_Next/Int_Mod))]) [Int_Level>=TechCap+Int_Mod?"<font color=#FF99FF>Max </font>":Int_Level>=TechCap?"<font color=#CCCC99>Overcapped </font>":Int_Level==TechCap? "<font color=green>Capped</font>":"<font color=yellow>Uncapped</font>"]")
					stat("[magicfocus=="Magical Skill"?"+":""]Magic Skill:","[Magic_Level] ([Magic_Potential] x) ([Commas(Magic_XP)] / [Commas(40*(Magic_Next/Magic_Potential))]) [Magic_Level>=TechCap+Magic_Potential?"<font color=#FF99FF>Max </font>":Magic_Level>=TechCap?"<font color=#CCCC99>Overcapped </font>":Magic_Level==TechCap? "<font color=green>Capped</font>":"<font color=yellow>Uncapped</font>"]")
					stat("--------------------------")
				stat("Attack Speed","[round(Refire/100,0.1)] attack(s) per second")
				stat("Buff Slots","\[[BuffNumber] / [BuffLimit]\]")
				stat("Milestone Points","\[[MilestonePoints] / [TotalMilestonePoints]\]")
				stat("MPs To catch up","\[[max(0,round(Year)-TotalMilestonePoints)]]")
				stat("Experience", "\[[EXPLifetime]/[MaxEXPReward]]")
				stat("--------------------------")
				stat("Coordinates","[src.client.holder||src.ScouterOn?"([E.x],[E.y],[E.z])":"???"]")


				if(!afk) if(Target && ismob(Target)&&Target.client)
					stat("Target") //stat("Target",Target)
					if(statpanel("Status"))
						var/mob/Center
						if(usr.S) Center=S
						else Center=src
						stat("Direction","[dir2text(get_dir(Center.loc,Target.loc))]")
						if(ismob(Target)&&BaseMaxKi>250)


							var/MyP=BP*Pow*Str*Spd*Off*Def*Anger*RecovMult*BaseRecovery
							var/TheyP=Target.BP*Target.Pow*Target.Str*Target.Spd*Target.Off*Target.Def*Target.Anger*Target.RecovMult*Target.BaseRecovery
							var/Power=round((TheyP/MyP)*100)
							if(Power>10000) Power=10000

							var/PowDisplay
							if(Target.GodKiActive&&!GodKi) PowDisplay="???"
							else if(Target.Race=="Android")PowDisplay="???"
							else if(MaxKi>75/KiMod) PowDisplay="[round((Target.BP/BP)*100)] % your battle power"
							for(var/obj/items/Scanner/A in src) if(A.suffix)
								PowDisplay="[Commas(Target.BP)] ([round((Target.BP/BP)*100)] % your battle power)"
								if(Target.BP>A.Scan) PowDisplay="!?"
								if(Target.GodKiActive) PowDisplay="Error!"
							for(var/obj/items/Magic_Scanner/A in src) if(A.suffix)
								PowDisplay="[Commas(Target.BP)] ([round((Target.BP/BP)*100)] % your battle power)"
								if(Target.BP>A.Scan) PowDisplay="!?"
								if(Target.GodKiActive) PowDisplay="[PowDisplay] (Unknown Energy Type)"
								if(Target.Race=="Android") PowDisplay="-----"
							if(Target.KOd==0)
								if(MaxKi>150/KiMod) stat("Combat Power","[Power] % your strength")
								if(MaxKi>75/KiMod) stat("Battle Power","[PowDisplay]")
							else stat("Life","[round(Target.Life)] %")
							stat("Willpower","[round((Target.Willpower/Target.MaxWillpower)*100)] %")
							if(MaxKi>500/KiMod&&Target.KOd==0)
								stat("Health","[round(Target.Health/Target.MaxHealth*100)] %")
								stat("Energy","[round(Target.Ki/Target.MaxKi*100)] %")
								stat("Energy Signature","[Target.Signature]")
								if(Magic_Potential>=2) stat("Alignment","[Target.Alignment]")
							if(MaxKi>500/KiMod) for(var/obj/Contact/A in src.Contacts) if(A.Signature==Target.Signature&&A.familiarity>10) if(Target.Race!="Android")
								stat("Strength","[round((Target.Str/Str)*100)] %")
								stat("Endurance","[round((Target.End/End)*100)] %")
								stat("Force","[round((Target.Pow/Pow)*100)] %")
								stat("Speed","[round((Target.Spd/Spd)*100)] %")
								stat("Offense","[round((Target.Off/Off)*100)] %")
								stat("Defense","[round((Target.Def/Def)*100)] %")
						if(Magic_Potential>=6) stat("Infection Status","[Target.Infection? "Infected":"Uninfected"]")
						if(HasSurgicalStrikes>=5) for(var/BodyPart/BP in Target) stat("[BP]","\[[round((BP.Health/BP.MaxHealth)*100,0.1)]%\] ([BP.Status]) [BP.Cybernetic ? "Cybernetic":""]")


			if(src.client.holder)if(ServerInfoOn||src.client.ServerInfoOn)if(!afk)
				statpanel("Server Information")
				if(statpanel("Server Information"))
					if(!global.ItemsLoaded||!global.MapsLoaded) stat("Server is: ","ADMIN ONLY (ItemsLoaded: [global.ItemsLoaded] | MapsLoaded: [global.MapsLoaded])")
					stat("Server Lock:","[global.rebooting ? "On" : "Off"]")
					stat("Version Number:","[UPDATE_VERSION]")
					stat("Processor:","[world.cpu]%")
					stat("FPS:","[world.fps]")
					stat("Tick Lag:","[world.tick_lag]")
					stat("Ki Power:","[round(Ki_Power*100)]%")
					if(autoannounce) stat("Auto Announce (Every [autoannouncedelay] Minutes)","[autoannounce]")
					if(global.HubText) stat("Hubtext","[global.HubText]")
					stat("")
					stat("Speed Dividend","[BaseRefireDiv]")
					stat("Gains Information")
					stat("Gain Multiplier Rate:","[Commas(GainMultRate*100)]%")
					stat("Gain Mulitiplier Cap:","[Commas(Gain_Mult_Cap)]")
					stat("BP Gain Speed:","[GG/Gain_Divider]%")
//					stat("Energy Gain Speed:","[EnergyGainSpeed*100]%")
					stat("Stat Gain:","[StatGain/Stat_Gain_Divider]%")
					stat("Int/Magic Gain Speed:","[Admin_Int_Setting*100]%")
					stat("Resources per Month:","[Commas(GlobalResourceRate)]")
					stat("")
					stat("Day Scaler:","[DayScaler]")
					stat("Wipe Day:","[WipeDay]")
					stat("Wipe Day Progress:","[WipeDayProgress]")


					stat("")
					stat("Starter Boost BP","[Commas(StarterBoostBP)]")
	//				stat("Starter Boost Energy","[StarterBoostEnergy]")
					stat("Starter Gain Multiplier:","[MinGainMult]")
					stat("")
					stat("World Settings")
					stat("First SSj:","[First_SSJ ? "[First_SSJ]" : "None"]")
					stat("First SSj 2:","[First_SSJ2 ? "[First_SSJ2]" : "None"]")
					stat("Global Transformation:","[Global_Trans ? "On" : "Off"]")
					stat("Global SSj:","[Global_SSJ ? "On" : "Off"]")
					stat("Global SSj 2:","[Global_SSJ2 ? "On" : "Off"]")
					stat("Global SSGSS:","[Global_Ascension ? "On" : "Off"]")
					stat("Global God Ki Leech:","[Global_GodKi ? "On" : "Off"]")
					stat("Global God Ki Training:","[Global_GodKiTrain ? "On ([Global_GodKiCap] Cap)" : "Off"]")
					stat("Realm Teleport:","[RealmTeleport ? "On" : "Off"]")
					stat("Makyo Star:","[MakyoStar ? "On" : "Off"]")
					stat("Android Ship Resources:","[Commas(AndroidRes)]")
//					stat("TestServerOn","[TestServerOn]")									//TestServerTestServerTestServerTestServerTestServerTestServerTestServerTestServer



			if(src&&src.client.holder) if(AdminSenseToggle)
				if(src)
					statpanel("Admin Sense")
					if(statpanel("Admin Sense")) if(!afk)
						if(ismob(Target))
							stat("[Target]")
							stat("God Ki [round(Target.GodKi,0.01)]")
							stat("Life","[round(Target.Life)]%")
							stat("Willpower","[round((Target.Willpower/Target.MaxWillpower)*100)]%")
							stat("Health","[round((Target.Health/Target.MaxHealth)*100)]%")
							stat("Energy","[round(Target.Ki/Target.MaxKi*100)]%")
							stat("BP","[Commas(Target.BP)] ([round(Target.BPMod,0.01)] Mod) ([Commas(Target.Base)] Base)")
							stat("Ki","[Commas(Target.Ki)] ([round(Target.KiMod,0.01)] Mod) ([Commas(Target.MaxKi)] Max)")
							stat("Experience","[Commas(Target.GainMultiplier)]x")
							for(var/obj/A in Target.contents)
								if(istype(A, /obj/Technology)) continue
								if(istype(A,/Milestone)) continue
								stat(A)
			if(src&&src.client.holder) if(AdminSenseToggle)
				if(src)
					statpanel("Admin Sense Extra")
					if(statpanel("Admin Sense Extra")) if(!afk)
						if(ismob(Target))
							for(var/obj/A in Target.Contacts) stat(A)
							for(var/Milestone/A in Target) stat(A)
			//Tabs
			if(S) if(S.Nav&&S.z==12)//if(S.Nav&&S.Planets&&S.z==11)
				statpanel("Navigation")
				if(statpanel("Navigation")) if(!afk)
					for(var/obj/Planets/A) stat("[dir2text(get_dir(S.loc,A.loc))]",A)
			if(z==12)//if(S.Nav&&S.Planets&&S.z==11)
				statpanel("Navigation")
				if(statpanel("Navigation")) if(!afk)
					for(var/obj/Planets/A) stat("[dir2text(get_dir(loc,A.loc))]",A)
			for(var/obj/Baby/A in src)
				statpanel("Mating")
				if(!afk) if(statpanel("Mating")) stat(A)
				else break
			for(var/obj/SoulContractObj/SC in src)
				statpanel("Contracts")
				stat(SC)
			for(var/obj/ConjureContractObj/SC in src)
				statpanel("Contracts")

			if(ShowBodyParts)
				for(var/BodyPart/BP in src)
					statpanel("Body Parts")
					BP.suffix="[BP.Health] / [BP.MaxHealth] HP"
					stat(BP)
			if(ShowLanguages)
				for(var/Language/L in src)
					statpanel("Languages")
					L.suffix="[L.Mastery] %"
					stat(L)
			for(var/obj/Faction/FC in src)
				statpanel("Factions")
				stat(FC)
			statpanel("Items")
			if(statpanel("Items")) if(!afk)
				for(var/obj/Resources/A in src)
					A.suffix="[Commas(A.Value)]"
					stat(A)
				for(var/obj/Mana/A in src)
					A.suffix="[Commas(A.Value)]"
					stat(A)
				for(var/obj/Ships/A in src) stat(A)
				/*for(var/obj/items/rawore/A in src) stat(A)
				for(var/obj/items/rawmetal/A in src) stat(A)
				for(var/obj/items/rawfood/A in src) stat(A)
				for(var/obj/items/cookedfood/A in src) stat(A)*/
				for(var/obj/items/A in src) if(!istype(A, /obj/items/Clothes)) stat(A)
				for(var/obj/items/Clothes/A in src) stat(A)

				var/Extra=HasBelt
				if(Race=="Tuffle") Extra+=5
				stat("Inventory Space:","[InventoryUsed] / [InventorySpace+(HasBeastOfBurden*10)+Extra]")
	sleep(20)
//var/gainget=0.00000001


//////MARKER
proc/sanityStats(mob/player/_player)

	if(!ismob(_player)) return FALSE // If the mob isn't a player mob. Then we're not checking stats.
	var/list/statlist = list(_player.Str, _player.StrMod, _player.End, _player.EndMod,
							  _player.Spd, _player.SpdMod, _player.Pow, _player.Off, _player.OffMod,
							  _player.Def, _player.DefMod, _player.StrMod,_player.EndMod,
							  _player.SpdMod,_player.OffMod,_player.DefMod) // All of their stats in a list.
	var/statcount = 0

	for(var/stat in statlist) // Loop through the list
		if(isnum(stat)) // Check if each entry is an actual number
			//sleep (1)
			statcount++ // Add one to the count
		else continue

	if(statcount == statlist.len) // If the count is as long as the list, then every stat was a number
		return TRUE // And we can continue the statrank proc.
	else
		return FALSE // If not, then something was wrong and we kill the statrank proc.


mob/proc/StatRank()
	ASSERT(src)
	if(!HasCreated) return
	if(!sanityStats(src)) return
	if(!WeightedStats) return
	if(!src.BPMod) src.BPMODFIX()
	if(src.BPMod==0) src.BPMODFIX()
	ASSERT(src.WeightedStats)
	ASSERT(src.Base||src.BPMod)
	if(DoesNotAffectStatRank)
		StatRank=50
		BPRank=50
		return
	var/StrongerStats=1
	var/StrongerBPs=1
	var/People=0 // Was 0.  Creates a potential divide by zero runtime error when attempting to assess the number of people present. -Arch
	for(var/mob/player/A in Players) if(A) if(!A.DoesNotAffectStatRank) if(A.WeightedStats&&A.HasCreated)// if(A.Savable&&A.HasCreated)
		ASSERT(A)
		ASSERT(A.WeightedStats)
		ASSERT(A.Base||A.BPMod)
		People++
		var/TheirStats=A.WeightedStats
		var/YourStats=WeightedStats
		if(TheirStats>YourStats) StrongerStats++
		if(A.Base/A.BPMod>Base/BPMod) StrongerBPs++
	if(People<1) People=1
	var/Modifier=100/People
	StatRank=StrongerStats*Modifier
	BPRank=StrongerBPs*Modifier
	if(!isnum(StatRank)||!isnum(BPRank)){log_errors("StatRank for [src] is not a number!");return}
	if(StatRank > 100) StatRank=100
	if(StatRank < 1) StatRank=1
	if(BPRank > 100) BPRank=100
	if(BPRank < 1) BPRank=1
	if(src.GainMultiplier<MinGainMult) src.GainMultiplier=MinGainMult
	if(src.GainMultiplier>Gain_Mult_Cap) src.GainMultiplier=Gain_Mult_Cap

mob/verb/InventoryAll()
	set name="Inventory"
	set category="Other"
	winshow(client,"Inventory",1)
	winset(client,"Inventory.Grid","cells=0x0")
	var/Row=0

	for(var/obj/Resources/A in src)
		Row++
		src << output(A, "Inventory.Grid:1,[Row]")
		src << output("[Commas(A.Value)]", "Inventory.Grid:2,[Row]")
	for(var/obj/Mana/A in src)
		Row++
		src << output(A, "Inventory.Grid:1,[Row]")
		src << output("[Commas(A.Value)]", "Inventory.Grid:2,[Row]")

	for(var/obj/Ships/A in src)
		Row++
		src << output(A, "Inventory.Grid:1,[Row]")
	for(var/obj/items/MP in src)
		Row++

		var/showstuff="[MP.desc]"
		if(istype(MP,/obj/items))
			var/obj/items/O=MP
			showstuff="[showstuff] [src.Display_Magic(O)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."

		src << output(MP, "Inventory.Grid:1,[Row]")
		src << output("[showstuff]", "Inventory.Grid:2,[Row]")
		src << output("[MP.suffix]", "Inventory.Grid:3,[Row]")

	Row++
	var/Extra=HasBelt
	if(Race=="Tuffle") Extra+=5
	src << output("Inventory Space:", "Inventory.Grid:1,[Row]")
	src << output("[InventoryUsed] / [InventorySpace+(HasBeastOfBurden*10)+Extra]", "Inventory.Grid:2,[Row]")

mob/verb/InventoryItems()
	winshow(client,"Inventory",1)
	winset(client,"Inventory.Grid","cells=0x0")
	var/Row=0

	for(var/obj/Ships/A in src)
		Row++
		src << output(A, "Inventory.Grid:1,[Row]")

	for(var/obj/items/MP in src) if(!istype(MP, /obj/items/Clothes)) if(!istype(MP, /obj/items/rawfood))if(!istype(MP, /obj/items/cookedfood))if(!istype(MP, /obj/items/rawmetal))if(!istype(MP, /obj/items/rawore))
		Row++

		var/showstuff="[MP.desc]"
		if(istype(MP,/obj/items))
			var/obj/items/O=MP
			showstuff="[showstuff] [src.Display_Magic(O)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."

		src << output(MP, "Inventory.Grid:1,[Row]")
		src << output("[showstuff]", "Inventory.Grid:2,[Row]")
		src << output("[MP.suffix]", "Inventory.Grid:3,[Row]")

	Row++
	var/Extra=HasBelt
	if(Race=="Tuffle") Extra+=5
	src << output("Inventory Space:", "Inventory.Grid:1,[Row]")
	src << output("[InventoryUsed] / [InventorySpace+(HasBeastOfBurden*10)+Extra]", "Inventory.Grid:2,[Row]")


mob/verb/InventoryFood()
	winshow(client,"Inventory",1)
	winset(client,"Inventory.Grid","cells=0x0")
	var/Row=0
	for(var/obj/items/rawfood/MP in src)
		Row++

		var/showstuff="[MP.desc]"
		if(istype(MP,/obj/items))
			var/obj/items/O=MP
			showstuff="[showstuff] [src.Display_Magic(O)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."

		src << output(MP, "Inventory.Grid:1,[Row]")
		src << output("[showstuff]", "Inventory.Grid:2,[Row]")
	for(var/obj/items/cookedfood/MP in src)
		Row++

		var/showstuff="[MP.desc]"
		if(istype(MP,/obj/items))
			var/obj/items/O=MP
			showstuff="[showstuff] [src.Display_Magic(O)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."

		src << output(MP, "Inventory.Grid:1,[Row]")
		src << output("[showstuff]", "Inventory.Grid:2,[Row]")

	Row++
	var/Extra=HasBelt
	if(Race=="Tuffle") Extra+=5
	src << output("Inventory Space:", "Inventory.Grid:1,[Row]")
	src << output("[InventoryUsed] / [InventorySpace+(HasBeastOfBurden*10)+Extra]", "Inventory.Grid:2,[Row]")

mob/verb/InventoryMetal()
	winshow(client,"Inventory",1)
	winset(client,"Inventory.Grid","cells=0x0")
	var/Row=0
	for(var/obj/items/rawore/MP in src)
		Row++

		var/showstuff="[MP.desc]"
		if(istype(MP,/obj/items))
			var/obj/items/O=MP
			showstuff="[showstuff] [src.Display_Magic(O)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."

		src << output(MP, "Inventory.Grid:1,[Row]")
		src << output("[showstuff]", "Inventory.Grid:2,[Row]")
	for(var/obj/items/rawmetal/MP in src)
		Row++

		var/showstuff="[MP.desc]"
		if(istype(MP,/obj/items))
			var/obj/items/O=MP
			showstuff="[showstuff] [src.Display_Magic(O)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."

		src << output(MP, "Inventory.Grid:1,[Row]")
		src << output("[showstuff]", "Inventory.Grid:2,[Row]")

	Row++
	var/Extra=HasBelt
	if(Race=="Tuffle") Extra+=5
	src << output("Inventory Space:", "Inventory.Grid:1,[Row]")
	src << output("[InventoryUsed] / [InventorySpace+(HasBeastOfBurden*10)+Extra]", "Inventory.Grid:2,[Row]")

mob/verb/InventoryClothes()
	winshow(client,"Inventory",1)
	winset(client,"Inventory.Grid","cells=0x0")
	var/Row=0
	for(var/obj/items/Clothes/MP in src)
		Row++

		var/showstuff="[MP.desc]"
		if(istype(MP,/obj/items))
			var/obj/items/O=MP
			showstuff="[showstuff] [src.Display_Magic(O)]<br>It seems to have a serial number of [O.Serial].<br>It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."

		src << output(MP, "Inventory.Grid:1,[Row]")
		src << output("[showstuff]", "Inventory.Grid:2,[Row]")

	Row++
	var/Extra=HasBelt
	if(Race=="Tuffle") Extra+=5
	src << output("Inventory Space:", "Inventory.Grid:1,[Row]")
	src << output("[InventoryUsed] / [InventorySpace+(HasBeastOfBurden*10)+Extra]", "Inventory.Grid:2,[Row]")


mob/proc/Stat_Labels()
	var/RawHP=Health/MaxHealth
	var/Health_Multiplier=RawHP
	if(RawHP>0.9&&RawHP<=0.95) Health_Multiplier=0.95
	if(RawHP>0.85&&RawHP<=0.9) Health_Multiplier=0.90
	if(RawHP>0.8&&RawHP<=0.85) Health_Multiplier=0.85
	if(RawHP>0.75&&RawHP<=0.8) Health_Multiplier=0.80
	if(RawHP>0.7&&RawHP<=0.75) Health_Multiplier=0.75
	if(RawHP>0.65&&RawHP<=0.7) Health_Multiplier=0.70
	if(RawHP>0.60&&RawHP<=0.65) Health_Multiplier=0.65
	if(RawHP>0.55&&RawHP<=0.60) Health_Multiplier=0.60
	if(RawHP>0.50&&RawHP<=0.55) Health_Multiplier=0.55
	if(RawHP>0.45&&RawHP<=0.50) Health_Multiplier=0.50
	if(RawHP>0.40&&RawHP<=0.45) Health_Multiplier=0.45
	if(RawHP>0.35&&RawHP<=0.40) Health_Multiplier=0.40
	if(RawHP>0.30&&RawHP<=0.35) Health_Multiplier=0.35
	if(RawHP<=0.30) Health_Multiplier=0.30
	if(!AndroidLevel) Health_Multiplier=max(0.3,Health_Multiplier)
	else Health_Multiplier=max(0.5,Health_Multiplier)


	if(HPDoesNotAffectBP||HasPercocet||Vampire||HasAsLongAsMyHeartBeats)
		if(RawHP>0.9&&RawHP<0.97) Health_Multiplier=0.97
		if(RawHP>0.8&&RawHP<=0.9) Health_Multiplier=0.95
		if(RawHP>0.7&&RawHP<=0.8) Health_Multiplier=0.92
		if(RawHP>0.6&&RawHP<=0.7) Health_Multiplier=0.90
		if(RawHP>0.5&&RawHP<=0.6) Health_Multiplier=0.87
		if(RawHP>0.4&&RawHP<=0.5) Health_Multiplier=0.85
		if(RawHP>0.3&&RawHP<=0.4) Health_Multiplier=0.82
		if(RawHP>0.2&&RawHP<=0.3) Health_Multiplier=0.80
		if(RawHP>0.1&&RawHP<=0.2) Health_Multiplier=0.77
		Health_Multiplier=max(0.75,Health_Multiplier)

	if(Anger_Restoration) Health_Multiplier=1
	if(KOd)  Health_Multiplier=1

	var/RawKi=Ki/MaxKi

	if(Ki/MaxKi>0.95) RawKi=1
	else if(Ki/MaxKi>0.9) RawKi=0.98
	else if(Ki/MaxKi>0.85) RawKi=0.93
	else if(Ki/MaxKi>0.80) RawKi=0.84
	else if(Ki/MaxKi<=0.8) RawKi=RawKi**1.3 //starts aroun 75% caps around 18%

	var/Energy_Multiplier=max(0.1,RawKi)

	RawKi=Ki/MaxKi
	if(KiDoesNotAffectBP) if(Race!="Android")
		if(RawKi>0.9&&RawKi<1) RawKi=0.99
		if(RawKi>0.8&&RawKi<=0.9) RawKi=0.96
		if(RawKi>0.7&&RawKi<=0.8) RawKi=0.93
		if(RawKi>0.6&&RawKi<=0.7) RawKi=0.90
		if(RawKi>0.5&&RawKi<=0.6) RawKi=0.87
		if(RawKi>0.4&&RawKi<=0.5) RawKi=0.84
		if(RawKi>0.3&&RawKi<=0.4) RawKi=0.81
		if(RawKi>0.2&&RawKi<=0.3) RawKi=0.78
		if(RawKi>0.1&&RawKi<=0.2) RawKi=0.75
		Energy_Multiplier=max(0.7,RawKi)
	if(Race=="Android") //Energy_Multiplier=1
		if(RawKi>0.9&&RawKi<0.99) RawKi=0.98
		if(RawKi>0.8&&RawKi<=0.9) RawKi=0.96
		if(RawKi>0.7&&RawKi<=0.8) RawKi=0.94
		if(RawKi>0.6&&RawKi<=0.7) RawKi=0.92
		if(RawKi>0.5&&RawKi<=0.6) RawKi=0.90
		if(RawKi>0.4&&RawKi<=0.5) RawKi=0.88
		if(RawKi>0.3&&RawKi<=0.4) RawKi=0.86
		if(RawKi>0.2&&RawKi<=0.3) RawKi=0.84
		if(RawKi>0.1&&RawKi<=0.2) RawKi=0.82
		Energy_Multiplier=max(0.8,RawKi)

	if(HUDOn)
		winset(src.client,"HealthBar","value=[round(Health/MaxHealth*100)]")
		src<<output("Health: [round(Health/MaxHealth*100)]%","HealthZ")
		if(MaxKi&&isnum(MaxKi))
			winset(src.client,"EnergyBar","value=[round((Ki/MaxKi)*100)]")
			src<<output("Energy: [round((Ki/MaxKi)*100)]%","EnergyZ")
		winset(src.client,"BPBar","value=[round((Health_Multiplier)*(Energy_Multiplier)*(BPpcnt)*(Body)*(Anger/100))]") //*(Anger/100)
		src<<output("Power: [round((Health_Multiplier)*(Energy_Multiplier)*(BPpcnt)*(Body)*(Anger/100))]%","PowerZ") //*(Anger/100)
		src<<output("Gravity: [Gravity]x","GravityT")

	src<<output("Health: [round(Health/MaxHealth*100)]%","Health")
	if(MaxKi&&isnum(MaxKi)) src<<output("Energy: [round((Ki/MaxKi)*100)]%","Energy")
	if(BPpcnt>100) src<<output("Power: [round((Health_Multiplier)*(Energy_Multiplier)*(BPpcnt)*(Body)*(Anger/100))]% (+[round(BPpcnt-100,0.1)]%)","Power") //Removed *(Anger/100) after Body at end of formula in order to hide anger %
	else if(BPpcnt<100) src<<output("Power: [round((Health_Multiplier)*(Energy_Multiplier)*(BPpcnt)*(Body)*(Anger/100))]% (-[round(BPpcnt-100,0.1)]%)","Power") //*(Anger/100)
	else src<<output("Power: [round((Health_Multiplier)*(Energy_Multiplier)*(BPpcnt)*(Body)*(Anger/100))]%","Power") //*(Anger/100)
	src<<output("Gravity: [Gravity]x","Gravity")
	src<<output("Willpower: [round(Willpower/MaxWillpower*100)]%","Willpower")

//add shit to modify these
mob/var
	EXPCurrentCycle=0
	EXPLifetime=0
	EXPInTransit=0
	EXPFromToken=0
	RoleplayRewards=0
	EXPUnfiltered=0

var/global
	MaxEXPReward=50 //Max number of rewards in one cycle = 550 EXP per 5 days
	NextRPReward=1
	BaseEXPRate=1


mob/proc/EarnServerEmote(type=1)
	if(type==1)
		EXPUnfiltered+=BaseEXPRate*5
		if(EXPLifetime<=MaxEXPReward)//&&RoleplayRewards<=Year)
			if(RoleplayRewards!=NextRPReward)
				EXPCurrentCycle+=BaseEXPRate*5
			EXPLifetime+=BaseEXPRate*5
			EXP+=BaseEXPRate*5
			if(Race=="Yardrat") EXP+=(BaseEXPRate/10)*5
			if(RoleplayRewards==NextRPReward&&EXPLifetime<=MaxEXPReward)
				EXPLifetime+=BaseEXPRate*2.5
				EXP+=BaseEXPRate*2.5
				if(Race=="Yardrat") EXP+=(BaseEXPRate/10)*2.5
			if(EXPLifetime<=MaxEXPReward)
				EXPInTransit=(MaxEXPReward-EXPLifetime)
				EXP+=EXPInTransit
				EXPLifetime+=EXPInTransit

			if(EXPLifetime<=MaxEXPReward-300)
				EXPLifetime+=BaseEXPRate*2.5
				EXP+=BaseEXPRate*2.5
				if(Race=="Yardrat")
					EXP+=(BaseEXPRate/10)*2.5

			if(EXPLifetime<=EXPLifetime-250)
				EXP+=BaseEXPRate*2
				if(EXP>=MaxEXPReward)
					EXP = MaxEXPReward
					EXPLifetime = MaxEXPReward


	if(type==2)
		if(EXPLifetime<=MaxEXPReward)//&&RoleplayRewards<=Year)
			if(RoleplayRewards!=NextRPReward)EXPCurrentCycle+=BaseEXPRate
			EXP+=BaseEXPRate
			EXPLifetime+=BaseEXPRate
			if(Race=="Yardrat") EXP+=(BaseEXPRate/10)
			if(RoleplayRewards==NextRPReward&&EXPLifetime<=MaxEXPReward)
				EXPLifetime+=BaseEXPRate*0.5
				EXP+=BaseEXPRate*0.5
				if(Race=="Yardrat") EXP+=(BaseEXPRate/10)*0.5

			if(EXPLifetime<=MaxEXPReward-300)
				EXPLifetime+=BaseEXPRate*0.5
				EXP+=BaseEXPRate*0.5
				if(Race=="Yardrat") EXP+=(BaseEXPRate/10)*0.5

			if(RoleplayRewards!=NextRPReward&&EXPCurrentCycle>=100)
				RoleplayRewards=NextRPReward
				usr.AllOut("You have qualified for Roleplay Rewards.")
				EXPCurrentCycle=0

			if(EXPLifetime<=EXPLifetime-250)
				EXP+=BaseEXPRate*2
				if(EXP>=MaxEXPReward)
					EXP = MaxEXPReward
					EXPLifetime = MaxEXPReward

	if(RoleplayRewards!=NextRPReward&&EXPCurrentCycle>=100)
		RoleplayRewards=NextRPReward
		usr.AllOut("You have qualified for Roleplay Rewards.")
		EXPCurrentCycle=0

