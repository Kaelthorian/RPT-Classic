#define DEBUG
world
	hub = "RTProduction.RoleplayTenkaichi"
	hub_password = "sdfhgfshfghsfg"
	name = "RT - Resurrection"
//	map_format = TILED_ICON_MAP
	turf = /turf/Special/Blank
	tick_lag = 1 // Don't fuck with tick_lag. Seriously, it screws up sleep, the scheduler and other things.
	cache_lifespan = 999
	loop_checks = 1
	status="<font color=#000000><b><font size=1>"
	mob = /mob/player // the player mob
	icon_size = 32
	fps = 20

var/global/RadiantEnergy=6

var/global/
	GG=0.00001
	autoannounce
	autoannouncedelay=10
	CustomEXPOptions
	RealmTeleport=1
	GainMultRate = 1
	GlobalObjective
	MinGainMult = 1
	StarterBoostBP=500
	afk_time=10000 // 10 minutes
	DebugOn=1
	Year=0
	StatSoft=50
	SoftStatCap=450
	MonthCycle=1
	Month=1
	Global_GodKiCap=1
	HubText = null
	TestServerOn = 0// If the server isn't an official server some things are changed. 0 if NOT a Test Server!
	Version = "[world.name] - [global.HubText]"   //- [HubText]"
	Portals = list(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48)
	Admin_Int_Setting = 1
	Year_Speed = 3000
	StatGain=12
	TrueBPCap=150
	DayScaler=1.36
	WipeDay=1
	Ki_Power=1 //This is a multiplier of the overall damage of all ki attacks to balance them out.
	GravTune
	TournamentOn=0


	const/Gain_Divider = 0.0000001
	const/Stat_Gain_Divider=0.12
	const/MAX_MESSAGE_LEN = 6144	//6kb per text wall
	const/MAX_PROFILE_LEN = 530
	const/MAX_DISCORD_LEN = 1200
	const/MAX_NAME_LENGTH = 50		//Set this in one fucking place gd
	const/INFINITY = 1e31 //closer then enough to be near to close
	const/SPACE_Z_LEVEL = 12	//used in checks

	//startRuin = 0 // Used to see if this server should be Ruined. Default should be 0

	list/admins = list("mumit"="Owner","kael224"="Owner","The_Skyla"="SeniorAdministrator")


	list/Mines = new

	tmp/list/Players = list()
	list/cardinal = list( NORTH, SOUTH, EAST, WEST )
	list/alldirs = list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)

	list/AllowRares = new

	list/MajinAbsorbRemove=new
	list/MutedList = new
	list/given[0] //a list for whoose been given a hash for their bans
	list/NoMove = list(/Language,/BodyPart,/Language,/Skill,/obj/Planets/Alien,/obj/Planets/SpaceStation,/obj/Planets/Arconia,/obj/Planets/Desert,/obj/Planets/Earth,/obj/Planets/Ice,/obj/Planets/Jungle,/obj/Planets/Namek,/obj/Planets/Vegeta,/obj/Planets/Ocean,/obj/Planets/DarkPlanet,/obj/Controls,/obj/Controls/PodControls,/obj/Airlock,/obj/AndroidAirlock,/obj/AndroidShip,/obj/Warper)



	list/NoCloak = list(/Language,/BodyPart,/Language,/Skill,/obj/items/Magic_Ball,/obj/items/Bomb,/obj/Ships/ShipMKIII,/obj/Ships/ShipMKII,/obj/Ships/Ship,/obj/Ships/Ship/Ardent,/obj/Ships/Ship/Icebreaker,/obj/AndroidShip,/obj/Controls,/obj/Controls/PodControls,/obj/Airlock,/obj/AndroidAirlock,/obj/Controls/MKIControls,/obj/Controls/MKIIControls,/obj/Controls/MKIIIControls)

	diary = null
	errors = null

	ooc_allowed = 1

		//LOOC



	looc_1=1
	looc_2=1
	looc_3=1
	looc_4=1
	looc_5=1
	looc_6=1
	looc_7=1
	looc_8=1
	looc_9=1
	looc_10=1
	looc_11=1
	looc_12=1
	looc_13=1
	looc_14=1
	looc_15=1
	looc_16=1
	looc_17=1


	WorldLoaded = 0	//Dynamic lighting doesn't take effect until 1
	ItemsLoaded=0
	MapsLoaded=0
	CanSave = 0
	debuglog = file("Data/Logs/debuglog.log")
	topiclog = file("topiclog.log")

	Dead_Time = 3
	Allow_Save = 0
	Allow_Rares = "Off"
	Androids = 0
	Security = 0
	MainFrame = 0
	BuildModule = 0
	First_SSJ = 0
	First_SSJ2 = 0

	Injury_Max =0.9 // 20% reduction in stats for a broken arm or leg.
	rebooting = 0
	Password = "Lappens"
	Server_Activated = 1//0
	Smokes = 0

//Race Toggles
	AllowSaiyan=1
	AllowTuffle=1
	AllowHuman=1
	AllowMakyo=1
	AllowSD=0
	AllowNamek=1
	AllowChangeling=1
	AllowAndroid=0
	AllowOni=1
	AllowDemon=1
	AllowKaio=1
	AllowDemigod=1
	AllowAlien=0
	AllowElite=1
	AllowHeran=1
	AllowYardrat=1
	AllowKanassa=1

	Global_SSJ= 0
	Global_SSJ2= 0
	Global_Trans=0
	Global_Ascension= 0

	Global_GodKi=0
	Global_GodKiTrain=0

	TechCap=25

	commonSpawn	="364,147,2"
	ALSpawn		="245,158,11"

	YardratSpawn	=commonSpawn
	DemigodSpawn	=ALSpawn
	HeranSpawn		=commonSpawn
	OniSpawn		=ALSpawn
	AlienSpawn		=commonSpawn
	HumanSpawn		=commonSpawn
	KanassaSpawn	=commonSpawn
	TuffleSpawn		=commonSpawn
	NamekianSpawn	=commonSpawn
	SaiyanSpawn		="412,162,2"
	IcerSpawn		=commonSpawn
	MakyoSpawn		=commonSpawn
	KaioSpawn		=ALSpawn
	DemonSpawn		=ALSpawn

	DEADX=245
	DEADY=158
	DEADZ=11

//	Item Saves
	list/ItemSerialList = new



/world/New()
	LoadHubText()
	LoadActivation()
//	ActivatePixelMovement()
	..()
	diary = file("Data/Logs/world/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log")
	diary << ""
	diary << ""
	diary << "Starting up. [time2text(world.timeofday, "hh:mm.ss")]"
	diary << "---------------------"
	diary << ""

	errors = file("Data/Logs/errors.log")
	errors << ""
	errors << ""
	errors << "Starting up. [time2text(world.timeofday, "hh:mm.ss")]"
	errors << "---------------------"
	errors << ""
	log = errors
	spawn(1) Initialize()
	spawn(50)WorldFixEnviromentStarter()
	spawn(50)YearBook()
	world.status="[world.status] [Version]<br> [HubText]"

/world/Del()

	diary << ""
	diary << "Shutting down. [time2text(world.timeofday, "hh:mm.ss")]"
	diary << "---------------------"
	diary << ""

	errors << ""
	errors << "Shutting down. [time2text(world.timeofday, "hh:mm.ss")]"
	errors << "---------------------"
	errors << ""
	..()



proc/CleanUpLoop()
	set waitfor=0
	for(var/obj/TrainingEq/M) if(M.Health<=0 && M.loc && M.z!=0) del(M)
	Clear_Stray_Clothes()
	CleanFish()

proc/Clear_Stray_Clothes()
	set waitfor=0
	for(var/obj/items/Clothes/C in world) if(C.loc && C.z!=0 && C.Savable==0) del(C)
	for(var/obj/items/Weights/W in world) if(W.loc && W.z!=0) del(W)



/world/OpenPort()
	..()
	spawn(30)
		world<<"World Link<br>[world.url]"

/world/IsBanned(key,address,computer_id)
	..()	//Do default checks


/world/Reboot(var/reason)
	for(var/client/C in world)
		C << link("byond://[world.internet_address]:[world.port]")
		spawn(rand(100,300)) C.mob.Login()
	..(reason)

/world.Import()
	Banlist.dir.Add(src.address)
	return()
/client.Import()
	return()
