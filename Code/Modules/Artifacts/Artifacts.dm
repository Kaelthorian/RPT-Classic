////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////Artifacts Variables and procs///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/obj/items/Artifact
	var
		BP
		Str
		End
		Spd
		Pow
		Off
		Def
		Regen
		Recov
		Anger
		KineticBarrier
		LastOwner
		ArtifactGrabCD
		ArtifactEXP = 0
		ArtifactMilestonePoints = 0
		ArtifactPower = 1
		ArtifactSkillList
		ArtifactInt = 0
		ArtifactMagic = 0
		ArtifactTax = 0
		ArtifactHP = 0
		ArtifactWP = 0
		ArtifactDeath = 0
		ArtifactFristDrop = 0
		ArtifactAge= 0
		ArtifactAnger= 0
		ArtifactRollAdd= 0
		ArtifactAndroidLevel= 0
		ArtifactAlignment= 0
		ArtifactBuild= 0
		ArtifactCooking= 0
		ArtifactMining= 0
		ArtifactSmith=0
		ArtifactFishing= 0
		ArtifactCyberArmLeft= 0
		ArtifactCyberLegLeft= 0
		ArtifactCyberArmRight= 0
		ArtifactCyberLegRight= 0
		ArtifactCyberEyes= 0
		ArtifactCyberTorso= 0
		ArtifactUnarmed= 0
		ArtifactSword= 0
		ArtifactEvasion= 0
		ArtifactGravity= 0
		ArtifactHTBC= 0
		ArtifactHiveMind= 0
		ArtifactIgnoreLimb= 0
		ArtifactImmortal= 0
		ArtifactInclineAge= 0
		ArtifactPrecognition= 0
		ArtifactTeachLimit	= 0
		ArtifactSkillLevel	= 0


mob/proc/ArtifactRemove()
	for(var/obj/items/Artifact/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		ArmorOn=0
		SwordOn=0
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		if(src.HasSwordsman) src.OffMult/=(A.Off+0.08)
		if(src.HasArmorMastery) src.EndMult/=(A.End+0.07)
		else
			src.EndMult/=A.End
			src.OffMult/=A.Off
		src.SpdMult/=A.Spd
//		if(src.HasArmorMastery) src.ResMult/=1.1
		view(20,src) << "[src]'s [A] falls off."
		break

mob/proc/ArtifactSkillRemove()							//Add anything that you want to remove when they drop the artifact here
	for(var/obj/items/Artifact/A in src)
		if(A.ArtifactFristDrop==0)
			A.ArtifactFristDrop++
			return
		usr.Int_Level			-=	A.ArtifactInt
		usr.Magic_Level			-=	A.ArtifactMagic
		usr.MaxHealth			-=	A.ArtifactHP
		usr.MaxWillpower		-=	A.ArtifactWP
		usr.HasDeathRegen		-=	A.ArtifactDeath
		usr.BaseMaxAnger		-=	A.ArtifactAnger
		usr.Age					-=	A.ArtifactAge
		usr.AndroidLevel		-=	A.ArtifactAndroidLevel
		usr.AlignmentNumber		-=	A.ArtifactAlignment
		usr.CanBuild			-=	A.ArtifactBuild
		usr.Cooking_Level		-=	A.ArtifactCooking
		usr.Mining_Level		-=	A.ArtifactMining
		usr.Smithing_Level		-=	A.ArtifactSmith
		usr.Fishing_Level		-=	A.ArtifactFishing
		usr.Cyber_Left_Arm		-=	A.ArtifactCyberArmLeft
		usr.Cyber_Left_Leg		-=	A.ArtifactCyberLegLeft
		usr.Cyber_Right_Arm		-=	A.ArtifactCyberArmRight
		usr.Cyber_Right_Leg		-=	A.ArtifactCyberLegRight
		usr.Cyber_Sight			-=	A.ArtifactCyberEyes
		usr.Cyber_Torso			-=	A.ArtifactCyberTorso
		usr.UnarmedSkillAdd		-=	A.ArtifactUnarmed
		usr.SwordSkillAdd		-=	A.ArtifactSword
		usr.AthleticismAdd		-=	A.ArtifactEvasion
		usr.GravMastered		-=	A.ArtifactGravity
		usr.HBTCPower			-=	A.ArtifactHTBC
		usr.HiveMind			-=	A.ArtifactHiveMind
		usr.IgnoresBrokenLimbs	-=	A.ArtifactIgnoreLimb
		usr.Immortal			-=	A.ArtifactImmortal
		usr.InclineAge			-=	A.ArtifactInclineAge
		usr.Precognition		-=	A.ArtifactPrecognition
		usr.TeachLimit			-=	A.ArtifactTeachLimit
		usr.IgnoreTaxes=0
		if(usr.Race=="Heran")
			usr.IgnoreTaxes=1
		usr.contents         	-= 	A.ArtifactSkillList


mob/proc/ArtifactSkillAdd()								//Remove anything that you want to add when they pick up the artifact here
	for(var/obj/items/Artifact/A in get_step(src,dir))
		usr.IgnoreTaxes			=	A.ArtifactTax
		usr.Int_Level			+=	A.ArtifactInt
		usr.Magic_Level			+=	A.ArtifactMagic
		usr.MaxHealth			+=	A.ArtifactHP
		usr.MaxWillpower		+=	A.ArtifactWP
		usr.HasDeathRegen		+=	A.ArtifactDeath
		usr.BaseMaxAnger		+=	A.ArtifactAnger
		usr.Age					+=	A.ArtifactAge
		usr.AndroidLevel		+=	A.ArtifactAndroidLevel
		usr.AlignmentNumber		+=	A.ArtifactAlignment
		usr.CanBuild			+=	A.ArtifactBuild
		usr.Cooking_Level		+=	A.ArtifactCooking
		usr.Mining_Level		+=	A.ArtifactMining
		usr.Smithing_Level		+=	A.ArtifactSmith
		usr.Fishing_Level		+=	A.ArtifactFishing
		usr.Cyber_Left_Arm		+=	A.ArtifactCyberArmLeft
		usr.Cyber_Left_Leg		+=	A.ArtifactCyberLegLeft
		usr.Cyber_Right_Arm		+=	A.ArtifactCyberArmRight
		usr.Cyber_Right_Leg		+=	A.ArtifactCyberLegRight
		usr.Cyber_Sight			+=	A.ArtifactCyberEyes
		usr.Cyber_Torso			+=	A.ArtifactCyberTorso
		usr.UnarmedSkillAdd		+=	A.ArtifactUnarmed
		usr.SwordSkillAdd		+=	A.ArtifactSword
		usr.Athleticism			+=	A.ArtifactEvasion
		usr.GravMastered		+=	A.ArtifactGravity
		usr.HBTCPower			+=	A.ArtifactHTBC
		usr.HiveMind			+=	A.ArtifactHiveMind
		usr.IgnoresBrokenLimbs	+=	A.ArtifactIgnoreLimb
		usr.Immortal			+=	A.ArtifactImmortal
		usr.InclineAge			+=	A.ArtifactInclineAge
		usr.Precognition		+=	A.ArtifactPrecognition
		usr.TeachLimit			+=	A.ArtifactTeachLimit

		usr.contents      		+=  A.ArtifactSkillList
		for(var/R in usr.contents)
			if(R==A.ArtifactSkillList)
				SkillTierSelector(R,A.ArtifactSkillLevel)


proc/SaveArtifact()
	var/foundobjects=0
	var/savedobjs = list()
	var/E = 1
	var/savefile/F=new("Data/ItemSaves/ItemSave[E].bdb")
	var/list/L=new
	for(var/obj/items/Artifact/A)
		A.savedX = A.x
		A.savedY = A.y
		A.savedZ = A.z
		A.Save_Loc = A.loc
		L += A
		savedobjs += A
	if(foundobjects % 1000 == 0)
		F["SavedItems"] << L
		E ++
		F=new("Data/ItemSaves/ItemSave[E].bdb")
		L=new

proc/SaveArtifact2()
	for(var/mob/player/M)									//For all the players in the server
		for(var/obj/items/Artifact/A in M)					//If there is an artifact inside of you
			if(A.x==0 && A.y==0 && A.z==0)					//And if there coords of them are 0 0 0 , aka is inside of someone (Or in the void)
				for(A in M)									//For that artifact inside the player
					M<<"<font color=red>ARTIFACT DROPPED AT [M.x];[M.y];[M.z]"
					M.ArtifactSkillRemove()					//Remove the extra skills the artifact gives.
					A.LastOwner=M.ckey						//Set the variable to the one who was hodling the artifact
					A.ArtifactGrabCD= Year+(Month*0.01)+1	//Set the CD year for it
					if(isobj(M.loc))						//If the obj is inside the player
						var/obj/O = M.loc					//Makes a new obj O on the user location
						A.loc=O.loc							//We make the old obj to have the same loc as the new obj
					else A.loc=M.loc						//The old obj location is the same as the player loc
					M.RemoveBuffs()							//Remove every single buff from Artifacts and all
					M.Reset_StatMultipliers()				//Reset stat multipliers
					A.SaveItem(A)



////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////Weapons//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/obj/items/Artifact/Weapon

	Off=1
	icon='Sword_Trunks.dmi'
	Click()
		if(src in usr)
			if(usr.Redoing_Stats) return
			for(var/obj/items/Artifact/A in usr) if(A!=src) if(A.suffix)
				usr<<"You already have a Artifact equipped."
				return
			if(!suffix)
				if(usr.SwordOn)
					usr<<"You are already wearing a sword."
					return
				if(usr.HammerOn)
					usr<<"You are already wearing a hammer."
					return
				if(usr.GlovesOn)
					usr<<"You are already wearing gauntlets."
					return
				usr.SwordOn=1+CanCrit
				if(usr.HasSwordsman) usr.OffMult*=(Off+0.08)
				else usr.OffMult*=Off
				suffix="*Equipped*"
				usr.Equip_Magic(src,"Add")
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer= src.layer
				usr.overlays+=_overlay
				for(var/mob/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
				return
			else
				if(!usr.SwordOn)
					usr<<"You are not currently wearing a sword."
					return
				suffix=null
				usr.SwordOn=0
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer= src.layer
				usr.overlays-=_overlay
				//usr.StrMult/=1.1
				if(usr.HasSwordsman) usr.OffMult/=(Off+0.08)
				else usr.OffMult/=Off
				usr.Equip_Magic(src,"Remove")
				for(var/Skill/Buff/Bushido/SF in usr) if(SF.Using) SF.use(usr)
				for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
				return




/obj/items/Artifact/Guantlet
	icon='Clothes_Gloves.dmi'
	BP=1
	Click()
		if(src in usr)
			if(usr.Redoing_Stats) return
			for(var/obj/items/Artifact/A in usr) if(A!=src) if(A.suffix)
				usr<<"You already have a Artifact equipped."
				return
			if(!suffix)
				if(usr.HammerOn)
					usr<<"You are already wearing a hammer."
					return
				if(usr.SwordOn)
					usr<<"You are already wearing a sword."
					return
				if(usr.GlovesOn)
					usr<<"You are already wearing gauntlets."
					return
				usr.GlovesOn=1+CanCrit
				//usr.StrMult*=1.2
				suffix="*Equipped*"
				usr.Equip_Magic(src,"Add")
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer= src.layer
				usr.overlays+=_overlay
				for(var/mob/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
				return
			else
				if(!usr.GlovesOn)
					usr<<"You are not currently wearing a sword."
					return
				suffix=null
				usr.GlovesOn=0
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer= src.layer
				usr.overlays-=_overlay
				//usr.StrMult/=1.2
				usr.Equip_Magic(src,"Remove")
				for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
				return

////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////Armor////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/obj/items/Artifact/Armor

	icon='Armor1.dmi'
	BP=1
	End=1
	Spd=1
	Click()
		if(src in usr)
			if(usr.Redoing_Stats) return
			for(var/obj/items/Artifact/A in usr) if(A!=src) if(A.suffix)
				usr<<"You already have a Artifact equipped."
				return
			for(var/obj/items/Power_Armor/A in usr)
				if(A.suffix)if(A!=src)
					usr<<"You already have armor equipped."
					return
			if(!suffix)
				if(usr.ArmorOn)
					usr<<"You are already wearing an armor."
					return
				if(usr.HelmetOn)if(!usr.HasHeavyArmorTraining)
					usr<<"You are already wearing a helmet."
					return
				suffix="*Equipped*"
				usr.ArmorOn=1+AvoidsCrits
				usr.Equip_Magic(src,"Add")
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer = src.layer
				usr.overlays+=_overlay
				if(usr.HasArmorMastery) usr.EndMult*=(End+0.07)
				else usr.EndMult*=End
				usr.SpdMult*=Spd
				for(var/mob/player/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
				return
			else
				if(!usr.ArmorOn)
					usr<<"You are not currently wearing an armor."
					return
				suffix=null
				usr.ArmorOn=0
				usr.Equip_Magic(src,"Remove")
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer = src.layer
				usr.overlays-=_overlay
				if(usr.HasArmorMastery) usr.EndMult/=(End+0.07)
				else usr.EndMult/=End
				usr.SpdMult/=Spd
				for(var/mob/player/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
				return





////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////Consumable///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/obj/items/Artifact/Consumable
	icon='enchantmenticons.dmi'
	icon_state="SilverCoin"
	desc="<br>Super cool artifact"
	verb
		Use()
			if(usr.KOd==0)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] takes a dose of [src].\n")
				view(usr)<<"[usr] use [src]."
				logAndAlertAdmins("[key_name(usr)] used a consumable artifact at [usr.x],[usr.y],[usr.z]")
				del(src)



////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////Object///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/obj/items/Artifact/Object
	icon='enchantmenticons.dmi'
	desc="<br>Super cool artifact"
	icon_state="RoR"

////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////Verbs////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
mob/Admin1/verb/Locate_Artifacts()
	set category="Event Admin"
	for(var/obj/items/Artifact/A in world)
		usr << "Artifact [A.name] at [A.x],[A.y],[A.z], [A.loc]."

mob/Admin1/verb/Artifact_Fix()
	set category="Event Admin"
	for(var/obj/items/Artifact/A in world)
		if(A.x==0 && A.y==0 && A.z==0)
			if(A.loc == null | A.loc == "")
				A.x=usr.x
				A.y=usr.y
				A.z=usr.z
		if(A.name==null | A.loc == "")
			A.name="No more Blank name"
		if(A.name=="")
			A.name="No more Blank name"
		if(A.name==" ")
			A.name="No more Blank name"
	for(var/obj/items/Magic_Ball/A in world)
		if(A.x==0 && A.y==0 && A.z==0)
			if(A.loc == null | A.loc == "")
				A.x=usr.x
				A.y=usr.y
				A.z=usr.z

mob/Admin1/verb/Artifact_Forge()
	set category="Event Admin"
	switch (input(usr ,"What you wish to forge?") in list("Weapon" , "Armor" , "Consumable" , "Object", "Guantlets" , "Cancel"))

		if ("Weapon")
			ForgeWeapon()
		if ("Armor")
			ForgeArmor()
		if ("Consumable")
			ForgeConsumable()
		if ("Object")
			ForgeObject()
		if ("Guantlets")
			ForgeGuantlets()
		else logAndAlertAdmins("[key_name(usr)] Made an Artifact at [usr.x],[usr.y],[usr.z]")
	logAndAlertAdmins("[key_name(usr)] Made an Artifact at [usr.x],[usr.y],[usr.z]")

proc/ForgeGuantlets()
	var/obj/items/Artifact/Guantlet/A = new(usr)
	//Basic info
	A.Builder 					=input("Name of the Builder") as text
	A.name						=input("Name of the Artifact") as text
	A.desc						=input("Description of the Artifact") as text
	A.Durability				=input("Durability of the item,this one is the variable that make items broke from use(set it to 1#INF for inf)")
	A.MaxDurability 			=A.Durability
	A.Health					=100000000000000000000000000000000000000
	A.MaxBPAdd					=input("MaxBPAdd , the extra BP it will use to attack someone") as num
	A.TotalEnchants= 33

	//Enchants
	QWE
	switch (input("What stats you want it to boost/nerf?") in list ("add_bp","add_energy","add_str","add_force","add_end","add_spd","add_off","add_def","add_recov","add_regen","Cancel"))
		if("add_bp")
			A.add_bp					=input("Battle Power (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_energy")
			A.add_energy				=input("Energy (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_str")
			A.add_str					=input("Strength (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_force")
			A.add_force					=input("Force (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_end")
			A.add_end					=input("Endurance (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_spd")
			A.add_spd					=input("Speed (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_off")
			A.add_off					=input("Offense (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_def")
			A.add_def					=input("Defense (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_recov")
			A.add_recov					=input("Recovery (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_regen")
			A.add_regen					=input("Regeneration (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE

	//Special traits
	ASD
	switch (input("What you want to change from the artifact?") in list ("AvoidsCrits","CanCrit","invisibility","ImmuneYear","Grabbable","Stealable","ArtifactEXP","ArtifactMilestonePoints"
	,"ArtifactPower","ArtifactTax","ArtifactInt","ArtifactMagic","ArtifactWP","ArtifactHP","ArtifactDeath","ArtifactAge","ArtifactRollAdd","ArtifactAndroidLevel","ArtifactAlignment"
	,"ArtifactBuild","ArtifactCooking","ArtifactMining","ArtifactSmith","ArtifactFishing","ArtifactCyberArmLeft","ArtifactCyberLegLeft","ArtifactCyberArmRight","ArtifactCyberLegRight"
	,"ArtifactCyberEyes","ArtifactCyberTorso","ArtifactUnarmed","ArtifactSword","ArtifactEvasion","ArtifactGravity","ArtifactHTBC","ArtifactHiveMind","ArtifactIgnoreLimb","ArtifactImmortal"
	,"ArtifactInclineAge","ArtifactPrecognition","ArtifactTeachLimit","Skills","Cancel"))
		if("AvoidsCrits")
			A.AvoidsCrits				=input("Can Avoid crits? 1=Yes 0=No") as num
			goto ASD
		if("CanCrit")
			A.CanCrit					=input("Can crit? 1=Yes 0=No") as num
			goto ASD
		if("invisibility")
			A.invisibility				=input("Want it to be invisible?(Only ppl who are invisible can see the item) 1=Yes 0=No") as num
			goto ASD
		if("ImmuneYear")
			A.ImmuneYear				=input("Immune Year") as num
			goto ASD
		if("Grabbable")
			A.Grabbable					=input("Want it to be grabbable? 1=Yes 0=No") as num
			goto ASD
		if("Stealable")
			A.Stealable					=input("Sould Bind? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactEXP")
			A.ArtifactEXP				=input("Extra EXP? Set how much EXP they get per month") as num
			goto ASD
		if("ArtifactMilestonePoints")
			A.ArtifactMilestonePoints	=input("Extra MP? Set how much MPs extra they get per year.") as num
			goto ASD
		if("ArtifactPower")
			A.ArtifactPower				=input("Artifact power? This is extra BP from just having the item on you , not equipped.(1.05 = to 5% extra BP)") as num
			goto ASD
		if("ArtifactTax")
			A.ArtifactTax				=input("Want to avoid taxes? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactInt")
			A.ArtifactInt				=input("Extra int levels") as num
			goto ASD
		if("ArtifactMagic")
			A.ArtifactMagic 			=input("Extra magic levels") as num
			goto ASD
		if("ArtifactWP")
			A.ArtifactWP				=input("Extra WP?") as num
			goto ASD
		if("ArtifactHP")
			A.ArtifactHP				=input("Extra HP?") as num
			goto ASD
		if("ArtifactDeath")
			A.ArtifactDeath				=input("Death regen charges?") as num
			goto ASD
		if("ArtifactAge")
			A.ArtifactAge				=input("Change the age of the user to what?") as num
			goto ASD
		if("ArtifactAnger")
			A.ArtifactAnger				=input("Change the Anger of the user to what?") as num
			goto ASD
		if("ArtifactRollAdd")
			A.ArtifactRollAdd			=input("Want to add extra flee roll?") as num
			goto ASD
		if("ArtifactAndroidLevel")
			A.ArtifactAndroidLevel		=input("Extra android levels?") as num
			goto ASD
		if("ArtifactAlignment")
			A.ArtifactAlignment			=input("Alignment change?") as num
			goto ASD
		if("ArtifactBuild")
			A.ArtifactBuild				=input("Can build with this?") as num
			goto ASD
		if("ArtifactCooking")
			A.ArtifactCooking			=input("Cooking levels?") as num
			goto ASD
		if("ArtifactMining")
			A.ArtifactMining			=input("Mining levels?") as num
			goto ASD
		if("ArtifactSmith")
			A.ArtifactSmith				=input("Smithing levels?") as num
			goto ASD
		if("ArtifactFishing")
			A.ArtifactFishing			=input("Fishing levels?") as num
			goto ASD
		if("ArtifactCyberArmLeft")
			A.ArtifactCyberArmLeft		=input("Cyber Left Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegLeft")
			A.ArtifactCyberLegLeft		=input("Cyber Left Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberArmRight")
			A.ArtifactCyberArmRight		=input("Cyber Right Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegRight")
			A.ArtifactCyberLegRight		=input("Cyber Right Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberEyes")
			A.ArtifactCyberEyes			=input("Cyber eyes? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberTorso")
			A.ArtifactCyberTorso		=input("Cyber Torso? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactUnarmed")
			A.ArtifactUnarmed			=input("Unarmed extra skill points?") as num
			goto ASD
		if("ArtifactSword")
			A.ArtifactSword				=input("Sword extra skill points?") as num
			goto ASD
		if("ArtifactEvasion")
			A.ArtifactEvasion			=input("Evasion extra skill points?") as num
			goto ASD
		if("ArtifactGravity")
			A.ArtifactGravity			=input("Extra gravity?") as num
			goto ASD
		if("ArtifactHTBC")
			A.ArtifactHTBC				=input("HTBC power that fade every month?") as num
			goto ASD
		if("ArtifactHiveMind")
			A.ArtifactHiveMind			=input("Hivemind channel , everyone in the same channel can hear(remember to give the skill Hive mind if you want to use this)") as num
			goto ASD
		if("ArtifactIgnoreLimb")
			A.ArtifactIgnoreLimb		=input("Ignore limb damage? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactImmortal")
			A.ArtifactImmortal			=input("Immortal , literally nothing and no one can kill him (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactInclineAge")
			A.ArtifactInclineAge		=input("Incline Age change") as num
			goto ASD
		if("ArtifactPrecognition")
			A.ArtifactPrecognition		=input("Want him to have precognition? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactTeachLimit")
			A.ArtifactTeachLimit		=input("Extra teching slots?") as num
			goto ASD
		if("Skills")
			switch (input("Want to add a skill to the Artifact?") in list ("Yes","No"))
				if("Yes")
					var/AS = input("What Skills you want this Artifact to have?") in typesof (/Skill)
					A.ArtifactSkillLevel = input("What tier you want the skill to be (1 to 4 only)?") as num
					if(A.ArtifactSkillLevel>4)
						A.ArtifactSkillLevel=4
					if(A.ArtifactSkillLevel<=0)
						A.ArtifactSkillLevel=1
					A.ArtifactSkillList += new AS
					goto ASD
				if("No")
					goto ASD


	switch (input("Want to change the icon?") in list ("Yes","No"))
		if("Yes")
			A.icon= input("Select an icon to use.","Change Icon") as null|icon

proc/ForgeWeapon()
	var/obj/items/Artifact/Weapon/A = new(usr)
	//Basic info
	A.Builder 					=input("Name of the Builder") as text
	A.name						=input("Name of the Artifact") as text
	A.desc						=input("Description of the Artifact") as text
	A.Durability				=input("Durability of the item,this one is the variable that make items broke from use(set it to 1#INF for inf)")
	A.MaxDurability 			=A.Durability
	A.Health					=100000000000000000000000000000000000000
	A.MaxBPAdd					=input("MaxBPAdd , the extra BP it will use to attack someone") as num
	A.TotalEnchants= 33

	//Enchants
	QWE
	switch (input("What stats you want it to boost/nerf?") in list ("add_bp","add_energy","add_str","add_force","add_end","add_spd","add_off","add_def","add_recov","add_regen","Cancel"))
		if("add_bp")
			A.add_bp					=input("Battle Power (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_energy")
			A.add_energy				=input("Energy (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_str")
			A.add_str					=input("Strength (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_force")
			A.add_force					=input("Force (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_end")
			A.add_end					=input("Endurance (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_spd")
			A.add_spd					=input("Speed (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_off")
			A.add_off					=input("Offense (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_def")
			A.add_def					=input("Defense (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_recov")
			A.add_recov					=input("Recovery (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_regen")
			A.add_regen					=input("Regeneration (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE

	//Special traits
	ASD
	switch (input("What you want to change from the artifact?") in list ("AvoidsCrits","CanCrit","invisibility","ImmuneYear","Grabbable","Stealable","ArtifactEXP","ArtifactMilestonePoints"
	,"ArtifactPower","ArtifactTax","ArtifactInt","ArtifactMagic","ArtifactWP","ArtifactHP","ArtifactDeath","ArtifactAge","ArtifactRollAdd","ArtifactAndroidLevel","ArtifactAlignment"
	,"ArtifactBuild","ArtifactCooking","ArtifactMining","ArtifactSmith","ArtifactFishing","ArtifactCyberArmLeft","ArtifactCyberLegLeft","ArtifactCyberArmRight","ArtifactCyberLegRight"
	,"ArtifactCyberEyes","ArtifactCyberTorso","ArtifactUnarmed","ArtifactSword","ArtifactEvasion","ArtifactGravity","ArtifactHTBC","ArtifactHiveMind","ArtifactIgnoreLimb","ArtifactImmortal"
	,"ArtifactInclineAge","ArtifactPrecognition","ArtifactTeachLimit","Skills","Cancel"))
		if("AvoidsCrits")
			A.AvoidsCrits				=input("Can Avoid crits? 1=Yes 0=No") as num
			goto ASD
		if("CanCrit")
			A.CanCrit					=input("Can crit? 1=Yes 0=No") as num
			goto ASD
		if("invisibility")
			A.invisibility				=input("Want it to be invisible?(Only ppl who are invisible can see the item) 1=Yes 0=No") as num
			goto ASD
		if("ImmuneYear")
			A.ImmuneYear				=input("Immune Year") as num
			goto ASD
		if("Grabbable")
			A.Grabbable					=input("Want it to be grabbable? 1=Yes 0=No") as num
			goto ASD
		if("Stealable")
			A.Stealable					=input("Sould Bind? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactEXP")
			A.ArtifactEXP				=input("Extra EXP? Set how much EXP they get per month") as num
			goto ASD
		if("ArtifactMilestonePoints")
			A.ArtifactMilestonePoints	=input("Extra MP? Set how much MPs extra they get per year.") as num
			goto ASD
		if("ArtifactPower")
			A.ArtifactPower				=input("Artifact power? This is extra BP from just having the item on you , not equipped.(1.05 = to 5% extra BP)") as num
			goto ASD
		if("ArtifactTax")
			A.ArtifactTax				=input("Want to avoid taxes? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactInt")
			A.ArtifactInt				=input("Extra int levels") as num
			goto ASD
		if("ArtifactMagic")
			A.ArtifactMagic 			=input("Extra magic levels") as num
			goto ASD
		if("ArtifactWP")
			A.ArtifactWP				=input("Extra WP?") as num
			goto ASD
		if("ArtifactHP")
			A.ArtifactHP				=input("Extra HP?") as num
			goto ASD
		if("ArtifactDeath")
			A.ArtifactDeath				=input("Death regen charges?") as num
			goto ASD
		if("ArtifactAge")
			A.ArtifactAge				=input("Change the age of the user to what?") as num
			goto ASD
		if("ArtifactAnger")
			A.ArtifactAnger				=input("Change the Anger of the user to what?") as num
			goto ASD
		if("ArtifactRollAdd")
			A.ArtifactRollAdd			=input("Want to add extra flee roll?") as num
			goto ASD
		if("ArtifactAndroidLevel")
			A.ArtifactAndroidLevel		=input("Extra android levels?") as num
			goto ASD
		if("ArtifactAlignment")
			A.ArtifactAlignment			=input("Alignment change?") as num
			goto ASD
		if("ArtifactBuild")
			A.ArtifactBuild				=input("Can build with this?") as num
			goto ASD
		if("ArtifactCooking")
			A.ArtifactCooking			=input("Cooking levels?") as num
			goto ASD
		if("ArtifactMining")
			A.ArtifactMining			=input("Mining levels?") as num
			goto ASD
		if("ArtifactSmith")
			A.ArtifactSmith				=input("Smithing levels?") as num
			goto ASD
		if("ArtifactFishing")
			A.ArtifactFishing			=input("Fishing levels?") as num
			goto ASD
		if("ArtifactCyberArmLeft")
			A.ArtifactCyberArmLeft		=input("Cyber Left Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegLeft")
			A.ArtifactCyberLegLeft		=input("Cyber Left Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberArmRight")
			A.ArtifactCyberArmRight		=input("Cyber Right Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegRight")
			A.ArtifactCyberLegRight		=input("Cyber Right Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberEyes")
			A.ArtifactCyberEyes			=input("Cyber eyes? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberTorso")
			A.ArtifactCyberTorso		=input("Cyber Torso? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactUnarmed")
			A.ArtifactUnarmed			=input("Unarmed extra skill points?") as num
			goto ASD
		if("ArtifactSword")
			A.ArtifactSword				=input("Sword extra skill points?") as num
			goto ASD
		if("ArtifactEvasion")
			A.ArtifactEvasion			=input("Evasion extra skill points?") as num
			goto ASD
		if("ArtifactGravity")
			A.ArtifactGravity			=input("Extra gravity?") as num
			goto ASD
		if("ArtifactHTBC")
			A.ArtifactHTBC				=input("HTBC power that fade every month?") as num
			goto ASD
		if("ArtifactHiveMind")
			A.ArtifactHiveMind			=input("Hivemind channel , everyone in the same channel can hear(remember to give the skill Hive mind if you want to use this)") as num
			goto ASD
		if("ArtifactIgnoreLimb")
			A.ArtifactIgnoreLimb		=input("Ignore limb damage? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactImmortal")
			A.ArtifactImmortal			=input("Immortal , literally nothing and no one can kill him (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactInclineAge")
			A.ArtifactInclineAge		=input("Incline Age change") as num
			goto ASD
		if("ArtifactPrecognition")
			A.ArtifactPrecognition		=input("Want him to have precognition? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactTeachLimit")
			A.ArtifactTeachLimit		=input("Extra teching slots?") as num
			goto ASD
		if("Skills")
			switch (input("Want to add a skill to the Artifact?") in list ("Yes","No"))
				if("Yes")
					var/AS = input("What Skills you want this Artifact to have?") in typesof (/Skill)
					A.ArtifactSkillLevel = input("What tier you want the skill to be (1 to 4 only)?") as num
					if(A.ArtifactSkillLevel>4)
						A.ArtifactSkillLevel=4
					if(A.ArtifactSkillLevel<=0)
						A.ArtifactSkillLevel=1
					A.ArtifactSkillList += new AS
					goto ASD
				if("No")
					goto ASD


	switch (input("Want to change the icon?") in list ("Yes","No"))
		if("Yes")
			A.icon= input("Select an icon to use.","Change Icon") as null|icon

proc/ForgeArmor()
	var/obj/items/Artifact/Armor/A = new(usr)
	//Basic info
	A.Builder 					=input("Name of the Builder") as text
	A.name						=input("Name of the Artifact") as text
	A.desc						=input("Description of the Artifact") as text
	A.Durability				=input("Durability of the item,this one is the variable that make items broke from use(set it to 1#INF for inf)")
	A.MaxDurability 			=A.Durability
	A.Health					=input("Health of the item,this one is the variable that make items broke from punching it(set it to 1#INF for inf)")
	A.MaxBPAdd					=input("MaxBPAdd , the extra BP it will use to attack someone") as num
	A.TotalEnchants= 33

	//Enchants
	QWE
	switch (input("What stats you want it to boost/nerf?") in list ("add_bp","add_energy","add_str","add_force","add_end","add_spd","add_off","add_def","add_recov","add_regen","Cancel"))
		if("add_bp")
			A.add_bp					=input("Battle Power (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_energy")
			A.add_energy				=input("Energy (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_str")
			A.add_str					=input("Strength (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_force")
			A.add_force					=input("Force (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_end")
			A.add_end					=input("Endurance (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_spd")
			A.add_spd					=input("Speed (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_off")
			A.add_off					=input("Offense (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_def")
			A.add_def					=input("Defense (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_recov")
			A.add_recov					=input("Recovery (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE
		if("add_regen")
			A.add_regen					=input("Regeneration (1= to 100% buff, 1 bp is a 2x bp buff,0.5 is a 1.5 bp buff , etc...)") as num
			goto QWE

	//Special traits
	ASD
	switch (input("What you want to change from the artifact?") in list ("AvoidsCrits","CanCrit","invisibility","ImmuneYear","Grabbable","Stealable","ArtifactEXP","ArtifactMilestonePoints"
	,"ArtifactPower","ArtifactTax","ArtifactInt","ArtifactMagic","ArtifactWP","ArtifactHP","ArtifactDeath","ArtifactAge","ArtifactRollAdd","ArtifactAndroidLevel","ArtifactAlignment"
	,"ArtifactBuild","ArtifactCooking","ArtifactMining","ArtifactSmith","ArtifactFishing","ArtifactCyberArmLeft","ArtifactCyberLegLeft","ArtifactCyberArmRight","ArtifactCyberLegRight"
	,"ArtifactCyberEyes","ArtifactCyberTorso","ArtifactUnarmed","ArtifactSword","ArtifactEvasion","ArtifactGravity","ArtifactHTBC","ArtifactHiveMind","ArtifactIgnoreLimb","ArtifactImmortal"
	,"ArtifactInclineAge","ArtifactPrecognition","ArtifactTeachLimit","Skills","Cancel"))
		if("AvoidsCrits")
			A.AvoidsCrits				=input("Can Avoid crits? 1=Yes 0=No") as num
			goto ASD
		if("CanCrit")
			A.CanCrit					=input("Can crit? 1=Yes 0=No") as num
			goto ASD
		if("invisibility")
			A.invisibility				=input("Want it to be invisible?(Only ppl who are invisible can see the item) 1=Yes 0=No") as num
			goto ASD
		if("ImmuneYear")
			A.ImmuneYear				=input("Immune Year") as num
			goto ASD
		if("Grabbable")
			A.Grabbable					=input("Want it to be grabbable? 1=Yes 0=No") as num
			goto ASD
		if("Stealable")
			A.Stealable					=input("Sould Bind? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactEXP")
			A.ArtifactEXP				=input("Extra EXP? Set how much EXP they get per month") as num
			goto ASD
		if("ArtifactMilestonePoints")
			A.ArtifactMilestonePoints	=input("Extra MP? Set how much MPs extra they get per year.") as num
			goto ASD
		if("ArtifactPower")
			A.ArtifactPower				=input("Artifact power? This is extra BP from just having the item on you , not equipped.(1.05 = to 5% extra BP)") as num
			goto ASD
		if("ArtifactTax")
			A.ArtifactTax				=input("Want to avoid taxes? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactInt")
			A.ArtifactInt				=input("Extra int levels") as num
			goto ASD
		if("ArtifactMagic")
			A.ArtifactMagic 			=input("Extra magic levels") as num
			goto ASD
		if("ArtifactWP")
			A.ArtifactWP				=input("Extra WP?") as num
			goto ASD
		if("ArtifactHP")
			A.ArtifactHP				=input("Extra HP?") as num
			goto ASD
		if("ArtifactDeath")
			A.ArtifactDeath				=input("Death regen charges?") as num
			goto ASD
		if("ArtifactAge")
			A.ArtifactAge				=input("Change the age of the user to what?") as num
			goto ASD
		if("ArtifactAnger")
			A.ArtifactAnger				=input("Change the Anger of the user to what?") as num
			goto ASD
		if("ArtifactRollAdd")
			A.ArtifactRollAdd			=input("Want to add extra flee roll?") as num
			goto ASD
		if("ArtifactAndroidLevel")
			A.ArtifactAndroidLevel		=input("Extra android levels?") as num
			goto ASD
		if("ArtifactAlignment")
			A.ArtifactAlignment			=input("Alignment change?") as num
			goto ASD
		if("ArtifactBuild")
			A.ArtifactBuild				=input("Can build with this?") as num
			goto ASD
		if("ArtifactCooking")
			A.ArtifactCooking			=input("Cooking levels?") as num
			goto ASD
		if("ArtifactMining")
			A.ArtifactMining			=input("Mining levels?") as num
			goto ASD
		if("ArtifactSmith")
			A.ArtifactSmith				=input("Smithing levels?") as num
			goto ASD
		if("ArtifactFishing")
			A.ArtifactFishing			=input("Fishing levels?") as num
			goto ASD
		if("ArtifactCyberArmLeft")
			A.ArtifactCyberArmLeft		=input("Cyber Left Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegLeft")
			A.ArtifactCyberLegLeft		=input("Cyber Left Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberArmRight")
			A.ArtifactCyberArmRight		=input("Cyber Right Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegRight")
			A.ArtifactCyberLegRight		=input("Cyber Right Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberEyes")
			A.ArtifactCyberEyes			=input("Cyber eyes? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberTorso")
			A.ArtifactCyberTorso		=input("Cyber Torso? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactUnarmed")
			A.ArtifactUnarmed			=input("Unarmed extra skill points?") as num
			goto ASD
		if("ArtifactSword")
			A.ArtifactSword				=input("Sword extra skill points?") as num
			goto ASD
		if("ArtifactEvasion")
			A.ArtifactEvasion			=input("Evasion extra skill points?") as num
			goto ASD
		if("ArtifactGravity")
			A.ArtifactGravity			=input("Extra gravity?") as num
			goto ASD
		if("ArtifactHTBC")
			A.ArtifactHTBC				=input("HTBC power that fade every month?") as num
			goto ASD
		if("ArtifactHiveMind")
			A.ArtifactHiveMind			=input("Hivemind channel , everyone in the same channel can hear(remember to give the skill Hive mind if you want to use this)") as num
			goto ASD
		if("ArtifactIgnoreLimb")
			A.ArtifactIgnoreLimb		=input("Ignore limb damage? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactImmortal")
			A.ArtifactImmortal			=input("Immortal , literally nothing and no one can kill him (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactInclineAge")
			A.ArtifactInclineAge		=input("Incline Age change") as num
			goto ASD
		if("ArtifactPrecognition")
			A.ArtifactPrecognition		=input("Want him to have precognition? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactTeachLimit")
			A.ArtifactTeachLimit		=input("Extra teching slots?") as num
			goto ASD
		if("Skills")
			switch (input("Want to add a skill to the Artifact?") in list ("Yes","No"))
				if("Yes")
					var/AS = input("What Skills you want this Artifact to have?") in typesof (/Skill)
					A.ArtifactSkillLevel = input("What tier you want the skill to be (1 to 4 only)?") as num
					if(A.ArtifactSkillLevel>4)
						A.ArtifactSkillLevel=4
					if(A.ArtifactSkillLevel<=0)
						A.ArtifactSkillLevel=1
					A.ArtifactSkillList += new AS
					goto ASD
				if("No")
					goto ASD

	//Icon
	switch (input("Want to change the icon?") in list ("Yes","No"))
		if("Yes")
			A.icon= input("Select an icon to use.","Change Icon") as null|icon

proc/ForgeObject()
	var/obj/items/Artifact/Object/A = new(usr)
	//Basic info
	A.Builder 					=input("Name of the Builder") as text
	A.name						=input("Name of the Artifact") as text
	A.desc						=input("Description of the Artifact") as text
	A.Durability				=input("Durability of the item,this one is the variable that make items broke from use(set it to 1#INF for inf)")
	A.MaxDurability 			=A.Durability
	A.Health					=input("Health of the item,this one is the variable that make items broke from punching it(set it to 1#INF for inf)")
	A.TotalEnchants= 33

	//Special traits
	ASD
	switch (input("What you want to change from the artifact?") in list ("AvoidsCrits","CanCrit","invisibility","ImmuneYear","Grabbable","Stealable","ArtifactEXP","ArtifactMilestonePoints"
	,"ArtifactPower","ArtifactTax","ArtifactInt","ArtifactMagic","ArtifactWP","ArtifactHP","ArtifactDeath","ArtifactAge","ArtifactRollAdd","ArtifactAndroidLevel","ArtifactAlignment"
	,"ArtifactBuild","ArtifactCooking","ArtifactMining","ArtifactSmith","ArtifactFishing","ArtifactCyberArmLeft","ArtifactCyberLegLeft","ArtifactCyberArmRight","ArtifactCyberLegRight"
	,"ArtifactCyberEyes","ArtifactCyberTorso","ArtifactUnarmed","ArtifactSword","ArtifactEvasion","ArtifactGravity","ArtifactHTBC","ArtifactHiveMind","ArtifactIgnoreLimb","ArtifactImmortal"
	,"ArtifactInclineAge","ArtifactPrecognition","ArtifactTeachLimit","Skills","Cancel"))
		if("AvoidsCrits")
			A.AvoidsCrits				=input("Can Avoid crits? 1=Yes 0=No") as num
			goto ASD
		if("CanCrit")
			A.CanCrit					=input("Can crit? 1=Yes 0=No") as num
			goto ASD
		if("invisibility")
			A.invisibility				=input("Want it to be invisible?(Only ppl who are invisible can see the item) 1=Yes 0=No") as num
			goto ASD
		if("ImmuneYear")
			A.ImmuneYear				=input("Immune Year") as num
			goto ASD
		if("Grabbable")
			A.Grabbable					=input("Want it to be grabbable? 1=Yes 0=No") as num
			goto ASD
		if("Stealable")
			A.Stealable					=input("Sould Bind? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactEXP")
			A.ArtifactEXP				=input("Extra EXP? Set how much EXP they get per month") as num
			goto ASD
		if("ArtifactMilestonePoints")
			A.ArtifactMilestonePoints	=input("Extra MP? Set how much MPs extra they get per year.") as num
			goto ASD
		if("ArtifactPower")
			A.ArtifactPower				=input("Artifact power? This is extra BP from just having the item on you , not equipped.(1.05 = to 5% extra BP)") as num
			goto ASD
		if("ArtifactTax")
			A.ArtifactTax				=input("Want to avoid taxes? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactInt")
			A.ArtifactInt				=input("Extra int levels") as num
			goto ASD
		if("ArtifactMagic")
			A.ArtifactMagic 			=input("Extra magic levels") as num
			goto ASD
		if("ArtifactWP")
			A.ArtifactWP				=input("Extra WP?") as num
			goto ASD
		if("ArtifactHP")
			A.ArtifactHP				=input("Extra HP?") as num
			goto ASD
		if("ArtifactDeath")
			A.ArtifactDeath				=input("Death regen charges?") as num
			goto ASD
		if("ArtifactAge")
			A.ArtifactAge				=input("Change the age of the user to what?") as num
			goto ASD
		if("ArtifactAnger")
			A.ArtifactAnger				=input("Change the Anger of the user to what?") as num
			goto ASD
		if("ArtifactRollAdd")
			A.ArtifactRollAdd			=input("Want to add extra flee roll?") as num
			goto ASD
		if("ArtifactAndroidLevel")
			A.ArtifactAndroidLevel		=input("Extra android levels?") as num
			goto ASD
		if("ArtifactAlignment")
			A.ArtifactAlignment			=input("Alignment change?") as num
			goto ASD
		if("ArtifactBuild")
			A.ArtifactBuild				=input("Can build with this?") as num
			goto ASD
		if("ArtifactCooking")
			A.ArtifactCooking			=input("Cooking levels?") as num
			goto ASD
		if("ArtifactMining")
			A.ArtifactMining			=input("Mining levels?") as num
			goto ASD
		if("ArtifactSmith")
			A.ArtifactSmith				=input("Smithing levels?") as num
			goto ASD
		if("ArtifactFishing")
			A.ArtifactFishing			=input("Fishing levels?") as num
			goto ASD
		if("ArtifactCyberArmLeft")
			A.ArtifactCyberArmLeft		=input("Cyber Left Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegLeft")
			A.ArtifactCyberLegLeft		=input("Cyber Left Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberArmRight")
			A.ArtifactCyberArmRight		=input("Cyber Right Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegRight")
			A.ArtifactCyberLegRight		=input("Cyber Right Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberEyes")
			A.ArtifactCyberEyes			=input("Cyber eyes? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberTorso")
			A.ArtifactCyberTorso		=input("Cyber Torso? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactUnarmed")
			A.ArtifactUnarmed			=input("Unarmed extra skill points?") as num
			goto ASD
		if("ArtifactSword")
			A.ArtifactSword				=input("Sword extra skill points?") as num
			goto ASD
		if("ArtifactEvasion")
			A.ArtifactEvasion			=input("Evasion extra skill points?") as num
			goto ASD
		if("ArtifactGravity")
			A.ArtifactGravity			=input("Extra gravity?") as num
			goto ASD
		if("ArtifactHTBC")
			A.ArtifactHTBC				=input("HTBC power that fade every month?") as num
			goto ASD
		if("ArtifactHiveMind")
			A.ArtifactHiveMind			=input("Hivemind channel , everyone in the same channel can hear(remember to give the skill Hive mind if you want to use this)") as num
			goto ASD
		if("ArtifactIgnoreLimb")
			A.ArtifactIgnoreLimb		=input("Ignore limb damage? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactImmortal")
			A.ArtifactImmortal			=input("Immortal , literally nothing and no one can kill him (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactInclineAge")
			A.ArtifactInclineAge		=input("Incline Age change") as num
			goto ASD
		if("ArtifactPrecognition")
			A.ArtifactPrecognition		=input("Want him to have precognition? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactTeachLimit")
			A.ArtifactTeachLimit		=input("Extra teching slots?") as num
			goto ASD
		if("Skills")
			switch (input("Want to add a skill to the Artifact?") in list ("Yes","No"))
				if("Yes")
					var/AS = input("What Skills you want this Artifact to have?") in typesof (/Skill)
					A.ArtifactSkillLevel = input("What tier you want the skill to be (1 to 4 only)?") as num
					if(A.ArtifactSkillLevel>4)
						A.ArtifactSkillLevel=4
					if(A.ArtifactSkillLevel<=0)
						A.ArtifactSkillLevel=1
					A.ArtifactSkillList += new AS
					goto ASD
				if("No")
					goto ASD
	//Icon
	switch (input("Want to change the icon?") in list ("Yes","No"))
		if("Yes")
			A.icon= input("Select an icon to use.","Change Icon") as null|icon

proc/ForgeConsumable()
	var/obj/items/Artifact/Consumable/A = new(usr)
	//Basic info
	A.Builder 					=input("Name of the Builder") as text
	A.name						=input("Name of the Artifact") as text
	A.desc						=input("Description of the Artifact") as text
	A.Durability				=input("Durability of the item,this one is the variable that make items broke from use(set it to 1#INF for inf)")
	A.MaxDurability 			=A.Durability
	A.Health					=input("Health of the item,this one is the variable that make items broke from punching it(set it to 1#INF for inf)")
	A.TotalEnchants= 33

	//Special traits
	ASD
	switch (input("What you want to change from the artifact?") in list ("AvoidsCrits","CanCrit","invisibility","ImmuneYear","Grabbable","Stealable","ArtifactEXP","ArtifactMilestonePoints"
	,"ArtifactPower","ArtifactTax","ArtifactInt","ArtifactMagic","ArtifactWP","ArtifactHP","ArtifactDeath","ArtifactAge","ArtifactRollAdd","ArtifactAndroidLevel","ArtifactAlignment"
	,"ArtifactBuild","ArtifactCooking","ArtifactMining","ArtifactSmith","ArtifactFishing","ArtifactCyberArmLeft","ArtifactCyberLegLeft","ArtifactCyberArmRight","ArtifactCyberLegRight"
	,"ArtifactCyberEyes","ArtifactCyberTorso","ArtifactUnarmed","ArtifactSword","ArtifactEvasion","ArtifactGravity","ArtifactHTBC","ArtifactHiveMind","ArtifactIgnoreLimb","ArtifactImmortal"
	,"ArtifactInclineAge","ArtifactPrecognition","ArtifactTeachLimit","Skills","Cancel"))
		if("AvoidsCrits")
			A.AvoidsCrits				=input("Can Avoid crits? 1=Yes 0=No") as num
			goto ASD
		if("CanCrit")
			A.CanCrit					=input("Can crit? 1=Yes 0=No") as num
			goto ASD
		if("invisibility")
			A.invisibility				=input("Want it to be invisible?(Only ppl who are invisible can see the item) 1=Yes 0=No") as num
			goto ASD
		if("ImmuneYear")
			A.ImmuneYear				=input("Immune Year") as num
			goto ASD
		if("Grabbable")
			A.Grabbable					=input("Want it to be grabbable? 1=Yes 0=No") as num
			goto ASD
		if("Stealable")
			A.Stealable					=input("Sould Bind? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactEXP")
			A.ArtifactEXP				=input("Extra EXP? Set how much EXP they get per month") as num
			goto ASD
		if("ArtifactMilestonePoints")
			A.ArtifactMilestonePoints	=input("Extra MP? Set how much MPs extra they get per year.") as num
			goto ASD
		if("ArtifactPower")
			A.ArtifactPower				=input("Artifact power? This is extra BP from just having the item on you , not equipped.(1.05 = to 5% extra BP)") as num
			goto ASD
		if("ArtifactTax")
			A.ArtifactTax				=input("Want to avoid taxes? 1=Yes 0=No") as num
			goto ASD
		if("ArtifactInt")
			A.ArtifactInt				=input("Extra int levels") as num
			goto ASD
		if("ArtifactMagic")
			A.ArtifactMagic 			=input("Extra magic levels") as num
			goto ASD
		if("ArtifactWP")
			A.ArtifactWP				=input("Extra WP?") as num
			goto ASD
		if("ArtifactHP")
			A.ArtifactHP				=input("Extra HP?") as num
			goto ASD
		if("ArtifactDeath")
			A.ArtifactDeath				=input("Death regen charges?") as num
			goto ASD
		if("ArtifactAge")
			A.ArtifactAge				=input("Change the age of the user to what?") as num
			goto ASD
		if("ArtifactAnger")
			A.ArtifactAnger				=input("Change the Anger of the user to what?") as num
			goto ASD
		if("ArtifactRollAdd")
			A.ArtifactRollAdd			=input("Want to add extra flee roll?") as num
			goto ASD
		if("ArtifactAndroidLevel")
			A.ArtifactAndroidLevel		=input("Extra android levels?") as num
			goto ASD
		if("ArtifactAlignment")
			A.ArtifactAlignment			=input("Alignment change?") as num
			goto ASD
		if("ArtifactBuild")
			A.ArtifactBuild				=input("Can build with this?") as num
			goto ASD
		if("ArtifactCooking")
			A.ArtifactCooking			=input("Cooking levels?") as num
			goto ASD
		if("ArtifactMining")
			A.ArtifactMining			=input("Mining levels?") as num
			goto ASD
		if("ArtifactSmith")
			A.ArtifactSmith				=input("Smithing levels?") as num
			goto ASD
		if("ArtifactFishing")
			A.ArtifactFishing			=input("Fishing levels?") as num
			goto ASD
		if("ArtifactCyberArmLeft")
			A.ArtifactCyberArmLeft		=input("Cyber Left Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegLeft")
			A.ArtifactCyberLegLeft		=input("Cyber Left Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberArmRight")
			A.ArtifactCyberArmRight		=input("Cyber Right Arm? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberLegRight")
			A.ArtifactCyberLegRight		=input("Cyber Right Leg? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberEyes")
			A.ArtifactCyberEyes			=input("Cyber eyes? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactCyberTorso")
			A.ArtifactCyberTorso		=input("Cyber Torso? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactUnarmed")
			A.ArtifactUnarmed			=input("Unarmed extra skill points?") as num
			goto ASD
		if("ArtifactSword")
			A.ArtifactSword				=input("Sword extra skill points?") as num
			goto ASD
		if("ArtifactEvasion")
			A.ArtifactEvasion			=input("Evasion extra skill points?") as num
			goto ASD
		if("ArtifactGravity")
			A.ArtifactGravity			=input("Extra gravity?") as num
			goto ASD
		if("ArtifactHTBC")
			A.ArtifactHTBC				=input("HTBC power that fade every month?") as num
			goto ASD
		if("ArtifactHiveMind")
			A.ArtifactHiveMind			=input("Hivemind channel , everyone in the same channel can hear(remember to give the skill Hive mind if you want to use this)") as num
			goto ASD
		if("ArtifactIgnoreLimb")
			A.ArtifactIgnoreLimb		=input("Ignore limb damage? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactImmortal")
			A.ArtifactImmortal			=input("Immortal , literally nothing and no one can kill him (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactInclineAge")
			A.ArtifactInclineAge		=input("Incline Age change") as num
			goto ASD
		if("ArtifactPrecognition")
			A.ArtifactPrecognition		=input("Want him to have precognition? (1=Yes 0=No)") as num
			goto ASD
		if("ArtifactTeachLimit")
			A.ArtifactTeachLimit		=input("Extra teching slots?") as num
			goto ASD
		if("Skills")
			switch (input("Want to add a skill to the Artifact?") in list ("Yes","No"))
				if("Yes")
					var/AS = input("What Skills you want this Artifact to have?") in typesof (/Skill)
					A.ArtifactSkillLevel = input("What tier you want the skill to be (1 to 4 only)?") as num
					if(A.ArtifactSkillLevel>4)
						A.ArtifactSkillLevel=4
					if(A.ArtifactSkillLevel<=0)
						A.ArtifactSkillLevel=1
					A.ArtifactSkillList += new AS
					goto ASD
				if("No")
					goto ASD
	//Icon
	switch (input("Want to change the icon?") in list ("Yes","No"))
		if("Yes")
			A.icon= input("Select an icon to use.","Change Icon") as null|icon


/*
/obj/items/Topic(href, href_list)
	..()

	if(href_list["ArtifactTeachLimit"])
		usr<<"Working."
		src<<"Working."
	if(href_list["ResourcesPay"])
		usr<<"Your rank is not high enough for this action."
		return


mob/Admin1/verb
	Sans_Forge_Window()
		ForgeSans()

proc/ForgeSans(obj/items/Artifact)
	var/ForgeTest={"
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
  background-color:black;
  color: #449999;
  font-size:12
  font-family: "Lato", sans-serif;
}
.sidebar {
  height: 100%;
  width: 160px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  padding-top: 16px;
}

.sidebar a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 20px;
  color: #818181;
  display: block;
}

.sidebar a:hover {
  color: #f1f1f1;
}

.main {
  margin-left: 160px; /* Same as the width of the sidenav */
  padding: 0px 10px;
}

@media screen and (max-height: 450px) {
  .sidebar {padding-top: 15px;}
  .sidebar a {font-size: 18px;}
}
</style>
</head>
<body>

<div class="sidebar">

</div>
<div class="main">
<center><h2>Artifact Forge</h2></center>


<A HREF='?src=\ref[src];ArtifactTeachLimit=\ref[src]'>ArtifactTeachLimit</A>
<A HREF='?src=\ref[usr];ArtifactTeachLimit=\ref[usr]'>ArtifactTeachLimit</A>
<A HREF='?src=\ref[usr];ArtifactTeachLimit=\ref[src]'>ArtifactTeachLimit</A>
<A HREF='?src=\ref[src];ResourcesPay=\ref[src]'>Resources Pay</A>

</div>
</body>
</html>



	"}


	usr<<browse(ForgeTest,"window='Artifact Forge';size=500x500")
*/




////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////Artifacts skills/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
Skill/Spell/Demon_Gate

	desc="This will let you open the gates of hell for a short period of time to let them lurk in the living realm."
	verb/Demon_Gate()
		set category="Other"
		var/Cost = 0
		var/GateCD= 0
		var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
		usr << "Base cost for this spell is [Commas(Cost)] mana per level. Your magic potential means it costs [Commas(Actual)] mana per level for you."
		if(GateCD==Year)
			usr <<"You can't open the gates until year [GateCD]"
			return
		for(var/obj/Mana/M in usr) if(M.Value > Actual) if(usr.Confirm("Attempt to summon a demon for [Actual] mana?"))
			M.Value -= Actual
			view(src)<<"[usr] Opens the gates of hell to let a demon lurk in the living realm!"
			var/obj/Baby/A=new
			A.Race="Demon Contract"
			A.loc=usr.loc
			A.icon='fx.dmi'
			A.icon_state="chaos gate"
			A.name="Demonic Contract ([usr])"
			usr.AlignmentNumber-=1
			usr.AlignmentCalibrate()
			if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Demon Contract",null) as text
			hearers(10,usr) << sound(pick('imhere1.ogg','behindyou1.ogg','behindyou2.ogg','farnoise.ogg','growl1.ogg','growl2.ogg','growl3.ogg','iseeyou1.ogg','iseeyou2.ogg','lookup1.ogg','lookup2.ogg','overhere1.ogg','overhere2.ogg','overhere3.ogg','turnaround1.ogg','turnaround2.ogg','veryfarnoise.ogg','overhere3.ogg'),volume=20)
			usr << "Something else went through as you attempt to summon the demon..."
			for(var/mob/player/m)
				if(m.Race=="Kaio" || m.Race=="Demon" || m.Race=="Oni" || m.Race=="Demigod")
					usr << sound(pick('imhere1.ogg','behindyou1.ogg','behindyou2.ogg','farnoise.ogg','growl1.ogg','growl2.ogg','growl3.ogg','iseeyou1.ogg','iseeyou2.ogg','lookup1.ogg','lookup2.ogg','overhere1.ogg','overhere2.ogg','overhere3.ogg','turnaround1.ogg','turnaround2.ogg','veryfarnoise.ogg','overhere3.ogg'),volume=20)
					usr <<"<span class=\"narrate\">Your mind snaps for a second as a demonic energy cross the realm veil...</span>"
					return
			GateCD = Year++

Skill/Technology/Angelical_Doors

	desc="This will let you use the trumpets of heaven to call for help from heaven."
	verb/Angelical_Doors()
		set category="Other"
		var/Cost = 0
		var/GateCD= 0
		var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
		usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
		if(GateCD==Year)
			usr <<"You can't open the doors until year [GateCD]"
			return
		for(var/obj/Resources/M in usr) if(M.Value > Actual) if(usr.Confirm("Attempt to create an artificial angel for [Actual] resources?"))
			M.Value -= Actual
			view(src)<<"[usr] Use the trumpets of heaven to call for aid!"
			var/obj/Baby/A=new
			A.Race="Artificial Angel"
			A.loc=usr.loc
			A.icon='fx.dmi'
			A.icon_state="astral gate"
			A.name="Artificial Angel ([usr])"
			if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Artificial Angel",null) as text
			GateCD = Year++

obj/items/Artifact/verb
	Inspect_Artifact()
		set src in view(10)
		var/Forge={"
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
  background-color:black;
  color: #449999;
  font-size:12
  font-family: "Lato", sans-serif;
}
</style>
</head>
<body>
</div>
<div class="main">
<center><h2>[name]</h2></center>
<center><h2>Builder: [Builder]</h2></center>
[desc]
</div>
</body>
</html>



	"}


		usr<<browse(Forge,"window='Artifact Forge';size=500x500")