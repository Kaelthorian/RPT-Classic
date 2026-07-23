Skill/Attacks/KillDriver
	UB1="Death"
	UB2="War"


	pixel_x=-15
	pixel_y=-15
	icon='Kill_Driver_21.dmi'
	desc="A blast that homes towards your target and stuns then as well as applying 5 ticks of stagger."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= ((DMGS_TIER_4*57.7)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_4*16.9)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_4*25.4)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Kill_Driver()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		usr.Bandages()
		var/Delay = 1
		spawn(Delay) usr.attacking=0
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
		flick(usr,"Blast")
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.DMGSOURCE_SPD		= src.DMGSOURCE_SPD
		A.DMGSOURCE_OFF		= src.DMGSOURCE_OFF
		A.DMGSOURCE_STR		= 0
		A.DMGSOURCE_DEF		= 0
		A.DMGSOURCE_END		= 0
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-6,6)
		A.pixel_y+=rand(-6,6)
		A.icon=icon
		A.Offense=usr.Off
		A.Stagger=5
		A.HeatSeeking=1
		A.Paralysis=5
		A.dir=usr.dir
		A.loc=usr.loc
		hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
		walk(A,A.dir)






