/*
atom/proc/Spin()
	animate(usr, transform = turn(matrix(), 90), time = 0.5)
	animate( transform = turn(matrix(), 180), time = 0.5)
	animate( transform = turn(matrix(), 270), time = 0.5)
	animate( transform = null, time = 0.5)
*/



Skill/Misc/Jump_Backwards

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= 5
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD


	desc="This will allow you to leap backwards and attempt to evade attacks."
	verb/Jump_Backwards()
		set category="Skills"
		set instant=1
		if(usr.RPMode) return
		if(usr.KOd) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if((usr.getCooldown("[src]")>world.time))
		//	usr.CombatOut("[src] is on cooldown. [src.CD*1.5]")
			return
		if(usr.move&&!usr.KB&&usr.KOd==0&&usr.icon_state!="Meditate"&&usr.icon_state!="Train")
			hearers(10,usr)<<sound('JumpBack.mp3',volume=20)
			var/turf/X=get_step(usr,usr.dir)
			var/OldDir=usr.dir
			var/Leaps=rand(1,3)+usr.SpdMod
			usr.Ki=(usr.Ki-EDT)
			Leaps+=usr.HasEvasion
			usr.Ki=(usr.Ki-EDT)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			animate(usr,pixel_z=12,time=3)
			Create_Shadow(usr)
			var/matrix/State1=matrix()
			State1.Scale(0.9,0.45)
			animate(usr.Shadow,alpha=190,transform=State1,time=3)
			while(Leaps>0&&src)
				if(usr&&X) step_away(usr,X,5)
				usr.dir=OldDir
				Leaps--
				sleep(1)
			animate(usr,pixel_z=0,time=3)
			var/matrix/LandingState=matrix()
			LandingState.Scale(1,0.5)
			animate(usr.Shadow,alpha=255,transform=LandingState,time=3)
			RemoveShadow(usr)
