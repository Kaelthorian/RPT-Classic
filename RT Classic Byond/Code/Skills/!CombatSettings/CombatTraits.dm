//Damage

proc/SkillTraitDamage(Skill/S)
	var/TraitCalculation =1
	var/TraitSearcher
	for(TraitSearcher in S.SKILLTRAIT)

		if(TraitSearcher		== "STRONG_I")
			TraitCalculation= STRONG_I
		if(TraitSearcher		== "STRONG_II")
			TraitCalculation= STRONG_II
		if(TraitSearcher		== "STRONG_III")
			TraitCalculation= STRONG_III
		if(TraitSearcher		== "STRONG_IV")
			TraitCalculation= STRONG_IV
		if(TraitSearcher		== "STRONG_V")
			TraitCalculation= STRONG_V


		if(TraitSearcher		== "WEAK_I")
			TraitCalculation= WEAK_I
		if(TraitSearcher		== "WEAK_II")
			TraitCalculation= WEAK_II
		if(TraitSearcher		== "WEAK_III")
			TraitCalculation= WEAK_III
		if(TraitSearcher		== "WEAK_IV")
			TraitCalculation= WEAK_IV
		if(TraitSearcher		== "WEAK_V")
			TraitCalculation= WEAK_V

	return TraitCalculation

//CDs

proc/SkillTraitCooldownReduce(Skill/S)
	var/TraitCalculation =1
	var/TraitSearcher
	for(TraitSearcher in S.SKILLTRAIT)

		if(TraitSearcher		== "SPAMMABLE_I")
			TraitCalculation	= SPAMMABLE_I
		if(TraitSearcher		== "SPAMMABLE_II")
			TraitCalculation	= SPAMMABLE_II
		if(TraitSearcher		== "SPAMMABLE_III")
			TraitCalculation	= SPAMMABLE_III
		if(TraitSearcher		== "SPAMMABLE_IV")
			TraitCalculation	= SPAMMABLE_IV
		if(TraitSearcher		== "SPAMMABLE_V")
			TraitCalculation	= SPAMMABLE_V

		if(TraitSearcher		== "WINDUP_I")
			TraitCalculation	=WINDUP_I
		if(TraitSearcher		== "WINDUP_II")
			TraitCalculation	=WINDUP_II
		if(TraitSearcher		== "WINDUP_III")
			TraitCalculation	=WINDUP_III
		if(TraitSearcher		== "WINDUP_IV")
			TraitCalculation	=WINDUP_IV
		if(TraitSearcher		== "WINDUP_V")
			TraitCalculation	=WINDUP_V

	return TraitCalculation

//Dodge and Hit

proc/SkillTraitDodge(Skill/S)
	var/TraitCalculation =1
	var/TraitSearcher
	for(TraitSearcher in S.SKILLTRAIT)

		if(TraitSearcher		== "Homing")
			TraitCalculation=HOMING
		if(TraitSearcher		== "Fast Lock")
			TraitCalculation=FASTLOCK

	return TraitCalculation

proc/SkillTraitHit(Skill/S)
	var/TraitCalculation =1
	var/TraitSearcher
	if(istype(S,/mob))
		TraitCalculation=1
	for(TraitSearcher in S.SKILLTRAIT)

		if(TraitSearcher		== "SKILLSHOOT_I")
			TraitCalculation= SKILLSHOOT_I
		if(TraitSearcher		== "SKILLSHOOT_II")
			TraitCalculation= SKILLSHOOT_II
		if(TraitSearcher		== "SKILLSHOOT_III")
			TraitCalculation= SKILLSHOOT_III
		if(TraitSearcher		== "SKILLSHOOT_IV")
			TraitCalculation= SKILLSHOOT_IV
		if(TraitSearcher		== "SKILLSHOOT_V")
			TraitCalculation= SKILLSHOOT_V

		if(TraitSearcher		== "AIMLESS_I")
			TraitCalculation= AIMLESS_I
		if(TraitSearcher		== "AIMLESS_II")
			TraitCalculation= AIMLESS_II
		if(TraitSearcher		== "AIMLESS_III")
			TraitCalculation= AIMLESS_III
		if(TraitSearcher		== "AIMLESS_IV")
			TraitCalculation= AIMLESS_IV
		if(TraitSearcher		== "AIMLESS_V")
			TraitCalculation= AIMLESS_V


//	world<<"TraitCalculation: [TraitCalculation]"

	return TraitCalculation


//Energy Changes

proc/SkillTraitEnergy(Skill/S)
	var/TraitCalculation =1
	var/TraitSearcher
	for(TraitSearcher in S.SKILLTRAIT)

		if(TraitSearcher	== "ENERGYFLOW_I")
			TraitCalculation= ENERGYFLOW_I
		if(TraitSearcher	== "ENERGYFLOW_II")
			TraitCalculation= ENERGYFLOW_II
		if(TraitSearcher	== "ENERGYFLOW_III")
			TraitCalculation= ENERGYFLOW_III
		if(TraitSearcher	== "ENERGYFLOW_IV")
			TraitCalculation= ENERGYFLOW_IV
		if(TraitSearcher	== "ENERGYFLOW_V")
			TraitCalculation= ENERGYFLOW_V


		if(TraitSearcher	== "ENERGYBLOCK_I")
			TraitCalculation= ENERGYBLOCK_I
		if(TraitSearcher	== "ENERGYBLOCK_II")
			TraitCalculation= ENERGYBLOCK_II
		if(TraitSearcher	== "ENERGYBLOCK_III")
			TraitCalculation= ENERGYBLOCK_III
		if(TraitSearcher	== "ENERGYBLOCK_IV")
			TraitCalculation= ENERGYBLOCK_IV
		if(TraitSearcher	== "ENERGYBLOCK_V")
			TraitCalculation= ENERGYBLOCK_V

	return TraitCalculation


//Status

proc/SkillTraitStatus(Skill/S)
	var/TraitCalculation =1
	var/TraitSearcher
	for(TraitSearcher in S.SKILLTRAIT)

		if(TraitSearcher		== "Knockback")
			TraitCalculation= HEAVYPUNCH
		if(TraitSearcher		== "Light Punch")
			TraitCalculation= LIGHTPUNCH
		if(TraitSearcher		== "Weak points")
			TraitCalculation= WEAKPOINT

	return TraitCalculation

