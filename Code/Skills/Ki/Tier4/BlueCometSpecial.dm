Skill/Attacks/BlueCometSpecial

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= ((DMGS_TIER_3*49)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_3*51)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	UB1="Godspeed"
	UB2="Fists of Fury"
	var/On=0
	var/tmp/Blue_Comet_Special=0
	desc="This attack causes you to summon several split forms around your location that then dash towards your target and attack. Deals damage based on speed."

	Level=3

	verb/Ki_Settings()
		set category="Other"
		var/Max=round(10)
		if(Max>6) Max=6
		Level=input("This will increase the attack radius. Current is [Level]. Minimum is 3. Max is [Max]") as num
		if(Level<3) Level=3
		if(Level>Max) Level=Max
		Level=round(Level)
	verb/Blue_Comet_Special()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			return
		if(usr.Target.z==usr.z)
			usr.attacking=3
			Blue_Comet_Special=1
			usr.Ki=(usr.Ki-EDT)
			CD=CDCalculation(src,usr)
			CDTick(usr)
			var/amount=Level
//			var/list/spawnArea = oview(usr,3)
			spawn()
				while(!usr.KOd&&amount>0)
					amount-=1
					flick(usr.CustomZanzokenIcon,usr)
					var/obj/ranged/Blast/A=unpool("Blasts")
					A.density=0
					A.DMGT				= src.DMGT
					A.DMGSOURCE_STR		= 0
					A.DMGSOURCE_POW		= src.DMGSOURCE_POW/3
					A.DMGSOURCE_OFF		= 0
					A.DMGSOURCE_DEF		= 0
					A.DMGSOURCE_SPD		= src.DMGSOURCE_SPD/3
					A.DMGSOURCE_END		= 0
					A.WEAPON			= NO
					A.LT				= HEAD
					A.UL				= HEAD
					A.SKILLTRAIT		= src.SKILLTRAIT
					A.Belongs_To=usr
					A.pixel_x=usr.pixel_x
					A.pixel_y=usr.pixel_y
					A.icon=usr.icon
					A.overlays=usr.overlays
					A.underlays=usr.underlays
					A.icon+=rgb(0,0,0,155)
					A.overlays+=rgb(0,0,0,155)
					A.name="Blue Comet Special"
//					var/spawnSpot=pick(spawnArea)
					A.loc=usr.loc
//					spawnArea-=spawnSpot
					A.dir=usr.dir
					A.Shockwave=1
					A.Offense=usr.Off
					spawn(rand(2,5))
						hearers(10,usr)<<sound('ChargeFire.wav',volume=20)
						if(A)
							A.density=1
							walk_towards(A,usr.Target,1)
					sleep(15)
			spawn(usr.Refire)
				Blue_Comet_Special=0
				usr.attacking=0
			return
		src<<"You must have a target"






