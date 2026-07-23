#define TRUE 	1
#define FALSE	0
atom/var
	EnvironmentHealth= 10000

turf/atom/TestWall
	icon			= 'smoothrocks.dmi'
	icon_state 		= ""
	density			= TRUE
	GroundLevel		= 1
	WaterSource		= FALSE
	WaterConnected	= FALSE
	opacity    		= TRUE
	GrowthLevel		= FALSE

	New()
		..()
		color=rgb(79,72,67)

turf/atom/Ground/Dirt
	icon			='DirtTest.dmi'
	icon_state 		= ""
	density			= FALSE
	GroundLevel		= 0
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE
	New()
		..()
		color=rgb(186,132,69)

turf/atom/DirtLow
	icon			= 'DirtLowOriginal.dmi'
	icon_state		= ""
	density			= FALSE
	GroundLevel		= -1
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE
	New()
		..()
		color=rgb(120,87,81)

turf/atom/Water
	icon			= 'WaterTest.dmi'
	icon_state		= ""
	density			= FALSE
	GroundLevel		= -1
	WaterSource		= TRUE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE
	SwimingDifficulty=2
	var/HasFish		= 0
	New()
		..()
		color=rgb(0,150,255)

turf/atom/Edges
	icon			= 'Edgess.dmi'
	icon_state 		= "5"
	density			= FALSE
	GroundLevel		= 0
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE
	New()
		..()
		color=rgb(79,72,67)

turf/atom/Hole
	icon			= 'Hole.dmi'
	icon_state 		= "5"
	density			= FALSE
	GroundLevel		= -2
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE
	layer			= 6
	Cross(mob/A)
		if(!A.Flying)
			A.z--
		return ..()

turf/atom/Underground
	icon			= 'UndergroundFloor.dmi'
	icon_state 		= "basalt0"
	density			= FALSE
	GroundLevel		= -2
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE

turf/atom/Lava
	icon			='Lava.dmi'
	icon_state 		= ""
	density			= TRUE
	GroundLevel		= 0
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE


turf/atom/Ground/Grass
	icon			='GrassOriginal.dmi'
	icon_state 		= ""
	density			= FALSE
	GroundLevel		= 0
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE
	New()
		..()
		color=rgb(0,225,0)

turf/atom/Ground/Sand
	icon			='SandOriginal.dmi'
	icon_state 		= ""
	density			= FALSE
	GroundLevel		= 0
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE

turf/atom/Sky
	icon			='SkyOriginal.dmi'
	icon_state 		= "Sky"
	density			= FALSE
	GroundLevel		= 0
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE
	layer			= 6

//=============================Teleporters=================================
turf/atom/Teleporters/Caves
	icon			= 'CaveEntrance.dmi'
	icon_state		= ""
	Health			= 1.#INF
	density			= FALSE
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE

	Cave01Out
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/Caves/Cave01In)
	Cave01In
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/Caves/Cave01Out)

	Cave02Out
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/Caves/Cave02In)
	Cave02In
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/Caves/Cave02Out)

	Cave03Out
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/Caves/Cave03In)
	Cave03In
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/Caves/Cave03Out)

	Cave04Out
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/Caves/Cave04In)
	Cave04In
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/Caves/Cave04Out)

turf/atom/Teleporters/ALtoLR
	icon			= 'SBombGivePower.dmi'
	icon_state		= ""
	Health			= 1.#INF
	density			= FALSE
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE

	AL
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/ALtoLR/LR)
	LR
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/ALtoLR/AL)

turf/atom/Teleporters/KorinTower
//	icon			= ''
	icon_state		= ""
	Health			= 1.#INF
	density			= FALSE
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE

	UPKorin
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/KorinTower/DOWNKorin)
	DOWNKorin
		Enter(mob/M) M.loc=locate(/turf/atom/Teleporters/KorinTower/UPKorin)

















//----------------------------Arena Turf
turf/atom/TestWall/ArenaVoid
	icon			='Hell turf.dmi'
	icon_state 		= ""
	density			= TRUE
	GroundLevel		= 0
	WaterSource		= FALSE
	WaterConnected	= FALSE
	GrowthLevel		= FALSE
	opacity    		= FALSE
	layer			= 6






