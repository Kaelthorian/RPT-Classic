/*
The object that's put inside the player's inventory. This is NOT the object created upon firing.
Look further down for the actual blast object that triggers Bump()
*/
/*
obj/Blast/var

	Damage
	Fatal=1
	Explosive
	Shockwave
	Piercer
	Paralysis
	Beam
	Shuriken
	Shrapnel //Shrapnel from explosions if any
	Deflectable=1
	Power=1 //BP of the Blast. Force can be obtained by dividing damage by Power.
	Offense=1
	Distance=30

*/
Skill/Attacks/T1/Blast
//	Fatal=1



	var/Spread=1
	var/Seek=0
	icon='1.dmi'
	desc="An attack that becomes more rapid as your skill with it develops"

	DMGT			= 1
	CDT				= CD_TIER_1
	EDT				= 5
	KBT				= KB_TIER_1

	DMGSOURCE_POW	= 1
	DMGSOURCE_STR	= 0
	DMGSOURCE_OFF	= 0
	DMGSOURCE_DEF	= 0
	DMGSOURCE_SPD	= 0
	DMGSOURCE_END	= 0

	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list("SPAMMABLE_V")

	verb/Ki_Settings()
		set category="Other"
		Seek=0
		Shockwave=0
		Spread=input("This allows you to choose the spread level of the Blast ability. 1 is slightly stronger but only travels straight forward. 2 is slightly weaker but shoots 3 blasts at once.") in list(1,2)
		Spread=round(Spread)
		if(Seek==0) switch(input("Do you want your blasts to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
		if(Shockwave==0) switch(input("Do you want your blasts to home towards your target? This will reduce their damage by 25%.") in list("Yes","No"))
			if("Yes") Seek=1
			if("No") Seek=0
		switch(input("Do you want your blasts to destroy walls when they hit?") in list("Yes","No"))
			if("Yes") usr.Destroy_Walls = 1
			if("No") usr.Destroy_Walls = 0
	verb/Blast()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
	//	usr.Learn_Attack()
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
	//	usr.kimanip+=(0.01*usr.kimanipmod)
		if(usr.attacking||usr.Ki<(2.5+Shockwave+Seek)*(Spread+Seek)) return
//		if(!usr.CanAttack((2.5+Shockwave+Seek)*(Spread+Seek))) return
		if(Spread ==0)
			usr.Ki=EnergyCalculation(src,usr)
		else
			usr.Ki=EnergyCalculation(src,usr) / Spread

		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.attacking=3
		usr.Bandages()
		var/Delay = usr.Refire / 14
		Delay += 7
		spawn(Delay) usr.attacking=0
		hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
		if(Spread>1)
			var/obj/ranged/Blast/B=unpool("Blasts")
			B.DMGT				= src.DMGT
			B.DMGSOURCE_POW		= src.DMGSOURCE_POW
			B.DMGSOURCE_STR		= 0
			B.DMGSOURCE_OFF		= 0
			B.DMGSOURCE_DEF		= 0
			B.DMGSOURCE_SPD		= 0
			B.DMGSOURCE_END		= 0
			B.LT				= HEAD
			B.UL				= HEAD
			B.SKILLTRAIT		= src.SKILLTRAIT
			B.Belongs_To=usr
			B.pixel_x=pixel_x
			B.pixel_y=pixel_y
			B.pixel_x+=rand(-16,16)
			B.pixel_y+=rand(-16,16)
			B.icon=src.icon
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MM.DurabilityCheck(usr)
				break
			B.Offense=usr.Off
			if(prob(15)) B.Shockwave=Shockwave
			if(Seek)
				B.HeatSeeking=1
				B.Damage*=0.50
			B.dir=usr.dir
			var/obj/ranged/Blast/C=unpool("Blasts")
			C.DMGT				= src.DMGT
			C.DMGSOURCE_POW		= src.DMGSOURCE_POW
			C.DMGSOURCE_STR		= 0
			C.DMGSOURCE_OFF		= 0
			C.DMGSOURCE_DEF		= 0
			C.DMGSOURCE_SPD		= 0
			C.DMGSOURCE_END		= 0
			C.LT				= HEAD
			C.UL				= HEAD
			C.SKILLTRAIT		= src.SKILLTRAIT
			C.Belongs_To=usr
			C.pixel_x=pixel_x
			C.pixel_y=pixel_y
			C.pixel_x+=rand(-16,16)
			C.pixel_y+=rand(-16,16)
			C.icon=src.icon
			C.Offense=usr.Off
			if(prob(15)) C.Shockwave=Shockwave
			if(Seek)
				C.HeatSeeking=1
				C.Damage*=0.50
			C.dir=usr.dir
			var/obj/ranged/Blast/A=unpool("Blasts")
			flick("Blast",usr)
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW
			A.DMGSOURCE_STR		= 0
			A.DMGSOURCE_OFF		= 0
			A.DMGSOURCE_DEF		= 0
			A.DMGSOURCE_SPD		= 0
			A.DMGSOURCE_END		= 0
			A.LT				= HEAD
			A.UL				= HEAD
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.Belongs_To=usr
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-16,16)
			A.pixel_y+=rand(-16,16)
			A.icon=src.icon
			A.Offense=usr.Off
			if(Seek)
				A.HeatSeeking=1
				A.Damage*=0.50
			if(prob(15)) A.Shockwave=Shockwave

			C.loc=usr.loc
			step(C,turn(usr.dir,-45))
			B.loc=usr.loc
			step(B,turn(usr.dir,45))
			if(usr.HasSmolder)
				A.CausesBurns=1
				B.CausesBurns=1
				C.CausesBurns=1
			if(C)
				C.dir=usr.dir
				walk(C,C.dir)
			if(B)
				B.dir=usr.dir
				walk(B,B.dir)

			if(A)
				A.dir=usr.dir
				A.loc=usr.loc
				walk(A,A.dir)
		else
			var/obj/ranged/Blast/A=unpool("Blasts")
			flick("Blast",usr)
			A.overlays --
//			A.light_power = 5
//			A.light_range = 5
//			A.light_color = "#ffffff"
			A.layer=35
			A.Belongs_To=usr
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW
			A.DMGSOURCE_STR		= 0
			A.DMGSOURCE_OFF		= 0
			A.DMGSOURCE_DEF		= 0
			A.DMGSOURCE_SPD		= 0
			A.DMGSOURCE_END		= 0
			A.LT				= HEAD
			A.UL				= HEAD
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-16,16)
			A.pixel_y+=rand(-16,16)
			A.icon=icon
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MM.DurabilityCheck(usr)
				break
			A.Offense=usr.Off
			if(prob(15)) A.Shockwave=Shockwave
			if(Seek)
				A.HeatSeeking=1
				A.Damage*=0.50
			A.dir=usr.dir
			A.loc=usr.loc
			if(usr.HasSmolder) A.CausesBurns=1
			walk(A,A.dir)
//			A.update_light()


