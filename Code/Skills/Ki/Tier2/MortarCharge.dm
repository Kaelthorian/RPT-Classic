Skill/Attacks/T2/Mortar_Charge
	UB1="War"
	UB2="Channel"
//	Fatal=1


	icon='16.dmi'
	desc="An explosive one-shot energy attack that takes a few seconds to charge, creates shrapnel on impact. With training its explosiveness and refire speed can increase."

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_STR	= DMGS_TIER_2
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Mortar_Charge()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		usr.Ki=(usr.Ki-EDT)
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.attacking=3
		charging=1
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.5
		Delay += 2
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")

		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		hearers(10,usr)<<sound('ChargeFire.wav',volume=20)
		usr.overlays-=ChargeOver
		flick(usr,"Blast")
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.DMGSOURCE_STR		= 0
		A.DMGSOURCE_OFF		= 0
		A.DMGSOURCE_DEF		= 0
		A.DMGSOURCE_SPD		= 0
		A.DMGSOURCE_END		= 0
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.Belongs_To=usr
		A.Explosive=1
		A.Shrapnel=1
		A.density=1
		A.Radius=1
		if(prob(10)) A.Explosive=2
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.loc=usr.loc
		A.dir=usr.dir
		A.Belongs_To=usr
		A.name=src.name
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MM.DurabilityCheck(usr)
			break
		A.Offense=usr.Off*1.1
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0
