obj
	Props
		Trees
			Savable=0
			layer=4
			density=1
//			Spawn_Timer=180000
			Flammable = 1

turf
	Health=9000000001
	Upgradeable/Roofs
//		FlyOverAble=0
		Enter(atom/A)
			if(FlyOverAble||ghostDens_check(A)) return ..()
			else return
		Roof1
			icon='Roofs.dmi'
			icon_state="Roof1"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof1C
			icon='Roofs.dmi'
			icon_state="Roof1C"
			density=1
			opacity=1
			//FlyOverAble=0
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof2
			icon='Roofs.dmi'
			icon_state="Roof2"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof3
			icon='Roofs.dmi'
			icon_state="Roof3"
			density=1
			opacity=1
			//FlyOverAble=0
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof4
			icon='Roofs.dmi'
			icon_state="Roof4"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof4C
			icon='Roofs.dmi'
			icon_state="Roof4C"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof5
			icon='Roofs.dmi'
			icon_state="Roof5"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof5C
			icon='Roofs.dmi'
			icon_state="Roof5C"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof6
			icon='Roofs.dmi'
			icon_state="Roof6"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof7
			icon='Roofs.dmi'
			icon_state="Roof7"
			density=1
			//FlyOverAble=0
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof8
			icon='Roofs.dmi'
			icon_state="Roof8"
			density=1
			//FlyOverAble=0
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof9
			icon='Roofs.dmi'
			icon_state="Roof9"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof10
			icon='Roofs.dmi'
			icon_state="Roof10"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof11
			icon='Roofs.dmi'
			icon_state="Roof11"
			//FlyOverAble=0
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof12
			icon='Roofs.dmi'
			icon_state="Roof12"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof13
			icon='Roofs.dmi'
			icon_state="Roof13"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof14
			icon='Roofs.dmi'
			icon_state="Roof14"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof15
			icon='Roofs.dmi'
			icon_state="Roof15"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof16
			icon='Roofs.dmi'
			icon_state="Roof16"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof17
			icon='Roofs.dmi'
			icon_state="Roof17"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof18
			icon='Roofs.dmi'
			icon_state="Roof18"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof19
			icon='Roofs.dmi'
			icon_state="Roof19"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof20
			icon='Roofs.dmi'
			icon_state="Roof20"
			//FlyOverAble=0
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof21
			icon='Roofs.dmi'
			icon_state="Roof21"
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
		Roof22
			icon='Roofs.dmi'
			icon_state="Roof22"
			//FlyOverAble=0
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)) return ..()
				else return
obj/Turfs

	CustomObj1
		icon='ArtificalObj.dmi'
		icon_state="QuestionMark"

	Glass
		Urban_Glass_Roof
			icon='Skyscraper.dmi'
			icon_state="Glass"
			density=1
			Grabbable=0
		RoofGlass
			icon='Objects.dmi'
			icon_state="Glass"
			density=1
			Grabbable=0

	IconsXLBig
		icon='NewOther.dmi'
		Icon73
			icon_state="73"
			layer = MOB_LAYER+1
			density=1
		Icon74
			icon_state="74"
			layer = MOB_LAYER+1
			density=1
		Icon75
			icon_state="75"
			layer = MOB_LAYER+1
			density=1
	IconsX
		icon='NewObjects.dmi'
		Icon28
			icon_state="28"
			density=1
			layer = MOB_LAYER+1
		Icon132
			icon_state="132"
			layer = MOB_LAYER-1
	Sign
		icon='Objects.dmi'
		icon_state="Sign"
		density=1
		Click() if(desc) usr<<desc
		Information_Panel
			icon='Objects.dmi'
			icon_state="Sign2"
		Sign3
			icon='Objects.dmi'
			icon_state="Sign3"
		Sign4
			icon='Objects.dmi'
			icon_state="Sign4"
		Sign5
			icon='Objects.dmi'
			icon_state="Sign5"
		Sign6
			icon='Objects.dmi'
			icon_state="Sign6"
		SignGrave1
			icon='NewObjects.dmi'
			icon_state="129"
		verb/Bolt()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				Bolted=1
				Shockwaveable=0
				range(20,src)<<"[usr] bolts the [src] to the ground."

				return
			if(Bolted) if(src.Builder=="[usr.real_name]")
				range(20,src)<<"[usr] unbolts the [src] from the ground."
				Bolted=0
				Shockwaveable=1

				return
	MidgarObj
		StreetLamp
			icon='Stret Laump.dmi'
			Flammable = 1
			density=1
			layer=5
		Lampost
			icon='Lampost and chairs.dmi'
			icon_state="Lampost"
			Flammable = 1
			density=1
		Stool
			icon='Lampost and chairs.dmi'
			icon_state="Stool"
			Flammable = 1
			layer=4
		TV
			icon='Lampost and chairs.dmi'
			icon_state="Tv"
			Flammable = 1
			density=1
		Widescreen
			icon='Lampost and chairs.dmi'
			icon_state="Widescreen"
			Flammable = 1
			density=1
		SmallChairE
			icon='Lampost and chairs.dmi'
			icon_state="Small chairE"
			Flammable = 1
		SmallChairW
			icon='Lampost and chairs.dmi'
			icon_state="Small chairW"
			Flammable = 1
		BenchW
			icon='Lampost and chairs.dmi'
			icon_state="BenchW"
			Flammable = 1
		BenchE
			icon='Lampost and chairs.dmi'
			icon_state="BenchE"
			Flammable = 1
		Steelstool
			icon='Lampost and chairs.dmi'
			icon_state="Steel Stool"
			Flammable = 1
			layer=4
		PlushChair
			icon='Lampost and chairs.dmi'
			icon_state="Chair"
			Flammable = 1



obj/Blocker
	EarthPrison
		icon='Roofs.dmi'
		icon_state="Roof5"
		Grabbable=0
		Savable=0
		density=1
		opacity=1
		Enter(atom/A)
			if(ghostDens_check(A)) return ..()
			else return 0
		Cross(atom/A)
			if(ghostDens_check(A)) return ..()
			else return 0
	ForceField
		icon='ForceField.dmi'
		Grabbable=0
		Savable=0
		density=1
		opacity=0
		Bolted=1
		Enter(atom/A)
			if(ghostDens_check(A)) return ..()
			else return 0
		Cross(atom/A)
			if(ghostDens_check(A)) return ..()
			else return 0
turf/Special
	Buildable=0
	Blank
		opacity=1
		FlyOverAble=0
		density=1
		Health=1.#INF
		Enter(mob/A)
			if(ismob(A)) if(A.client)
				if(A.client.holder)
					return ..()
				else
					return 0
			else return 0//why was this del(A)
			if(ismob(A)) return 0
			else return 0//why was this del(A)
	PDTurf
		icon='PDTurf.dmi'
		icon_state="1"
	Static
		icon='Special.dmi'
		icon_state="Special5"
	Stars
		icon = 'StarPixel.dmi'
		icon_state="2"
		Health=1.#INF
	EventStars
		icon='StarPixel.dmi'
		icon_state="3"
		Health=1.#INF
	BiodomeGlass
		icon='Objects.dmi'
		icon_state="Glass"
		Health=5000000
		density=1
		opacity=0
		Enter(atom/A)
			if(ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb)))if(!istype(A,/obj/TrainingEq)) return ..()
			else return
turf/Special

	Buildable=0
turf/Special



	Teleporter2
		density=1
//		var/gotox
//		var/gotoy
//		var/gotoz
		Enter(mob/M) M.loc=locate(gotox,gotoy,gotoz)
		Health=1.#INF

	ArdentPortals
		icon='Lab.dmi'
		icon_state="Warp"
		Health=1.#INF
		density=1
		Portal1In
			Enter(mob/M) M.loc=locate(/turf/Special/ArdentPortals/Portal1Out)
		Portal1Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArdentPortals/Portal1In)
		Portal2In
			Enter(mob/M) M.loc=locate(/turf/Special/ArdentPortals/Portal2Out)
		Portal2Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArdentPortals/Portal2In)


	IceBreakerPortals
		icon='Lab.dmi'
		icon_state="Warp"
		Health=1.#INF
		density=1
		Portal1In
			Enter(mob/M) M.loc=locate(/turf/Special/IceBreakerPortals/Portal1Out)
		Portal1Out
			Enter(mob/M) M.loc=locate(/turf/Special/IceBreakerPortals/Portal1In)
		Portal2In
			Enter(mob/M) M.loc=locate(/turf/Special/IceBreakerPortals/Portal2Out)
		Portal2Out
			Enter(mob/M) M.loc=locate(/turf/Special/IceBreakerPortals/Portal2In)

area/CP
	verb/Reincarnate_Self()
		set category="Afterlife"
		usr<<"Choose new to reincarnate or load to cancel."
		usr.Reincarnation()
/*	verb/Visit_Living_Realm()
		set category="Afterlife"
		if(MakyoStar)
			if(usr.Confirm("Would you like to visit the living realm for 2 years?"))
				usr.SeanceYear=Year+2
				usr.Location() */
area/Hell
	verb/Reincarnate_Self()
		set category="Afterlife"
		usr<<"Choose new to reincarnate or load to cancel."
		usr.Reincarnation()
area/KSP
	verb/Reincarnate_Self()
		set category="Afterlife"
		usr<<"Choose new to reincarnate or load to cancel."
		usr.Reincarnation()






obj/Props
	Savable=0
	layer=4
//	Spawn_Timer=180000
	Buildable = 1
//	var/Slinger = null
//	var/Slinger_Key = null
	Bump(mob/m)
		if(isobj(m))
			m.TakeDamage(src, 50, "Collision")
			//m.Health -= 50
			if(m.Health <= 0)
				SmallCrater(src)
				del(m)
				del(src)
		if(ismob(m))
			for(var/mob/X in view(8,src))
				if(X.client)
					X.saveToLog("| [X.client.address ? (X.client.address) : "IP not found"] | ([X.x], [X.y], [X.z]) | [src] is slung into [m] by [src.Slinger_Key].\n")
			var/Evasion = 10
			if(m.Spd)
				Evasion += m.Spd
			if(m.Def)
				Evasion += m.Def/m.DefMod/100
			if(src.Projectile_Speed)
				Evasion -= src.Projectile_Speed / 10
			if(m.afk)
				Evasion = 100
			if(!prob(Evasion))
				view(10,m) << "[src.Slinger] slams [src] into [m]!"
				SmallCrater(src)
				if(src.Projectile_Speed)
					var/dmg = src.Projectile_Speed / 10
					dmg -= m.End / 1000
					if(dmg <= 0)
						dmg = 1
					if(dmg >= 10)
						dmg = 10
					m.TakeDamage(src, dmg, "Collision")
					//m.Health -= dmg
				del(src)
			else
				flick(m.CustomZanzokenIcon,m)
turf/Special

	Buildable=0

	Teleporter
		Health=1.#INF
		density=1
//		var/gotox
//		var/gotoy
//		var/gotoz
		Enter(mob/M) M.loc=locate(gotox,gotoy,gotoz)

	EarthCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave02Out)
		Cave03Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave03In)
		Cave03In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave03Out)
		Cave04Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave04In)
		Cave04In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave04Out)
		Cave05Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave05In)
		Cave05In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave05Out)
		Cave06Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave06In)
		Cave06In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave06Out)
		Cave07Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave07In)
		Cave07In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave07Out)

	EarthTower
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Tower01Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthTower/Tower01In)
		Tower01In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthTower/Tower01Out)
		Tower02Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthTower/Tower02In)
		Tower02In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthTower/Tower02Out)



	IceCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/IceCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/IceCaves/Cave01Out)

	NamekCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave02Out)
		Cave03Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave03In)
		Cave03In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave03Out)
		Cave04Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave04In)
		Cave04In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave04Out)
		Cave05Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave05In)
		Cave05In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave05Out)
	VegetaCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave02Out)
		Cave03Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave03In)
		Cave03In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave03Out)
		Cave04Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave04In)
		Cave04In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave04Out)
		Cave05Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave05In)
		Cave05In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave05Out)
		Cave06Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave06In)
		Cave06In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave06Out)
		Cave07Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave07In)
		Cave07In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave07Out)
		Cave08Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave08In)
		Cave08In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave08Out)
		Cave09Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave09In)
		Cave09In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave09Out)
		Cave10Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave10In)
		Cave10In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave10Out)
	ArconiaCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave02Out)
		Cave03Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave03In)
		Cave03In
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave03Out)
		Cave04Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave04In)
		Cave04In
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave04Out)
	ASMiscCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/ASMiscCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/ASMiscCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/ASMiscCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/ASMiscCaves/Cave02Out)
	EnterHBTC/Enter(mob/A)
		if(ismob(A))
			A.loc=locate(/turf/Special/ExitHBTC)
		//	A.loc=locate(469,481,9) // OPTIMIZED MAP
			logAndAlertAdmins("([A.key])[A] has entered the HBTC.",1)
			A<<"HBTC power is handled by admins. If you have IC access to the HBTC, are knowledgable about its effects and would like to apply for the boost, please submit an Ahelp including HBTC boost somewhere in the message."
				//HBTC()
				//A.HBTC_Enters++
			//else if(ismob(A)) A<<"You cannot enter the time chamber more than twice a lifetime."
	ExitHBTC/Enter(mob/A) A.loc=locate(/turf/Special/EnterHBTC)


turf/Terrain
	Sky
		Sky1
			icon='Misc.dmi'
			icon_state="Sky"
	//		luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying|!M.density) return ..()
				else return ..()
		Sky2
			icon='Misc.dmi'
			icon_state="Clouds"
			Buildable=0
    //        luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying|!M.density) return ..()
				else return ..()
		Sky3
			icon='Misc.dmi'
			icon_state="Clouds"
			Buildable=0
    //        luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying) M.loc=locate(M.x,1,8)
				return ..()
		Sky4
			icon='Misc.dmi'
			icon_state="Clouds"
			Buildable=0
    //        luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying) M.loc=locate(M.x,235,10)
				return ..()
		Sky5
			icon='NewTurfs.dmi'
			icon_state="56"
			Buildable=0
    //        luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying) M.loc=locate(M.x,499,8)
				return ..()

		RingOutSensor
			icon='Indoor Tiles.dmi'
			icon_state="Kitchen Tile"
//			var/RCD=0
			Entered(mob/A)
				if(!RCD&&ismob(A))
					view(A)<<"[A] ring out."
					RCD=1
				spawn(120) RCD=0
				..()


	Majin
		Wall1
			icon='Majin_Walls.dmi'
			icon_state="Wall1"
			Health=100000000000000000000
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Wall2
			icon='Majin_Walls.dmi'
			icon_state="Wall2"
			Health=100000000000000000000
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Wall3
			icon='Majin_Walls.dmi'
			icon_state="Wall3"
			Health=100000000000000000000
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Wall4
			icon='Majin_Walls.dmi'
			icon_state="Wall4"
			Health=100000000000000000000
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Floor
			icon='Majin_Walls.dmi'
			icon_state="Floor"
		Stairs
			icon='Majin_Walls.dmi'
			icon_state="Stairs"
		BigCrater
			icon='Craters.dmi'
			icon_state="Center"
			Health=1.#INF

turf/proc/Destroy(var/U,var/K)
	var/image/I=image(icon='Lightning flash.dmi',layer=99)
	overlays-=I
	if(Health<=0)
		if(type!=/turf/Terrain/Ground/GroundDirt&&type!=/turf/Special/Teleporter&&type!=/turf/Special/Blank&&type!=/turf/Special/Stars&&type!=/turf&&type!=/turf/Other/Blank&&type!=/turf/Other/Stars)
			var/turf/S = new/turf/Terrain/Ground/GroundDirt(locate(x,y,z))
			S.DestroyedBy="[U]/[K]"

/turf/Entered(atom/movable/M as mob|obj)
	if(!istype(src, /turf/Other/Stars))
		M.inertia_dir = 0
	..()

/turf/Other/Stars

	icon='Space.dmi'
	icon_state="placeholder"
	Buildable=0
	Health=1.#INF
	New()
		icon_state = "[rand(1,25)]"
		..()

	Entered(atom/movable/A as mob|obj)
		..()
		if (!A || src != A.loc || istype(A,/Skill/Attacks/))
			return

		if (!(A.last_move))
			return

		if(istype(A, /mob/)&&A)
			var/mob/M = A
			if(!(M.icon_state == "Flight" && M.SuperFly))	//Gotta superfly to get through space
				spawn(5)
					if(M && M.loc == src)
						if(!M.anchored)
							if(M.inertia_dir) //they keep moving the same direction
								if(M.icon_state != ("Blast" || "KO"))
									spawn
										flick("KB",M)	//as we go through space, aaaa
								var/turf/T = get_step(M, M.inertia_dir)
								if(T) if(!T.density) M.loc = T
								if(M.loc)	M.loc.Entered(M)
							else
								if(M.icon_state != ("Blast" || "KO"))
									spawn
										flick("KB",M)	//as we go through space, aaaa
								M.inertia_dir = M.last_move
								var/turf/T = get_step(M, M.inertia_dir)
								if(!T.density) M.loc = T //TODO: DEFERRED
								if(M.loc)	M.loc.Entered(M)
						else	//anchored
							M.inertia_dir = 0
		else if(istype(A, /obj/Ships))
			var/obj/Ships/S = A
			spawn(5)
				if (S && S.loc == src)
					if (!S.anchored)
						if(S.inertia_dir) //they keep moving the same direction
							var/turf/T = get_step(S, S.inertia_dir)
							if(!T.density) S.loc = T // Walls and other objects, we dont want them to magically move through walls, do we?
							if(S.loc)	S.loc.Entered(S)
						else
							S.inertia_dir = S.last_move
							var/turf/T = get_step(S, S.inertia_dir)
							if(!T.density) S.loc = T
							if(S.loc)	S.loc.Entered(S)
					else
						S.inertia_dir = 0	//Stop moving
						S.last_move = null
		if(src.z == SPACE_Z_LEVEL)
			if(src.x <= 2)
				A.x = world.maxx - 3
				spawn (0)
					if(A && A.loc)
						A.loc.Entered(A)
			else if(src.x >= (world.maxx-2))
				A.x = 3
				spawn (0)
					if(A && A.loc)
						A.loc.Entered(A)
			if(src.y <= 2)
				A.y = world.maxy - 3
				spawn (0)
					if(A && A.loc)
						A.loc.Entered(A)
			else if(src.y >= (world.maxy-2))
				A.y = 3
				spawn (0)
					if(A && A.loc)
						A.loc.Entered(A)