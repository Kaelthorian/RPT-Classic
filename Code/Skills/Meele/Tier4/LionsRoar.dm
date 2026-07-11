mob/proc/FireLionsRoar(Skill/S)
	var/obj/ranged/Blast/A=unpool("Blasts")
	A.Belongs_To=src
	A.icon=S.icon
	A.Explosive=1
	A.density=1
	//A.Radius=1
	A.pixel_x=S.pixel_x
	A.pixel_y=S.pixel_y
	A.name=S.name
	A.Damage=4*(src.BP)*(src.Pow+src.Str)*Ki_Power
	A.Power=(src.BP)*Ki_Power
	A.Offense=src.Off
	A.loc=src.loc
	walk(A,src.dir,1)

Skill/Unarmed/T4/Lions_Roar
	UB1="Bestial Wrath"
	UB2="High Tension"

	icon='16.dmi'
	desc="Dashes three tiles and launch an energy blast that deals strength and force damage. The dash gets bonus damage from force."


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= ((DMGS_TIER_4*83.1)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_4*16.9)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Lions_Roar()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		CD= CDCalculation(src,usr)
		CDTick(usr)
		var/Distance=3
		var/Steps=3
		while(Steps)
			step(usr,usr.dir)
			Steps--
			sleep(1)
		if(usr.Ki>usr.MaxKi*0.05)
			usr.DashAttacking=1
			usr.attacking=1
			while(src&&usr&&Distance&&usr.Health>0)
				if(usr.Ki<50) break
				for(var/mob/M in get_step(usr,usr.dir)) if(M!=usr) if(!M.adminDensity&&M.attackable)
					if(M.afk==0&&!M.RPMode)
						usr.Fight()
						var/Evasion=SkillAccuracy(usr,M,src)
						var/Damage=DamageCalculator(usr,M,src)
						if((M.KOd==0&&M.client))
							if(M.attacking==1) usr.Opp(M)
							Distance--
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
								M.CombatOut("You dodge [usr].")
								usr.CombatOut("[M] dodges you.")
								hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
//								if(prob(65))
//									M.dir=turn(M.dir,pick(-45,45))
//									step(M,M.dir)
							else //Successful hit
								if(!prob(Evasion))
									Damage = Damage
									hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
//									if(prob(65))
//										M.dir=turn(M.dir,pick(-45,45))
//										step(M,M.dir)
								if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(M)
									if(!isnum(M.Health)) return
									M.TakeDamage(src, Damage, "[src]")
									hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
									M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
									M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
									spawn(1) usr.FireLionsRoar(src)
									Distance=0
						else
							usr.Fight()
							M.KB=round((usr.Str/M.End)*5)
							if(M.KB>5) M.KB=5
							M.KnockBack(usr)
				usr.Ki= EnergyCalculation(src,usr)
//				step(usr,usr.dir)
				Distance--
				if(Distance<=0)
					usr.FireLionsRoar(src)
					break
//				sleep(rand(1,2/max(1,Experience/50)))
			spawn(usr.Refire*2)
				usr.attacking=0
				usr.DashAttacking=0
			if(Distance<=0)
				usr.DashAttacking=0
				usr.attacking=0

