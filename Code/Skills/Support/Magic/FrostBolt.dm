Skill/Spell
	Frost_Bolt

//		DMGT			= DMG_TIER_2
//		CDT				= CD_TIER_2
//		EDT				= ED_TIER_2
//		KBT				= KB_TIER_4
		WEAPON			= NO
		LT				= HEAD
		UL				= HEAD

		desc="This will fire a damaging ice blast that slows on hit and home towards your target."
		icon='Ice Blast.dmi'
		verb/Frost_Bolt()
			set category = "Skills"
			if(usr.RPMode) return
			if(SkillSafeCheckUnarmed(usr,src))
				//TESTINGREPLACE
				return
			if(usr.Magic_Level >= 43)
				var/Cost = 4000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						var/obj/ranged/Blast/A=unpool("Blasts")
						A.Belongs_To=usr
						flick("Blast",usr)
						A.DMGT				= src.DMGT
						A.DMGSOURCE_POW		= usr.Magic_Potential
						A.DMGSOURCE_STR		= 0
						A.DMGSOURCE_OFF		= 0
						A.DMGSOURCE_DEF		= 0
						A.DMGSOURCE_SPD		= 0
						A.DMGSOURCE_END		= 0
						A.SKILLTRAIT		= src.SKILLTRAIT
						A.LT				= HEAD
						A.UL				= HEAD
						A.pixel_x=pixel_x
						A.pixel_y=pixel_y
						A.pixel_x+=rand(-16,16)
						A.pixel_y+=rand(-16,16)
						A.icon=icon
						A.name="FrostBolt"
						var/MaskDamage=0
						if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
							MaskDamage=MM.Health
							MM.DurabilityCheck(usr)
							break
						if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
						A.Offense=usr.Off*1.2
						A.HeatSeeking=1
						A.Slowing=30
						A.dir=usr.dir
						A.loc=usr.loc
						walk(A,A.dir)
						M.Value -= Actual
						for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to cast Frost Bolt")
						CD=CDCalculation(src,usr)
						CDTick(usr)
						hearers(10,usr)<<sound('magic.ogg',volume=20)
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Frost Bolt spell."
						return