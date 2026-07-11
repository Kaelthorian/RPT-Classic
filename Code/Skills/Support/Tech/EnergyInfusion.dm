Skill/Technology/Energy_Infusion

//	DMGT			= DMG_TIER_2
//	CDT				= CD_TIER_2
//	EDT				= ED_TIER_2
//	KBT				= KB_TIER_4
	DMGSOURCE_STR	= DMGS_TIER_3
	WEAPON			= NO
	LT				= HEAD
	UL				= HEAD

	desc="This will grant someone +25% of their Ki reserves in one quick burst."
	var/LastUse=0
	verb/Energy_Infusion()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.KOd) return
		if(LastUse+0.1>Year)
			usr<<"You must wait until Year [LastUse+0.1] to use this again."
			return
		for(var/mob/M in get_step(usr,dir))
			var/Cost = 1000000
			var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
			usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
			if(usr.Confirm("Cast Energy Infusion on [M] for [Commas(Actual)]?"))
				for(var/obj/Resources/RR in usr)
					if(RR.Value > Actual)
						if(usr.Confirm("Use Energy Infusion on [M]?"))
							RR.Value-=Actual
							M.Ki+=M.MaxKi*0.25
							LastUse=Year
							view(usr)<<"<font color=#FFFF00>[usr] uses [src] on [M]"
							CD=(1+Modifier(usr))/CDT
							CDTick(usr)
					else
						usr << "You do not have [Commas(Actual)] resources to spare in order to use the Energy Infusion."
						return
			break