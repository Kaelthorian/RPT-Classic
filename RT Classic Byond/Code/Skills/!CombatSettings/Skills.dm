Skill
	layer=MOB_LAYER+1

mob/var/tmp/InSelectionTierSkill

proc/SkillTierSelector(Skill/R,var/Slot)

	usr.InSelectionTierSkill = 1

	if(Slot ==0)
		R.DMGT		= 0
		R.EDT		= 99999
		R.CDT		= 0
		R.KBT		= 0
		R.Tier	= 0

	if(Slot ==1)
		R.DMGT		= DMG_TIER_1
		R.EDT		= ED_TIER_1
		R.CDT		= CD_TIER_1
		R.KBT		= KB_TIER_1
		R.Tier	= 1

	if(Slot ==2)
		R.DMGT	= DMG_TIER_2
		R.EDT		= ED_TIER_2
		R.CDT		= CD_TIER_2
		R.KBT		= KB_TIER_2
		R.Tier	= 2

	if(Slot ==3)
		R.DMGT	= DMG_TIER_3
		R.EDT		= ED_TIER_3
		R.CDT		= CD_TIER_3
		R.KBT		= KB_TIER_3
		R.Tier	= 3

	if(Slot ==4)
		R.DMGT	= DMG_TIER_4
		R.EDT		= ED_TIER_4
		R.CDT		= CD_TIER_4
		R.KBT		= KB_TIER_4
		R.Tier	= 4

	usr.InSelectionTierSkill = 0

mob/var/TeachLimit=2
mob/var/TeachCD=0

Skill/Attacks/var
	Wave
	tmp/chargelvl=1
	tmp/charging
	tmp/streaming
	KiReq
	WaveMult
	ChargeRate
	MaxDistance
	MoveDelay
	Piercer
	Power=1 //Damage multiplier
	Explosive=0
	Shockwave=0
	Paralysis=0


Skill/Attacks
	luminosity = 1
//	Scatter=0 //A barrage effect
//	Fatal=1 //Certain attacks may not be capable of killing

Skill
	parent_type=/obj
	var
		Teach=0
		TeachYear=0
		WaitTime=2
		TeachCD=0
		RequiresApproval=0
		LastTeach=0
		list/HasApproval=new
		Tier=0
		RankKit=0
		Trait
		UB1
		UB2
	New()
		..()
		switch(Tier)
			if(1)
				WaitTime=0
				TeachCD=0
				RequiresApproval=0
			if(2)
				WaitTime=1
				TeachCD=1
				RequiresApproval=0
			if(3)
				WaitTime=5
				TeachCD=2
				RequiresApproval=0
			if(4)
				WaitTime=7
				TeachCD=4
				RequiresApproval=0
			if(5)
				WaitTime=10
				TeachCD=5
				RequiresApproval=1
		if(!TeachYear)TeachYear=Year+WaitTime


Skill/Buff
	Tier=0
	layer=MOB_LAYER+EFFECTS_LAYER
	var
		BP=1
		Str=1
		End=1
		Spd=1
		Pow=1
		Off=1
		Def=1
		Regen=1
		Recov=1
		Anger=1
		KiNeeded = 0
		energydrain = 0 // a multiplier for energy drain feature
		healthdrain = 0 // a multiplier for health drain feature
		buffslot=1
		buffname="Buff"
		buffon=""
		buffoff=""
		TimedBuff=0
		CritCan=0
		WeaponLevel=1
	New()
		..()
		buffname="[src]"

	proc
		use(mob/user,var/ExtraOver,var/KiBPEffect,var/DisableRegen,var/IgnoreLimb,var/Thorns,var/NeedsSword,var/SNJ,var/Shield,var/Ultra,var/BoundWeapon)
			/*if(istype(src,/Skill/Buff/Bound_Weapon))
				var/Skill/Buff/Bound_Weapon/BW=src
				BW.BWuse(user)
				return*/
			if(!ismob(user)) return
			if(!Using)
				if(buffslot && user.BuffNumber+buffslot > user.BuffLimit)
					user.BuffOut("You are already using too many buffs.")
					return
				buff(user,ExtraOver,KiBPEffect,DisableRegen,IgnoreLimb,Thorns,NeedsSword,SNJ,Shield,Ultra,BoundWeapon)
			else if(Using) debuff(user,ExtraOver,KiBPEffect,DisableRegen,IgnoreLimb,Thorns,NeedsSword,SNJ,Shield,Ultra,BoundWeapon)
		buff(mob/user,var/ExtraOver,var/KiBPEffect,var/DisableRegen,var/IgnoreLimb,var/Thorns,var/NeedsSword,var/SNJ,var/Shield,var/Ultra,var/BoundWeapon) if(!Using)
			if(!ismob(user)) return
			//if(user.RPMode) return
			if(user.KOd) return
			if(NeedsSword)
				if(!usr.WeaponCheck())
					user<<"A weapon is required for this skill."
					return
//			if(user.Ki < user.MaxKi * KiNeeded)
//				user.BuffOut("You need at least [KiNeeded*100]% energy to use [src].")
//				return
			if(buffslot) user.BuffNumber+=buffslot
			if(user.BP>1000) SmallDust(usr)
			else if(user.BP>10000) LargeDust(usr)
			if(user.BP>100000)BigShockwave(usr)
			hearers(10,usr)<<sound('PowerStabi.mp3',volume=20)

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
//			user.energydraining+=energydrain
			user.healthdraining+=healthdrain
			if(istype(src,/Skill/Buff/Mystic)) user.ismystic=1
			if(istype(src,/Skill/Buff/Sin_Force)) user.ismajin=1
			if(Ultra)user.Precognition+=Ultra
			if(Shield) user.Shielding=1
			if(SNJ) user.SNj=1
			if(Thorns) user.HasThornsOn+=Thorns
			if(IgnoreLimb) user.IgnoresBrokenLimbs+=IgnoreLimb
			if(DisableRegen) user.DisableRegen+=DisableRegen
			if(KiBPEffect) user.KiDoesNotAffectBP+=KiBPEffect

			if(BoundWeapon)
				user.SwordOn=1+CritCan
				user.HammerOn=1+CritCan
				user.BoundWeaponOn=WeaponLevel

			if(isicon(icon)) //user.overlays += src
				var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
				_overlay.pixel_x = pixel_x
				_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays += _overlay

			if(ExtraOver) //user.overlays+=ExtraOver
				var/image/_overlay = image(ExtraOver) // In order to get pixel offsets to stick to overlays we create an image
		//		_overlay.pixel_x = pixel_x
		//		_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays += _overlay
				user.ExtraOvers+= _overlay


			if(buffon) for(var/mob/player/M in view(usr)) M.BuffOut("[user] [buffon]")
			user.overlays-=user.HealthBar
			user.overlays-=user.EnergyBar
			if(istype(src,/Skill/Buff/Expand))
				if(usr.Race=="Namekian") animate(usr, transform = matrix()*1.5, time = 3)
				else animate(usr, transform = matrix()*1.3, time = 3)
			if(istype(src,/Skill/Buff/MakyoForm))animate(usr, transform = matrix()*2, time = 3)
			if(istype(src,/Skill/Buff/Giant_Mode))animate(usr, transform = matrix()*2, time = 3)
			if(TimedBuff) spawn(TimedBuff) if(Using) debuff(user,ExtraOver,KiBPEffect,DisableRegen,IgnoreLimb,Thorns,NeedsSword,SNJ,Shield,Ultra)
			user.overlays+=user.HealthBar
			user.overlays+=user.EnergyBar


		debuff(mob/user,var/ExtraOver,var/KiBPEffect,var/DisableRegen,var/IgnoreLimb,var/Thorns,var/NeedsSword,var/SNJ,var/Shield,var/Ultra,var/BoundWeapon) if(Using)
			if(!ismob(user)) return
			if(buffslot) user.BuffNumber-=buffslot
			user.Buffs -= buffname
			Using = 0
			user.BPMult/=src.BP
			user.StrMult/=src.Str
			user.EndMult/=src.End
			user.SpdMult/=src.Spd
			user.PowMult/=src.Pow
			user.OffMult/=src.Off
			user.DefMult/=src.Def
			user.RegenMult/=Regen
			user.RecovMult/=Recov
			user.AngerMult/=Anger
//			user.energydraining-=energydrain
			user.healthdraining-=healthdrain
			if(istype(src,/Skill/Buff/Mystic)) user.ismystic=0
			if(istype(src,/Skill/Buff/Sin_Force)) user.ismajin=0
			if(Ultra) user.Precognition-=Ultra
			if(Shield) user.Shielding=0
			if(SNJ) user.SNj=0
			if(Thorns) user.HasThornsOn=0
			if(IgnoreLimb) user.IgnoresBrokenLimbs-=IgnoreLimb
			if(DisableRegen) user.DisableRegen-=DisableRegen
			if(KiBPEffect) user.KiDoesNotAffectBP-=KiBPEffect

			if(BoundWeapon)
				user.SwordOn=0
				user.HammerOn=0
				user.BoundWeaponOn=0
			if(isicon(icon)) //user.overlays += src
				var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
				_overlay.pixel_x = pixel_x
				_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays -= _overlay

			if(ExtraOver) //user.overlays+=ExtraOver
				var/image/_overlay = image(ExtraOver) // In order to get pixel offsets to stick to overlays we create an image
			//	_overlay.pixel_x = pixel_x
			//	_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays -= _overlay
				user.ExtraOvers-= _overlay


	//		if(isicon(icon)) user.overlays -= src
	//		if(ExtraOver) user.overlays-=ExtraOver
			user.HairAdd()
			if(buffoff) for(var/mob/player/M in view(usr)) M.BuffOut("[user] [buffoff]")
			if(istype(src,/Skill/Buff/Expand)) animate(usr, transform = null, time = 3)
			if(istype(src,/Skill/Buff/MakyoForm)) animate(usr, transform = null, time = 3)
			if(istype(src,/Skill/Buff/Giant_Mode)) animate(usr, transform = null, time = 3)





/*
mob/proc/MajinRemove() if(MajinBy)
	for(var/obj/MajinAbsorbReleaser/Maj in MajinRemove) if(Majin_By==Maj.MajinKey)
		Majin_Revert()
		for(var/Skill/Buff/Sin_Force/MJ in src) del(MJ)
		src<<"The person who majinized you has perished and their power over you has faded away."

*/
mob/proc/AuraOverlays(donotapply)
	overlays.Remove(GodKiAura,/Icon_Obj/Cloak/SSG2,/Icon_Obj/Cloak/Bojack,/Icon_Obj/Cloak/SSJ1,/Icon_Obj/Cloak/SSJ2,/Icon_Obj/Cloak/SSJ2FP,/Icon_Obj/Cloak/LSSJ,/Icon_Obj/Cloak/SN,/Icon_Obj/Cloak/SSR,/Icon_Obj/Cloak/SSGSS,/Icon_Obj/Cloak/SSGFP,/Icon_Obj/Cloak/SSRFP,'Aura SSj3.dmi','Sparks LSSj.dmi','SNj Elec.dmi',\
	'Electric_Mystic.dmi','Mutant Aura.dmi','Void Aura.dmi','Rising Rocks.dmi','Elec PU 3.dmi',/Icon_Obj/Cloak/PowerCloak)
	underlays-=/Icon_Obj/Cloak/SSj4
	for(var/Skill/Buff/Power_Control/A in src)
		overlays-=A
		if(A.Powerup>0) if(!donotapply)
			//if(Race=="Void Spawn"|ContractPower) overlays+='Void Aura.dmi'
			//if(Race=="Namekian"&&FBMAchieved) overlays+=/Icon_Obj/Cloak/SN
			//else if(Race=="Heran") overlays+='Mutant Aura.dmi'
			if(GodKiActive&&!ssj)
				if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan") overlays+=/Icon_Obj/Cloak/SSG2
				else overlays+=GodKiAura
			else if(Bojack) overlays+=/Icon_Obj/Cloak/Bojack
			else if(!ssj) if(MaxKi>=0) overlays+=A
			else if(ssj&&Class=="Legendary")
				overlays+='Sparks LSSj.dmi'
				overlays+=/Icon_Obj/Cloak/LSSJ
			else if(ssj == 1) overlays+=/Icon_Obj/Cloak/SSJ1
			else if(ssj == 2&&SSj2Drain<280) overlays+=/Icon_Obj/Cloak/SSJ2
			else if(ssj == 2) overlays+=/Icon_Obj/Cloak/SSJ2FP
			else if(ssj == 3)
				overlays+=/Icon_Obj/Cloak/SSJ2
				overlays+=/Icon_Obj/Cloak/SSJ1
			else if(ssj == 4) underlays+=/Icon_Obj/Cloak/SSj4
			else if(ssj==5)
				if(SSGSSColor=="Rose"&&SSGSSDrain<=290) overlays+=/Icon_Obj/Cloak/SSR
				else if(SSGSSColor=="Rose") overlays+=/Icon_Obj/Cloak/SSRFP
				else if(ssj == 5&&SSGSSDrain<=290) overlays+=/Icon_Obj/Cloak/SSGSS
				else if(ssj == 5) overlays+=/Icon_Obj/Cloak/SSGFP
			if(ismystic) overlays+='Electric_Mystic.dmi'
			//if(BP> 1000000)
			if(BP> 25000) overlays+='Rising Rocks.dmi'
			if(BP> 250000) overlays+='Elec PU 3.dmi'
			if(BP> 2500000) overlays+=/Icon_Obj/Cloak/PowerCloak
			break

/*
				var/image/_overlay = image(ExtraOver) // In order to get pixel offsets to stick to overlays we create an image
				_overlay.pixel_x = pixel_x
				_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays += _overlay
*/
mob/proc/Get_Observe(mob/M, hear=1)
	if(M==src)
		//Observee=null
		for(var/mob/player/MM in Players) if(MM.Observer==usr.key) MM.Observer=null
		src.reset_view(null)//client.eye=src
	else
		if(hear)
			if(M) M.Observer=src.key
		src.reset_view(M)

obj/RankChatECPool
	verb/Rank_Chat(A as text)
		set src=usr.contents
		set category="Event Character"
		var/msg = copytext(sanitize(A), 1, MAX_MESSAGE_LEN)
		if(!msg)	return
		for(var/mob/player/B in Players)
			if(B.client.holder)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] EC Pool: [msg]"
			else
				for(var/obj/RankChat/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChat2/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChatECPool/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
	verb/Add_Player_Note(mob/M in oview(6))
		set category = "Event Character"
		M.mind.show_memory(usr)

obj/RankChat2
	verb/Rank_Chat(A as text)
		set src=usr.contents
		set category="Rank"
		var/msg = copytext(sanitize(A), 1, MAX_MESSAGE_LEN)
		if(!msg)	return
		for(var/mob/player/B in Players)
			if(B.client.holder)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
			else
				for(var/obj/RankChat/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChat2/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChatECPool/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
	verb/Add_Player_Note(mob/M in oview(12))
		set category = "Rank"
		M.mind.show_memory(usr)

	verb/Mark_As_Alignment(mob/M)
		set category="Rank"
		if(M.LastAlignmentAssign+1<=Year)
			var/Align=input("Mark [M] as being which alignment?") in list("Good","Evil","Neutral")
			view(M)<<"[M] has been marked as [Align]."
			if(M.LastAlignmentAssign+1> Year) return
			switch(Align)
				if("Evil") M.AlignmentNumber-=1
				if("Good") M.AlignmentNumber+=1
				if("Neutral") if(M.AlignmentNumber!=0) M.AlignmentNumber/=3
			M.AlignmentCalibrate()
			M.LastAlignmentAssign=Year
		//	AlignmentHook(usr,M,Align)
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align]")
			logAndAlertAdmins("([usr.Rank]) [key_name(usr)] marked [key_name(M)] to [Align].")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
		else usr<<"Their alignment is on cooldown."

obj/RankChat
	var/Acquired=0
	New()
		..()
		if(!Acquired) Acquired=Year

	verb/Add_Player_Note(mob/M in oview(6))
		set category = "Rank"
		M.mind.show_memory(usr)
	verb/Mark_As_Alignment(mob/M)
		set category="Rank"
		if(M.LastAlignmentAssign+1<=Year)
			var/Align=input("Mark [M] as being which alignment?") in list("Good","Evil","Neutral")
			view(M)<<"[M] has been marked as [Align]."
			if(M.LastAlignmentAssign+1> Year) return
			switch(Align)
				if("Evil") M.AlignmentNumber-=1
				if("Good") M.AlignmentNumber+=1
				if("Neutral") if(M.AlignmentNumber!=0) M.AlignmentNumber/=3
			M.AlignmentCalibrate()
			M.LastAlignmentAssign=Year
		//	AlignmentHook(usr,M,Align)
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align]")
			logAndAlertAdmins("([M.Rank]) [key_name(usr)] marked [key_name(M)] to [Align].")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
			M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
		else usr<<"Their alignment is on cooldown."



obj/ranged/Blast/proc/Zig_Zag(B,Z) while(src)
	var/A=dir
	var/C=B
	density=0
	while(C)
		step_rand(src)
		C-=1
	density=1
	dir=A
	sleep(Z)

Icon_Obj
	Bolted=1



atom/proc/CleanOverlay(var/image/A,var/Time=1)
	sleep(Time)
	overlays-=A
	overlays.Remove(A)

