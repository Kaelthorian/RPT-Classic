mob/proc/Cancel_Olympus() src.Olympus_Revert()
mob/var/Pantheon

Skill/Buff/Pantheon
	RequiresApproval = 0
	buffon="taps into the power of the gods!"
	buffoff="returns to using their mortal power."
	var
	//Zeus
		ZBP=1.3
		ZStr=1.4
		ZOff=1.4
	//Odin
		OBP=1.5
	//Horus
		HoBP=1.3
		HoSpd=1.5
		HoRegen=1.25
	//Nuada
		NBP=1.3
		NEnd=1.5
		NDef=1.4


	//Chernobog
		CBP=1.6
		CRecov=1.2
	//Akatosh
		AkBP=1.4
		AkEnd=1.2
		AkStr=1.3
	//Vulcan
		VBP=1.4
		VEnd=1.2
		VPow=1.3

	//Hanuman
		HBP=1.4
		HDef=1.2
		HOff=1.2
		HSpd=1.2
		HStr=1.2
		HEnd=1.2
	//Ravana
		RBP=1.5
		RSpd=1.2
		RStr=1.2
		ROff=1.2
		REnd=1.2
		RDef=1.2
		RRecov=1.3



	var/tmp/Clicks=0
	icon='Spartan2.dmi'

	layer=MOB_LAYER+1
	var/list/Panths=list("Zeus","Odin","Horus","Nuada")
	GetDescription()
		var/Returner="This ability has several different forms. Zeus: [ZStr]x Str, [ZBP]x BP and [ZOff]x Offense. Odin: [OBP]x BP. Horus: [HoSpd]x Speed, [HoBP]x BP and [HoRegen]x Regeneration. Nuada: [NBP]x BP, [NEnd]x End, [NDef]x Defense."
//		if(Panths.Find("Akatosh")) Returner="[Returner] Akatosh:[AkBP]x BP, [AkStr]x Str, [AkEnd]x Endurance."
//		if(Panths.Find("Vulcan")) Returner="[Returner] Vulcan: [VBP]x BP, [VPow]x Force, [VEnd]x Endurance."
		if(Panths.Find("Hanuman")) Returner="[Returner] Hanuman: [HBP]x BP, [HDef]x Defense,[HOff]x Offense, [HStr]x Strength, [HEnd]x Endurance,and [HSpd]x Speed."
		if(Panths.Find("Chernobog")) Returner="[Returner] Chernobog: [CBP]x BP, [CRecov]x Recov"
		if(Panths.Find("Ravana")) Returner="[Returner] Ravana: [RBP]x BP, [RSpd]x Spd, [RStr]x Str, [ROff]x Off, [REnd]x End, [RDef]x Defense, [RRecov]x Recovery."
		return Returner
	//	..()
	verb/Pantheon()
		set category="Skills"
		set src = usr.contents
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		if(usr.KOd) return
		if(Clicks)
			if(prob(1)) usr<<"You only need to click once, fool."
			return
		if(usr.Ki<usr.MaxKi*0.1)
			usr<<"You require atleast 10% energy to use Pantheon."
			return
		Clicks=1
		if(!Using)
			if(usr.BuffNumber>=usr.BuffLimit)
				usr.BuffOut("You are already using too many buffs.")
				return
			if((usr.Base/usr.BPMod)>Tier6Req) if(!Panths.Find("Ravana"))
				Panths.Add("Ravana")
				usr<<"You have unlocked the Ravana Pantheon"
				alertAdmins("[usr] has unlocked the Ravana Pantheon")
			if(usr.FBMAchieved)if(!Panths.Find("Chernobog"))
				Panths.Add("Chernobog")
				usr<<"You have unlocked the Chernobog Pantheon"
				alertAdmins("[usr] has unlocked the Chernobog Pantheon")
//			if(usr.Base/usr.BPMod>=Tier3Req&&usr.UnarmedSkill>1500)if(!Panths.Find("Akatosh"))
//				Panths.Add("Akatosh")
//				usr<<"You have unlocked the Akatosh Pantheon"
//				alertAdmins("[usr] has unlocked the Akatosh Pantheon")
//			if(usr.Base/usr.BPMod>=Tier3Req&&usr.KiManipulation>1500)if(!Panths.Find("Vulcan"))
//				Panths.Add("Vulcan")
//				usr<<"You have unlocked the Vulcan Pantheon"
//				alertAdmins("[usr] has unlocked the Vulcan Pantheon")
			if(usr.FBMAchieved) if(!Panths.Find("Hanuman"))
				Panths.Add("Hanuman")
				usr<<"You have unlocked the Hanuman Pantheon"
				alertAdmins("[usr] has unlocked the Hanuman Pantheon")
			var/Choice=input(usr,"Choose your form","Pantheon") in Panths
			if(usr.BuffNumber>=usr.BuffLimit)
				usr.BuffOut("You are already using too many buffs.")
				return
			switch(Choice)
				if("Zeus")
					usr.OffMult*=ZOff
					usr.BPMult*=ZBP
					usr.StrMult*=ZStr
					usr.Pantheon="Zeus"
				if("Odin")
					usr.BPMult*=OBP
					usr.Pantheon="Odin"
				if("Horus")
					usr.BPMult*=HoBP
					usr.SpdMult*=HoSpd
					usr.RegenMult*=HoRegen
					usr.Pantheon="Horus"
				if("Nuada")
					usr.BPMult*=NBP
					usr.DefMult*=NDef
					usr.EndMult*=NEnd
					usr.Pantheon="Nuada"
				if("Chernobog")
					usr.BPMult*=CBP
					usr.RecovMult*=CRecov
					usr.Pantheon="Chernobog"
				if("Hanuman")
					usr.BPMult*=HBP
					usr.DefMult*=HDef
					usr.OffMult*=HOff
					usr.SpdMult*=HSpd
					usr.EndMult*=HEnd
					usr.StrMult*=HStr
					usr.Pantheon="Hanuman"
				if("Akatosh")
					usr.BPMult*=AkBP
					usr.EndMult*=AkEnd
					usr.StrMult*=AkStr
					usr.Pantheon="Akatosh"
				if("Vulcan")
					usr.BPMult*=VBP
					usr.EndMult*=VEnd
					usr.PowMult*=VPow
					usr.Pantheon="Vulcan"
				if("Ravana")
					usr.BPMult*=RBP
					usr.SpdMult*=RSpd
					usr.StrMult*=RStr
					usr.OffMult*=ROff
					usr.EndMult*=REnd
					usr.DefMult*=RDef
					usr.PowMult*=RDef
					usr.RecovMult*=RRecov
					usr.Pantheon="Ravana"
			usr.BuffNumber++
			usr.Buffs+="Pantheon"
			usr.FirstTransWPRestore(usr)
			usr.overlays+=src
			LargeDust(usr)
			Using=1
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] begins using Pantheon.")
			/*if(Global_GodKi==1)
				view(usr)<<"You stop being able to sense [usr]'s ki."


							user.Buffs += buffname
			Using = 1
			user.BPMult*=src.BP
			user.StrMult*=src.Str
			user.EndMult*=src.End
			user.SpdMult*=src.Spd
			user.PowMult*=src.Pow
			user.OffMult*=src.Off
			user.DefMult*=src.Def
			user.RegenMult*=Regen
			user.RecovMult*=Recov
			user.AngerMult*=Anger
			user.energydraining+=energydrain
			user.healthdraining+=healthdrain


				usr.SSjGodKi+=max(0.5,usr.GodKi/3)*/
		else {usr.Cancel_Olympus()}
		spawn(15) Clicks=0

mob/proc/Olympus_Revert() for(var/Skill/Buff/Pantheon/A in src) if(A.Using) if(Pantheon)
	A.Using=0
	view(src)<<"[src] stops using Pantheon."
	switch(Pantheon)
		if("Zeus")
			StrMult/=A.ZStr
			BPMult/=A.ZBP
			OffMult/=A.ZOff
			Pantheon=null
		if("Nuada")
			DefMult/=A.NDef
			BPMult/=A.NBP
			EndMult/=A.NEnd
			Pantheon=null
		if("Akatosh")
			BPMult/=A.AkBP
			EndMult/=A.AkEnd
			StrMult/=A.AkStr
			Pantheon=null
		if("Vulcan")
			BPMult/=A.VBP
			EndMult/=A.VEnd
			PowMult/=A.VPow
			Pantheon=null
		if("Odin")
			BPMult/=A.OBP
			Pantheon=null
		if("Horus")
			BPMult/=A.HoBP
			SpdMult/=A.HoSpd
			RegenMult/=A.HoRegen
			Pantheon=null
		if("Chernobog")
			BPMult/=A.CBP
			RecovMult/=A.CRecov
			Pantheon=null
		if("Hanuman")
			BPMult/=A.HBP
			DefMult/=A.HDef
			SpdMult/=A.HSpd
			EndMult/=A.HEnd
			OffMult/=A.HOff
			StrMult/=A.HStr
			Pantheon=null
		if("Ravana")
			BPMult/=A.RBP
			SpdMult/=A.RSpd
			StrMult/=A.RStr
			OffMult/=A.ROff
			DefMult/=A.RDef
			PowMult/=A.RDef
			EndMult/=A.REnd
			RecovMult/=A.RRecov
			Pantheon="Ravana"
	BuffNumber--
	Buffs-="Pantheon"
	overlays -= A





