Skill/Support/Send_Energy

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	UB2="Channel"
	UB1="Arcane Power"

	desc="Using this will cause you to send a continous stream of energy from you to your target.  It will heal them a small amount and drain your HP and energy as it goes."

	var/tmp/Active
	verb/Send_Energy()
		set category="Skills"
		if(usr.RPMode) return
		if(SkillSafeCheckUnarmed(usr,src))
			//TESTINGREPLACE
			return
		if(Active) Active=0
		else
			var/list/Choices=new
			Choices+="Cancel"
			for(var/mob/P in view(10,usr)) if(P.client&&P!=usr) Choices+=P
			var/mob/P=input(usr,"Choose who to send energy to") in Choices
			if(!P||P=="Cancel") return
			Active=1
			spawn while(P&&Active&&!usr.RPMode&&!usr.KOd)
				if(!Active) return
				missile('Spirit.dmi',usr,P)
				sleep(2)
			spawn while(P&&Active&&!usr.RPMode&&!usr.KOd)
				if(!Active) return
				if(usr.Ki>usr.MaxKi*0.05)
					usr.Ki=max(0,usr.Ki-usr.MaxKi*0.01)
					P.Ki+=usr.MaxKi*0.01
				else Active = 0
				if(usr.Health>=10)
					usr.TakeDamage(usr, 0.5, "Sending Energy to [P]")
					P.HealDamage("Send Energy", 1)
				else Active = 0
				if(usr.icon_state=="Meditate") Active=0
				sleep(10)
			usr.RecentSendEnergy=300