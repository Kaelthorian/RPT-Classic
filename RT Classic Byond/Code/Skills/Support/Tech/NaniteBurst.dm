Skill/Technology/Nanite_Burst

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_3
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	desc="This will heal team mates within a 3 tile radius by +5 Health , it will take 1 WP per use."
	verb/Nanite_Burst()
		set category="Skills"
		if(SkillSafeCheckKi(usr,src))
			return
		for(var/mob/A in view(usr,3)) if(A.Team==usr.Team)
			if(A.Willpower<=0) A.WillpowerRestore()
//			if(A.Willpower<A.MaxWillpower&&A.Willpower>0) A.Willpower++
			if(A.KOd) return
			A.Health += 7
			A.Willpower--
			if(A.Health>A.Willpower) A.Health=A.Willpower
			for(var/BodyPart/P in A)
				if(usr.Magic_Level>70)
					if(P.Health<=P.MaxHealth)
						A.Injure_Heal(25,P,1)
				else  if(P.Health<=P.MaxHealth) A.Injure_Heal(20,P)
//			A.Heal_Zenkai()
			view(usr)<<"<font color=#FFFF00>[usr] uses their nanites to heal [A]"
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)