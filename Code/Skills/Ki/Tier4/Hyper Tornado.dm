Skill/Attacks/HyperTornado
	UB1="Godspeed"
//	Fatal=1


	pixel_x=-32
	pixel_y=-16
	icon='Twister_Aura-2.dmi'
	desc="This attack unleashes several tornados that after a short delay will spin up and then home towards your target. Damage based on Speed."

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= ((DMGS_TIER_4*15.3)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_4*67.7)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_4*16.9)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Hyper_Tornado()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)
		usr.attacking=3
		charging=1
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*3
		Delay += 5
		var/amount=1
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		hearers(10,usr)<<sound('ChargeFire.wav',volume=20)
		usr.overlays-=ChargeOver
		charging=0
		while(amount)
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.density=1
			//A.Radius=1
			A.Shockwave=1
			A.name=src.name
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.icon=icon
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW
			A.DMGSOURCE_SPD		= src.DMGSOURCE_SPD
			A.DMGSOURCE_OFF		= src.DMGSOURCE_OFF
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.LT				= HEAD
			A.UL				= HEAD
			A.Offense=usr.Off
			if(amount==1) A.dir=usr.dir
			if(amount==2) A.dir=turn(usr.dir,90)
			if(amount==3) A.dir=turn(usr.dir,-90)
			if(amount==4) A.dir=turn(usr.dir,180)
			A.loc=get_step(get_step(usr,A.dir),A.dir)
			if(A) walk(A,A.dir,1)
			spawn(4) if(usr.Target) walk_towards(A,usr.Target,1)
			amount-=1
			//spawn(40*(round(Experience/20))) if(A) del(A)
		usr.attacking=0

