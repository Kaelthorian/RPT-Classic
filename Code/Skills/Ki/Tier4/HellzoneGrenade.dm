Skill/Attacks/Hellzone_Grenade
	UB1="Arcane Power"
	UB2="Channel"
	icon='15.dmi'

	desc="This ki attack is a high damage shot that upon impact causes a double wave of explosions."


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Hellzone_Grenade()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=(1+Modifier(usr))/CDT
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		charging=1
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.3
		Delay += 4
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
		var/obj/ranged/Blast/A=unpool("Blasts")//HellzoneGrenade
		A.DMGT				= DMG_TIER_1
		A.CDT				= CD_TIER_1
		A.EDT				= ED_TIER_1
		A.KBT				= KB_TIER_1
		A.DMGSOURCE_POW		= DMGS_TIER_4
		A.WEAPON			= NO
		A.LT				= HEAD
		A.UL				= HEAD
		A.name=src.name
		A.Belongs_To=usr
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.Offense=usr.Off
		A.Explosive=1
		A.Explosive=1
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,1)
		usr.attacking=0