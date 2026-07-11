Skill/Misc/Icey_Grip//adds stagger to attacks for next 20 seconds


	icon='Ice Wing.dmi'
	pixel_x=-32
	layer=EFFECTS_LAYER+5
	desc="Causes all of your attacks for the next 10 seconds to slow and have a chance to stun. Only affects attack verb."

//	EDT				= ED_TIER_3
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	verb/Icey_Grip()
		set category="Skills"
		if(usr.RPMode) return
//		if(!usr.CanAttack(150,src)) return
		usr.IceyGrip=7
		usr.overlays+=src
		for(var/mob/player/M in view(usr))
			M.BuffOut("[usr] sprouts wings of ice as they empower their attacks with frost.")
		CD= DEBUFF_CD
		CDTick(usr)
		usr.Ki= EnergyCalculation(src,usr)

mob/proc/GripOfIce()
	set waitfor=0
	Slow(src,5,25)
	if(prob(20)) Stun(src,1)
	IceyGrip(src)