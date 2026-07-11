
mob/var/tmp/PSand=0
Skill/Unarmed/T4/PocketSand
	UB1="Fungal Plague"
	UB2="Death"


	desc="Launch a cheap attack against an opponent's eyes by throwing sand at them. Reduces their Offense and Defense by 10% if it hits for 15 seconds as well as staggering them. (Bonus damage based on offense)"

//	DMGT			= DMG_TIER_4
//	CDT				= CD_TIER_4
//	EDT				= ED_TIER_4
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= ((DMGS_TIER_4*32.3)/100)
	DMGSOURCE_OFF	= ((DMGS_TIER_4*67.7)/100)
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD
	SKILLTRAIT		= list()

	verb/Pocket_Sand()
		set category="Skills"
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		flick("Attack",usr)
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
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
						hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage
							hearers(10,usr)<<sound('MeeleWeak1.wav','MeeleWeak2.wav',volume=20)
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
							M.Injure_Hurt(Damage,"Eyes",usr)
							M.TakeDamage(usr, Damage, "[src]")
						//	winset(M.client,"Wing_Clipd","is-visible=true")
							M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
							M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
							M.PSand=10
							Stun(M,0.5)
							Stagger(M,4)
							hearers(6,M) << "[usr] throws sand at [M]'s eyes."
							hearers(10,usr)<<sound(pick('MeeleStrong1.wav','MeeleStrong2.wav'),volume=20)
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