Skill/Unarmed/T3/Wing_Clip


	UB1="Bestial Wrath"
	UB2="Fists of Fury"
	desc="Launch a cheap attack against an opponent's joints in order to reduce their speed by 40% for 8 seconds if it lands. This will also stagger their movement."
//	DMGT			= DMG_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= ((DMGS_TIER_3*11.1)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_3*12.7)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_3*50.8)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Wing_Clip()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				flick("Attack",usr)
				CD= DEBUFF_CD
				CDTick(usr)
				usr.Ki= EnergyCalculation(src,usr)
				var/Evasion=SkillAccuracy(usr,M,src)
				var/Damage=DamageCalculator(usr,M,src)
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
//						hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
						hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage
							hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
							M.Injure_Hurt(rand(15,20)/10*Damage,"Legs",usr)
							hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
							M.TakeDamage(usr, Damage, "[src]")
							winset(M.client,"Wing_Clipd","is-visible=true")
							M.Wing_Clipped=10
							Stagger(M,5)
							hearers(6,M) << "[usr] has weakened [M]s joints with a cheap attack."
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage,3)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)

