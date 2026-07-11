Skill/Attacks/Time_Freeze
	desc="This will send paralyzing energy rings all around nearby people and they will not be able to move until it wears off. This has a long cooldown."


//	DMGT			= DMG_TIER_1
//	CDT				= CD_TIER_1
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_1
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Time_Freeze()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		Stun(usr,1,1)
		usr.Ki=EnergyCalculation(src,usr)
		usr.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Time Freeze.\n")
		hearers(10,usr) << sound('TimeFreez3.ogg',volume=20)
		for(var/mob/A in oview(usr)) if(A.Team!=usr.Team)
			if(!A.Frozen&&A.client)
				sleep(2)
				var/obj/ranged/Blast/_TF=unpool("Blasts")
				_TF.Belongs_To=usr
				_TF.icon='TimeFreeze.dmi'
				_TF.name=src
				_TF.Power=usr.BP*Ki_Power
				_TF.Damage=_TF.Power*usr.Pow
				_TF.Offense=usr.Off
				_TF.Paralysis=3
				_TF.density=1
				missile(_TF,usr,A)
				_TF.Bump(A)
				//missile('TimeFreeze.dmi',usr,A)
