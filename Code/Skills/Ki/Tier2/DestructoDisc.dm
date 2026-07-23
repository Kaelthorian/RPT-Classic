Skill/Attacks/T2/DestructoDisc
//	Fatal=1


	NoMove=1
	icon='Blast - Destructo Disk.dmi'
	desc="This attack is much like Charge at its core with some differences. Destructo_Disc takes longer to charge, is completely undeflectable, has a higher velocity, it is slightly more powerful than Charge, it also drains much more energy to use."
	UB1="Channel"

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_POW	= ((DMGS_TIER_2*81)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_2*19)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Destructo_Disc()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		charging=1
		var/image/O=image(icon=icon,pixel_y=24)
		usr.overlays+=O
		hearers(10,usr) << sound('DestructoDiskCharge.mp3',volume=20)
		var/Delay = usr.Refire
		Delay += 3
		for(var/mob/M in range(20,usr)) M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		usr.overlays-=O
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.DMGSOURCE_OFF		= src.DMGSOURCE_OFF
		A.DMGSOURCE_STR		= 0
		A.DMGSOURCE_DEF		= 0
		A.DMGSOURCE_SPD		= 0
		A.DMGSOURCE_END		= 0
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.Belongs_To=usr
		A.name=src.name
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		flick(usr,"Blast")
		hearers(10,usr) << sound('DestructoDiskFire.mp3',volume=20)
		A.Deflectable=0
		A.icon=icon
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MM.DurabilityCheck(usr)
			break
		A.Offense=usr.Off
		A.Explosive=0
		A.Explosive=1
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,1)
		usr.attacking=0
		charging=0

