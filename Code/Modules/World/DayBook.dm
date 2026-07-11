proc/DayBook()
	while(1)
		if(WipeDay<1)
			WipeDay=1
		WipeDayProgress++
		MonthCycle++
		if(MonthCycle>=5)
			Resources()
			Mana()
			MonthCycle=1
			Month++
			TurfsHealLoop()
			if(Month>12)
				Year++
				Month=1
				EraPowerChange()
			for(var/mob/player/A in Players) if(A)
				A.Yearly_Update()
				sleep(0)
			spawn
				for(var/turf/atom/Underground/G in world)
					if(prob(5))
						G.OreGenerate2()
				sleep(1)

		else world<<"<span class=\"narrate\">[YearOutput()]</span>"
		sleep(600*Year_Speed)//18000

