//CDs
proc/Modifier(mob/M)

	var/Modifier=((M.Refire*100)/10)

	return Modifier

mob/proc/getAttackXY()if(!AttackXY)
	filters += filter(type = "blur", size = 1)
	spawn(2) filters -= filter(type = "blur", size = 1)
	AttackXY=1
	switch(dir)
		if(EAST)
			pixel_x+=8
		if(NORTHEAST)
			pixel_x+=4
			pixel_y+=4
		if(SOUTHEAST)
			pixel_x+=4
			pixel_y-=4
		if(WEST)
			pixel_x-=8
		if(NORTHWEST)
			pixel_x-=4
			pixel_y+=4
		if(SOUTHWEST)
			pixel_x-=4
			pixel_y-=4
		if(NORTH)
			pixel_y+=8
		if(SOUTH)
			pixel_y-=8
	spawn(2)
		pixel_x=adjustedX
		pixel_y=adjustedY
		spawn() AttackXY=0

Skill/proc/CDTick(mob/M)
	set waitfor=0
	var/div=10
	if(M.HasCooldownMastery)div=6.66
	M.setCooldown("[src]",CD*div)
//	world<<"Working [CD*div] // [src]"

mob/proc/CD_Tick()
	set waitfor=0
	if(!src.RPMode)
		if(BurningShotOn)
			BurningShotOn--
			if(BurningShotOn<=0)BurningShotBuffRemove()
	if(BurningDesireCD>0) BurningDesireCD--//1500 minutes
	if(RefuseToDieCD>0) RefuseToDieCD--//150 minutes
	if(SecondWindCD>0) SecondWindCD--//15 minutes
	if(LBCD>0) LBCD--
	if(TargetWarpCD>0)TargetWarpCD--
	//CDUpdate()
mob/proc/GetCleave(direction,times=0)
	switch(direction)
		if(1.0)
			if(!times)return 9
			if(times==1)return 5
			return 1
			return "North"
		if(2.0)
			if(!times)return 6
			if(times==1)return 10
			return 2
			return "South"
		if(4.0)
			if(!times)return 5
			if(times==1)return 6
			return 4
			return "East"
		if(8.0)
			if(!times)return 10
			if(times==1)return 9
			return 8
			return "West"
		if(5.0)
			if(!times)return 1
			if(times==1)return 4
			return 5
			return "NorthEast"
		if(6.0)
			if(!times)return 4
			if(times==1)return 2
			return 6
			return "SouthEast"
		if(9.0)
			if(!times)return 8
			if(times==1)return 1
			return 9
			return "NorthWest"
		if(10.0)
			if(!times)return 2
			if(times==1)return 8
			return 10
			return "SouthWest"


mob/proc/Comboz(var/mob/M,var/forced)
	if(M==1)return
	if(M)
		mark1
		var/turf/W=locate(M.x+rand(-1,1),M.y+rand(-1,1),usr.z)
		if(W)
			if(istype(W,/turf/Special/Blank))
				goto mark1
			if(!W.density)
				for(var/atom/x in W) if(x.density) goto mark1
				src.AfterImage()
				src.loc=W
				src.dir=get_dir(src,M)
				M.dir=get_dir(M,src)

mob/proc/AerialRecovery() if(AerialRecovery)
	var/ProbMult=1
	if(KBStr) ProbMult=BP/KBStr
	if(prob(50*ProbMult))
		KB=0
		AerialRecovery=0
		for(var/mob/player/P in view(src)) P.BuffOut("[src] has endured the hit!")
		spawn(rand(400,600))
			src<<"You feel you can resist another knockback."
			AerialRecovery=1

turf
	proc
		Explosion(var/mob/M)
			for(var/turf/A in range(6,src))
				ExplosionEffect(A)
				spawn(1)
					for(var/mob/B in A)
						if(B.icon_state == "Flight") if(prob(50))
							view(20,B) << "[B] is sucked to the ground by the force of the explosion!"
							B.Flight_Land()
						if(!B.Flying)
							B.TakeDamage(src, 30*(M.Pow/B.End)*(M.BP/B.BP), "Explosion")
							//B.Health-=30*(M.Pow/B.Res)*(M.BP/B.BP)
							if(B.Health<=0)
								if(B.client) spawn B.KO("[M]")
								else spawn B.Death("[M]")
					for(var/obj/B in A)
						B.TakeDamage(src, M.Pow*5, "Explosion")
						//B.Health-=M.Pow*5
						if(B.Health<=0)
							if(prob(50)) Crater(B)
							del(B)
					if(!A.density)
						A.Health=0
						if(M!=0) A.Destroy(M,M.key)
						else A.Destroy("Unknown","Unknown")
					else
						A.TakeDamage(src, M.Pow*5, "Explosion")
						//A.Health -= M.Pow*5
						if(M!=0) A.Destroy(M,M.key)
						else A.Destroy("Unknown","Unknown")
mob
	proc
		Equip_Magic(var/obj/items/I,var/State,var/Ver)
			if(I) if(istype(I,/obj/items))
				var/N = 1
				if(I.magical) if(State == "Add")
					src << "This item empowers your stats."
					src.overlays -= 'tk.dmi'
					src.overlays += 'tk.dmi'
					src.Remove_Effects()
				if(I.add_bp)
					N = N + I.add_bp
					if(State == "Add")
						src.BPMult *= N
					if(State == "Remove")
						src.BPMult /= N
					if(!Ver)
						N = 1
				if(I.add_energy)
					N = N + I.add_energy
					if(State == "Add")
						src.KiMult *= N
					if(State == "Remove")
						src.KiMult /= N
						if(src.Ki > src.MaxKi)
							src.Ki = src.MaxKi
					if(!Ver)
						N = 1
				if(I.add_str)
					N = N + I.add_str
					if(State == "Add")
						src.StrMult *= N
					if(State == "Remove")
						src.StrMult /= N
					if(!Ver)
						N = 1
				if(I.add_end)
					N = N + I.add_end
					if(State == "Add")
						src.EndMult *= N
					if(State == "Remove")
						src.EndMult /= N
					if(!Ver)
						N = 1
				if(I.add_spd)
					N = N + I.add_spd
					if(State == "Add")
						src.SpdMult *= N
					if(State == "Remove")
						src.SpdMult /= N
					if(!Ver)
						N = 1
				if(I.add_force)
					N = N + I.add_force
					if(State == "Add")
						src.PowMult *= N
					if(State == "Remove")
						src.PowMult /= N
					if(!Ver)
						N = 1
				if(I.add_off)
					N = N + I.add_off
					if(State == "Add")
						src.OffMult *= N
					if(State == "Remove")
						src.OffMult /= N
					if(!Ver)
						N = 1
				if(I.add_def)
					N = N + I.add_def
					if(State == "Add")
						src.DefMult *= N
					if(State == "Remove")
						src.DefMult /= N
					if(!Ver)
						N = 1
				if(I.add_regen)
					N = N + I.add_regen
					if(State == "Add")
						src.RegenMult *= N
					if(State == "Remove")
						src.RegenMult /= N
					if(!Ver)
						N = 1
				if(I.add_recov)
					N = N + I.add_recov
					if(State == "Add")
						src.RecovMult *= N
					if(State == "Remove")
						src.RecovMult /= N
					if(!Ver)
						N = 1
		Display_Magic(var/obj/items/I)
			if(I) if(istype(I,/obj/items))
				var/returner
				if(I.add_bp)returner="[returner] <br>Power increase of [I.add_bp*100]%"
				if(I.add_energy)returner="[returner] <br>Energy increase of [I.add_energy*100]%"
				if(I.add_str)returner="[returner] <br>Strength increase of [I.add_str*100]%"
				if(I.add_end)returner="[returner] <br>Durability increase of [I.add_end*100]%"
				if(I.add_spd)returner="[returner] <br>Speed increase of [I.add_spd*100]%"
				if(I.add_force)returner="[returner] <br>Force increase of [I.add_force*100]%"
				if(I.add_off)returner="[returner] <br>Offense increase of [I.add_off*100]%."
				if(I.add_def)returner="[returner] <br>Defense increase of [I.add_def*100]%"
				if(I.add_regen)returner="[returner] <br>Regeneration increase of [I.add_regen*100]%"
				if(I.add_recov)returner="[returner] <br>Recovery increase of [I.add_recov*100]%"
				return returner

atom
	MouseDrag(var/obj/Over_Object,var/turf/Turf_Start,var/obj/Over_Loc)
		var/Actual = 3
		var/can_use = 0
		var/using = null
		var/Logit = 0
		for(var/X in NoMove)
			if(src.type == X)
				return
		if(usr.attacking!=1)
			for(var/obj/Telekinesis_Magic in usr)
				if(usr.TK_Magic)
					Actual = 25
					Actual = round(initial(Actual)/usr.Magic_Potential)
					for(var/obj/Mana/X in usr)
						if(X.Value >= Actual)
							can_use = 1
							using = "mana"
							X.Value -= Actual
							if(ismob(src))
								var/mob/M = src
								if(usr.TK_Last != "[M.real_name] ([M.key])")
									usr.TK_Last = "[M.real_name] ([M.key])"
									Logit = 1
							else
								if(usr.TK_Last != "[src]")
									usr.TK_Last = "[src]"
									Logit = 1
			for(var/obj/Telekinesis in usr)
				if(usr.TK) if(can_use == 0)
					if(usr.Ki >= Actual)
						can_use = 1
						using = "energy"
						usr.Ki -= Actual
						if(ismob(src))
							var/mob/M = src
							if(usr.TK_Last != "[M.real_name] ([M.key])")
								usr.TK_Last = "[M.real_name] ([M.key])"
								Logit = 1
						else
							if(usr.TK_Last != "[src]")
								usr.TK_Last = "[src]"
								Logit = 1
			if(src in range(20,usr)) if(can_use) if(usr.KOd==0) if(usr.afk == 0)
				if(ismob(src))
					var/mob/M = src
					var/moves = 25
					if(M.afk == 0) if(!usr.invisibility)
						if(using == "mana")
							moves += usr.Magic_Level
							moves -= M.Magic_Level
						if(using == "energy")
							moves += usr.MaxKi / 100
							moves -= M.MaxKi / 100
						if(prob(moves))
							if(using == "mana")
								M.overlays -= 'fx dispel.dmi'
								M.overlays += 'fx dispel.dmi'
								usr.overlays -= 'fx dispel.dmi'
								usr.overlays += 'fx dispel.dmi'
							if(using == "energy")
								M.overlays -= 'tk.dmi'
								M.overlays += 'tk.dmi'
								usr.overlays -='tk.dmi'
								usr.overlays += 'tk.dmi'
							usr.Remove_Effects()
							spawn(10)
								if(M)
									M.overlays -= 'tk.dmi'
									M.overlays -= 'fx dispel.dmi'
							if(M in view(1,Over_Loc))
								for(var/atom/A in Over_Loc)
									if(A.density)
										return
								M.Move(Over_Loc)
								Stagger(M,1)
								if(Logit) usr.saveToLog("| [key_name(usr)] moves [src] with their [using] based Telekinesis..\n")
				if(isobj(src)&&!istype(src,/obj/ranged/))
					var/obj/O = src
					if(!O.Bolted) if(Over_Loc)
						if(using == "energy")
							usr.overlays -= 'tk.dmi'
							usr.overlays += 'tk.dmi'
							O.overlays -= 'tk.dmi'
							O.overlays += 'tk.dmi'
						if(using == "mana")
							usr.overlays -= 'fx dispel.dmi'
							usr.overlays += 'fx dispel.dmi'
							O.overlays -= 'fx dispel.dmi'
							O.overlays += 'fx dispel.dmi'
						usr.Remove_Effects()
						spawn(10)
							if(O)
								O.overlays -= 'tk.dmi'
								O.overlays -= 'fx dispel.dmi'
						if(!usr.invisibility)
							if(istype(O,/obj/Props/))
								var/obj/Props/P = src
								P.Slinger = "[usr]"
								P.Slinger_Key = "[key_name(usr)]"
							if(using == "mana")
								O.Projectile_Speed = usr.Magic_Level
							if(using == "energy")
								O.Projectile_Speed = usr.MaxKi / 100
						if(O in view(1,Over_Loc))
							for(var/atom/A in Over_Loc)
								if(A.density)
									O.Bump(A)
									return
							O.Move(Over_Loc)
							if(Logit)usr.saveToLog("| [key_name(usr)] moves [src] with their [using] based Telekinesis..\n")

			if(using == "mana") if(can_use == 0)
				usr << "Not enough mana!"
			if(using == "energy") if(can_use == 0)
				usr << "Not enough energy!"
mob
	proc
		Remove_Effects()
			spawn(10)
				if(src)
					src.overlays -= 'fx dispel.dmi'
					src.overlays -= 'tk.dmi'


proc/Shockwave(mob/Origin,Range=7,Icon='Shockwave.dmi')
	for(var/turf/T in range(Range,Origin)) missile(Icon,Origin,T)

mob/proc/Screen_Shake(Amount=10,Offset=8) if(client)
	while(Amount)
		Amount-=1
		client.pixel_x=rand(-Offset,Offset)
		client.pixel_y=rand(-Offset,Offset)
		sleep(1)

mob/proc/KnockBack(mob/P)
	set waitfor=0
	if(Frozen) return
	if(Training) return
	if(Study) return
	if(Meditate) return
	var/Old_State=""
	var/OldDir=dir
	var/turf/X=P
	KBStr=0
	if(ismob(P))
		KBStr=P.BP
		X=P.loc
	if(!KBStr||KBStr==0)KBStr=100
//	if(istype(src,/mob/NPC)) Old_State=icon_state
	if(KB>20) KB=20
	if(!KB) return
	if(prob(KB*3)) if(Flying) Flight_Land()
	if(src.KOd==1) Old_State="KO"
	if(src.Flying) Old_State="Fly"
	var/crater=0
	if(LethalCombatTracker&&prob(30)) crater=1
	if(KB>4) crater=1
	if(KB>9) crater=2
	//DustCloudOrigin(P) Already removed Mumit, don't touch this
	if(prob(50)) ShockwaveScale(src,KBStr,1)
	if(prob(20)) crater=0
	if(locate(/Icon_Obj/Effects/KBHole1) in loc) crater=0
	if(locate(/Icon_Obj/Effects/KBHole2) in loc) crater=0
	if(crater==1) KBHole1(src,get_dir(X,src),SE=1)
	if(crater==2) KBHole2(src,get_dir(X,src),SE=1)
	while(src&&src.KB>0)
		if(!src) break // Sanity check
		if(KBResist) if(prob(KBResist*5+(HasSturdyBuild*5)))
			src.CombatOut("You resist some knockback.")
			src<<"You resist some knockback."
			src.KB-=KBResist
	//	if(prob(10*KB)) DustCloud(src)
		animate(src, icon_state="KB", time = 3)//src.icon_state="KB"
		src.Knockback()
		if(LethalCombatTracker) if(prob(30))
			if(Race=="Android"||AndroidLevel&&prob(50)) OilTrail(src)
			else BloodTrail(src)
		if(prob(30)) Quake_Effect(3)
		OldDir=dir
		if(src&&X) step_away(src,X,20)
		dir=OldDir
		if(crater==1) KBHole1(src,get_dir(X,src))
		if(crater==2) KBHole2(src,get_dir(X,src))
		src.KB--
		sleep(1)
		if(src) animate(src, icon_state=Old_State)
		if(!KB) break
	if(src) animate(src, icon_state=Old_State)
	if(KOd) icon_state="KO"
	KB=0
	KBStr=0
	if(crater==1) KBHole1(src,get_dir(X,src),SE=2)
	if(crater==2) KBHole2(src,get_dir(X,src),SE=2)
	if(crater==2&&prob(60)) Crater(src)

mob/proc/Knockback(damage as num)
	ASSERT(src)


	if(usr.Study)
		usr.Study=0
		usr<<"You stop studing."
		icon_state=""
	if(usr.Training)
		usr.Training=0
		usr<<"You stop training."
		icon_state=""
	if(usr.Meditate)
		usr.Meditate=0
		usr<<"You stop meditating."
		icon_state=""

	for(var/obj/Props/A in view(1,src)) if(A.z) //if(A.type!=/obj/Dust)
		var/Knock_Range=0
		if(BP>=5000000) Knock_Range=1
		if(Knock_Range||get_dir(src,A)==dir)
			if(isnum(A.Health)) A.TakeDamage(src, BP*0.1, "Knockback")//A.Health-=BP*0.1
			if(A.Health<=0)
				SmallCrater(A)
				del(A)
	for(var/turf/A in view(1,src)) if(!A.Water)
		var/Knock_Range=0
		if(BP>=5000000) Knock_Range=1
		if(Knock_Range||get_dir(src,A)==dir) //if(A.density)
			var/Damage=BP*0.1
			if(!A.density) Damage*=0.1
			if(isnum(A.Health)) A.TakeDamage(src, Damage, "Knockback")//A.Health-=Damage
			if(A.Health<=0)
				if(A.density)
					if(src!=0) A.Destroy(src,src.key)
					else A.Destroy("Unknown","Unknown")
					if(damage) return 1
				else if(prob(50)) if(!(icon_state in list("Flight"))) FightingDirt(A)

atom/proc/TakeDamage(var/mob/damager, damage as num, var/source, var/Htype="physical")
	if(!isnum(src.Health)) return
	var/OldHP=src.Health

	if(isturf(src)||isobj(src))if(ImmuneYear)
		if(ImmuneYear>Year) damage=0
		else damage+=(Health*0.75)+1
	if(ismob(damager))
		if(damager.HasBuildingPermit&&isturf(src)) damage*=2
		if(damager.HasBuildingPermit&&isobj(src)) damage*=2

	if(ismob(src))
		var/mob/M=src
		if(M.AdminMode)return
		if(M.RPMode) return
		if(M.afk) return
		if(M.invisibility)
			M.invisibility=0
			M.see_invisible=0
			M << "The attack causes you to lose your focus and slip out of invisibility!"
			for(var/Skill/Support/Invisibility/A in M) if(A.Using) spawn(45){A.Using=0;M<<"You feel your body relax again."}
		if(M.Blocking)damage*=0.7
		if(ismob(damager))
			if(damager.HasFriendOrFoe)
				if(M.Team==damager.Team) damage*=0.9
				else damage*=1.05
			else if(M.Team==damager.Team) damage*=0.7
			if(damager.HasConcentratedFire)
				if(damager.Target==M)damage*=1.1
				else damage*=0.95
			if(M.HasChallengersMark&&M.Target!=damager)damage*=1.00
			if(M.HasChallengersMark&&M.Target==damager)damage*=0.85
			if(M.Smashing) M.SmashCheck(damage)
			if(M.HasXenophobia&&M.Race!=damager.Race) damage*=1.03
			if(damager.HasXenophobia&&M.Race!=damager.Race)damage*=1.1

			if(damager.HasMidasPunch)
				var/Riches=0
				for(var/obj/Mana/MM in damager) Riches+=MM.Value
				for(var/obj/Resources/MM in damager) Riches+=MM.Value
				if(Riches>50000000)damage*=1.05
			if(damager.HasEatTheRich)
				var/Riches=0
				for(var/obj/Mana/MM in M) Riches+=MM.Value
				for(var/obj/Resources/MM in M) Riches+=MM.Value
				if(Riches>50000000)damage*=1.05

			if(damager.HeartAiming&&damager.Lethality)
				damage*=0.1
				M.Willpower-=damage
				damager.CombatOut("(Damaged [M]) [round(damage,0.01)] willpower damage [damager.Lethality?"(Lethal)":""]")
				M.CombatOut("([damager]) You took [round(damage,0.01)] willpower damage")
				return
			if(damager.HasGrimeReaper)
				var/KillAdd=1+(min(3,damager.Kills)*0.05)
				damage*=KillAdd
			if(damager.HasCleanseWicked)
				var/KillAdd=1+(min(3,M.Kills)*0.05)
				damage*=KillAdd
			if(M.HasFastMetabolism&&M.HasFoodRegen) damage*=0.95
			if(damager.HasKeepYourEnemies)
				for(var/obj/Contact/A in damager.Contacts) if(A.Signature == M.Signature)
					var/DM=(A.familiarity/5)
					if(DM>10)DM=10
					damage*=1+(DM/100)
			if(damager.HasLoneWolf)if(damager.Team.Members.len<=1&&!locate(/obj/Faction) in damager)damage*=1.05
			if(M.HasLoneWolf) if(M.Team.Members.len<=1&&!locate(/obj/Faction) in M)damage*=0.95

			if(M.HasThornsOn&&ismob(damager)&&source!="Thorns Aura"&&source!=src&&damager!=src)
				var/mob/MP=damager
				MP.TakeDamage(M, min(max(0.005,damage*0.35),5), "Thorns Aura")
			if(damager.Total_Stats_Strength)
				var/MightDamage=1
				if(damager.Race=="Alien") MightDamage=(damager.Total_Stats_Strength*0.0024)+1
				else MightDamage=(damager.Total_Stats_Strength*0.01)+1
				damage*=MightDamage
		if(M.HasBerserking&&M!=damager) damage*=1.15
		if(M.StanceCore==3) damage*=0.95
		if(M.BestDefenseRate)
			var/DR=M.BestDefenseRate/100
			damage-=damage*DR
			M.BestDefenseRate=0
		if(ismob(src)&&damager!=src&&ismob(damager)) src.HitOverlay(Htype,damager)
	//Might damage boost
	//Total_Stats_Strength


		if(M.Total_Stats_Endurance)
			var/EndDR=1
			if(M.Race=="Alien") EndDR=(M.Total_Stats_Endurance*0.0024)+1
			else EndDR=(M.Total_Stats_Endurance*0.01)+1
			damage/=EndDR

	src.Health-=damage
	if(istype(src,/obj/TrainingEq/Punchometer)) view(src,10)<<"[damager] dealt [damage]!"
	if(ismob(src))
		var/mob/SWguy=src
		if(OldHP>=50&&SWguy.Health<50)
			SWguy.SecondWind()
			SWguy.Anger()
		if(SWguy.Health<=0) SWguy.KO(damager)
		if(source)SWguy.CombatOut("([damager]) You took [round(damage,0.01)] damage ([source])")
		else SWguy.CombatOut("([damager]) You took [round(damage,0.01)] damage")
	if(ismob(damager)&&ismob(src))
		var/mob/S=src
		if(prob(3*damage)&&damager!=src) ShockwaveScale(S,damager.BP,damage/3)
		if(!source) damager.CombatOut("(Damaged [src]) [round(damage,0.01)] damage [damager.Lethality?"(Lethal)":""]")
		else damager.CombatOut("(Damaged [src]) [round(damage,0.01)] damage ([source]) [damager.Lethality?"(Lethal)":""]")
		if(ismob(src)&&damager!=src)
			S.Add_Anger(damage)
			if(damage>=1)
				if(S.Willpower<50&&prob(2)&&S.LethalCombatTracker) S.RefuseToDie()
				if(S.Willpower<30&&prob(2)&&S.LethalCombatTracker&&S.Lethality) S.BurningDesireForVictory()
			if(S.client&&damager.Lethality)
				if(S.Willpower>70) S.LethalCombatTracker=600
				else if(S.Willpower>40) S.LethalCombatTracker=1200
				else S.LethalCombatTracker=2400
				if(prob(30))
					if(S.Race=="Android"||S.AndroidLevel&&prob(50)) OilTrail(S)
					else BloodTrail(S)

				var/RateMult=max(0.5,damage*(rand(50,150)/100))
				if(damager.HasSurgicalStrikes) damage*=(damager.HasSurgicalStrikes*0.1)+1
				damage=damage*(rand(5,15)/10)
				S.BPDamage(damager,damage,RateMult)
				if(damager.HasBestDefense) damager.BestDefenseRate=min(20,damager.BestDefenseRate+damage)
			if(S.Flying&&S.SuperFly)Stagger(S,1)
		else S.BPDamage(damager,damage)
		if(!S.Target) S.Target=damager
		if(damage>3&&prob(damage*3)) S.Flight_Land()