Skill/Attacks/T4/SkyBreak
	UB1="Bushido"
//	Fatal=1


	pixel_x=-32
	icon='blackslash.dmi'
	desc="A massive and wickedly destructive technique that uses a weapon to break the speed of sound and unleash a terrifying blast. Strength based damage, requires a weapon."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= ((DMGS_TIER_4*57.7)/100)
	DMGSOURCE_POW	= ((DMGS_TIER_4*16.9)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_4*25.4)/100)
	WEAPON			= NO

	verb/Sky_Break()
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		charging=1
		usr.overlays+='blackflameaura.dmi'
		var/Delay = usr.Refire
		for(var/mob/M in range(20,usr)) M.CombatOut("[usr] begins to charge a [src]!")
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		sleep(Delay)
		usr.overlays-='blackflameaura.dmi'
		flick("Blast",usr)
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.Explosive=1
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.dir=usr.dir
		A.loc=usr.loc
		spawn(2)A.Radius=2
		A.DMGSOURCE_STR	= ((DMGS_TIER_4*57.7)/100)
		A.DMGSOURCE_POW	= ((DMGS_TIER_4*16.9)/100)
		A.DMGSOURCE_SPD	= ((DMGS_TIER_4*25.4)/100)
		A.Offense=usr.Off
		hearers(10,usr)<<sound('ChargeFire.wav',volume=20)
		A.Explosive=1
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0






