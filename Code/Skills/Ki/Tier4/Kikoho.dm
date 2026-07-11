Skill/Attacks/TriBeam
//	Fatal=1
	UB1="Channel"
	UB2="Fungal Plague"


	icon='16.dmi'
	desc="This is a very high power blast attack with a short delay that is explosive and is three tiles, but causes damage to the user."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Kikoho()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.TakeDamage(usr, (rand(5,10)-round(2)), "Firing TriBeam")
		usr.Injure_Hurt(rand(5,10)-round(2),"Random",src)
		usr.attacking=3
		charging=1
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.2
		Delay += 2
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		hearers(10,usr) << sound('KikohoCharge.wav',volume=20)
		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		hearers(10,usr) << sound('KikohoFire.wav',volume=20)
		usr.overlays-=ChargeOver
		flick(usr,"Blast")
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.Belongs_To=usr
		A.Explosive=1
		A.density=1
		A.Radius=1
		A.name=src.name
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.loc=usr.loc
		A.dir=usr.dir
		A.Explosive=1
		A.Offense=usr.Off
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0
		spawn(100) if(usr.Health<0&&prob(10)) usr.Death(usr)
