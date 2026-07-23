Skill/Attacks/T3/Earthquake
	UB1="Fungal Plague"
	UB2="Death"


	desc="An area of effect attack that does Offense based damage and knocks back people in the area. (9 Targets Max)"


//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= DMGS_TIER_2
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Earthquake()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		charging=1
		BigShockwave(usr)
		Crater(usr)
		hearers(10,usr) << sound(pick('Explosion1.mp3','Explosion2.mp3','Explosion3.mp3','Explosion4.mp3'),volume=20)
		//var/maxHit=9
		//spawn if(usr) for(var/turf/T in oview(usr,3)) if(prob(30)&&!T.density&&!T.Water)FightingDirt(T)
		spawn if(usr) for(var/mob/P in oview(usr,3)) if(P!=usr) if(!P.afk&&!P.RPMode)//if(maxHit>0)
			//maxHit--
			/*if(prob(30))
				var/Distance=round((usr.Str/P.End)*(usr.BP/P.BP))
				if(Distance>5) Distance=5
				P.Shockwave_Knockback(Distance,usr.loc)*/
			P.Flight_Land()
			P.Injure_Hurt(1.5*((usr.BP*usr.Off)/(P.BP*P.End)),"Legs",usr)
			var/Damage=DamageCalculator(usr,P,src)
			P.TakeDamage(usr,Damage, "Earthquake")
			P.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
			P.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
			sleep(0)
		spawn(100/(max(20,50))) if(usr)
			usr.attacking=0
			charging=0