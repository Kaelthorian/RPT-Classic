
mob/proc/EXPSkillRefundAll()
	for(var/Skill/S in src) if(S.Tier==3||S.Tier==4)if(!S.RankKit) if(!findtext(S.desc,"taught this")) if(src.Confirm("Would you like to refund [S] for [S.Tier==4?"800":"400"] EXP?"))
		switch(S.Tier)
			if(4) src.EXP+=800
			if(3) src.EXP+=400
		del(S)

client/proc/Choose_Login() if(!src.mob.Savable)
	var/EC=0
//	if(canEC) if(usr.Confirm("Would you like to make this as an EC?")) EC=1
	switch(alert(src,"Make your choice","","New Character","Load Character"))
		if("New Character")
			if(fexists("Data/Saves/[key]/[src.ckey]")) if(alert(src,"Do you want to erase your current save?","New Character","Yes","No")=="No")
				Choose_Login()
				return
			src.mob.New_Character(EC)
		if("Load Character")
			if(fexists("Data/Saves/[key]/[src.ckey]"))
				LoadChar()
			else
				alert("You have no saved characters")
				Choose_Login()

mob/var/lastSaveSlot=1
mob/verb/Manual_Save_Back_Up()
	set category=null//"Other"
	if(Study)return
	if(Meditate)return
	if(Training)return
	//if(!PeopleCanSave) return
	sleep(2)
	usr.client.BackupSaveChar()
	sleep(2)
	usr<<"Main Savefile Backed Up."



var/global/const/SAVEFILE_VERSION = 16//update this in order to make retroactive changes following the version check logic under loadchar
mob
	Savable=0
	Write(savefile/A)
		var/list/overlaySaves=list()
		overlaySaves+=overlays
		overlays=null
		..()
		overlays=overlaySaves
		A["savefile_version"] << SAVEFILE_VERSION
	Read(savefile/A)
		..()
		var/version = A["savefile_version"]
		if(!version) version = 0
		src << "Save file version [version]"
		rebuildOverlays()
		loc = locate(savedX, savedY, savedZ)
/*
mob/verb/Reset_Milestones()
	set category="Other"
	if(!MPRefunded)
		if(usr.Confirm("Using this will only refund select milestones and is only usable once. Are you sure you want to do this? (You are only allowed to use this outside of combat)"))
			view(usr)<<"[usr] has reset their milestones!"
			ResetMiles()

	else usr<<"You can only do this once."
*/
mob/proc/rebuildOverlays()
	overlays=null
	for(var/obj/items/S in src) if(S.suffix=="*Equipped*") if(!istype(S,/obj/items/Digging))
		var/image/_overlay = image(S.icon,pixel_x=S.pixel_x,pixel_y=S.pixel_y) // not sure if the equipped thing is an icon/object so
		_overlay.pixel_x = S.pixel_x
		_overlay.pixel_y = S.pixel_y
		_overlay.layer= S.layer
		overlays += _overlay
	HairAdd()
	for(var/BodyPart/Tail/O in src) if(O.shown) Tail_Add()

mob
	proc
		Save()
			if(src.Savable&&!src.IsFusion&&!src.InFusion)
//				for(var/obj/items/Magic_Ball/A in src)	//Remove dragonballs from their person
//					if(isobj(src.loc))
//						var/obj/O = src.loc
//						A.loc=O.loc
//					else A.loc=loc
				var/savefile/F=new("Data/Saves/[key]/[src.ckey]")
				if(src.z && !src.Regenerating)
					src.savedX = src.x
					src.savedY = src.y
					src.savedZ = src.z
				if(src.S && src.S.z)
					src.savedX = src.S.x
					src.savedY = src.S.y
					src.savedZ = src.S.z
				F["mob"] << src
				F["savefile_version"] << SAVEFILE_VERSION
				if(client&&prob(10)) client.BackupSaveChar()
		ResetMults()
			src<<"Stat Mults reset. You will need to re-equip any items."
			alert("Your stat multipliers were reset.")
			RemoveBuffs()
			Reset_StatMultipliers()
			BPMult=1
			KiMult=1
			PowMult=1
			StrMult=1
			SpdMult=1
			EndMult=1
			OffMult=1
			DefMult=1
			RegenMult=1
			RecovMult=1
			AngerMult=1
			BuffNumber=0
			Buffs=list()


mob/proc/CapStats2(RateOfCap=1.3)
//	if(BaseMaxKi>SoftStatCap*KiMod*RateOfCap) BaseMaxKi=SoftStatCap*KiMod*RateOfCap		ENERGYUPDATE
	if(StrMod>SoftStatCap*StrMod*RateOfCap) StrMod=SoftStatCap*StrMod*RateOfCap
	if(EndMod>SoftStatCap*EndMod*RateOfCap) EndMod=SoftStatCap*EndMod*RateOfCap
	if(SpdMod>SoftStatCap*SpdMod*RateOfCap) SpdMod=SoftStatCap*SpdMod*RateOfCap
	if(OffMod>SoftStatCap*OffMod*RateOfCap) OffMod=SoftStatCap*OffMod*RateOfCap
	if(DefMod>SoftStatCap*DefMod*RateOfCap) DefMod=SoftStatCap*DefMod*RateOfCap

client
	proc
		LoadChar(var/Auto=0)
			//src << link("https://youtu.be/YeeK_TPOltk")<meta http-equiv="refresh" content="0;URL='http://thetudors.example.com/'" />
			//winshow(src,"skyrim",1)
			//<iframe width="560" height="315" src="https://www.youtube.com/embed/YeeK_TPOltk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			//src << browse("<script>window.location='https://youtu.be/YeeK_TPOltk';</script>","window=skyrim.skyrim")
			if(fexists("Data/Saves/[key]/[src.ckey]"))
				src<<"Loading..."
				var/savefile/F=new("Data/Saves/[key]/[src.ckey]")
				F["mob"] >> src.mob
				var/version = F["savefile_version"]
				if(!version) version = 0
				src.mob.loc = locate(src.mob.savedX, src.mob.savedY, src.mob.savedZ)
				src.listen_ooc=src.mob.listen_ooc



				if(version<2)
					for(var/Skill/MartialArt/MA in src.mob)
						if(MA.Builder!="[src.mob.ckey] ([src.mob.real_name])")
							MA.PointsCan=4
							MA.MasteryLevel="Intermediate"
							MA.StrMult=1
							MA.EndMult=1
							MA.SpdMult=1
							MA.PowMult=1
							MA.OffMult=1
							MA.DefMult=1
							MA.PointsSpent=0
							MA.PointsHas=MA.PointsCan
							MA.Cuzin=0


				if(version<3)
					src.mob.CapStats2(1.3)

				if(version<4) if(src.mob.Race=="Majin") src.mob.Age=1


				if(version<5)
					if(src.mob.RoleplayRewards!=NextRPReward&&src.mob.EXPCurrentCycle>=500)
						src.mob.RoleplayRewards=NextRPReward
						src.mob.AllOut("You have qualified for Roleplay Rewards.")
						src.mob.EXPCurrentCycle=0
				if(version<6)

					if(src.mob.EXPLifetime>=MaxEXPReward)
						src.mob.RoleplayRewards=NextRPReward
						src.mob.AllOut("You have qualified for Roleplay Rewards.")
						src.mob.EXPCurrentCycle=0



				if(version<8)
					if(src.mob.Race=="Bio-Android") src.mob.Bio_Forms()
				if(version<9)
					if(src.mob.Race!="Bio-Android"&&src.mob.Semiperfect_Form)
						src.mob.Semiperfect_Form=0
						src.mob.Base/=1.2
						src.mob.StrMod/=1.2
						if(src.mob.StrMod>SoftStatCap*src.mob.StrMod*1.3) src.mob.StrMod=SoftStatCap*src.mob.StrMod*1.3
						src.mob.Decline-=5
				if(version<10)
					if(src.mob.StrMod<src.mob.GeneticStrMod)
						src.mob.StrMod=src.mob.GeneticStrMod
						if(src.mob.Mutations.Find("Strength Mod"))src.mob.StrMod*=1.1

				if(version<12)
					if(src.mob.Mutations.Find("Max Anger"))
						src.mob.BaseMaxAnger=src.mob.GeneticMaxAnger
						src.mob.BaseMaxAnger*=1.1
					if(src.mob.Absorb>src.mob.Base*0.3) src.mob.Absorb=src.mob.Base*0.3
/*				if(version<13)
					for(var/Skill/Weapon/Bound_Weapon/BE in src.mob) del(BE)
					for(var/Milestone/I_Studied_The_Blade/SS in src.mob)
						src.mob.MilestonePoints+=8
						src.mob.HasStudiedBlade=0
						src.mob<<"[SS] refunded."
						del(SS) */
				if(version<15)
					for(var/Skill/Buff/SuperPerfectForm/SPF in src.mob) del(SPF)

				if(version<16)
					if(src.mob.HasAdamantineSkeleton)
						src.mob.MaxHealth=100
						if(src.mob.HasResolveOfTheMountain) src.mob.MaxHealth+=20
						if(src.mob.Race=="Changeling") src.mob.MaxHealth+=10
						for(var/BodyPart/L in src.mob) L.MaxHealth+=25



/*
				if(version<3)
					if(src.mob.Int_Level>TechCap+src.mob.Int_Mod)
						src.mob.Int_Level=1
						src.mob.Int_Next=1000
						src.mob.medreward=TechCap+src.mob.Int_Mod
					if(src.mob.Magic_Level>TechCap+src.mob.Magic_Potential)
						src.mob.Magic_Level=1
						src.mob.Magic_Next=1000
						src.mob.medrewardmagic=TechCap+src.mob.Magic_Potential
					if(src.mob.HasEmbraceTheFuture) src.mob.MilestonePoints++

				if(version<4)
					for(var/Skill/Melee/ConsecutiveNormalPunches/CNP in src.mob)
						src.mob.contents+= new/Skill/Unarmed/T4/ConsecutiveNormalPunches
						del(CNP)
					for(var/Skill/Melee/WolfFangFist/CNP in src.mob)
						src.mob.contents+= new/Skill/Unarmed/T4/WolfFangFist
						del(CNP)

					if(src.mob.SwordSkillAdd)
						src.mob.EXP+=src.mob.SwordSkillAdd
						src.mob.SwordSkillAdd=0

					if(src.mob.KiManipulationAdd)
						src.mob.EXP+=src.mob.KiManipulationAdd
						src.mob.KiManipulationAdd=0

					if(src.mob.UnarmedSkillAdd)
						src.mob.EXP+=src.mob.UnarmedSkillAdd
						src.mob.UnarmedSkillAdd=0

					if(src.mob.AthleticismAdd)
						src.mob.EXP+=src.mob.AthleticismAdd
						src.mob.AthleticismAdd=0
					for(var/Milestone/MP in src.mob)
						MP.Refundable=initial(MP.Refundable)
					if(src.mob.HasRangeOfMotion) src.mob.MilestonePoints+=2

				if(version<5)
					for(var/obj/A in src.mob) if(A.name==null||!A.name) A.name="Nullname"
					if(src.mob.Race=="Demon")src.mob.Asexual=0
					if(src.mob.Race=="Kaio")src.mob.Asexual=0


				if(version<6)
					src.mob.EXPSkillRefundAll()


				if(version<7)
					if(src.mob.HasCustomStance)
						src.mob.CustomStanceRef()
					if(src.mob.HasFireKeeper)
						src.mob.RefundFireKeep()
					if(src.mob.HasZanzokenMaster)
						src.mob.RefundZanzM()
					if(src.mob.HasSmolder) src.mob.MilestonePoints+=1
					if(src.mob.Race=="Human")
						src.mob.FBMMult=2.35
						src.mob.AscensionMult=1


				if(version<8) for(var/Skill/Support/NamekianFusion/NF in src.mob) del(NF)


				if(version<9)
					src.mob.RemoveExtraPassives()

				if(version<10)
					src.mob.RemoveExtraPassives2()

				if(version<11)
					src.mob.SSj2Mult=1.3*/


				if(version!=SAVEFILE_VERSION)
					src.mob.ResetMults()

				if(!src.mob.AgreedtoTerms)
					if(!src.mob.Confirm("I agree that I will follow the rules and conduct myself accordingly.")) del(src)
					else src.mob.AgreedtoTerms = 1

				if(Auto)
					src.mob.TRIGGER_AFK(1)

				if(src.mob.MacroType==1)
					src<<"Arrow Keys used for movement."
					winset(src, "mainwindow", "macro = macro")
				if(src.mob.MacroType==2)
					src<<"WASD used for movement."
					winset(src, "mainwindow", "macro = macro2")
				if(src.mob.MacroType==3)
					src<<"Arrow Keys AND WASD used for movement."
					winset(src, "mainwindow", "macro = macro3")
				winset(src,"mapwindow.map", "icon-size=[src.mob.icon_sizeSave]")
				winshow(src,"CharacterCreator",0)
				winset(src,"mapcc","is-default=false")
				winset(src,"mapwindow.map","is-default=true")
		BackupSaveChar(var/Special=0)
			if(src.mob.Savable)
				var/savefilefound=file("Data/Saves/[key]/[src.ckey]")
				fcopy(savefilefound,"Data/Saves/[key]/BackUp/[src.ckey]1")
				src.mob.lastSaveSlot++
				if(src.mob.lastSaveSlot>3)src.mob.lastSaveSlot=1
				if(Special)fcopy(savefilefound,"Data/Saves/[key]/BackUp/[src.ckey]Special")
		SaveChar()
			if(src.mob.Savable)
				var/savefile/F=new("Data/Saves/[key]/[src.ckey]")
				if(src.mob.z && !src.mob.Regenerating)
					src.mob.savedX = src.mob.x
					src.mob.savedY = src.mob.y
					src.mob.savedZ = src.mob.z
				if(src.mob.S && src.mob.S.z)
					src.mob.savedX = src.mob.S.x
					src.mob.savedY = src.mob.S.y
					src.mob.savedZ = src.mob.S.z
				F["mob"] << src.mob
				F["savefile_version"] << SAVEFILE_VERSION

mob/proc/BPMODFIX()
	alertAdmins("[src] had a null or 0 BPMod. It has been set to 1 to save the BPRanks, but requires investigation.")
	BPMod=1
mob/var/icon_sizeSave=32
mob/verb/SetMapIconSize(C as num)
	set hidden=1
	winset(src.client,"mapwindow.map", "icon-size=[C]")
	icon_sizeSave=C

mob/proc/FixMutations()
	Mutations=new/list()
	MutationNumber=0
	BPMod=GeneticBPMod
	BaseMaxAnger=GeneticMaxAnger
	KiMod=GeneticKiMod
	StrMod=GeneticStrMod
	EndMod=GeneticEndMod
	SpdMod=GeneticSpdMod
	OffMod=GeneticOffMod
	DefMod=GeneticDefMod
	BaseRegeneration=GeneticRegeneration
	BaseRecovery=GeneticRecovery
	FBMAchieved=0
	FBMAt=1000000
