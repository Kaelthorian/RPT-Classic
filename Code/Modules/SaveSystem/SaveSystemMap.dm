proc/FirstSave()
	NatureGrowthGrass()
	NatureGrowthDirt()
	SandSpawn()
	NatureGrowthSand()
	NatureScore()
	Save_Turfs()

proc/MapEnviromentLoad()
	Load_Turfs()
	WaterLevelCheck()


mob/Admin1/verb/FirstSaveTime()
	if(src.ckey != "kael224")
		world<<"[src] attemped to play god and fail."
		return
	else
		FirstSave()