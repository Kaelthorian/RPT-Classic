Skill/Unarmed/T4/Torrential_Strike

	desc="Launches an attack that drowns your opponent in a torrent of water and creates water tiles that last for 20 seconds. Drains energy equal to half the damage dealt."


//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= ((DMGS_TIER_4*74.6)/100)
	DMGSOURCE_END	= ((DMGS_TIER_4*25.4)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Torrential_Strike()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				flick("Attack",usr)
				CD= CDCalculation(src,usr)
				CDTick(usr)
				usr.Ki= EnergyCalculation(src,usr)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
				if((M.KOd==0&&M.client))
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
						if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
							M.TakeDamage(usr, Damage, "[src]")
							M.DrainKi(src,"Percent",Damage*0.5)
							hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
							M.Torrential()
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					M.KB=0
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)



mob/proc/Torrential()
	DrownWaterOver(src)
	for(var/turf/T in view(src,4)) new/obj/Hazard/Drowning_Water(T)
