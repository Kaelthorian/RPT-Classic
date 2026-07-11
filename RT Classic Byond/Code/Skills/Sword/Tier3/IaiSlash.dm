Skill/Weapon/T3/Iai_Slash

	UB1="Bushido"
	UB2="Godspeed"
	desc="Use your impressive speed to rush at your opponent and strike them as you pass dealing bonus damage with 33% of your speed and an increased baseline damage. This technique is like dash attack except you will phase through your opponents and damage them at the end of the travel."



//	DMGT			= DMG_TIER_3
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_3
	DMGSOURCE_STR	= ((DMGS_TIER_3*49.2)/100)
	DMGSOURCE_SPD	= ((DMGS_TIER_3*50.8)/100)
	WEAPON			= NO

	verb/Iai_Slash()
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		var/Distance=6
		Distance+=round(usr.SpdMod)
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)

		var/list/HitMobs=list()
		animate(usr, alpha = 155, time = 2)
		if(usr.Ki>usr.MaxKi*0.05)
			usr.DashAttacking=1
			usr.attacking=1
			while(src&&usr&&Distance&&usr.Health>0)
				if(usr.Ki<20) break
				for(var/mob/M in get_step(usr,usr.dir)) if(M!=usr)if(!M.adminDensity&&M.attackable)
					if(M.afk==0&&!M.RPMode)
						if(M.Blocking)
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] blocks [usr]s [src]!")
							ShockwaveScale(usr,usr.BP,1)
							BlockEffect(M)
							Crater(M)
						else
							flick("Attack",usr)
							var/Evasion=SkillAccuracy(usr,M,src)
							if((M.KOd==0&&M.client))
								if(M.attacking==1) usr.Opp(M)
								if(!prob(Evasion))
									flick(M.CustomZanzokenIcon,M)
									M.CombatOut("You dodge [usr].")
									usr.CombatOut("[M] dodges you.")
									hearers(10,usr)<<sound(pick('MeeleDodge1.wav','MeeleDodge2.wav','MeeleDodge3.wav'),volume=20)
								else //Successful hit
									if(!(M in HitMobs)) HitMobs+=M
				if(Distance<=0) break
				sleep(min(3,1))
				step(usr,usr.dir)
				Distance--
				//usr.density=0
			for(var/mob/M in HitMobs)
				if((M.KOd==0&&M.client))
					var/Damage=DamageCalculator(usr,M,src)
					ShockwaveScale(M,usr.BP,1)
					if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
					M.KB=round(Damage*0.5)
					if(M.KB>3) M.KB=3
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					M.KnockBack(usr)
					if(M)
						if(!isnum(M.Health)) return
						M.TakeDamage(usr, Damage, "[src]")
						hearers(10,usr)<<sound('Sword.mp3',volume=20)
						M.LastHitter = usr.name															//Read the hit him with an autoattack and save it in LastHitter
						M.HitterListCheck(usr.name)														//Runs the HitterListCheck proc from Better Anger while aiming to the one who hitted.
				else
					flick("Attack",usr)
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
			animate(usr, alpha = 255, time = 2)
			spawn(usr.Refire)
				usr.attacking=0
				usr.DashAttacking=0
