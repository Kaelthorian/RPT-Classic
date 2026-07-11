Skill/Attacks/SuperExplosiveWave
	UB1="War"
	UB2="Channel"


	desc="This is similar to self destruct but you don't die. It deals less damage but is faster as a result."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list("Strong")

	verb/Super_Destructive_Wave()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		switch(input("Super Explosive Wave?") in list("No","Yes"))
			if("Yes") if(!usr.Dead&&usr.KOd==0)
				usr.move=0
				CD=CDCalculation(src,usr)
				CDTick(usr)
				Using=1
				for(var/mob/player/P in view(12)) P.BuffOut("[usr] begins gathering all the energy around him into his body!")
				sleep(15)
				for(var/mob/player/P in view(12)) P.BuffOut("The ground begins to shake fiercely around [usr]!")
				sleep(15)
				if(usr.KOd)
					Using=0
					usr.move=1
					return
				for(var/mob/player/P in view(12)) P.BuffOut("A huge explosion eminates from [usr] and surrounds the area!")
				for(var/turf/T in view(usr,5))
				//	if(prob(7)) sleep(1)
					if(T) spawn T.Self_Destruct_Lightning(rand(50,100))
					T.TakeDamage(usr, 40*usr.Off, "Super Explosive Wave")
					spawn(rand(50,100)) {if(usr!=0) T.Destroy(usr,usr.key);else T.Destroy("Unknown","Unknown")}
					for(var/mob/M in T) if(M!=usr) if(!M.afk)
						var/DamageDealt=DamageCalculator(usr,M,src)
						M.TakeDamage(usr, DamageDealt, "Super Explosive Wave")
						if(M.Health<=0) M.KO(usr)
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Super_Explosive_Wave")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Super_Explosive_Wave.\n")
				usr.Ki=(usr.Ki-EDT)
				usr.TakeDamage(src,25, "Super Explosive Wave")
				usr.move=1
				spawn(10) if(usr) src.Using=0
				hearers(10,usr) << sound(pick('Explosion1.mp3','Explosion2.mp3','Explosion3.mp3'),volume=20)
