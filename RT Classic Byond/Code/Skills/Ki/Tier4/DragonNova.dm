Skill/Attacks/Dragon_Nova

	UB1="Channel"
//	Fatal=1

	icon='16.dmi'
	desc="A giant charged energy ball. It is very powerful, and very explosive. It is very similar to \
	TriBeam but does not drain health, and due to that, it is a bit weaker, but still much stronger \
	than charge. It is quite a good finishing attack."


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Dragon_Nova()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		charging=1
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		for(var/mob/M in range(20,usr)) M.CombatOut("[usr] begins to charge a [src]!")
		sleep((usr.Refire)/(max(1,4)))
		usr.overlays-=ChargeOver
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.icon=icon
		A.Explosive=1
		A.density=1
		A.Radius=1
		A.name=src.name
		A.DMGT				= src.DMGT
		A.DMGSOURCE_POW		= src.DMGSOURCE_POW
		A.SKILLTRAIT		= src.SKILLTRAIT
		A.LT				= HEAD
		A.UL				= HEAD
		A.Offense=usr.Off
		A.loc=usr.loc
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0
//		spawn(100) if(usr.Health<0&&prob(10)) usr.Death(usr)