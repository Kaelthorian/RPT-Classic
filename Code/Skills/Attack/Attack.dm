mob/var/tmp/HomingAttack=0

mob/proc/Blast() flick("Blast",src)
mob/proc/Fight() flick("Attack",src)
mob/var/tmp/SeenYouBleed=0
mob/proc/RHK()
	set waitfor=0
	dir=turn(dir,90)
	sleep(1)
	dir=turn(dir,90)
	sleep(1)
	dir=turn(dir,90)
	sleep(1)
	dir=turn(dir,90)
	sleep(1)

mob/proc/KO(mob/Z)
	ASSERT(Z)   //test assert
	if(src.afk) if(Z!="low health") return
	if(IsFishing)
		IsFishing=0
		usr<<"You stopped fishing."
	if(IsMining)
		IsMining=0
		usr<<"You stopped mining."
	if(IsCooking)
		IsCooking=0
		usr<<"You were interrupted."
	if(Creating)
		usr<<"You were interrupted."
		Creating=0
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
	if(usr.z==3)
		usr.z=2
	if(client) if(!KOd) // The one who got knocked out
		if(src.Health<=0 && LethalCombatTracker && !src.RPMode && src.Willpower>1&& src.FailToAnger==0)				//If the one being KOed is at 0 HP , have letal tracker on , is not in RP mode and have more than 1 WP.
			if(src.LastHitter in src.HitterListNew)																	//If the last guy who hitted you , and therefore koed you , is in the list of guys who is hitting you and didn't KO you yet.
				src.AngerCheck()																					//Run the anger check.
				return
		KOd=1
		if(ismob(Z)&&ismob(src)) if(Z.Lethality)
			var/mob/M=src
			if(M.Willpower>40) M.LethalCombatTracker=1200
			else M.LethalCombatTracker=2400
			if(prob(30))
				if(Race=="Android"||AndroidLevel&&prob(50)) OilTrail(src)
				else BloodTrail(src)
			if(Z.HasSeeYouBleed&&!Z.SeenYouBleed)
				SeenYouBleed=100
				Z.Willpower=min(Z.Willpower+15,Z.MaxWillpower)
				for(var/mob/player/MM in view(src)) MM.BuffOut("[Z] smirks at [src].")
		if(LethalCombatTracker)
			if(!RPMode) RPMode()
			Willpower=max(0,Willpower-(30-(0*8)))
			if(Majinized>0) Willpower-=5
			if(Dead && z!=11)
				if(KeepsBody)
					Willpower-=30
					if(Willpower<0)
						Willpower=0
				if(!KeepsBody)
					Willpower-=70
					if(Willpower<0)
						Willpower=0
			src<<"Willpower drain from [Z] knocking you out!"
			if(Z.HasASwiftDeath) Willpower=(max(0,Willpower-10))
			if(Health<=-500) Willpower=max(0,Willpower-10)
			if(Willpower<=0) WillpowerFailure()

		//if(usr.InAutoAttack) usr.AutoAttack()

		Flight_Land()
		Calm()
		Life=100
		if(client) src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] is knocked out by [key_name(Z)]\n")
		icon_state="KO"
		//KOOverlay()
		KB=0
		Health=0
		if(!LethalCombatTracker) DeathAnger=0
		/*for(var/Activity/O in Z) if(O.Subtype=="KO") if(!locate("[src.name]") in O.Tracker)
			var/op=O.Progress
			O.CheckProgress(1,"[src.name]",Z)
			if(O.Progress>op) Z<<"You have gained progress on your daily activity. ([O])"*/
		if(src.BPpcnt > 100)
			src<<"Your energy escapes as you are knocked out."
			src.BPpcnt = 100
		//Anger to onlookers...
		if(ismob(Z)&&Z.client) // For the one who's the responsible player

			for(var/mob/player/M in view(src))
				M.ICOut("<font color=purple>[src] is knocked out by [Z]!")
				M.CombatOut("<font color=purple>[src] is knocked out by [Z]!")
			saveToLog("<font color=purple>|| ([src.x], [src.y], [src.z]) | [key_name(src)] is knocked out by [Z]\n")
		else
			for(var/mob/player/M in view(src))
				M.ICOut("<font color=purple>[src] is knocked out by [Z]!")
				M.CombatOut("<font color=purple>[src] is knocked out by [Z]!")
		saveToLog("<font color=purple>| [key_name(src)] is knocked out by [Z]\n")
		RevertAll()
		var/T = rand(800,1600)/(Regeneration)
		if(T<=300) T=300
		if(isnum(Regeneration)) spawn(300) spawn(T) src.Un_KO()
		hearers(10,usr)<<sound('KO.wav',volume=20)
	else if(!Frozen)
		Life=100
		if(istype(src,/mob/Splitform))
			var/mob/Splitform/SF=src
			SF.function=0
		Frozen=1
		view(src)<<"[src] is defeated."
		//if(!client) del(src)
		if(!client){del(src);return}
		//if(sim){del(src);return}
		spawn(rand(500,700)) if(src)
			view(src)<<"[src] regains consciousness"
			Health=MaxHealth
			Frozen=0




mob/proc/Un_KO() if(client&&KOd)
	if(!RPMode&&Willpower>0)
		icon_state=""
		KOd=0
		attacking=0
		Health=1
		Life=100
		//Ki=0
		move=1
		Frozen=0
		for(var/mob/player/M in view(src))
			M.ICOut("[src] regains consciousness.")
			M.CombatOut("[src] regains consciousness.")


		if(LethalCombatTracker&&HasWillUnbroken) Willpower=min(Willpower+5,MaxWillpower)
//		src.RemoveStatOverlays()
/*		if(src.client)
			spawn(20) if(prob(10))
				src<<"Being knocked out so much angers you..."
				src.CombatOut("Being knocked out so much angers you...")
				Anger()
				SecondWindCD=0*/
	else if(RPMode)
		sleep(600/Regeneration)
		Un_KO()


mob/proc/resetChargelvl(mob/player/P)
	for(var/Skill/Attacks/A in P)
		if(A.chargelvl>1) A.chargelvl=1
		sleep(1)
/*
mob/verb/AttackOld()
	set category="Skills"
	return
	if(usr.InAutoAttack) usr.Toggle_Auto_Attack()
	if(usr.IsBlocking) return
	if(adminDensity)
		src << "You're currently in Ghost Form. Disable it first."
		return

//	if(!usr.CanAttack(1)) return

	//Are we allowed to hit him ?

	if(usr.SwordOn || usr.HammerOn)
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
	if(!usr.SwordOn && !usr.HammerOn)
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
	MeleeAttack()


mob/verb/Toggle_Auto_Attack()
	set category="Other"
	return
	if(usr.IsBlocking)
		return
	InAutoAttack=!InAutoAttack
	if(InAutoAttack)
		winset(client,"AUTO","is-visible=true")
		usr<<"Auto Attack initiated."
		spawn() AutoAttack()
	else
		AALoop=0
		winset(client,"AUTO","is-visible=false")
		usr<<"Auto Attack cancelled."

mob/var/tmp
	InAutoAttack=0
	AALoop=0
*/
/*
mob/proc/AutoAttack()
	set waitfor=0
	set background=1
	if(AALoop) return
	while(InAutoAttack&&!KOd)
		AALoop=1
		MeleeAttack()
		if(Ki<=MaxKi*0.05)
			InAutoAttack=0
			winset(client,"AUTO","is-visible=false")
			src<<"You stop Auto Attacking due to lack of energy. (<5% Energy)"
		sleep(Refire)
*/
mob/var/tmp/OppTicks=0

mob/proc/Opp(var/mob/P) if(!Opp) if(istype(P,/mob))
	Opp=P
	OppTicks=6

	//awn(100) Opp=null




mob/proc/TrainOpp(var/P)
//	if(!P) return
//	if(args.len>1)
//		return
//	var/obj/TrainingEq/_equipment
//	if(!istype(P, /obj/TrainingEq))
//		return
//	else
//		_equipment = P
//	if(Opp) return
//	Opp=_equipment
//	OppTicks=4
//	Stop_TrainDig_Schedulers()
//
mob/var/tmp/TargetWarpCD=0
mob/proc/TargetWarp() if(!TargetWarpCD)
	if(src.Target&&src.Target.z==src.z) if(get_dist(src,Target)<10)
		Comboz(Target)
		TargetWarpCD=12
mob/var/tmp/mob/LastAttacked

/*
mob/proc/MeleeAttack(skiprefire=0,skipKB=0)
	set background=1
	set waitfor=0
	if(DashAttacking) return
	if(S) return
	Bandages()
	if(src.invisibility)
		src.invisibility=0
		src.see_invisible=0
		src << "As you attack, you feel your body become tense and you turn visible again!"
		for(var/Skill/Support/Invisibility/A in src) if(A.Using) spawn(45){A.Using=0;src<<"You feel your body relax again."}

	//Football code
	for(var/obj/items/Soccer_Ball/E in get_step(src,dir))
		step_away(E,src,StrMod*2)
		sleep(0)
		step_away(E,src,StrMod*2)
		sleep(0)
		step_away(E,src,StrMod*2)
		sleep(0)
		step_away(E,src,StrMod*2)
		sleep(0)
		step_away(E,src,StrMod*2)

	//Training Code for attack
	for(var/obj/TrainingEq/E in get_step(src,dir)) if(icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
		var/Bag = 0
		if(!attacking)
			attacking=1
			if(E.icon_state=="Off") spawn(1000) if(E) E.icon_state="Off"
			E.icon_state="On"
			if(E.dir==turn(dir,180))
				getAttackXY()
				Fight()
				TrainOpp(E)
				if(prob(50)) E.dir=turn(E.dir,90)
				else E.dir=turn(E.dir,-90)
				spawn(Refire*0.5) attacking=0
			else
				flick("Attack",src)
				Opp=null
				spawn(Refire*2) attacking=0
				return
				//DisableTraining()
				//if(ProcOn==1&&TimerOn==0) TrainingTimer()  //	if(!usr.TrainingTimer()
			var/Damage=((Str/E.End)+(BP/(E.BP*10)))
			for(var/obj/items/Boxing_Gloves/G in src)
				if(G.suffix)
					Damage = Damage / 20
					//src.Spar = 1
					break
			if(!isnum(E.Health)) return
			E.TakeDamage(src, Damage, "Attack")
			//E.Health-=Damage
			if(E.Health<=0&&E.icon_state!="KO")
				E.Health=0
				E.icon_state="KO"
				spawn(600) if(E) if(E.Health<=0) del(E)
				return
		else if(istype(E,/obj/TrainingEq/Punching_Bag)) if(E.Health>0&&dir==EAST&&Ki>0.1)
			for(var/obj/TrainingEq/Magic_Goo/R in range(0,src)) if(R!=src)
				view(src)<<"You can't hit the [src] because [R] is in the way."
				sleep(1)
				return
			for(var/obj/TrainingEq/Punching_Bag/R in range(0,src)) if(R!=src)
				view(src)<<"You can't hit the [src] because [R] is in the way."
				sleep(1)
				return
			Bag = 1
		else if(istype(E,/obj/TrainingEq/Magic_Goo)) if(E.Health>0&&dir==EAST&&Ki>0.1)
			for(var/obj/TrainingEq/Magic_Goo/R in range(0,src)) if(R!=src)
				view(src)<<"You can't hit the [src] because [R] is in the way."
				sleep(1)
				return
			for(var/obj/TrainingEq/Punching_Bag/R in range(0,src)) if(R!=src)
				view(src)<<"You can't hit the [src] because [R] is in the way."
				sleep(1)
				return
			Bag = 1
		else if(istype(E,/obj/TrainingEq/Punchometer)) if(E.Health>0&&dir==EAST&&Ki>0.1)
			Bag=1
		if(Bag)
			if(!attacking)
				attacking=1
				TrainingEquipment(usr)
//				TrainOpp(E)
				spawn(Refire) attacking=0 //Refire*.05 original code -  Combat CPU optimization
				//flick("hit",E)
				getAttackXY()
				Fight()
				flick("hit",E)
				var/Damage=((Str/E.End)+(BP/(E.BP*10)))
				for(var/obj/items/Boxing_Gloves/G in src)
					if(G.suffix)
						Damage = Damage / 20
						break
				if(!isnum(E.Health)) return
				E.TakeDamage(src, Damage, "Attack")
				if(E.Health<=0&&E.icon_state!="Destroyed") E.icon_state="Destroyed"
		return

	var/mob/M=null


	//Begining of the attack verb vs another mob here
	for(var/mob/MN in oview(src,1)) if(MN==LastAttacked&&Warp) M=MN
	if(!M)
		for(var/mob/MM in get_step(src,dir))
			M=MM
			//break
	if(M) if(!M.adminDensity&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0) //if(!ghostDens_check(M)&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
		if(HasDoubleAttack) if(prob(20))
			src.FreeAttack(M,1)
		if(M.RPMode) return
		for(var/obj/items/Regenerator/R in range(0,src)) if(R.z) return
		if(M.client&&client&&!TestServerOn) if(M.client.computer_id==client.computer_id) // Based on computer ID instead of IP.
			src<<"Do not interact with alternate keys"
			alertAdmins("|| ([src.x], [src.y], [src.z]) | [key_name(src)] has been forced off the server for attempted alt interaction with [key_name(M)].\n")
			src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] has been forced off the server for attempted alt interaction with [key_name(M)].\n")
			Logout()
		if(!attacking||skiprefire) if(M.afk == 0)
			//if(M.Flying!=Flying) return
			if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
				attacking=1
				if(skiprefire)attacking=0
				if(prob(20)&&locate(/Skill/Zanzoken) in src&&Zanzoken>=1000) Comboz(M)
				if(!Oozaru)getAttackXY()
				Fight()
				/*
				if(FancyFight&&!incoolattack&&!M.incoolattack&&prob(25)&&locate(/Skill/Zanzoken) in src&&locate(/Skill/Zanzoken) in M) PrettyAttack(M) //
				else
					getAttackXY()
					Fight()*/
				if(M.attacking==1) Opp(M)
//				var/DidCrit=0
				var/Evasion=SkillAccuracy(src,M)
//				var/Damage=DamageFormula(src,M)
				var/Damage=AutoAttackDamageCalculator(src,M)

				if(KiFists)
					Damage=DamageCalculatorKiWeapon(src,M,src)
				if(KiBlade)
					Damage=DamageCalculatorKiWeapon(src,M,src)
				if(KiHammer)
					Damage=DamageCalculatorKiWeapon(src,M,src)
				if(SpiritSword)
					Damage=DamageCalculatorKiWeapon(src,M,src)
				if(CriticalEdge&&prob(50))
					Damage*=1.33
				var/WarpCD=0
				var/DecisiveBlow=0
				var/DBChance=Refire*0.5
				if(src.Warp)
					DBChance/=3
				if(HasRefuseToLose)
					DBChance*=1.1
				if(src.Health<30&&src.Lethality&&src.EventCharacter<1&&prob(DBChance))
					DecisiveBlow=1
				if(!DecisiveBlow&&BurningDesireAttacks)
					BurningDesireAttacks--
					DecisiveBlow=1
				//del(L)
				if(M.RiposteActive)
					for(var/mob/player/teleg in view(src))
						teleg.CombatOut("[M] counters [src]s attack.")
					hearers(10,usr)<<sound('SkillTrigger.mp3',volume=20)
					M.dir=get_dir(M,src)
					GetDisarmed(M,8)
					BlockEffect(M)
					Stun(src,0.5)
					M.RiposteActive=0
					RiposteActive=0
					spawn(Refire) attacking=0
					return 0
				if(M.CatchBladeActive) //if(SwordOn||HammerOn)
					for(var/mob/player/teleg in view(src))
						teleg.CombatOut("[M] catches [src]s attack mid-swing.")
					hearers(10,usr)<<sound('SkillTrigger.mp3',volume=20)
					M.dir=get_dir(M,src)
					GetDisarmed(M,8)
					BlockEffect(M)
					Stun(src,0.5)
					M.CatchBladeActive=0
					CatchBladeActive=0
					spawn(Refire) attacking=0
					return 0


				//If we didn't
				if(!prob(Evasion) && !M.IsBlocking)

					Spar(usr)
					//Animation
					flick(M.CustomZanzokenIcon,M)
					hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)

					//msg that we dodge
					M.CombatOut("You dodge [usr].")
					CombatOut("[M] dodges you.")



					//Energy Math for dodge
					M.Ki+=DodgeEnergyCalculation(M,usr)
					if(M.MaxKi<=M.Ki)
						M.Ki=M.MaxKi
//					if(M.HasFloatLike)
//						if(Warp) DrainKi("[M] Floats Like A Butterfly","Percent",0.12)
//						else DrainKi("[M] Floats Like A Butterfly","Percent",0.6)

				//Successful hit
				else
					//Anger markers
					M.LastHitter = usr.name
					M.HitterListCheck(usr.name)

					Spar(usr)

					//If he block it
					if(!prob(Evasion-(M.HasWayOfTheTurtle*2.5))|| M.IsBlocking)

						//Animation
						M.Screen_Shake(2,8)
						ShockwaveScale(M,usr.BP,1)
						if(prob(10)) ShockwaveScale(M,BP)
						hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)

						//We take the damage
						Damage = Damage * 0.5
//						didBlock=1
//						M.TakeDamage(src, Damage, "[src]")

						//msg that we blocked
						M.CombatOut("You block [usr].")
						CombatOut("[M] blocks you.")


						//Energy Math for Block
						M.Ki+=BlockEnergyCalculation(M)
						if(M.MaxKi<=M.Ki)
							M.Ki=M.MaxKi

					//If he didn't block it
					hearers(10,usr)<<sound(pick('MeeleMedium1.wav','MeeleMedium2.wav'),volume=20)

					//KB meter
					M.KB=round(Damage*0.5)
					if(M.KB>20)
						M.KB=20
					if(skipKB)
						M.KB=0
					if(Warp&&M.KB)
						M.KB=M.KB/2
					if(HammerOn)
						if(prob(max(25,SwordSkill/25)))
							SmallCrater(M)
					if(SwordOn||HammerOn)
						if(prob(50))
							StabUser(src)
						else SlashUser(src)
					if(DecisiveBlow)
						M.KB+=2
					spawn M.KnockBack(usr)

					//Zanzoken combo code
					if(KOd==0&&prob(Zanzoken*0.1)&&Warp&&(locate(/Skill/Zanzoken) in src))
						if(Warp)
							Damage/=3
							if(HasZanzokenMaster) Damage*=1.2
							WarpCD=1
						spawn(M.KB+1)
							flick(src.CustomZanzokenIcon,src)
							Comboz(M)
					var/Htype="physical"
					if(SwordOn)Htype="sharp"
					if(M)
						if(!isnum(M.Health)) return
						var/AttackOut="Attack"

						//We calculate and damage here
						M.TakeDamage(src, (Damage), AttackOut,Htype)

						//Energy Math for Attacks
						if(!SwordOn&&!HammerOn)
							Ki+=UnarmedEnergyCalculation(usr,M)
							if(MaxKi<=Ki)
								Ki=MaxKi
						if(SwordOn)
							Ki+=SwordEnergyCalculation(usr,M)
							if(MaxKi<=Ki)
								Ki=MaxKi
						if(HammerOn)
							Ki+=HammerEnergyCalculation(usr,M)
							if(MaxKi<=Ki)
								Ki=MaxKi

						if(M.client&&GuardBreaking)
//							winset(M.client,"guardB","is-visible=true")
							if(!M.GuardBroken) viewers(6,M) <<"[M]'s guard has been broken by [src]."
							hearers(10,usr)<<sound('SkillTrigger.mp3',volume=20)
							M.GuardBroken=4
							//GuardBreaking--
						if(M.client&&ChakraBlocking)
							winset(M.client,"ChakraB","is-visible=true")
							if(!M.ChakraBlocked) viewers(6,M) <<"[M]'s chakra has been blocked by [src]."
							hearers(10,usr)<<sound('SkillTrigger.mp3',volume=20)
							M.ChakraBlocked=1
							if(Warp) M.DrainKi("[src] Chakra Blocking","Percent",0.4)
							else M.DrainKi("[src] Chakra Blocking","Percent",1.2)
							//ChakraBlocking--
						LastAttacked=M
						spawn()
							if(M.ArmorCheck()<3) if(WeaponCheck()>2) if(prob(10))
								if(Warp) M.DrainKi("[src] Auracite Weapon","Percent",0.4)
								else M.DrainKi("[src] Auracite Weapon","Percent",1.2)
							if(DecisiveBlow)
								for(var/mob/player/P in view(src)) P.BuffOut("[src] has dealt a decisive blow against [M]!")
								M.TakeDamage(src, M.Health*0.1, "Decisive Blow")
								hearers(10,usr)<<sound(pick('Drama1.mp3','Drama2.mp3','Drama3.mp3'),volume=20)
								src.DecisiveRegen()
							if(IceyGrip) spawn() M.GripOfIce()
							if(Element) spawn() if(prob(70)) M.BurnDamage(src,"Firey Weapon",Damage*0.1)
							if(BurningFists&&!SwordOn&&!HammerOn)if(!SpiritSword&&!KiBlade&&!KiHammer) if(prob(50)) M.BurnDamage(src,"Burning Fists",Damage*0.2)
							if(!Disarmed) if(WeaponCheck()) if(!SpiritSword&&!KiBlade&&!KiHammer)
								if(BleedingEdge) if(prob(33)) M.BleedDamage(src,"Bleeding Edge",Damage*0.125)
								if(ThunderingBlows) if(prob(50)) M.Thunderstruck(src,Damage*0.1)
							if(ManaLeech) LeechMana(M)
				if(!skiprefire)
					if(WarpCD&&Warp) spawn(Refire/3) if(attacking!=3) attacking=0
					else spawn(Refire) if(attacking!=3) attacking=0
			else
				attacking=1
				spawn(Refire) attacking=0
				Fight()
				if(!isnum(M.Life)) return
				//CombatOut("You attack [M]. ([round(3*((BP*Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
				//M.CombatOut("[usr] attacks you. ([round(3*((BP*Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
				M.Life-=3*((BP*Str)/(M.Base*M.Body*M.End))
				M.KB=round((Str/M.End)*5)
				if(M.KB>5) M.KB=5
				M.KnockBack(usr)
				////if(M&&M.Life<=0) M.Death(src)
		return

	if(src.HomingAttack) if(src.Target&&src.Target.z==src.z) if(get_dist(src,Target<10))
		Comboz(Target)
		src.HomingAttack--
		return

	for(var/obj/Door/A in get_step(src,dir)) if(icon_state!="Meditate"&&icon_state!="Train"&&KOd==0&&!attacking) if(!istype(A,/Icon_Obj))
		attacking=1
		spawn(Refire) attacking=0
		Fight()
		if(!isnum(A.Health)) return
		if(istype(A,/obj/Door/)) A.TakeDamage(src,Str*BP, "Attack")
		else if(!istype(A,/obj/items/Power_Armor)) if(!istype(A,/obj/Ships)) A.TakeDamage(src, (Str*BP)/TrueBPCap, "Attack")
		if(A.Health<0) A.Health=0
		if(A.Health<=0)
			SmallCrater(A)
			del(A)
		return
//	usr.attacking=0




*/

mob/proc/FreeAttack(mob/M,Skill/S,skipKB=1)
	set waitfor=0
/*	if(!attacking) if(M.afk == 0)
		if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
			if(prob(20)&&locate(/Skill/Zanzoken) in src&&Zanzoken>=1000) Comboz(M)
			if(!Oozaru)getAttackXY()
			Fight()
			if(M.attacking==1) Opp(M)
			var/Evasion=SkillAccuracy(usr,M,S)
//			var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
			var/Damage=DamageCalculator(usr,M,S)
//			var/DidCrit=0
//			if(M.ArmorCheck()<2) if(WeaponCheck(2)>1) if(prob(10)) DidCrit=1//Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
//			if(!HammerOn&&!SwordOn&&!KiBlade&&!KiHammer&&!SpiritSword)
//				if(HasWayOfTheOpenPalm&&!KiFists) Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0.1,Offense=0,DamageType="Physical",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
//				else if(KiFists&&HasWayOfTheOpenPalm)
//					Evasion=SkillAccuracy(src,M)
//					Damage=DamageFormula(src,M,Strength=0.7,Force=0.3,Speed=0.1,Offense=0,DamageType="KiFist",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
//				else if(KiFists)
//					Evasion=SkillAccuracy(src,M)
//					Damage=DamageFormula(src,M,Strength=0.7,Force=0.3,Speed=0,Offense=0,DamageType="KiFist",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
//			if(KiBlade)
//				Evasion=SkillAccuracy(src,M)
//				Damage=DamageFormula(src,M,Strength=0.2,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
//			if(KiHammer)
//				Evasion=SkillAccuracy(src,M)
//				Damage=DamageFormula(src,M,Strength=0.3,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
//			if(SpiritSword)
//				Evasion=SkillAccuracy(src,M)
//				Damage=DamageFormula(src,M,Strength=0.4,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
			if(CriticalEdge&&prob(50)) Damage*=1.33
			var/didBlock=0
			var/DecisiveBlow=0
			var/DBChance=Refire*0.5
			if(src.Warp)DBChance/=5
			if(HasRefuseToLose) DBChance*=1.1
			if(src.Health<30&&src.Lethality&&prob(DBChance))DecisiveBlow=1
			if(!DecisiveBlow&&BurningDesireAttacks)
				BurningDesireAttacks--
				DecisiveBlow=1
			//del(L)
			if(M.RiposteActive)
				for(var/mob/player/teleg in view(src)) teleg.CombatOut("[M] counters [src]s attack.")
				M.dir=get_dir(M,src)
				GetDisarmed(M,8)
				BlockEffect(M)
				Stun(src,0.5)
				M.RiposteActive=0
				RiposteActive=0
				spawn(Refire) attacking=0
				return 0
			if(M.CatchBladeActive) if(SwordOn||HammerOn)
				for(var/mob/player/teleg in view(src)) teleg.CombatOut("[M] catches [src]s weapon.")
				M.dir=get_dir(M,src)
				GetDisarmed(M,8)
				BlockEffect(M)
				Stun(src,0.5)
				M.CatchBladeActive=0
				CatchBladeActive=0
				spawn(Refire) attacking=0
				return 0
			if(!prob(Evasion))
				flick(M.CustomZanzokenIcon,M)
				M.CombatOut("You dodge [usr].")
				CombatOut("[M] dodges you.")

			else //Successful hit
				if(!prob(Evasion+(M.HasWayOfTheTurtle*2.5)))
					if(prob(10)) ShockwaveScale(M,BP)
					Damage = (Damage/2) * 0.5
					didBlock=1
				//if(prob(70)) ImpactDust(M,usr.dir)//
				M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
				if(M.KB>20) M.KB=20
				if(skipKB)M.KB=0
				if(Warp&&M.KB) M.KB=M.KB/2
				if(HammerOn) if(prob(max(25,SwordSkill/100))) SmallCrater(M)
				if(SwordOn||HammerOn)
					if(prob(50)) StabUser(src)
					else SlashUser(src)
				if(DecisiveBlow) M.KB+=2
				spawn M.KnockBack(usr)
				var/Htype="physical"
				if(SwordOn)Htype="sharp"
				if(M)
					if(!isnum(M.Health)) return
					var/AttackOut="Attack"
					if(didBlock==1)AttackOut="Blocked Attack"
					else if(didBlock==2) AttackOut="(Armor) Blocked Attack"
					M.TakeDamage(src, Damage, AttackOut,Htype)
					LastAttacked=M
					if(M.ArmorCheck()<3) if(WeaponCheck()>2) if(prob(10))
						if(Warp) M.DrainKi("[src] Auracite Weapon","Percent",0.3)
						else M.DrainKi("[src] Auracite Weapon","Percent",1.5)
					if(DecisiveBlow)
						for(var/mob/player/P in view(src)) P.BuffOut("[src] has dealt a decisive blow against [M]!")
						M.TakeDamage(src, M.Health*0.1, "Decisive Blow")
						src.DecisiveRegen()
					if(Element) spawn()//redo me REMOVE ME FIX ME
						if(prob(70)) M.BurnDamage(src,"Firey Weapon",Damage*0.1)
					spawn()
						if(BurningFists&&!SwordOn&&!HammerOn) if(prob(66)) M.BurnDamage(src,"Burning Fists",Damage*0.2)
						if(!Disarmed) if(WeaponCheck())
							if(BleedingEdge) if(prob(33)) M.BleedDamage(src,"Bleeding Edge",Damage*0.125)
							if(ThunderingBlows) if(prob(50)) M.Thunderstruck(src,Damage*0.1)
						if(ManaLeech) LeechMana(M)
*/