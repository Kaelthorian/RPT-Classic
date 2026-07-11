Skill/Attacks/T1/Shockwave


	icon='Shockwave.dmi'
	desc="You send out a blast of air that is designed to knockback your opponent. The attack does a small amount of damage and has a small range, but will send your opponent flying."

//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_POW	= ((DMGS_TIER_1*42.9)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_1*28.6)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_1*28.6)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Shockwave()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)

		usr.Ki=EnergyCalculation(src,usr)
		usr.attacking=3
		usr.Bandages()
		var/Delay = usr.Refire / 15
		Delay += 1
		spawn(Delay) usr.attacking=0
		hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)



		var/obj/ranged/Blast/B=unpool("Blasts")
		B.Belongs_To=usr
		B.name=src.name
		flick(usr,"Blast")
		B.DMGT				= src.DMGT
		B.DMGSOURCE_POW		= src.DMGSOURCE_POW
		B.DMGSOURCE_SPD		= src.DMGSOURCE_SPD
		B.DMGSOURCE_OFF		= src.DMGSOURCE_OFF
		B.DMGSOURCE_STR		= 0
		B.DMGSOURCE_DEF		= 0
		B.DMGSOURCE_END		= 0
		B.SKILLTRAIT		= src.SKILLTRAIT
		B.LT				= HEAD
		B.UL				= HEAD
		B.pixel_x=pixel_x
		B.pixel_y=pixel_y
		B.pixel_x+=rand(-6,6)
		B.pixel_y+=rand(-6,6)
		B.icon=icon
		B.Offense=usr.Off
		B.Shockwave=3
		B.Stagger=1
		B.dir=usr.dir
		B.Radius=1
		B.loc=get_step(usr,turn(usr.dir,45))

		var/obj/ranged/Blast/C=unpool("Blasts")
		C.Belongs_To=usr
		C.name=src.name
		flick(usr,"Blast")
		C.DMGT				= src.DMGT
		C.DMGSOURCE_POW		= src.DMGSOURCE_POW
		C.DMGSOURCE_SPD		= src.DMGSOURCE_SPD
		C.DMGSOURCE_OFF		= src.DMGSOURCE_OFF
		B.DMGSOURCE_STR		= 0
		B.DMGSOURCE_DEF		= 0
		B.DMGSOURCE_END		= 0
		C.SKILLTRAIT		= src.SKILLTRAIT
		C.LT				= HEAD
		C.UL				= HEAD
		C.pixel_x=pixel_x
		C.pixel_y=pixel_y
		C.pixel_x+=rand(-6,6)
		C.pixel_y+=rand(-6,6)
		C.icon=icon
		C.Damage=0.15*usr.BP*usr.Pow*Ki_Power  //200
		C.Power=(usr.BP)*Ki_Power
		C.Offense=usr.Off*2
		C.Shockwave=3
		C.Stagger=1
		//C.Piercer=1
		C.dir=usr.dir
		C.loc=get_step(usr,turn(usr.dir,-45))

		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
		flick(usr,"Blast")
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.DMGSOURCE_SPD		= src.DMGSOURCE_SPD
		A.DMGSOURCE_OFF		= src.DMGSOURCE_OFF
		B.DMGSOURCE_STR		= 0
		B.DMGSOURCE_DEF		= 0
		B.DMGSOURCE_END		= 0
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-6,6)
		A.pixel_y+=rand(-6,6)
		A.icon=icon
		A.Damage=0.15*usr.BP*usr.Pow*Ki_Power  //200
		A.Power=(usr.BP)*Ki_Power
		A.Offense=usr.Off*2
		A.Shockwave=3
		A.Stagger=1
		//A.Piercer=1
		A.dir=usr.dir
		A.loc=usr.loc
		A.name=src.name
		B.name=src.name
		C.name=src.name

		walk(A,A.dir)
		walk(B,B.dir)
		walk(C,C.dir)
		spawn(20)
			del(C)
			del(B)
			del(A)
