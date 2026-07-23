Skill/Attacks/WallofFlame
	UB1="War"
	UB2="Kaioken"


	icon='a fire blast.dmi'
	desc="Creates 3 to 9 tiles, based on experience, of flame in front of you. These tiles will last for 30 seconds and damage and stun anyone that bumps them."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= ((DMGS_TIER_4*57.7)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_4*42.3)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Wall_of_Flame()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.5
		Delay +=  0.5
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
			hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		sleep(Delay)
		usr.attacking=0
		usr.overlays-=ChargeOver
		var/Amount=10
		while(Amount)
			Amount-=1
			var/obj/ranged/Blast/A=unpool("Blasts")
			hearers(10,usr)<<sound('ChargeFire.wav',volume=20)
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW/10
			A.DMGSOURCE_OFF		= src.DMGSOURCE_OFF/10
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.LT				= HEAD
			A.UL				= HEAD
			A.Belongs_To=usr
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.Offense=usr.Off
			A.dir=usr.dir
			if(Amount<=2) A.loc=get_step(usr,usr.GetCleave(usr.dir,Amount))
			else if(Amount<=5)A.loc=get_step(get_step(get_step(get_step(usr,turn(usr.dir,-90)),turn(usr.dir,-90)),turn(usr.dir,-90)),usr.GetCleave(usr.dir,Amount-3))
			else if(Amount<=8)A.loc=get_step(get_step(get_step(get_step(usr,turn(usr.dir,90)),turn(usr.dir,90)),turn(usr.dir,90)),usr.GetCleave(usr.dir,Amount-6))
			A.Paralysis=6
			A.density=0
			spawn() while(A)
				A.density=0
				for(var/mob/M in view(0,A))
					if(M!=A.Belongs_To)
						A.density=1
						A.Bump(M)
				sleep(2)
			spawn(250) if(A) del(A)
			sleep(1)
		usr.attacking=0








