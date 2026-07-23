//Settings for the Melee skills//
Skill/var

//Damage
	#define DMG_TIER_1	1
	#define DMG_TIER_2	1
	#define DMG_TIER_3	1
	#define DMG_TIER_4	1

	DMGT

//Energy Drain
	#define ED_TIER_1 	15
	#define ED_TIER_2 	30
	#define ED_TIER_3 	45
	#define ED_TIER_4 	60

	EDT

//CoolDown
	#define CD_TIER_1 	20
	#define CD_TIER_2 	15
	#define CD_TIER_3	10
	#define CD_TIER_4	5

	#define BUFF_CD		200
	#define DEBUFF_CD	100

	CDT

//Knockback
	#define KB_TIER_1 	0
	#define KB_TIER_2 	1
	#define KB_TIER_3 	3
	#define KB_TIER_4 	5

	KBT

//Damage source
	#define	DMGS_TIER_1 3.5
	#define DMGS_TIER_2 5.25
	#define DMGS_TIER_3 7.87
	#define DMGS_TIER_4 11.81

	DMGSOURCE_STR	=0
	DMGSOURCE_OFF	=0
	DMGSOURCE_DEF	=0
	DMGSOURCE_POW	=0
	DMGSOURCE_SPD	=0
	DMGSOURCE_END	=0

//Weapon Check
	#define YES 		1
	#define NO			0

	tmp/WEAPON

//Limb Target Damage
	#define BODY 		"Body"
	#define HEAD 		"Head"
	#define EYES		"Eyes"
	#define EARS		"Ears"
	#define RIGHT_ARM	"Right Arm"
	#define	LEFT_ARM	"Left Arm"
	#define ARMS		"Arms"
	#define RIGHT_LEG	"Right Leg"
	#define LEFT_LEG	"Left Leg"
	#define LEGS		"Legs"
	#define GROIN		"Groin"
	#define CHEST		"Chest"
	#define TAIL		"Tail"

	LT
	UL

//Traits for Skills
	//Positives
	#define SKILLSHOOT	1.2
	//SKILLSHOOT
	#define SKILLSHOOT_I	1.2
	#define SKILLSHOOT_II	1.4
	#define SKILLSHOOT_III	1.6
	#define SKILLSHOOT_IV	1.8
	#define SKILLSHOOT_V	2

	#define	SPAMMABLE	0.8
	//SPAMMABLE
	#define SPAMMABLE_I		0.8
	#define SPAMMABLE_II	0.6
	#define SPAMMABLE_III	0.4
	#define SPAMMABLE_IV	0.2
	#define SPAMMABLE_V		0

	#define	STRONG		1.2
	//STRONG
	#define STRONG_I		1.2
	#define STRONG_II		1.4
	#define STRONG_III		1.6
	#define STRONG_IV		1.8
	#define STRONG_V		2

	#define	ENERGYFLOW	0.8
	//ENERGYFLOW
	#define ENERGYFLOW_I	0.8
	#define ENERGYFLOW_II	0.6
	#define ENERGYFLOW_III	0.4
	#define ENERGYFLOW_IV	0.2
	#define ENERGYFLOW_V	0

	#define	FASTLOCK	1.2
	//FASTLOCK
	#define FASTLOCK_I		1.2
	#define FASTLOCK_II		1.4
	#define FASTLOCK_III	1.6
	#define FASTLOCK_IV		1.8
	#define FASTLOCK_V		2

	#define	HEAVYPUNCH	1.2
	//HEAVYPUNCH
	#define HEAVYPUNCH_I	1.2
	#define HEAVYPUNCH_II	1.4
	#define HEAVYPUNCH_III	1.6
	#define HEAVYPUNCH_IV	1.8
	#define HEAVYPUNCH_V	2

	#define WEAKPOINT	1.2
	//WEAKPOINT
	#define WEAKPOINT_I		1.2
	#define WEAKPOINT_II	1.4
	#define WEAKPOINT_III	1.6
	#define WEAKPOINT_IV	1.8
	#define WEAKPOINT_V		2

	#define	ENERGETIC	1.2
	//ENERGETIC
	#define ENERGETIC_I		1.2
	#define ENERGETIC_II	1.4
	#define ENERGETIC_III	1.6
	#define ENERGETIC_IV	1.8
	#define ENERGETIC_V		2
//------------------------------------
	//Negatives

	#define HOMING		1.2
	//HOMING
	#define HOMING_I		1.2
	#define HOMING_II		1.4
	#define HOMING_III		1.6
	#define HOMING_IV		1.8
	#define HOMING_V		2

	#define	WINDUP		1.2
	//WINDUP
	#define WINDUP_I		1.2
	#define WINDUP_II		1.4
	#define WINDUP_III		1.6
	#define WINDUP_IV		1.8
	#define WINDUP_V		2

	#define	WEAK		0.8
	//WEAK
	#define WEAK_I			0.8
	#define WEAK_II			0.6
	#define WEAK_III		0.4
	#define WEAK_IV			0.2
	#define WEAK_V			0

	#define	ENERGYBLOCK	1.2
	//ENERGYBLOCK
	#define ENERGYBLOCK_I	1.2
	#define ENERGYBLOCK_II	1.4
	#define ENERGYBLOCK_III	1.6
	#define ENERGYBLOCK_IV	1.8
	#define ENERGYBLOCK_V	2

	#define	LIGHTPUNCH	1.2
	//LIGHTPUNCH
	#define LIGHTPUNCH_I	1.2
	#define LIGHTPUNCH_II	1.4
	#define LIGHTPUNCH_III	1.6
	#define LIGHTPUNCH_IV	1.8
	#define LIGHTPUNCH_V	2

	#define AIMLESS		0.8
	//AIMLESS
	#define AIMLESS_I		0.8
	#define AIMLESS_II		0.6
	#define AIMLESS_III		0.4
	#define AIMLESS_IV		0.2
	#define AIMLESS_V		0

	#define	DRAINING	1.2
	//DRAINING
	#define DRAINING_I		1.2
	#define DRAINING_II		1.4
	#define DRAINING_III	1.6
	#define DRAINING_IV		1.8
	#define DRAINING_V		2

	//Stats


	tmp/list/SKILLTRAIT

/////////////////////////////////////////////////
//Settings for the Ki skills//
/////////////////////////////////////////////////
obj/ranged/Blast/var

//Damage
	#define DMG_TIER_1	1
	#define DMG_TIER_2	1
	#define DMG_TIER_3	1
	#define DMG_TIER_4	1

	DMGT

//Energy Drain
	#define ED_TIER_1 	15
	#define ED_TIER_2 	30
	#define ED_TIER_3 	45
	#define ED_TIER_4 	60

	EDT

//CoolDown
	#define CD_TIER_1 	20
	#define CD_TIER_2 	15
	#define CD_TIER_3	10
	#define CD_TIER_4	5

	CDT

//Knockback
	#define KB_TIER_1 	0
	#define KB_TIER_2 	1
	#define KB_TIER_3 	3
	#define KB_TIER_4 	5

	KBT

//Damage source
	#define	DMGS_TIER_1 3.5
	#define DMGS_TIER_2 5.25
	#define DMGS_TIER_3 7.87
	#define DMGS_TIER_4 11.81

	DMGSOURCE_STR	=0
	DMGSOURCE_OFF	=0
	DMGSOURCE_DEF	=0
	DMGSOURCE_POW	=0
	DMGSOURCE_SPD	=0
	DMGSOURCE_END	=0

//Weapon Check
	#define YES 		1
	#define NO			0

	tmp/WEAPON

//Limb Target Damage
	#define BODY 		"Body"
	#define HEAD 		"Head"
	#define EYES		"Eyes"
	#define EARS		"Ears"
	#define RIGHT_ARM	"Right Arm"
	#define	LEFT_ARM	"Left Arm"
	#define ARMS		"Arms"
	#define RIGHT_LEG	"Right Leg"
	#define LEFT_LEG	"Left Leg"
	#define LEGS		"Legs"
	#define GROIN		"Groin"
	#define CHEST		"Chest"
	#define TAIL		"Tail"

	LT
	UL

//Traits for Skills
	//Positives
	#define SKILLSHOOT	1.2
	//SKILLSHOOT
	#define SKILLSHOOT_I	1.2
	#define SKILLSHOOT_II	1.4
	#define SKILLSHOOT_III	1.6
	#define SKILLSHOOT_IV	1.8
	#define SKILLSHOOT_V	2

	#define	SPAMMABLE	0.8
	//SPAMMABLE
	#define SPAMMABLE_I		0.8
	#define SPAMMABLE_II	0.6
	#define SPAMMABLE_III	0.4
	#define SPAMMABLE_IV	0.2
	#define SPAMMABLE_V		0

	#define	STRONG		1.2
	//STRONG
	#define STRONG_I		1.2
	#define STRONG_II		1.4
	#define STRONG_III		1.6
	#define STRONG_IV		1.8
	#define STRONG_V		2

	#define	ENERGYFLOW	0.8
	//ENERGYFLOW
	#define ENERGYFLOW_I	0.8
	#define ENERGYFLOW_II	0.6
	#define ENERGYFLOW_III	0.4
	#define ENERGYFLOW_IV	0.2
	#define ENERGYFLOW_V	0

	#define	FASTLOCK	1.2
	//FASTLOCK
	#define FASTLOCK_I		1.2
	#define FASTLOCK_II		1.4
	#define FASTLOCK_III	1.6
	#define FASTLOCK_IV		1.8
	#define FASTLOCK_V		2

	#define	HEAVYPUNCH	1.2
	//HEAVYPUNCH
	#define HEAVYPUNCH_I	1.2
	#define HEAVYPUNCH_II	1.4
	#define HEAVYPUNCH_III	1.6
	#define HEAVYPUNCH_IV	1.8
	#define HEAVYPUNCH_V	2

	#define WEAKPOINT	1.2
	//WEAKPOINT
	#define WEAKPOINT_I		1.2
	#define WEAKPOINT_II	1.4
	#define WEAKPOINT_III	1.6
	#define WEAKPOINT_IV	1.8
	#define WEAKPOINT_V		2

	#define	ENERGETIC	1.2
	//ENERGETIC
	#define ENERGETIC_I		1.2
	#define ENERGETIC_II	1.4
	#define ENERGETIC_III	1.6
	#define ENERGETIC_IV	1.8
	#define ENERGETIC_V		2
//------------------------------------
	//Negatives

	#define HOMING		1.2
	//HOMING
	#define HOMING_I		1.2
	#define HOMING_II		1.4
	#define HOMING_III		1.6
	#define HOMING_IV		1.8
	#define HOMING_V		2

	#define	WINDUP		1.2
	//WINDUP
	#define WINDUP_I		1.2
	#define WINDUP_II		1.4
	#define WINDUP_III		1.6
	#define WINDUP_IV		1.8
	#define WINDUP_V		2

	#define	WEAK		0.8
	//WEAK
	#define WEAK_I			0.8
	#define WEAK_II			0.6
	#define WEAK_III		0.4
	#define WEAK_IV			0.2
	#define WEAK_V			0

	#define	ENERGYBLOCK	1.2
	//ENERGYBLOCK
	#define ENERGYBLOCK_I	1.2
	#define ENERGYBLOCK_II	1.4
	#define ENERGYBLOCK_III	1.6
	#define ENERGYBLOCK_IV	1.8
	#define ENERGYBLOCK_V	2

	#define	LIGHTPUNCH	1.2
	//LIGHTPUNCH
	#define LIGHTPUNCH_I	1.2
	#define LIGHTPUNCH_II	1.4
	#define LIGHTPUNCH_III	1.6
	#define LIGHTPUNCH_IV	1.8
	#define LIGHTPUNCH_V	2

	#define AIMLESS		0.8
	//AIMLESS
	#define AIMLESS_I		0.8
	#define AIMLESS_II		0.6
	#define AIMLESS_III		0.4
	#define AIMLESS_IV		0.2
	#define AIMLESS_V		0

	#define	DRAINING	1.2
	//DRAINING
	#define DRAINING_I		1.2
	#define DRAINING_II		1.4
	#define DRAINING_III	1.6
	#define DRAINING_IV		1.8
	#define DRAINING_V		2

	//Stats


	tmp/list/SKILLTRAIT

//Fight Settings
var/DEFAULTACC						=55
var/DEFAULT_BLOCK_ENERGY			=0.025
var/DEFAULT_DODGE_ENERGY			=0.025
var/DEFAULT_UNARMED_ENERGY			=0.1
var/DEFAULT_SWORD_ENERGY			=0.125
var/DEFAULT_HAMMER_ENERGY			=0.15


//Skill variables in the user
mob/var/tmp/energydraining=0
mob/var/tmp/transenergydraining=0
mob/var/tmp/healthdraining=0
mob/var/LastUsedSenzu=0
mob/var/Absorbed = 0
mob/var/MajinAbsorbed
mob/var/KPAuthorized=0
mob/var/tmp/SolarFlared=0
mob/var/tmp/Observer=null
mob/var/LastAlignmentAssign=-2
mob/var/LastEXPAssign=-2
mob/var/EXP=0
mob/var/tmp/HeartAiming=0
mob/var/tmp/IceyGrip=0
mob/var/tmp/CriticalEdge=0
mob/var/GuardBroken=0
mob/var/tmp/GuardBreaking=0
mob/var/ChakraBlocked=0
mob/var/tmp/ChakraBlocking=0
mob/var/tmp/DashAttacking=0
mob/var/Wing_Clipped=0
mob/var/tmp/Smashing=0
mob/var/tmp/Blocking=0
mob/var/tmp/KiBlade = 0
mob/var/tmp/KiHammer = 0
mob/var/tmp/SpiritSword = 0
mob/var/tmp/AttackXY
mob/var/tmp/KiWeapon=null
mob/var/tmp/KBStr=0
mob/var/tmp/AerialRecovery=1
mob/var/RecentSendEnergy


Skill/var/tmp/InCD=0

obj/var/CD