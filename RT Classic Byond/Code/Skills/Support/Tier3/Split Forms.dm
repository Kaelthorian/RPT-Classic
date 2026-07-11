mob/Splitform
	var/function
	New()
		spawn Splitty()

	/*Bump(atom/Z)
		MeleeAttack()*/
	proc/Splitty() while(src)
		if(Health<=0)
			view(src)<<"[src] has been defeated."
			del(src)
		sleep(10)
	Click(c)
		var/choice = c
		var/list/Choices=new
		if(usr.RPMode) return
		Choices.Add("Follow","Stop","Attack Target","Attack Nearest","Destroy Splitforms","Toggle Follow Mouse Clicks","Cancel")
		if(choice in Choices)
			if(choice == "Attack Nearest") return
			if(usr) DoChoice(choice)
		else
			if(lastKnownKey==usr.key)
				choice = input("Choose Option") in Choices
				if(choice=="Toggle Follow Mouse Clicks")
					usr.SplitFollowsMouse=!usr.SplitFollowsMouse
					usr<<"SplitFollowsMouse is now [usr.SplitFollowsMouse]."
					if(function==2) function=0
					return
				if(usr) DoChoice(choice)

	proc/DoChoice(var/_choice,var/clickT)
		var/c = _choice
		switch(c)
			if("Attack Nearest")
				walk(src,0)
				function=1
			if("Destroy Splitforms")
				for(var/mob/Splitform/A) if(A.lastKnownKey == usr.key) del(A)
			if("Follow")
				function=0
				attacking=1
				walk(src,0)
				walk_towards(src,usr)
			if("Stop")
				function=0
				walk(src,0)
			if("Attack Target")
				walk(src,0)
				function=0
				var/mob/list/Targets=new
				for(var/mob/M in oview(12,src)) Targets.Add(M)
				Targets.Add("Cancel")
				var/mob/Choice=input("Attack who?") in Targets
				if(Choice!="Cancel")
					sleep(10)
					function=1
//					while(src&&function)
//						if(src.Allow_Move(get_dir(src,Choice))) step_towards(src,Choice)
//						sleep(2)
			if("Click Target")
				walk(src,0)
				function=0
				/*attacking=0*/
				function=2
//				if(src.Allow_Move(get_dir(src,clickT))) walk_towards(src,clickT,3)

mob/var/SplitFollowsMouse=0
Skill/Support/Splitform

	DMGT			= DMG_TIER_2
	CDT				= CD_TIER_2
	EDT				= ED_TIER_2
	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	UB1="Shadow King"
	UB2="Arcane Power"

	desc="This will materialize a copy of yourself, made of energy. It has much the same power as you, \
	and makes a good sparring partner or assistant in battle. You can command their actions by clicking \
	on them"

	verb/Split_Form() if(usr.KOd==0)
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<0.5)
			usr<<"You do not have the energy"
			return
		var/Amount=0
		for(var/mob/Splitform/Z) if(Z.lastKnownKey==usr.key) Amount++
		if(Amount<5)
			view(6,usr) << "[usr] creates a copy of themselves."
			usr.Ki=(usr.Ki-EDT)
			var/mob/Splitform/A=new
			for(var/obj/items/Boxing_Gloves/G in usr)
				if(G.suffix)
					var/obj/items/Boxing_Gloves/X = new
					X.loc = A
					X.suffix = "*Equipped*"
					break
			A.lastKnownKey=usr.key
			A.Race=usr.Race
			A.appearance=usr.appearance
			A.overlays-=usr.EnergyBar
			A.overlays-=usr.HealthBar
			A.Zanzoken=usr.Zanzoken
			A.UnarmedSkill=usr.UnarmedSkill
			A.Athleticism=usr.Athleticism
			A.MaxKi=usr.BaseMaxKi
			A.KiMod=usr.KiMod
			A.Str=usr.StrMod
			A.Spd=usr.SpdMod
			A.End=usr.EndMod
			A.Off=usr.OffMod
			A.Def=usr.DefMod
			A.BP=usr.BP
			A.MaxHealth=20
			A.Health=20
			A.BPMod=usr.BPMod
			A.StrMod=usr.StrMod
			A.SpdMod=usr.SpdMod
			A.EndMod=usr.EndMod
			A.OffMod=usr.OffMod
			A.DefMod=usr.DefMod
			A.GravMastered=usr.GravMastered
			if(usr.GodKiActive) A.GodKi=usr.GodKi
			A.loc = usr.loc
			A.dir=usr.dir
			var/copies=0
			for(var/mob/Splitform/B) if(B.lastKnownKey==usr.key) copies++
			//A.layer=MOB_LAYER+10
			A.name="[usr.name] Copy [copies]"
			hearers(10,usr)<<sound('pop.wav',volume=20)
			A.screen_loc="1,[copies+2]:0"
			usr.client.screen.Add(A)
		else usr<<"You do not have the skill to create this many splitforms."

	verb/Split_Stop()
		for(var/mob/Splitform/A) if(A.lastKnownKey == usr.key)
			A.function=0
			walk(A,0)
	verb/Split_Nearest()
		for(var/mob/Splitform/A) if(A.lastKnownKey == usr.key)
			walk(A,0)
			A.function=1
//			while(A&&A.function)
//				for(var/mob/AA in oview(12,A))
//					if(A.Allow_Move(get_dir(A,AA)))
//						step_towards(A,AA)
//						break
//				sleep(2)

	verb/Split_Destroy()
		for(var/mob/Splitform/A) if(A.lastKnownKey == usr.key)del(A)

	verb/Split_Target()
		for(var/mob/Splitform/A) if(A.lastKnownKey == usr.key)
			walk(A,0)
			A.function=0
			var/mob/list/Targets=new
			for(var/mob/M in oview(12,A)) Targets.Add(M)
			Targets.Add("Cancel")
			var/mob/Choice=input("Attack who?") in Targets
			if(Choice!="Cancel")
				sleep(10)
				A.function=1
//				while(A&&A.function)
//					if(A.Allow_Move(get_dir(A,Choice))) step_towards(A,Choice)
//					sleep(2)

	verb/Split_Click()
		for(var/mob/Splitform/A) if(A.lastKnownKey == usr.key)
			walk(A,0)
			A.function=0
			A.function=2



