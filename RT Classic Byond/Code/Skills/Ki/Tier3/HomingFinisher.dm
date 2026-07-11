Skill/Attacks/T3/Homing_Finisher
	UB1="Channel"
	icon='17.dmi'
	desc="This will create multiple low damage homing ki blasts that seek towards your target after a slight delay."
	var/Setting=10


	NoMove=1

//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_POW	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Ki_Settings()
		set category="Other"
		Setting=input("Input the amount of blasts you want created when you use this attack. Default is [initial(Setting)].") as num
		if(Setting<10) Setting=10
		if(Setting>30) Setting=30

	verb/Homing_Finisher()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		var/Targs=list()
		for(var/mob/M in orange(usr,20)) Targs+=M
		CD=CDCalculation(src,usr)
		CDTick(usr)
		Targs+="Cancel"
		var/mob/B=null
		if(usr.Target&&!usr.Target.KOd)B=usr.Target
		if(!B) B=input("Choose a target") in Targs
		if(B=="Cancel")
			CD=0
			return
		if(Setting>30) Setting=30
		usr.attacking=3
		usr.Ki=(usr.Ki-EDT)
		var/amount=Setting
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		var/list/spawnArea = oview(usr,8)
		if(!length(spawnArea))
			usr.attacking=0
			return
		while(usr&&B)
			if(!amount||usr.KOd||(B.z!=usr.z)) break
			hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
			sleep(1)
			spawnArea = oview(usr,8)
			for(var/i=0, i<5, i++)
				if(!amount)
					break
				amount-=1
				flick("Blast",usr)
				var/obj/ranged/Blast/A=unpool("Blasts")
				A.Belongs_To=usr
				A.name=src.name
				A.pixel_x=pixel_x
				A.pixel_y=pixel_y
				A.pixel_x+=rand(-16,16)
				A.pixel_y+=rand(-16,16)
				A.density=0
				A.Belongs_To=usr
				A.icon=icon
				A.DMGT				= src.DMGT
				A.DMGSOURCE_POW		= (src.DMGSOURCE_POW / Setting)
				A.DMGSOURCE_STR		= 0
				A.DMGSOURCE_OFF		= 0
				A.DMGSOURCE_DEF		= 0
				A.DMGSOURCE_SPD		= 0
				A.DMGSOURCE_END		= 0
				A.SKILLTRAIT		= src.SKILLTRAIT
				A.LT				= HEAD
				A.UL				= HEAD
				var/turf/pick = pick(spawnArea)
				A.loc = pick
				spawnArea -= pick
				A.Shockwave=1
				if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
					MM.DurabilityCheck(usr)
					break
				A.Offense=usr.Off
				if(A) A.dir=pick(alldirs)
				//spawn(50) A.density=1
				spawn(rand(10,60)/(2))
					A.density=1
					if((usr.icon_state in list("KO"))||usr.Frozen) return
					if(A) if(B) walk_towards(A,B)
		usr.attacking=0
