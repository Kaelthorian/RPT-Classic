Skill/Unarmed/T2/Headbutt
	UB1="High Tension"
	UB2="Fists of Fury"


	desc="Bash your opponent in the face with the crown of your head. This will stun them for 2 ticks if it lands but if you miss, you will be stunned for 2 ticks. Does damage to your head and your opponents head if it lands."

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_2
	DMGSOURCE_STR	= ((DMGS_TIER_2*42.9)/100)
	DMGSOURCE_END	= ((DMGS_TIER_2*38.1)/100)
	DMGSOURCE_DEF	= ((DMGS_TIER_2*19.0)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Headbutt()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			flick("Attack",usr)
			CD= CDCalculation(src,usr)
			CDTick(usr)
			usr.Ki= EnergyCalculation(src,usr)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
//				var/didBlock=0
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
						Stun(usr,0.5)
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
						hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage
							hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//								M.BPDamage(usr,Damage,3)
							hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
							M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
							usr.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
							M.TakeDamage(usr, Damage, "[src]")
							Stun(M,2)
							M.BuffOut("[usr] bashes [M] with their headbutt.")
							usr.BuffOut("[usr] bashes [M] with their headbutt.")
							M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
							M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//						M.BPDamage(usr,Damage,3)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
