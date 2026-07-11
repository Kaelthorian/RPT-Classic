Skill/Attacks/T3/MegaBurst
	UB1="Arcane Power"
	UB2="Channel"


	icon='Ki MegaBurst.dmi'
	desc="This attack packs huge single hit power, but takes a while to charge and is easy to dodge, it is very big though and very draining."
	New()
		icon+=rgb(rand(0,225),rand(0,225),rand(0,225))
		..()

//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_4
	DMGSOURCE_POW	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Mega_Burst()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			//TESTINGREPLACE
			return
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.attacking=3
		hearers(10,usr) << sound(pick('Charging.wav','Charging2.wav'),volume=20)
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		charging=1
		var/Delay = usr.Refire * 2.4
		Delay += 5
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		usr.Ki=(usr.Ki-EDT)
		usr.Frozen=1
		spawn(Delay/2)
			usr.attacking=0
			usr.Frozen=0
		hearers(10,usr) << sound('kamehameha.wav',volume=20)
		usr.overlays-=ChargeOver
		charging=0
		var/MasterIcon=icon
		var/amount=50
		var/distance=10
		flick("Blast",usr)
		if(usr.KOd==0&&!usr.KB)
			while(amount)
				var/obj/ranged/Blast/A=unpool("Blasts")
				A.Belongs_To=usr
				A.name=src.name
				if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
					MM.DurabilityCheck(usr)
					break
				A.DoNotTrack=1
				A.Offense=usr.Off
				A.layer=MOB_LAYER+10
				A.icon=MasterIcon
				A.icon_state="center"
				A.density=0
				A.DMGT				= src.DMGT
				A.DMGSOURCE_POW		= src.DMGSOURCE_POW
				A.SKILLTRAIT		= src.SKILLTRAIT
				A.LT				= HEAD
				A.UL				= HEAD
				//positioning / appearance
				A.loc=locate(usr.x,usr.y,usr.z)
				if(amount<=40&&amount>30)
					A.icon_state="outer1" //Middle Right
					if(usr.dir==NORTH) A.x+=1
					if(usr.dir==SOUTH) A.x-=1
					if(usr.dir==EAST) A.y-=1
					if(usr.dir==WEST) A.y+=1
					if(usr.dir==NORTHWEST)
						A.x+=1
						A.y+=1
					if(usr.dir==SOUTHWEST)
						A.x-=1
						A.y+=1
					if(usr.dir==NORTHEAST)
						A.x+=1
						A.y-=1
					if(usr.dir==SOUTHEAST)
						A.x-=1
						A.y-=1
					if(amount==40) A.icon_state="outer1head"
					else if(amount==31)
						A.icon=turn(A.icon,180)
						A.icon_state="outer1origin"
				else if(amount<=30&&amount>20)
					A.icon_state="outer2" //Outer Right
					if(usr.dir==NORTH) A.x+=2
					if(usr.dir==SOUTH) A.x-=2
					if(usr.dir==EAST) A.y-=2
					if(usr.dir==WEST) A.y+=2
					if(usr.dir==NORTHWEST)
						A.x+=2
						A.y+=1
					if(usr.dir==SOUTHWEST)
						A.x-=2
						A.y+=1
					if(usr.dir==NORTHEAST)
						A.x+=2
						A.y-=1
					if(usr.dir==SOUTHEAST)
						A.x-=2
						A.y-=1
					if(amount==30) A.icon_state="outer2head"
					else if(amount==21)
						A.icon=turn(A.icon,180)
						A.icon_state="outer2origin"
				else if(amount<=20&&amount>10)
					A.icon_state="outer1" //Middle Left
					if(usr.dir==NORTH) A.x-=1
					if(usr.dir==SOUTH) A.x+=1
					if(usr.dir==EAST) A.y+=1
					if(usr.dir==WEST) A.y-=1
					if(usr.dir==NORTHWEST)
						A.x-=1
						A.y-=1
					if(usr.dir==SOUTHWEST)
						A.x+=1
						A.y-=1
					if(usr.dir==NORTHEAST)
						A.x-=1
						A.y+=1
					if(usr.dir==SOUTHEAST)
						A.x+=1
						A.y+=1
					if(amount==20) A.icon_state="outer3head"
					else if(amount==11)
						A.icon=turn(A.icon,180)
						A.icon_state="outer3origin"
				else if(amount<=10)
					A.icon_state="outer2" //Outer Left
					if(usr.dir==NORTH) A.x-=2
					if(usr.dir==SOUTH) A.x+=2
					if(usr.dir==EAST) A.y+=2
					if(usr.dir==WEST) A.y-=2
					if(usr.dir==NORTHWEST)
						A.x-=2
						A.y-=1
					if(usr.dir==SOUTHWEST)
						A.x+=2
						A.y-=1
					if(usr.dir==NORTHEAST)
						A.x-=2
						A.y+=1
					if(usr.dir==SOUTHEAST)
						A.x+=2
						A.y+=1
					if(amount==10) A.icon_state="outer4head"
					else if(amount==1)
						A.icon=turn(A.icon,180)
						A.icon_state="outer4origin"
				//---
				spawn(50) if(A) del(A)
				var/distance2=distance-1
				while(distance&&A)
					step(A,usr.dir)
					if(amount==50&&A) A.icon_state="centerorigin"
					else if(amount==41&&A)
						A.icon=turn(A.icon,180)
						A.icon_state="centerorigin"
					distance-=1
				distance=distance2
				if(!distance) distance=10
				amount-=1
				for(var/mob/M in view(0,A)) if(M!=usr) if(!M.afk)
					var/Damage=(usr.Pow*(usr.BP))/(M.End*M.BP)*14
					M.TakeDamage(usr, Damage, "[src]")
			spawn(60/usr.SpdMod) usr.Frozen=0
		spawn(80/usr.SpdMod) usr.attacking=0









