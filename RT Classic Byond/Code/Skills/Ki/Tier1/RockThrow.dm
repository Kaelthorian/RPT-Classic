Skill/Attacks/T1/RockThrow


	var/Spread=0
	icon='bouldertest2.dmi'
	pixel_x=-16
	pixel_y=-16
	desc="You throw a rock at your opponent and deal damage with your strength."
	verb/Ki_Settings()
		set category="Other"
		switch(input("Do you want your Rock Throws to be similar to blast and have lower damage but no cooldown?") in list("Yes","No"))
			if("Yes") Spread=1
			if("No") Spread=0

//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_POW	= ((DMGS_TIER_1*85.7)/100)
	DMGSOURCE_STR	= ((DMGS_TIER_1*14.3)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Rock_Throw()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(!Spread)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki=EnergyCalculation(src,usr)
			usr.attacking=3
			usr.Bandages()
			spawn(usr.Refire) usr.attacking=0
			hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			flick(usr,"Blast")
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW
			A.DMGSOURCE_STR		= src.DMGSOURCE_STR
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
			A.Offense=usr.Off
			A.Shockwave=1
			A.dir=usr.dir
			A.loc=usr.loc
			walk(A,A.dir)
			spawn(6) del(A)
		else
			/*CD=(usr.Refire*0.05)/(max(0.7,Experience/100))
			CDTick(usr)*/

			usr.DrainKi(src,1,16)//usr.Ki=max(0,usr.Ki-75)
			usr.attacking=3
			usr.Bandages()
			var/Delay = usr.Refire / 14
			Delay += 7
			spawn(Delay) usr.attacking=0
			hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			flick(usr,"Blast")
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-6,6)
			A.pixel_y+=rand(-6,6)
			A.icon=icon
			A.Offense=usr.Off
			A.Shockwave=1
			A.dir=usr.dir
			A.loc=usr.loc
			var/obj/ranged/Blast/B=unpool("Blasts")
			B.Belongs_To=usr
			B.name=src.name
			flick(usr,"Blast")
			B.pixel_x=pixel_x
			B.pixel_y=pixel_y
			B.pixel_x+=rand(-6,6)
			B.pixel_y+=rand(-6,6)
			B.icon=icon
			B.Offense=usr.Off
			B.Shockwave=1
			B.dir=usr.dir
			B.loc=get_step(usr,turn(usr.dir,-45))
			var/obj/ranged/Blast/C=unpool("Blasts")
			C.Belongs_To=usr
			C.name=src.name
			flick(usr,"Blast")
			C.pixel_x=pixel_x
			C.pixel_y=pixel_y
			C.pixel_x+=rand(-6,6)
			C.pixel_y+=rand(-6,6)
			C.icon=icon
			C.Offense=usr.Off
			C.Shockwave=1
			C.dir=usr.dir
			C.loc=get_step(usr,turn(usr.dir,45))
			walk(B,B.dir)
			walk(C,C.dir)
			spawn(7)
				del(B)
				del(C)
			walk(A,A.dir)
			spawn(6) del(A)

