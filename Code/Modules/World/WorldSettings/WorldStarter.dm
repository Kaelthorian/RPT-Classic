proc/Initialize()
	set waitfor=0
	if(WorldLoaded)
		world.log << "Attempted to Initialize World when World was already initialized!"
		diary << "Attempted to Initialize World when World was already initialized!"
		return
	WorldLoaded = 1

	if(global.TestServerOn)
		Version_Notes={"
	<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
	<html><head><title>Roleplay Tenkaichi!</title></head>
	<body>Discord: https://discord.gg/nqJWvbhfn9<br><hr>
	Welcome friends, we are testing!
	<br><br>
	Post bug reports and feedback to the discord!
	<br><br>
	</body></html>
	"}
	LoadItemSerialList()
	LoadBanHashes()
	LoadBans()
	load_admins()
	SkillBanned()
	LoadScalingPower()
	LoadBans()
	LoadYear()
	sleep(0)
	Load_Gain()
	sleep(0)
	LoadLogin()
	sleep(0)
	Load_Spawns()
	sleep(0)
	world << "Item Serial list , Bans, Admins,Skill Banned , Power Scaling and Year loaded..."
	world.log << "Gains and Etc loaded..."
	AntiDupProc()
	spawn(15)
		MapEnviromentLoad()
		LoadItems()
		ItemSerialLoad()
		UnderVisContent()

	AddBuilds()
	spawn SaveWorldRepeat()
	spawn Save_Loop() //Not sure what Save() does or i can't remember but it will stay for now
	Load_Area()
	SetMPList()
	fill_techlist() // fill global tech list
	for(var/obj/items/A in world)  //anti void obj check
		if(isnull(A.loc)&&A.z==0)
			DeleteSaveItem(A)
			del(A)
	log_errors("World Opened Successfully [time2text(world.timeofday, "hh:mm.ss")]")
	DayBook()
	AutoAnnounce()
	Allow_Save = 1


