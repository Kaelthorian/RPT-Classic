mob/proc/GetDisarmed(mob/M,length)
//	if(!HasEOMA)
	for(var/mob/player/P in oview(M))
		P.CombatOut("[src] is disarmed by [M]!")
	Disarmed=length
//	else for(var/mob/player/P in oview(M)) P.CombatOut("[M] tries to disarm [src] but their weapon is like a part of their arm!")

mob/var/tmp/Disarmed=0
mob/var/tmp/RiposteActive=0
mob/var/tmp/CatchBladeActive=0
Skill/Weapon/T2/Riposte//adds stagger to attacks for next 20 seconds


	UB1="Bushido"
	UB2="Fists of Fury"

	desc="Causes you to automatically counter-attack and disarm your opponent if they attack you within the next 6 seconds. (Disarm lasts about 8 seconds, only usable while wearing a weapon)"

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_1
	DMGSOURCE_STR	= DMGS_TIER_2
	WEAPON			= NO


	verb/Riposte()
		set category="Skills"
		if(SkillSafeCheckWeapon(usr,src))
			//TESTINGREPLACE
			return
		usr.RiposteActive=4
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr] prepares to parry their opponent's attack.")
		CD=CDCalculation(src,usr)
		CDTick(usr)
		usr.Ki=(usr.Ki-EDT)


