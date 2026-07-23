Skill/Misc/Resist

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD



	UB1="Kaioken"
	UB2="Shadow King"
	desc="This will allow you to break any existing crowd control at the cost of 10% energy. Grants the default period of immunity. Removes bleeds, burns and any other debuffs."
	verb/Resist()
		set category="Skills"
		set instant=1
		if(usr.RPMode) return
		if(usr.KOd) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.getCooldown("[src]")>world.time)
		//	usr.CombatOut("[src] is on cooldown. [src.CD*1.5]")
			return
		if(!usr.HasWillUnbroken)
			usr.Ki=(usr.Ki-EDT)
			CD=(1+Modifier(usr))/CDT
			CDTick(usr)
		else usr.DrainKi(src,"Percent",3)
		for(var/mob/player/teleg in view(usr)) teleg.BuffOut("[usr] resists their restraints and breaks free!")
		usr.SlowDuration=0
		usr.Slow=0
		usr.SlowImmune=world.time+20+usr.KBResist
		usr.Stagger=0
		var/image/_overlay = image('Stun.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
		usr.overlays -= _overlay
		var/image/_overlay2 = image('Slow Overlay.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
		usr.overlays -= _overlay2
		usr.StaggerImmune=world.time+20+usr.KBResist
		var/image/_overlay3 = image('TimeFreeze.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
		usr.overlays -= _overlay3
		var/image/_overlay4 = image('stunoverlay.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
		usr.overlays -= _overlay4
		usr.Stunned=0
		usr.StunImmune=world.time+20+usr.KBResist
		usr.Wing_Clipped=0
		usr.GuardBroken=0
		usr.Bleeds=0
		usr.BleedTicks=0
		usr.Burns=0
		usr.BurnTicks=0





