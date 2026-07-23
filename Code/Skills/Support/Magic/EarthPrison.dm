Skill/Spell
	Earth_Prison

//		DMGT			= DMG_TIER_2
//		CDT				= CD_TIER_2
//		EDT				= ED_TIER_2
//		KBT				= KB_TIER_4
		DMGSOURCE_STR	= DMGS_TIER_3
		WEAPON			= NO
		LT				= HEAD
		UL				= HEAD

		desc="This will create a large barrier 5 tiles away from you to trap in your enemies."
		verb/Earth_Prison()
			set category = "Skills"
			if(usr.RPMode) return
			if(SkillSafeCheckUnarmed(usr,src))
				//TESTINGREPLACE
				return
			if(usr.Magic_Level >= 55)
				var/Cost = 15000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.Ki=(usr.Ki-EDT)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						var/startx=usr.x-5
						var/starty=usr.y-5
						var/endx=usr.x+5
						var/endy=usr.y+5
						if(startx<1) startx=1
						if(starty<1) starty=1
						if(endx>world.maxx) endx=world.maxx
						if(endy>world.maxy) endy=world.maxy
						var/placer=startx
						var/placery=starty
						spawn()
							while(placery<endy+1)
								//if(startx>=placer&&placer<=endx)
								if(placery==starty)
									var/turf/C=new /obj/Blocker/EarthPrison(locate(placer,placery,usr.z))
									C.Builder="[usr.real_name]"
									C.Health=(usr.Magic_Level**3)*500
									spawn(12*usr.Magic_Level) del(C)
								else if(placer==startx||placer==endx)
									var/turf/C=new /obj/Blocker/EarthPrison(locate(placer,placery,usr.z))
									C.Builder="[usr.real_name]"
									C.Health=(usr.Magic_Level**3)*500
									spawn(12*usr.Magic_Level) del(C)
								else if(placery==endy)
									var/turf/C=new /obj/Blocker/EarthPrison(locate(placer,placery,usr.z))
									C.Builder="[usr.real_name]"
									C.Health=(usr.Magic_Level**3)*500
									spawn(12*usr.Magic_Level) del(C)
								if(placer>=endx)
									placer=startx
									placery++
								else
									if(placery>starty&&placery<endy) placer=endx
									else placer++
								sleep(0)
						CD=CDCalculation(src,usr)
						CDTick(usr)
						M.Value -= Actual
						for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to cast Earth Prison")
						hearers(10,usr)<<sound('magic.ogg',volume=20)
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Earth Prison spell."
						return
