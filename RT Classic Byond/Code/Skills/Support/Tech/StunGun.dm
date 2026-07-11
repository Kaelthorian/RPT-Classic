Skill/Technology/Stungun

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD


	desc="Stun your opponent with a burst of electric shock. This will stun them for 3 ticks if it lands."
	verb/Stungun()
		set category="Skills"
		hearers(10,usr) << sound('Stun.wav',volume=20)

		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			var/Cost = 10000
			var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
			usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)

				for(var/obj/Resources/RR in usr)
					if(RR.Value >= Actual)
						flick("Attack",usr)
						CD=CDCalculation(src,usr)
						CDTick(usr)
						usr.Ki=(usr.Ki-EDT)
					//	RR.Value-=Actual


						var/Evasion=SkillAccuracy(usr,M,src)
						var/Damage=DamageCalculator(usr,M,src)
		//				var/didBlock=0
						if((M.KOd==0&&M.client))
							flick("Attack",usr)
							if(M.attacking==1) usr.Opp(M)
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
		//							hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
								//Stun(usr,0.5)
								M.CombatOut("You dodge [usr].")
								usr.CombatOut("[M] dodges you.")
							else //Successful hit
								if(!prob(Evasion))
									ShockwaveScale(M,usr.BP,1)
									Damage = Damage
		//								hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
		//							didBlock=1
								if(prob(25))
									ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
								M.KB=round(Damage*0.5)
								if(M.KB>5) M.KB=5
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								spawn() M.KnockBack(usr)
								if(M)
									if(!isnum(M.Health)) return
									M.TakeDamage(usr, Damage, "[src]")
									Stun(M,3)
									M.BuffOut("[usr] stuns [M] with their [src].")
									usr.BuffOut("[usr] stuns [M] with their [src].")
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


					else
						usr << "You do not have [Commas(Actual)] resources to spare in order to use the [src]."
						return
			break