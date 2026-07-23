Skill/Unarmed/T2/RoundhouseKick
	desc="Unleash a devastating roundhouse kick that hits everyone around you. This attack has reduced knockback but 150% damage."

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_1
//	KBT				= KB_TIER_2
	DMGSOURCE_STR	= ((DMGS_TIER_2*57.1)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_2*42.9)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= LEGS
	SKILLTRAIT		= list()


	verb/Roundhouse_Kick() //hits everyone around you //can use with sword but no bonus damage
		set category="Skills"

		var/hashit=0
		if(usr.Critical_Left_Leg&&usr.Critical_Right_Leg)
			usr<<"Both your legs are injured, you may not use this."
			return
		for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
		var/Hit=0
		for(var/mob/M in oview(usr,1)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) Hit=1
		if(Hit)
			SweepingKick(usr)
			CD= CDCalculation(src,usr)
			CDTick(usr)
			flick("Attack",usr)
			spawn(1) usr.RHK()
			usr.Ki= EnergyCalculation(src,usr)
			LargeDust(usr)
			for(var/mob/M in oview(usr,1)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
				if(!usr.attacking) if(M.afk == 0&&!M.RPMode)//
					usr.Ki=(usr.Ki-EDT)
					var/Evasion=SkillAccuracy(usr,M,src)
					var/Damage=DamageCalculator(usr,M,src)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						hashit=1
						flick("Attack",usr)
						if(M.attacking==1) usr.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [usr].")
							usr.CombatOut("[M] dodges you.")
							hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,usr.BP,1)
								Damage = Damage
								hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)

//								didBlock=1
							if(prob(25))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							M.KB=round(Damage*0.5)
							if(M.KB>10) M.KB=10
							if(prob(50)) M.KB++
							if(prob(50)) M.KB++
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							spawn M.KnockBack(usr)
							if(M)
								if(!isnum(M.Health)) return
//								M.BPDamage(usr,Damage,5)
								M.Injure_Hurt(rand(5,15)/10*Damage,"Arms",usr)
								hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
								M.TakeDamage(usr, Damage, "[src]")
								M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
								M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
//						M.BPDamage(usr,Damage,10)
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						M.KB=round((usr.Str/M.End)*5)
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
						//if(M&&M.Life<=0) M.Death(usr)
	//		DustCloud(usr)
			if(hashit)
				usr.attacking=1
				spawn(usr.Refire) usr.attacking=0

