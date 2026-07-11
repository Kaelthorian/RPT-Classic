Skill/Attacks/T1/RockSlide
	UB1="High Tension"


	icon='bouldertest2.dmi'
	pixel_x=-16
	pixel_y=-16
	desc="You throw lots of rocks at your opponent and deal damage with your strength. Each projectile is slightly weaker than Rock Throw."

//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_POW	= ((DMGS_TIER_1*14.3)/100)
	DMGSOURCE_STR	= ((DMGS_TIER_1*85.7)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Rock_Slide()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=EnergyCalculation(src,usr)
		usr.attacking=3
		usr.Bandages()
		spawn(usr.Refire) usr.attacking=0
//		hearers(6,usr) << pick('Blast1.wav','Blast2.wav')
		var/amount=7
		if(amount>15)amount=15
		var/nextdir=0
		while(amount)
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			flick(usr,"Blast")
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW/amount
			A.DMGSOURCE_STR		= src.DMGSOURCE_STR/amount
			A.DMGSOURCE_OFF		= 0
			A.DMGSOURCE_DEF		= 0
			A.DMGSOURCE_SPD		= 0
			A.DMGSOURCE_END		= 0
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.LT				= HEAD
			A.UL				= HEAD
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-6,6)
			A.pixel_y+=rand(-6,6)
			A.icon=icon
			A.name=src.name
			A.Offense=usr.Off
			A.Shockwave=1
			A.dir=usr.dir
			A.loc=usr.loc
			//walk(A,A.dir)
			nextdir++
			if(nextdir>5)nextdir=1
			switch(nextdir)
				if(5)
					if(A) step(A,turn(A.dir,45))
					if(A) step(A,A.dir)
					if(A) walk(A,usr.dir)
				if(4)
					if(A) step(A,turn(A.dir,-45))
					if(A) step(A,A.dir)
					if(A) walk(A,usr.dir)
				if(3)
					if(A) step(A,turn(A.dir,pick(-45,45)))
					if(A) walk(A,usr.dir)
				if(2)
					if(A) step(A,turn(A.dir,pick(-45,45)))
					if(A) walk(A,usr.dir)
				if(1) walk(A,A.dir)
			amount-=1
			sleep(2)
