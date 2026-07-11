Skill/Attacks/T2/EchoingSlash
//	Fatal=1

	UB1="Bushido"
	icon='BlastKiShuriken.dmi'
	desc="You use your weapon to launch an attack that creates a shockwave.  If the shockwave hits an enemy they will begin to bleed."


//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_STR	= ((DMGS_TIER_2*42.9)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_2*57.1)/100)
	WEAPON			= NO
	SKILLTRAIT		= list()

	verb/Echoing_Slash()
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		usr.Ki=(usr.Ki-EDT)
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.attacking=3
		charging=1
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		usr.overlays+='blackflameaura.dmi'
		var/Delay = usr.Refire
		Delay += 1
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		hearers(10,usr)<<sound('ChargeFire.wav',volume=20)
		usr.overlays-='blackflameaura.dmi'
		flick("Blast",usr)
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To		=usr
		A.icon				=icon
		A.name				=src.name
		A.DMGT				= src.DMGT
		A.DMGSOURCE_STR		= src.DMGSOURCE_STR
		A.DMGSOURCE_SPD		= src.DMGSOURCE_SPD
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.ChainTrigger		=1
		A.Deflectable		=0
		A.pixel_x			=pixel_x
		A.pixel_y			=pixel_y
		A.dir				=usr.dir
		A.loc				=usr.loc
//		walk(A,usr.dir,1)
		walk(A,A.dir)
		usr.attacking=0
		charging=0
