Skill/Attacks/T2/GuideBomb

	UB1="Channel"

//	Fatal=0
	icon='17.dmi'
	desc="This makes a very powerful guided bomb of energy that explodes on contact. If you can get it \
	to actually hit someone it is a very nice attack. It will move faster and faster as you master it."
	//var/Sokidan_Delay=50

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_POW	= DMGS_TIER_2
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Guide_Bomb()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(Using)
			for(var/obj/ranged/Blast/AA in range(20,usr)) if(AA.Sokidan&&AA.Belongs_To==usr) del(AA)
			Using=0
			for(var/mob/M in range(20,usr)) M.CombatOut("[usr] detonates their [src]!")
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		Using=1
		usr.attacking=3
		var/Delay = usr.Refire
		spawn(Delay) usr.attacking=0
		usr.Ki=(usr.Ki-EDT)
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.DMGSOURCE_STR		= 0
		A.DMGSOURCE_OFF		= 0
		A.DMGSOURCE_DEF		= 0
		A.DMGSOURCE_SPD		= 0
		A.DMGSOURCE_END		= 0
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.Belongs_To=usr
		A.name=src.name
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.Sokidan=1
		A.icon=icon
		A.loc=get_step(usr,NORTH)
		A.Explosive=1
		A.Shockwave=1
		A.Piercer=0
		A.maxSteps=100
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")

//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MM.DurabilityCheck(usr)
			break
		A.Offense=usr.Off
		Delay =  2
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		sleep(Delay)
		if(A)
			A.density=0
			flick("Blast",usr)
			spawn(20) if(usr)
				usr.attacking=0
				Using=0
			while(A.z&&usr)
				Using=1
				step(A,usr.dir)
				if(A) A.density=1
				sleep((1)+pick(0,0,1))
			Using=0
		Using=0
		hearers(10,usr)<<sound('ChargeFire.wav',volume=20)



