Skill/Attacks/Grand_Explosion


	desc="Causes you to unleash a massive Force based explosion from your body. Costs 50% of energy and 25% Health."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list("Strong")

	verb/Grand_Explosion()
		set category="Skills"
		if(Using)return
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		usr.move=0
		CD=CDCalculation(src,usr)
		CDTick(usr)
		Using=1
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		for(var/mob/player/P in view(12)) P.BuffOut("[usr] begins gathering all the energy around him into his body!")
		sleep(15)
		for(var/mob/player/P in view(12)) P.BuffOut("The ground begins to shake fiercely around [usr]!")
		sleep(15)
		if(usr.KOd)
			Using=0
			usr.move=1
			return
		for(var/mob/player/P in oview(usr,12)) P.BuffOut("A huge explosion eminates from [usr] and surrounds the area!")
		hearers(10,usr) << sound(pick('Explosion1.mp3','Explosion2.mp3','Explosion3.mp3'),volume=20)
		for(var/turf/T in oview(usr,5))
		//	if(prob(7)) sleep(1)
			if(T) spawn T.Self_Destruct_Lightning(rand(50,100))
			T.TakeDamage(usr, 20*usr.Off, "Grand Explosion")
			//T.Health-=60*usr.Pow
			spawn(rand(50,100)) {if(usr!=0) T.Destroy(usr,usr.key);else T.Destroy("Unknown","Unknown")}
			for(var/mob/M in T) if(M!=usr) if(!M.afk)
				var/DamageDealt=DamageCalculator(usr,M,src)
				M.TakeDamage(usr, DamageDealt, "Grand Explosion")
				//M.TakeDamage(usr, DamageDealt)
				if(M.Health<=0) M.KO(usr)
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Grand Explosion")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Grand Explosion.\n")
		//usr.Ki=max(0,usr.Ki*0.5)
		usr.Ki=(usr.Ki-EDT)
		usr.TakeDamage(src, 10, "Grand Explosion")
		usr.move=1
		spawn(10)
			if(usr)
				src.Using=0