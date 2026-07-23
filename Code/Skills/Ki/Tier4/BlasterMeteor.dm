Skill/Attacks/T1/Blaster_Meteor
	UB1="Channel"
	UB2="War"
	icon='17.dmi'
	desc="This attack fires off several homing blasts that track towards your target and cause shrapnel."
	var/Setting=4


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


	verb/Ki_Settings()
		set category="Other"
		Setting=input("Input the amount of blasts you want created when you use this attack. Default is [initial(Setting)]. You can fire 10 max") as num
		if(Setting<2) Setting=2
		if(Setting>10) Setting=10
		if(Setting>10)Setting=10
	verb/Blaster_Meteor()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		var/mob/B
		if(usr.Target) B =usr.Target
		else
			CD=0
			usr<<"This requires a target."
			return
		usr.attacking=3
		usr.Ki=(usr.Ki-EDT)
		var/amount=Setting
		usr.overlays+='Shield, Legendary.dmi'
		while(usr&&B)
			if(!amount||usr.KOd||(B.z!=usr.z)) break
			sleep(2)
			for(var/i=0, i<10, i++)
				if(!amount) break
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
				A.icon=icon
				A.DMGT				= src.DMGT
				A.DMGSOURCE_POW		= src.DMGSOURCE_POW
				A.SKILLTRAIT		= src.SKILLTRAIT
				A.LT				= HEAD
				A.UL				= HEAD
				A.SKILLTRAIT		= src.SKILLTRAIT
				A.Shrapnel=1
				A.loc = usr.loc
				A.dir=usr.dir-45
				while(prob(50)) A.Explosive++
				hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
				A.Offense=usr.Off
				spawn(rand(1,2))
					hearers(10,usr) << sound(pick('Blast1.wav','Blast2.wav'),volume=20)
					if(A)
						A.density=1
						if(A&&B) walk_towards(A,B)
				sleep(2)
		usr.attacking=0
		usr.overlays-='Shield, Legendary.dmi'


