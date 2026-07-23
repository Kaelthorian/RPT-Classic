Skill/Attacks/T2/SpiritBall
	UB1="Channel"
	UB2="Arcane Power"


//	Fatal=0
	icon='17.dmi'
	desc="Very similar to sokidan except it is controlled by clicking the map."
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

	verb/Spirit_Ball()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(!usr.Target||usr.Target.z!=usr.z)
			usr<<"You must have a target on the same plane."
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		Using=1
		usr.attacking=3
		usr.Ki=(usr.Ki-EDT)
		var/obj/ranged/Blast/SpiritBall/A=unpool("SpiritBall")
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
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.icon=icon
		A.name=src.name
		A.loc=get_step(usr,usr.dir)
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MM.DurabilityCheck(usr)
			break
		A.Offense=usr.Off
		spawn(usr.Refire*0.5) if(usr) usr.attacking=0
		Using=0
		var/Delay = usr.Refire
		Delay +=  5
		sleep(Delay)
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		if(A)
	//		A.SpiritBall=1
			flick("Blast",usr)
			walk_towards(A,usr.Target)
		spawn(80*(5))
			Using=0
			del(A)
		hearers(10,usr)<<sound('ChargeFire.wav',volume=20)

obj/ranged/Blast/SpiritBall
	Explosive=1
	density=1
//	var/SpiritBall=0