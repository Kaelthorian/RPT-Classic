Skill/Attacks/T2/Barrage
//	Fatal=0
	UB1="Channel"
//	UB2=


	icon='1.dmi'
	desc="An attack that becomes more rapid as your skill with it develops, and shoots in multiple directions easily. Fires seven volleys before going on CD."

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_POW	= 1
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Ki_Settings()
		set category="Other"
		switch(input("Do you want your blasts to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
	verb/Barrage()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		var/Delay = usr.Refire / 15
		var/Charges=5//number of volleys fired
		var/MaskDamage=0
		var/MaxSwordPercent=100

		if(usr.HasWeaponizedKi)
			for(var/obj/items/Sword/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			for(var/obj/items/Hammer/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			for(var/obj/items/Gauntlets/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			if(usr.BoundWeaponOn) MaskDamage=usr.BP*(0.4+(usr.BoundWeaponOn*0.1))
			if(usr.KiBlade)
				if(usr.HasBladeOfLight) MaskDamage=usr.BP*0.4
				else MaskDamage=usr.BP*0.3
			if(usr.KiHammer)
				MaskDamage=usr.BP*0.6
			if(usr.SpiritSword)
				MaskDamage=usr.BP*0.7
			if(usr.KiFists) if(MaskDamage<=usr.BP*0.18)
				MaskDamage=usr.BP*0.18


			if(usr.MaskOn)
				for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
					MaskDamage=MM.Health
					MM.DurabilityCheck(usr)
					break
				if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			if(MaskDamage>(MaxSwordPercent/100)*usr.BP) MaskDamage=(MaxSwordPercent/100)*usr.BP

		while(usr.attacking==3&&usr.KOd==0&&Charges)

			Charges--
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
			B.name=src.name
			B.pixel_x=pixel_x
			B.pixel_y=pixel_y
			B.pixel_x+=rand(-16,16)
			B.pixel_y+=rand(-16,16)
			B.icon=icon
			//B.HeatSeeking=1
			B.Offense=usr.Off
			if(prob(10)) B.Shockwave=Shockwave
			B.dir=usr.dir
			B.loc=get_step(usr,turn(usr.dir,45))
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
			C.name=src.name
			C.pixel_x=pixel_x
			C.pixel_y=pixel_y
			C.pixel_x+=rand(-16,16)
			C.pixel_y+=rand(-16,16)
			C.icon=icon
			//C.HeatSeeking=1
			C.Offense=usr.Off
			if(prob(10)) C.Shockwave=Shockwave
			C.dir=usr.dir
			C.loc=get_step(usr,turn(usr.dir,-45))
			var/obj/ranged/Blast/D=unpool("Blasts")
			D.DMGT				= src.DMGT
			D.DMGSOURCE_POW		= src.DMGSOURCE_POW
			D.DMGSOURCE_STR		= 0
			D.DMGSOURCE_OFF		= 0
			D.DMGSOURCE_DEF		= 0
			D.DMGSOURCE_SPD		= 0
			D.DMGSOURCE_END		= 0
			D.LT				= HEAD
			D.UL				= HEAD
			D.SKILLTRAIT		= src.SKILLTRAIT
			D.Belongs_To=usr
			D.name=src.name
			D.pixel_x=pixel_x
			D.pixel_y=pixel_y
			D.pixel_x+=rand(-16,16)
			D.pixel_y+=rand(-16,16)
			D.icon=icon
			//D.HeatSeeking=1
			D.Offense=usr.Off
			if(prob(10)) D.Shockwave=Shockwave
			D.dir=usr.dir
			D.loc=get_step(get_step(usr,turn(usr.dir,-45)),turn(usr.dir,-90))
			var/obj/ranged/Blast/E=unpool("Blasts")
			E.DMGT				= src.DMGT
			E.DMGSOURCE_POW		= src.DMGSOURCE_POW
			E.DMGSOURCE_STR		= 0
			E.DMGSOURCE_OFF		= 0
			E.DMGSOURCE_DEF		= 0
			E.DMGSOURCE_SPD		= 0
			E.DMGSOURCE_END		= 0
			E.LT				= HEAD
			E.UL				= HEAD
			E.SKILLTRAIT		= src.SKILLTRAIT
			E.Belongs_To=usr
			E.name=src.name
			E.Belongs_To=usr
			E.pixel_x=pixel_x
			E.pixel_y=pixel_y
			E.pixel_x+=rand(-16,16)
			E.pixel_y+=rand(-16,16)
			E.icon=icon
			//E.HeatSeeking=1
			E.Offense=usr.Off
			if(prob(10)) D.Shockwave=Shockwave
			E.dir=usr.dir
			E.loc=get_step(get_step(usr,turn(usr.dir,45)),turn(usr.dir,90))
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			flick(usr,"Blast")
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
			//A.HeatSeeking=1
			A.Offense=usr.Off
			if(prob(10)) A.Shockwave=Shockwave
			A.dir=usr.dir
			A.loc=usr.loc
			if(usr.HasSmolder)
				A.CausesBurns=1
				B.CausesBurns=1
				C.CausesBurns=1
				D.CausesBurns=1
				E.CausesBurns=1
			walk(A,A.dir)
			walk(B,B.dir)
			walk(C,C.dir)
			walk(D,D.dir)
			walk(E,E.dir)
			sleep(Delay)
			hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
			hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
			hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
		spawn(Delay) usr.attacking=0


