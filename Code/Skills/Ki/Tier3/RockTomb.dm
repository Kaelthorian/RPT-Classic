Skill/Attacks/T3/RockTomb
	UB1="High Tension"


	var/Master=0
	icon='Meteor.dmi'
	pixel_x=-15
	pixel_y=-15
	desc="You throw a rock at your opponent and deal damage with your strength. When masterd this rock explodes!"

//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list("WINDUP_V")

	verb/Rock_Tomb()
		set category="Skills"
		if(Master==0)
			if(SkillSafeCheckKi(usr,src))
				//TESTINGREPLACE
				return
			CD=CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki=(usr.Ki-EDT)
			usr.attacking=3
			usr.Bandages()
			spawn(usr.Refire) usr.attacking=0
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			flick(usr,"Blast")
			A.DMGT				= src.DMGT
			A.DMGSOURCE_STR		= ((DMGS_TIER_3*51)/100)
			A.DMGSOURCE_POW		= ((DMGS_TIER_3*49)/100)
			A.DMGSOURCE_OFF		= 0
			A.DMGSOURCE_DEF		= 0
			A.DMGSOURCE_SPD		= 0
			A.DMGSOURCE_END		= 0
			A.WEAPON			= NO
			A.LT				= HEAD
			A.UL				= HEAD
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-6,6)
			A.pixel_y+=rand(-6,6)
			A.icon=icon
			A.name=src.name
			A.Offense=usr.Off
			animate(A, transform = matrix()*2, time=3)
			A.Radius=1
			A.Explosive=2
			A.Shrapnel=1
			A.Shockwave=1
			A.dir=usr.dir
			A.loc=usr.loc
			hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
			walk(A,A.dir)
			spawn(12) del(A)