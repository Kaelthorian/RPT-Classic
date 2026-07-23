mob/proc
	ArmorCheck(CheckType=1)
		if(CheckType==1)
			if(src.ArmorOn) return ArmorOn
			if(src.PowerArmorOn) return PowerArmorOn
//		if(CheckType==2)
	WeaponCheck(CheckType=1)
		if(CheckType==1)
			if(src.Disarmed) return 0
			if(src.SwordOn) return SwordOn
			if(src.HammerOn) return HammerOn
			if(src.KiBlade&&src.HasBladeOfLight) return 1
			if(src.KiHammer&&src.HasBladeOfLight) return 1
			if(src.SpiritSword&&src.HasBladeOfLight) return 1
		if(CheckType==2)
			if(src.Disarmed) return 0
			if(src.SwordOn) return SwordOn
			if(src.HammerOn) return HammerOn
			if(src.GlovesOn) return GlovesOn
			if(src.KiBlade&&src.HasBladeOfLight) return 1
			if(src.KiHammer&&src.HasBladeOfLight) return 1
			if(src.SpiritSword&&src.HasBladeOfLight) return 1

proc/SkillSafeCheckUnarmed(mob/S,Skill/W)
	//The user
	if(W.Tier==0)
		S.CombatOut("You can't use tier 0 skills.")
		return 1
	if(S.ClashRoll)
		S.CombatOut("You can't do this while Clashing.")
		return 1
	if(S.KOd)
		S.CombatOut("You can't do this while KOed.")
		return 1
	if(S.afk)
		S.CombatOut("You can't do this while AFK.")
		return 1
	if(S.isGrabbing)
		S.CombatOut("You can't do this while grabbing someone.")
		return 1
	if(S.RPMode)
		S.CombatOut("You are in RP mode.")
		return 1
	if(S.SwordOn)
		S.CombatOut("You can't do this with a weapon.")
		return 1
	if(S.HammerOn)
		S.CombatOut("You can't do this with a weapon.")
		return 1
	if(S.icon_state=="Train")
		S.CombatOut("You can't do this while training.")
		return 1
	if(S.Animation)
		S.CombatOut("You can't do this in the middle of an animation.")
		return 1
	if(StunCheck(S))
		S.CombatOut("You can't do this while stunned.")
		return 1
	if(S.DashAttacking)
		S.CombatOut("You can't do this while dash attacking.")
		return 1
	if(S.Frozen)
		S.CombatOut("You can't do this while frozen.")
		return 1
	if(S.Ki<W.EDT)
		S.CombatOut("You don't have enough energy , Current energy:[S.Ki].")
		return 1
	if(S.IsBlocking)
		S.CombatOut("You can't do this while blocking.")
		return 1
	if(S.Meditate)
		S.CombatOut("You can't do this while Meditating.")
		return 1
	if(S.Training)
		S.CombatOut("You can't do this while Training.")
		return 1
	if(S.Study)
		S.CombatOut("You can't do this while Studing.")
		return 1
	if(S.getCooldown("[W]")>world.time)
		S.CombatOut("<font color=#ffb300>[round((S.getCooldown("[W]")-world.time)/10,0.1)] seconds cooldown remaining. ([W])</font>")
		return 1
	for(var/T in SkillBanned)
		if(W.name == T)
			S.CombatOut("This skill is temporaly banned.")
			return 1
	//The Target
	for(var/mob/M in get_step(S,S.dir))
		if(M.KOd)
			S.CombatOut("You can't do this while he is KOed.")
			return 1
		if(M.afk)
			S.CombatOut("You can't do this to an AFK person.")
			return 1
		if(M.RPMode)
			S.CombatOut("You can't do this to a person in RP mode.")
			return 1
		if(M.Animation)
			S.CombatOut("You can't do this while he is in an animation.")
			return 1
		if(M.Meditate)
			S.CombatOut("You can't do this while he is Meditating.")
			return 1
		if(M.Training)
			S.CombatOut("You can't do this while he is Training.")
			return 1
		if(M.Study)
			S.CombatOut("You can't do this while he is Studing.")
			return 1








proc/SkillSafeCheckKi(mob/S,Skill/W)
	//The user
	if(W.Tier==0)
		S.CombatOut("You can't use tier 0 skills.")
		return 1
	if(S.ClashRoll)
		S.CombatOut("You can't do this while Clashing.")
		return 1
	if(S.KOd)
		S.CombatOut("You can't do this while KOed.")
		return 1
	if(S.afk)
		S.CombatOut("You can't do this while AFK.")
		return 1
	if(S.isGrabbing)
		S.CombatOut("You can't do this while grabbing someone.")
		return 1
	if(S.RPMode)
		S.CombatOut("You are in RP mode.")
		return 1
	if(StunCheck(S))
		S.CombatOut("You can't do this while stunned.")
		return 1
	if(S.DashAttacking)
		S.CombatOut("You can't do this while dash attacking.")
		return 1
	if(S.Frozen)
		S.CombatOut("You can't do this while frozen.")
		return 1
	if(S.icon_state=="Train")
		S.CombatOut("You can't do this while training.")
		return 1
	if(S.Animation)
		S.CombatOut("You can't do this in the middle of an animation.")
		return 1
	if(S.Ki<W.EDT)
		S.CombatOut("You don't have enough energy , Current energy:[S.Ki].")
		return 1
	if(S.IsBlocking)
		S.CombatOut("You can't do this while blocking.")
		return 1
	if(S.Meditate)
		S.CombatOut("You can't do this while Meditating.")
		return 1
	if(S.Training)
		S.CombatOut("You can't do this while Training.")
		return 1
	if(S.Study)
		S.CombatOut("You can't do this while Study.")
		return 1
	if(S.getCooldown("[W]")>world.time)
		S.CombatOut("<font color=#ffb300>[round((S.getCooldown("[W]")-world.time)/10,0.1)] seconds cooldown remaining. ([W])</font>")
		return 1
	for(var/T in SkillBanned)
		if(W.name == T)
			S.CombatOut("This skill is temporaly banned.")
			return 1

	//The Target
	for(var/mob/M in get_step(S,S.dir))
		if(M.KOd)
			S.CombatOut("You can't do this while he is KOed.")
			return 1
		if(M.afk)
			S.CombatOut("You can't do this to an AFK person.")
			return 1
		if(M.RPMode)
			S.CombatOut("You can't do this to a person in RP mode.")
			return 1
		if(M.Animation)
			S.CombatOut("You can't do this while he is in an animation.")
			return 1
		if(M.Meditate)
			S.CombatOut("You can't do this while he is Meditating.")
			return 1
		if(M.Training)
			S.CombatOut("You can't do this while he is Training.")
			return 1
		if(M.Study)
			S.CombatOut("You can't do this while he is Studing.")
			return 1

proc/SkillSafeCheckWeapon(mob/S,Skill/W)
	//The user
	if(W.Tier==0)
		S.CombatOut("You can't use tier 0 skills.")
		return 1
	if(S.ClashRoll)
		S.CombatOut("You can't do this while Clashing.")
		return 1
	if(S.KOd)
		S.CombatOut("You can't do this while KOed.")
		return 1
	if(S.afk)
		S.CombatOut("You can't do this while AFK.")
		return 1
	if(S.isGrabbing)
		S.CombatOut("You can't do this while grabbing someone.")
		return 1
	if(S.RPMode)
		S.CombatOut("You are in RP mode.")
		return 1
	if(S.GlovesOn)
		S.CombatOut("You can't do this with guantlets.")
		return 1
	if(StunCheck(S))
		S.CombatOut("You can't do this while stunned.")
		return 1
	if(S.DashAttacking)
		S.CombatOut("You can't do this while dash attacking.")
		return 1
	if(S.Frozen)
		S.CombatOut("You can't do this while frozen.")
		return 1
	if(!S.HasBladeOfLight)
		if(S.NoWeapon==1)
			S.CombatOut("You can't do this with out a weapon.")
			return 1
	if (S.HasBladeOfLight &&!S.KiBlade&&!S.KiHammer&&!S.SpiritSword)
		S.CombatOut("You can't do this without a weapon or a ki weapon.")
		return 1
	if(S.Disarmed)
		S.CombatOut("You were disarmed!!.")
		return 1
	if(S.icon_state=="Train")
		S.CombatOut("You can't do this while training.")
		return 1
	if(S.Animation)
		S.CombatOut("You can't do this in the middle of an animation.")
		return 1
	if(S.Ki<W.EDT)
		S.CombatOut("You don't have enough energy , Current energy : [S.Ki] .")
		return 1
	if(S.IsBlocking)
		S.CombatOut("You can't do this while blocking.")
		return 1
	if(S.Meditate)
		S.CombatOut("You can't do this while Meditating.")
		return 1
	if(S.Training)
		S.CombatOut("You can't do this while Training.")
		return 1
	if(S.Study)
		S.CombatOut("You can't do this while Study.")
		return 1
	if(S.getCooldown("[W]")>world.time)
		S.CombatOut("<font color=#ffb300>[round((S.getCooldown("[W]")-world.time)/10,0.1)] seconds cooldown remaining. ([W])</font>")
		return 1
	for(var/T in SkillBanned)
		if(W.name == T)
			S.CombatOut("This skill is temporaly banned.")
			return 1
	//The Target
	for(var/mob/M in get_step(S,S.dir))
		if(M.KOd)
			S.CombatOut("You can't do this while he is KOed.")
			return 1
		if(M.afk)
			S.CombatOut("You can't do this to an AFK person.")
			return 1
		if(M.RPMode)
			S.CombatOut("You can't do this to a person in RP mode.")
			return 1
		if(M.Animation)
			S.CombatOut("You can't do this while he is in an animation.")
			return 1
		if(M.Meditate)
			S.CombatOut("You can't do this while he is Meditating.")
			return 1
		if(M.Training)
			S.CombatOut("You can't do this while he is Training.")
			return 1
		if(M.Study)
			S.CombatOut("You can't do this while he is Studing.")
			return 1

proc/SkillSafeCheckBuff(mob/S,Skill/W)
	if(S.ClashRoll)
		S.CombatOut("You can't do this while Clashing.")
		return 1
	if(S.KOd)
		S.CombatOut("You can't do this while KOed.")
		return 1
	if(S.afk)
		S.CombatOut("You can't do this while AFK.")
		return 1
	if(StunCheck(S))
		S.CombatOut("You can't do this while stunned.")
		return 1
	if(S.Meditate)
		S.CombatOut("You can't do this while Meditating.")
		return 1
	if(S.Training)
		S.CombatOut("You can't do this while Training.")
		return 1
	if(S.Study)
		S.CombatOut("You can't do this while Study.")
		return 1
	if(S.getCooldown("[W]")>world.time)
		S.CombatOut("<font color=#ffb300>[round((S.getCooldown("[W]")-world.time)/10,0.1)] seconds cooldown remaining. ([W])</font>")
		return 1
	for(var/T in SkillBanned)
		if(W.name == T)
			S.CombatOut("This skill is temporaly banned.")
			return 1