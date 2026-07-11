Skill/Unarmed/T2/PressurePunch

	UB2="High Tension"
	UB1="Fists of Fury"

	icon='Shockwave.dmi'
	desc="You strike the air in front of you with an open palm and send a burst of air at your opponent. The attack does a small amount of damage and has a small range, but will stun them for a moment."

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_POW	= ((DMGS_TIER_2*61.9)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_2*38.1)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Pressure_Punch()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		usr.Bandages()
		var/Delay = usr.Refire / 15
		Delay += 50
		spawn(Delay) usr.attacking=0
//		hearers(6,usr) << pick('Blast1.wav','Blast2.wav')
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.DMGSOURCE_OFF		= src.DMGSOURCE_OFF
		A.DMGSOURCE_STR		= 0
		A.DMGSOURCE_DEF		= 0
		A.DMGSOURCE_SPD		= 0
		A.DMGSOURCE_END		= 0
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.Belongs_To=usr
		A.name=src.name
		flick(usr,"Blast")
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-6,6)
		A.pixel_y+=rand(-6,6)
		A.icon=icon
		A.Power=(usr.BP)*Ki_Power
		A.Offense=usr.Off
		A.Paralysis=3

		A.dir=usr.dir
		A.loc=usr.loc
		walk(A,A.dir)
		spawn(6) del(A)


