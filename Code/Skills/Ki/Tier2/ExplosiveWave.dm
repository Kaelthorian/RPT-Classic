Skill/Attacks/T2/ExplosiveWave
	UB1="Channel"


	desc="An area of effect attack that does Offense based damage and knocks back people in the area. (9 Targets Max)"

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_POW	= DMGS_TIER_1
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()


	verb/Explosive_Wave()
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
	//	var/maxHit=9
		//spawn if(usr) for(var/turf/T in oview(usr,3)) if(prob(30)&&!T.density&&!T.Water)FightingDirt(T)
		spawn if(usr) for(var/mob/P in oview(usr,3)) if(P!=usr) if(!P.afk&&!P.RPMode)//if(maxHit>0)
		//	maxHit--
			/*if(prob(10))
				var/Distance=round((usr.Pow/P.End)*(usr.BP/P.BP))
				if(Distance>5) Distance=5
				P.Shockwave_Knockback(Distance,usr.loc)*/
			P.Flight_Land()
			P.Injure_Hurt(1.5*((usr.BP*usr.Off)/(P.BP*P.End)),"Ears",usr)
			var/Damage=DamageCalculator(usr,P,src)
			P.TakeDamage(usr, Damage, "Explosive Wave")
			P.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
			P.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
			sleep(0)
		spawn(100/(max(20,50))) if(usr)
			usr.attacking=0
			charging=0
