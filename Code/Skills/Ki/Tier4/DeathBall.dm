Skill/Attacks/Death_Ball
	desc="Calculates damage using Force. Cast it to begin charging and when done charging clicking with the mouse will cause it to move continuosly towards the mouse click."
	var/IsCharged
	UB1="Death"
	UB2="Shadow King"
	KiReq=300
	NoMove=1


//	Fatal=1

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Death_Ball()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(charging) return
		if(!usr.Target||usr.Target.z!=usr.z)
			usr<<"You must have a target on the same plane."
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		if(usr)
			usr.Ki=(usr.Ki-EDT)
			var/obj/ranged/Blast/SpiritBall/Genki_Dama/A=unpool("Genki_Dama")
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.LT				= HEAD
			A.UL				= HEAD
			A.Belongs_To=usr
			A.loc=usr.loc
			A.name=src.name
			A.y+=3
			if(!A||!A.z) return
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.Offense=usr.Off
			A.Size=1
			A.Explosive=2
			A.Large('Death Ball.dmi',0,0,0,180)
			A.DoNotTrack=1
			A.Health=1000000000000
			usr.attacking=3
			charging=1
			hearers(10,usr) << sound('DeathBallCharge.mp3',volume=20)
			for(var/mob/M in range(20,usr))
				M.CombatOut("[usr] begins to charge a [src]!")
			var/Delay = usr.Refire * 2
			Delay += 20
			usr.overlays+='SBombGivePower.dmi'
			sleep(Delay)
			usr.overlays-='SBombGivePower.dmi'
			hearers(10,usr) << sound('DeathBallFire.mp3',volume=20)
			charging=0
			for(var/Skill/Zanzoken/Z in usr)if(Z.Zon)
				Z.Zon = 0
				usr.BuffOut("Zanzoken toggled off.")
			IsCharged=1
			walk_towards(A,usr.Target)
			A.maxSteps*=2
			usr.attacking=0
