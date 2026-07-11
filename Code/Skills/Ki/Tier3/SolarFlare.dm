Skill/Attacks/T3/SolarFlare
	UB1="Kaioken"


	desc="Solar Flare blinds an Opp for a limited amount of time. \
	The amount of time the person is blinded depends on their regeneration. It is mainly used so \
	that they dont see what direction you went in, and so that they cant pursue you until they can \
	see again"
	var/DistancePick=1

//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Solar_Flare()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(!usr.attacking)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			usr.attacking=3
			usr.Ki=(usr.Ki-EDT)
			var/distance=DistancePick
			if(distance>=20) distance=20
			if(distance<=1) distance=1
			for(var/turf/A in orange(usr,distance)) A.Self_Destruct_Lightning(5)
			sleep(5)
			hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
			for(var/mob/A in orange(usr,distance))if(!A.afk)
				CD=(1+Modifier(usr))/CDT
				CDTick(usr)

				if(A.SolarFlareHit(usr,A,distance))

					A.SolarFlare(distance)
					A<<"You are blinded by [usr]'s Taiyoken"
					var/BodyPart/Eyes/L =locate(/BodyPart/Eyes) in A
					var/DamageD=DamageCalculator(usr,A,src)
					if(A.Critical_Sight == 0) A.Injure_Hurt(DamageD,L,usr)
				else A<<"You managed to avoid looking at the solar flare."


			spawn(usr.Refire) usr.attacking=0
		else CD=5
	verb/Solar_flare_Distance()
		DistancePick=input("set the range of the skill") as num
		if(DistancePick>=20) DistancePick=20
		if(DistancePick<=1) DistancePick=1


mob/proc/SolarFlareHit(mob/U,mob/T,distance)
	var/didHit=0
	if(get_dir(T, U)==T.dir)didHit=1
	if(get_dir(T, U)==turn(T.dir, 45))didHit=1
	if(get_dir(T, U)==turn(T.dir, -45))didHit=1
	if(get_dist(T, U)<= 1)didHit=1
	return didHit

obj
	Taiyoken
		icon='Taiyoken.dmi'
		layer=999
mob/proc/SolarFlare(var/Power)
	var/duration=20*Power
	SolarFlared=1
	if(duration<20)duration=20
	if(duration>200)duration=200
	var/obj/x=new/obj/Taiyoken
	x.screen_loc="1,1 to 25,25"
	src.client.screen+=x
	spawn(20)src.client.screen-=x
	spawn(30)src.client.screen-=x
	while(prob(90))
		x.icon_state=pick("1","2","3","4")
		if(prob(40))sleep(0.1)
	while(prob(80))
		x.icon_state=pick("5","6","7","8")
		if(prob(40))sleep(0.1)
	while(prob(70))
		x.icon_state=pick("9","10","11","12")
		if(prob(40))sleep(0.1)
	while(prob(80))
		x.icon_state=pick("13","14","15","16")
		if(prob(40))sleep(0.1)
	while(prob(90))
		x.icon_state=pick("17","18","19","20")
		if(prob(40))sleep(0.1)
	src.client.eye=null
	SolarFlared=0
	spawn(duration)src.client.eye=src