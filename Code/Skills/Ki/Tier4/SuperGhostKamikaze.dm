Skill/Attacks/SuperGhostKamikazeAttack
	UB1="Arcane Power"
	UB2="Shadow King"

	desc="Makes splitforms of yourself that after a short delay attack your target and deal strength based damage."

	NoMove=1

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= DMGS_TIER_4
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Super_Ghost_Kamikaze_Attack()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		if(!usr.Target)
			usr << "You need to have a target!"
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		var/mob/B
		if(usr.Target.z==usr.z) B=usr.Target
		else return
		usr.attacking=3
		usr.Ki=(usr.Ki-EDT)
		var/amount=2+round(5)
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		spawn() while(usr&&B&&amount)
			if(!amount||usr.KOd||(B.z!=usr.z)) break
			sleep(1)
			if(!amount) break
			usr.attacking=3
			amount-=1
			flick("Blast",usr)
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.DMGT				= src.DMGT
			A.DMGSOURCE_POW		= src.DMGSOURCE_POW/4
			A.SKILLTRAIT		= src.SKILLTRAIT
			A.LT				= HEAD
			A.UL				= HEAD
			A.Belongs_To=usr
			A.density=0
			A.pixel_x=usr.pixel_x
			A.pixel_y=usr.pixel_y
			A.icon=usr.icon
			A.overlays=usr.overlays
			A.underlays=usr.underlays
			A.icon+=rgb(0,0,0,155)
			A.overlays+=rgb(0,0,0,155)
			A.name="Super Ghost Kamikaze"
			A.loc = get_step(usr.loc,pick(usr.dir,turn(usr.dir,-90),turn(usr.dir,90)))
			step(A,usr.dir)
			if(A)
				A.dir=usr.dir
				A.Explosive=1
				A.Shockwave=1
				A.Offense=usr.Off
				spawn(12-amount)
					if(A)
						A.density=1
						if(B) walk_towards(A,B,1)
		spawn(usr.Refire*2)usr.attacking=0
