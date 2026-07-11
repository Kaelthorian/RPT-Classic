Skill/Attacks/ExplosiveDemonWave
//	Fatal=1

	UB1="Arcane Power"
	UB2="Channel"

	icon='27.dmi'
	desc="This attack will charge up for a short while and then release a rain of short range ki blasts. These blasts have increased accuracy."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list("Weak")

	verb/Explosive_Demon_Wave()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		usr.Ki=(usr.Ki-EDT)
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.attacking=3
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*1.4
		Delay +=  30
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
			hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		usr.overlays-=ChargeOver
		var/Amount=30
		while(Amount>0&&!usr.KOd)
			Amount-=1
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.icon=icon
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.LT				= HEAD
			A.UL				= HEAD
			A.Offense=usr.Off
			A.Explosive=1
			A.dir=usr.dir
			A.pixel_x+=rand(-16,16)
			A.HeatSeeking=1
			A.pixel_y+=rand(-16,16)
			if(prob(30)) A.loc=get_step(usr,turn(usr.dir,45))
			else if(prob(30)) A.loc=get_step(usr,turn(usr.dir,45))
			else A.loc=usr.loc
			if(A)
				walk(A,usr.dir,1)
				spawn(5) if(A&&prob(50)) step(A,pick(A.dir+90,A.dir-90))
				spawn(10) if(A&&prob(50)) step(A,pick(A.dir+90,A.dir-90))
			spawn(15) if(A) del(A)
			sleep(10)
			hearers(10,usr) << sound('Blast1.wav',volume=20)
		usr.attacking=0


