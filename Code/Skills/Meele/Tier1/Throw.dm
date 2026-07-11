mob/var/tmp/BestDefenseRate=0


atom/proc/GetThrowResistance() return 1

atom/proc/SetThrownDamage(var/mob/other )
	throwForce = (other.Str*(other.BP))*rand(2,5)
	throwDamage = throwForce
//	if(ismob(src)) src<<"Throw Damage [throwDamage]"
//	if(ismob(other)) other<<"Throw Damage [throwDamage]"

atom/proc/BeforeThrow()
	isThrown = 1
	//oldDensity = density
	density = 1
	hasHitAnything = 0
	if(isSpinning) Spin()
	spawn() Spin()
atom/proc/GetThrown(var/mob/other)
	var/const/t = 1
	var/throw_dir = dir
	var/prev_loc = loc
	if(isThrown) return
	thrower = other
	SetThrownDamage(other)
	var/dist = min( 2*throwDamage, 50 )
	var/oldDensity=density
	BeforeThrow()
//	if(prob(50)) DustCloud(src)
	for( var/i = 0; i < dist; i++ )
		step( src, throw_dir )
		if(prev_loc == loc) break
		prev_loc = loc
//		if(prob(10)) DustCloud(src)
		sleep(t)
	spawn() Spin()
	AfterThrow(other)
	density=oldDensity
atom/proc/AfterThrow(var/mob/thrower)
	isThrown = 0
	lastBumped = null
	if(hasHitAnything&&ismob(src))
		var/mob/M=src
		M.TakeDamage(thrower, throwDamage, "Throw")
	//density = oldDensity
	if(icon_state == "KB") icon_state = ""
mob
	SetThrownDamage(var/mob/other)
		..()
		Flight_Land()
		throwDamage /= GetThrowResistance()
	GetThrowResistance() return (src.End*src.BP)
	BeforeThrow( )
		KB = 1
		if(KOd==0) icon_state = _KB
		..()
	AfterThrow()
		KB = 0
		..()
		density = 1

mob/proc/CanAttackMob( var/mob/M, mod as num, bias=0)
	var/const/zanzo_max = 1000
	var/Evasion=(BP*(Off+(Spd*0.30)))/(M.BP*(M.Def+(M.Spd*0.30))) * mod // Speed contribution to off/def formula - Mumit
	if(M.icon_state=="Meditate") Evasion*=1.5
	var/Your_Zanzoken=min(Zanzoken, zanzo_max)
	var/Their_Zanzoken=min(M.Zanzoken, zanzo_max)
	var/Zanzoken_Boost=min(Their_Zanzoken/Your_Zanzoken, 2)
	return prob(Evasion*55/Zanzoken_Boost + bias)


mob/verb/MakeSpin()
//	usr<<"Long ago. .. there existed a form of knockback that used the KB icon state.  Then Ryu found out about the animate proc and the power it possessed to make things look nicer.  He added a testing verb called MakeSpin, which would allow him to view the animation in the single player version of RT that he hosted on his desktop to test.  The verb was great and helped him find the proper timing, however Ryu forgot to remove the verb.  Long did MakeSpin slumber before being discovered by several crafty individuals. It was a cool 1337 way of showing you were a true RT pro.  It was basically teabagging someone in RT. Then,  one of the weebs, Shumba, popularized the use of the technique in combat.  This lead to large groups of people all spamming MakeSpin, way outside of its original intended use.  As such, Ryu was forced to remove the ability due to the stress animating 10+ mobs on repeat without proper delays and staggering would put on weaker PCs.  Now we can only dream of when MakeSpin may one day rejoin the ranks of RT."

	animate(usr, transform = turn(matrix(), 90), time = 0.5)
	animate( transform = turn(matrix(), 180), time = 0.5)
	animate( transform = turn(matrix(), 270), time = 0.5)
	animate( transform = null, time = 0.5)


atom/proc/Spin(DirD)
	if(src)//istype(src,/mob/))
		if(isSpinning)
			animate(src, transform = null, time = 1)
			isSpinning=0
		else
			isSpinning=1
			while(isSpinning)
				animate(src, transform = turn(matrix(), 90), time = 1)
				sleep(1)
				animate(src,  transform = turn(matrix(), 180), time = 1)
				sleep(1)
				animate(src,  transform = turn(matrix(), 270), time = 1)
				sleep(1)
				animate(src,  transform = null, time = 1)
				sleep(1)


atom/var/tmp/grabberSTR
mob/var/IsThrowing
mob/verb
	Throw()
		set category="Skills"
		if(IsThrowing ==1)
			return
		IsThrowing = 1
		sleep(10)
		if(!onThrowCD)
			onThrowCD = 1
			spawn(usr.Refire*6) onThrowCD = 0
			if(!usr.GrabbedMob) usr.Grab()
			Ki=max(0,Ki-MaxKi*0.05/StrMod)
			var/atom/other = GrabbedMob
			var/mob/as_mob = other
			var/will_throw = ( istype(other, /mob) ) ? CanAttackMob(as_mob, 1) : 1
			if(other)
				other.grabberSTR=null
				if(will_throw)
					other.dir = dir
					spawn(1) other.GetThrown( src )
					hearers(10,usr)<<sound('Throw.mp3',volume=20)
					//DustCloudOrigin(usr) Already removed Mumit, don't touch
				else
					src.CombatOut("You failed to throw [other].")
					if(ismob(other))
						var/mob/MM=other
						MM.CombatOut("[src] failed to throw you.")
				usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] threw [GrabbedMob]\n")
				src.GrabbedMob = null
				src.isGrabbing = null
		else src.CombatOut("Your throw is on cooldown.")
		IsThrowing = 0
//			usr.Grab()
//			sleep(2)
//			//.()

