Skill/Attacks/Genocide
	UB1="Death"
	UB2="Fungal Plague"

	NoMove=0

	icon='18.dmi'
	var/Charges=20
	desc="This attack lasts for 20 blasts.  Turning it on will cause you to start firing blasts towards your selected target until you run out of charges. These blasts will home."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= ((DMGS_TIER_2*74.6)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_2*25.4)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Genocide()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(!charging)
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<10) return
			CD=CDCalculation(src,usr)
			CDTick(usr)
			var/mob/Targ=usr.Target
			if(!usr.Target)
				CD=0
				return
			if(Targ.z==usr.z)
				charging=1
				usr.overlays+='SBombGivePower.dmi'
				usr.attacking=4
				Charges=20
				for(var/mob/M in range(20,usr))
					M.CombatOut("[usr] begins to charge a [src]!")
					hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
				sleep(150/usr.Refire)
				while(charging&&usr.KOd==0&&usr.Ki>15&&Targ&&Charges)
					Charges--
					var/obj/ranged/Blast/A=unpool("Blasts")
					A.DMGT				= src.DMGT
					A.DMGSOURCE_POW		= src.DMGSOURCE_POW/20
					A.DMGSOURCE_OFF		= src.DMGSOURCE_OFF/20
					A.SKILLTRAIT		= src.SKILLTRAIT
					A.LT				= HEAD
					A.UL				= HEAD
					A.Belongs_To=usr
					A.name=src.name
					A.pixel_x=pixel_x
					A.pixel_y=pixel_y
					A.pixel_x+=rand(-16,16)
					A.pixel_y+=rand(-16,16)
					A.icon=icon
					A.HeatSeeking=1
					A.Offense=usr.Off
					A.loc=usr.loc
					A.dir=NORTH
					walk(A,get_dir(src,Targ),1)
//					usr.Ki=(usr.Ki-EDT)
					hearers(10,usr)<<sound('ChargeFire.wav',volume=20)
					sleep(rand(2,8))

				usr.overlays-='SBombGivePower.dmi'
				usr.attacking=0
				charging=0
			else CD=0
		else charging=0
