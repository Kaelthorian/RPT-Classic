
//mob/luminosity=4

mob/var/tmp
	AdminSenseToggle=0
	move=1
	//Spell_CD = 0
	BuildOpen = 0
	BuildTab = "Roofs"

	DEBUGMATH
	TestChar=null // TestChar variable, used for looping the Status() proc on mobs with no clients.
	Weight=1
	mob/Target
	transing
	RaceDescription="Undefined Race Desc"  //Was nothing  null.var bug
	computer_id
	lastKnownKey
	Logged_Out_Body
	adminObserve
	onThrowCD = 0
	Gravity=1
	KB
	mob/GrabbedMob
	isGrabbing
	attacking
	Beam_Refire_Delay_Active
	mob/Opp         // Leeching STATS
	Went_Afk = 0
	afk=0
	TK_Last = null
	Delete = null
	obj/Ships/S=null
	Element
	ElementTicks
	EmpoweredDefenseTicks
	Redoing_Stats=0
	Points=15
	Max_Points=15
	adminDensity=0 // Admin density, allows admins to pass through walls and such unscathed
	immortal = 0 // temporary var that disables death checks on the mob, it's for a system to check if we can prevent people from dying multiple times from one attack
	training_id // id to make sure the scheduled event belongs to the current action. we dont want it saved so its a tmp

mob/var

	Total_Stats_Energy = 0
	Total_Stats_Strength = 0
	Total_Stats_Endurance = 0
	Total_Stats_Speed = 0
	Total_Stats_Off = 0
	Total_Stats_Def = 0
	Total_Stats_Regen = 0
	Total_Stats_Recov = 0

/* General Stats */


	//Born = 0
	Offspring=0
	DoesNotAffectStatRank=0
	HasCreated=0 // Prevent people from stacking statpoints to increase their mods.
	SelectingRace=0 //Prevents people from changing race after being spawned
	AgreedtoTerms=0 // Prevents people from spending Milestones on the creation window
	NitroBooster=0
	SelectedAge=0
	BodySwap=0
	Font="name"
	Race="Undefined"  //Was nothing  null.var bug
	Class="Undefined Class"  //Was nothing  null.var bug

	BP=1
	Base=1
	Body=1
	Ki=1
	MaxKi=1
	Pow=1
	Str=1
	Spd=1
	End=1
	Off=1
	Def=1
	Anger=100
	MaxAnger=120

	BPMult=1
	KiMult=1
	PowMult=1
	StrMult=1
	SpdMult=1
	EndMult=1
	OffMult=1
	DefMult=1
	RegenMult=1
	RecovMult=1
	AngerMult=1

	BaseMaxAnger=120
	BaseMaxKi=1
	BaseRegeneration=1
	BaseRecovery=1

	BPMod=1
	KiMod=1
	StrMod=1
	SpdMod=1
	PowMod=1
	EndMod=1
	OffMod=1
	DefMod=1
	Regeneration=1
	Recovery=1

	GravMastered=1
	GravMulti = 1
	GravMod=1
	Zenkai=1
	MedMod=1

	Age=0
	Real_Age=0
	Immortal=0
	InclineAge=18
	Decline=30

	TK_Magic = 0
	TK = 0
	Kills = 0
	Signature_True = 0
	RPs = 0

	Blindness = null
	x_view = 15
	y_view = 15

	Destroy_Walls = 0
	HPDoesNotAffectBP = 0
	KiDoesNotAffectBP = 0
	IgnoresBrokenLimbs = 0
	IgnoresGodKi=0
	NoBreak = 0

// Character Profile Vars

	Height="N/A"
	BodyWeight="N/A"
	Backstory="N/A"
	ImageLink="http://pngimg.com/uploads/question_mark/question_mark_PNG141.png"
	Portrait
	radarChart

	//Alignment = 0
	//AlignmentTxt = "Neutral"


/* Variables required for UnTeleport and ReturnMob */

	unSummonX=1
	unSummonY=1
	unSummonZ=1

/* Unsorted as of yet */

	datum/mind/mind
	real_name

	undelayed
	stretch=0
	ViewX=15
	ViewY=15
	TextSize=2
	seetelepathy=1

	hair

	HairColor
	BPpcnt=100
	attackable=1

	BreathInSpace=0

	RoidPower=0
	HBTCPower=0
	BlackWaterPower=0
	RPPower=1
	RPPowerAdd=0
	RacialPowerAdd=0

	AndroidLevel=0
	oicon=" "
	Warp=0

	Regenerate=0 //Like Majin and Bios regenerate instead of dying
	Regenerating

	Refire=20
	Dead=0
	Died = 0
	Life=100
	Anger_Restoration=0

/* Saiyan variables */
	OozaruIcon='OozaruNew.dmi'
	Oozaru=0
	OozaruMastery = 50
	OozaruTimer=0

	ssj = 0

	HasSSj = 0
	HasSSj4=0

	SSjMult=1.5
	SSjDrain=100
	SSjMod=1

	SSj2Mult=1.2
	SSj2Drain=100
	SSj2Mod=1

	SSj3Mult=1.3
	SSj3Drain=100
	SSj3Mod=1

	SSj4Mult=4


	SSGSSColor
	SSGSSDrain=50

	SSjHair='Hair_GokuSSj.dmi'
	USSjHair='Hair_GokuUSSj.dmi'
	SSjFPHair='Hair_GokuSSjFP.dmi'
	SSj2Hair='Hair_GokuUSSj.dmi'
	SSj3Hair='Hair_GokuSSj3.dmi'
	SSj4Hair='Hair_SSj4.dmi'
	SSGSSHair='Hair_GokuSSB.dmi'
	SSGFPHair='Hair_GokuSSBFP.dmi'
	SSRHair='Hair_GokuSSR.dmi'
	SSGHair

/* Changeling variables */
	Form=0

	HasForm=1
	Form2Mult = 1.1
	Form3Mult = 1.1
	Form4Mult = 1.5
	Form5Mult = 1.1
	Form6Mult = 1.2

	Form1Icon
	Form2Icon
	Form3Icon
	Form4Icon
	Form5Icon='Changeling Koola Expand.dmi'
	Form6Icon='FriezaGold.dmi'
	Form6Drain=50

	//Enlarged
	HasAlienTrans=0
	AlienTrans=0
	TransDrain = 100

	HasBojack=0
	Bojack=0
	BojackMult=1.6
	SuperBojackMult=1.25

	WeightedStats=0

	HadStarBoost=0
	MakyoPower=0

	SNj=0

	SparSSj=0
	SparAscended=0

	Rank

	list/Buffs=list()
	BuffLimit=3
	BuffNumber=0

	obj/GodKiAura=new/Icon_Obj/Cloak/GodAura//'Aura_godtest.dmi'

	FlightAura='Aura Fly.dmi'
	BlastCharge='Charge1.dmi'
	KiHitEffect='fevExplosion.dmi'

	Modules=0

	Counterpart

	FlySkill=1
	FlyMod=1
	SuperFly=0
	Zanzoken=1
	ZanzoMod=1

	Build=1
	RP_Total = 0
	AS_Droid = 0 //Is this player a Android ship android

	Fusions=0

	ismajin=0
	ismystic=0
	Precognition=0 //for the blast avoidance...

	PotentialUnlocked=0

	Absorb=0
	Semiperfect_Form=0
	Perfect_Form=0
	Fruits=0
	KeepsBody=0 //If this is 1 you keep your body when Dead.
	GavePower=0
	GotPower=0

	Spar = 1
	Critical_Left_Arm = 0
	Critical_Left_Leg = 0
	Critical_Right_Leg = 0
	Critical_Right_Arm = 0
	Critical_Head = 0
	Critical_Sight = 0
	Critical_Throat = 0
	Critical_Torso = 0
	Critical_Hearing = 0
	Critical_Mate = 0
	Critical_Tail = 0

	Conjured=0
	Conjurer=""
	ConjureX=1
	ConjureY=1
	ConjureZ=1
	ConjuredKey=""

	list/Overlays=new

	Asexual
	HBTC_Enters=0
	KaiokenCycle=0
	Senzu=0
	HealthPotion=0
	Hair_Base
	Hair_Age=1
	BirthYear=0
	YearCreated=0
	SaveAge=0
	LogYear=0

	MajinBy = null //For majin to check who gave them it.


	pfocus="Balanced"
	mfocus="Balanced"
	ifocus=0
	magicfocus=0

	Mining_Level=1
	Mining_XP=0
	Mining_Next=500

	Smithing_Level=1
	Smithing_XP=0
	Smithing_Next=500

	Fishing_Level=1
	Fishing_XP=0
	Fishing_Next=500

	Cooking_Level=1
	Cooking_XP=0
	Cooking_Next=500

	Int_Level=1
	Int_XP=0
	Int_Next=1000
	Int_Mod=1

	Magic_Level=1
	Magic_XP=0
	Magic_Next=1000
	Magic_Potential = 1

	GainMultiplier=1

	ZenkaiPower=0

	StatRank=1
	BPRank=1
	list/Minimum_Stats=new
	list/LearnList=list()//new

	medreward // Variable to allow an admin to reward and raise their levels WITHOUT forcing the player to meditate
	medrewardmagic

	Contacts = list()
	Ignores = list()
	TotalDeaths=0
	insideTank=0
	isSwimming = 0
	swimSkill = 100

//New wipe variables
	BoosterTag
	OOCTag

	CanLimbRegen=0
	KOd=0
	BirthDate="None"
	Signature = 0
	Stance=null
	StanceLevel=null
	SwordOn=0
	HammerOn=0
	GlovesOn=0
	MaskOn=0
	ArmorOn=0
	Willpower=100
	SwordSkill=1
	UnarmedSkill=1
	KiManipulation=1
	Athleticism=1
	SwordSkillAdd=0
	UnarmedSkillAdd=0
	KiManipulationAdd=0
	AthleticismAdd=0
	IsBandaged=0
	Sterile=0
	ScouterOn=0
	BuildInSpace=0
	Racial_Stats=2
	list/Mutations=list()
	MutationNumber
	UniqueMutation=0
	EnablementSlot=0
	MaxHealth=100
	MaxWillpower=100
	GotStarterBoost=0
	Old_Sight=0
	CatchUpMPs=0
	BeenGivenStartingGrav=0

	Alignment="Neutral"
	AlignmentNumber=0
	GoodKills=0
	BadKills=0
	Vampire=0
	Infection=0
	GotRE=0
	TaxPaid=0
	MTaxPaid=0
	HelmetOn=0
	CustomZanzokenIcon='Zanzoken.dmi'
	AntiPowerGameKey
	OverFlowPower=1
	Majinized
	AmountOfMajinized
	Cyborg
	SummonedBy
	tmp/CrystalPower
	CrystalClaimer
	Dispelled
	IgnoreRealmTeleport=0
	tmp/IsBlocking=0
	tmp/Animation=0
	NoWeapon=1
	Weights
	BoxingGloves

	HasSSJ3=0
	tmp/sim=0
	tmp/Creating=0
	tmp/TechWindowOpen
	tmp/MagicWindowOpen
	FleeAdd=0

mob/var/HasBeenInfected=0
mob
	var// Tab variables
		tmp/Toggled_Sense = 0
		Toggled_Timestamps=0
		tmp/Lethality=0
		SOverlayToggle=1
		BodyHUD=1
		viewStats=1
mob/var
	TextColorOOC = "red"
	TextColor="red"
mob/var/listen_ooc=1
mob/var/listen_looc=1
mob/var/tmp/SayCD=0
mob/var/tmp/EmoteCD=0
mob/var/MultikeyApproved=0
mob/var/tmp/OpeningDoor=0

mob/var
	LogTime=0
	RestedTime=0
	InspiredTime=0
//Stat Loop Finder
mob/var
	ManaCycle=0
	ResourceCycle=0
	BindPower=0
mob/var/tmp/DoNotUnfreeze=0
mob/var/LethalCombatTracker=0
mob/var/SeanceYear=0
mob/var/tmp/GoingHome=0
mob/var/LastEmoteAudit=0


mob/var
	HasUsedReplenish=0
	TicksOfReplenish=0
	HasUsedBookOfAges=0
	HasUsedBookOfFortitude=0
	HasUsedBookOfLessons=0
	HasUsedEmpowerment=0
	TicksOfMerriment=0
mob/var/HasUsedReform=0

mob/var/tmp
	IsFishing=0
	IsCooking=0


mob/var
	HasFoodWP=0
	HasFoodRegen=0
	HasFoodRecov=0
	HasFoodBPTrain=0
	HasFoodStatsTrain=0
	HasFoodEnergyTrain=0
mob/var/LastUsedGrenade=0
mob/var/LastEOU=0

mob/var/Upgrade_Components
mob/var/HasAdamantineSkeleton=0
mob/var/PowerArmorOn=0


mob/var
	ShowRace=0
	ShowGender=0
	FakeAge
	FakeGender
	FakePortrait
	FakeBackstory
	FakeHeight
	FakeWeight

mob/var/tmp/LBCD=0

mob/var/tmp/DeadCap = 0 //Puts a cap/stopper on the Death() proc to avoid spamm killing that results from some ki attacks.

mob/var/LastKill=0

mob/var
	adjustedX=0
	adjustedY=0

mob/var/LoginAction=null
mob/var/MacroType=1

mob/var/tmp/ClashRoll = 0
mob/var/tmp/AutoAim	=0

mob/var/Swimming
mob/var/IsSwimming
mob/var/tmp/Spinning



mob/var/RaceEraScore



//Clashing Vars
mob/var/tmp/PushingRoll			=0
mob/var/tmp/PushingPunchRoll	=0
mob/var/tmp/TugWarRoll			=0

