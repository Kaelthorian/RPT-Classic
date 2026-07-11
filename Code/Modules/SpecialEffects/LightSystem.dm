#define get_area1(A) (isarea(A) ? A : get_step(A, 0)?.loc)
#define get_turf1(A) (get_step(A, 0))
///////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Day And Night/////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
area
//	mouse_opacity = 0
//	layer=33
//	alpha=0
//	icon= 'Icons/Areas/Negro.dmi'

var/MakyoLight

proc/DayAndNight()
	if(StopCycle ==1)
		return
	if(MakyoLight==1)
		for(var/area/T)
			T.Day()
			sleep(100)
			T.MakyoStarLightOn()
		return
	if(MonthCycle==1)
		for(var/area/T)
			T.Morning()
	if(MonthCycle==2)
		for(var/area/T)
			T.Day()
	if(MonthCycle==3)
		for(var/area/T)
			T.Morning()
	if(MonthCycle==4)
		for(var/area/T)
			T.Night()
area/proc
	Night()
		icon= 'Icons/Areas/Negro.dmi'
		animate(src,alpha = 150, time = 100)
	Day()
		icon= 'Icons/Areas/Negro.dmi'
		animate(src,alpha = 0, time = 100)
	Morning()
		icon= 'Icons/Areas/Negro.dmi'
		animate(src,alpha = 75, time = 100)
	MakyoStarLightOn()
		icon+=rgb(125,0,0)
		animate(src,alpha = 75, time = 100)
	MakyoStarLightOff()
		animate(src,alpha = 0, time = 100)
		sleep(100)
		icon= 'Icons/Areas/Negro.dmi'


obj/var/LightState
proc/Light()
	for(var/obj/M)
		if(M.LightState == 1) return
		var/obj/light/L=new()
		L.icon='Icons/Areas/Vision2.dmi'
		L.Blur()
		L.Bloom()
		L.alpha = 25
		L.pixel_x = -32
		L.pixel_y = -32
		M.overlays += L
		M.layer=35
		M.blend_mode= BLEND_OVERLAY
		M.LightState = 1
	return
/////////////////////////////////////////////////////////////////////////////////////////////////
obj/Circle
	icon = 'Icons/Areas/Vision2.dmi'
	density = 1
	layer= 34
	alpha=25
	blend_mode= BLEND_ADD
	pixel_x = -32
	pixel_y = -32
	verb/ACA()
		set src in oview(1)
		Bloom()
		Blur()
		layer=35
atom/proc
	Blur()
		filters += filter(type = "blur", size = 2)
	Bloom()
		filters += filter(type = "bloom",threshold= "#999999" ,size = 2 , alpha = 225 )
obj/light
	icon = 'Icons/Areas/Vision32x32.dmi'
	layer= 35
	alpha = 25
atom/var/Light

atom/proc/Lightstorm()

	overlays += 'Icons/Areas/Lighting.dmi'
	sleep(5)
	overlays -= 'Icons/Areas/Lighting.dmi'
	overlays += 'Icons/Areas/Lighting2.dmi'
	sleep(2)
	overlays -= 'Icons/Areas/Lighting2.dmi'
	var/sound/Thunder = sound('Sound/Thunder.wav')
	world << Thunder
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Seasons Overlays////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
particles
	Rain
		width = 11500     // 500 x 500 image to cover a moderately sized map
		height = 11500
		count = 2500    // 2500 particles
		spawning = 12    // 12 new particles per 0.1s
		bound1 = list(-1000, -300, -1000)   // end particles at Y=-300
		lifespan = 600  // live for 60s max
		fade = 50       // fade out over the last 5s if still on screen
	    // spawn within a certain x,y,z space
		position = generator("box", list(-300,250,0), list(300,300,50))
	    // control how the snow falls
		gravity = list(0, -10)
		friction = 0.3  // shed 30% of velocity and drift every 0.1s
		//drift = generator("sphere", 0, 2)
//		color = "blue"
		icon='TenderRain.dmi'

	Snow
		width = 11500     // 500 x 500 image to cover a moderately sized map
		height = 11500
		count = 2500    // 2500 particles
		spawning = 12    // 12 new particles per 0.1s
		bound1 = list(-1000, -300, -1000)   // end particles at Y=-300
		lifespan = 600  // live for 60s max
		fade = 50       // fade out over the last 5s if still on screen
		// spawn within a certain x,y,z space
		position = generator("box", list(-300,250,0), list(300,300,50))
	    // control how the snow falls
		gravity = list(0, -1)
		friction = 0.3  // shed 30% of velocity and drift every 0.1s
		drift = generator("sphere", 0, 2)

	BloodRain
		width = 11500     // 500 x 500 image to cover a moderately sized map
		height = 11500
		count = 2500    // 2500 particles
		spawning = 12    // 12 new particles per 0.1s
		bound1 = list(-1000, -300, -1000)   // end particles at Y=-300
		lifespan = 600  // live for 60s max
		fade = 50       // fade out over the last 5s if still on screen
	    // spawn within a certain x,y,z space
		position = generator("box", list(-300,250,0), list(300,300,50))
	    // control how the snow falls
		gravity = list(0, -10)
		friction = 0.3  // shed 30% of velocity and drift every 0.1s
		//drift = generator("sphere", 0, 2)
		color = "red"

obj/Fire
    screen_loc = "CENTER"
//    particles = new/particles/fire
obj/Snow
    screen_loc = "CENTER"
    layer=30
    particles = new/particles/Snow
obj/Rain
    screen_loc = "CENTER"
    layer=30
    particles = new/particles/Rain
obj/BloodRain
    screen_loc = "CENTER"
    layer=30
    particles = new/particles/BloodRain
mob
	var/Snow = 0
	proc/MakeSnow()
		client.screen += new/obj/Snow
		if(Snow ==1)
			client.screen =- new/obj/Snow
			Snow = 0
			return
		Snow = 1
	proc/MakeBloodRain()
		client.screen += new/obj/BloodRain

	proc/MakeRain()
		client.screen += new/obj/Rain
	proc/CleanSky()
		for(var/mob/player/A)
			client.screen =- new/obj/Snow
			client.screen =- new/obj/BloodRain
			client.screen =- new/obj/Rain
		for(var/area/T)
			T.Day()


//	proc/CreateRain()
//		client.screen += new/obj/Rain
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Controls////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
area/var/NightAlpha=150
area/var/MorningAlpha=75
var/StopCycle=1

mob/Admin1/verb

	Day()
//		set category="Weather"
		for(var/area/T)
			T.Day()
	Night()
//		set category="Weather"
		for(var/area/T)
			T.Night()
	Morning()
//		set category="Weather"
		for(var/area/T)
			T.Morning()
/*	Blood_Rain()
		set category="Weather"
		for(var/mob/player/A)
			A.MakeBloodRain()

	Snow_Fall()
		set category="Weather"
		for(var/mob/player/A)
			A.MakeSnow()
	Rain()
		set category="Weather"
		for(var/mob/player/A)
			A.MakeRain()
	Makyo_Star()
		set category="Weather"
		if(MakyoLight==1)
			MakyoStar=0
			MakyoLight=0
			world<<"<span class=\"narrate\">The Makyo star to drift away into the depths of the universe...</span>"
			for(var/area/T)
				T.Day()
			return
		world<<"<span class=\"narrate\">The sky glows red as the Makyo star came earlier this year...</span>"
		MakyoStar=1
		MakyoLight=1
		for(var/area/T)
			T.Day()
			sleep(50)
			T.MakyoStarLightOn()

	Force_Moon()
		set category="Weather"
	LightStorm()
		set category="Weather"
	Tornado()
		set category="Weather"
	Earthquake()
		set category="Weather"
	Blizzard()
		set category="Weather"
	Flood()
		set category="Weather"
	Volcano()
		set category="Weather"
	SuperVolcano()
		set category="Weather"
	Strong_Winds()
		set category="Weather"
	Hurricane()
		set category="Weather"
	Dust_Storm()
		set category="Weather"
	Ice_Storm()
		set category="Weather"
*/
	Stop_or_resume_day_night_cycle()
//		set category="Weather"
		if(StopCycle ==1)
			StopCycle =0
			usr << "Cycle resumed."
			return
		StopCycle =1
		usr << "Cycle stopped."

	Clean_Weather()
//		set category="Weather"
		for(var/mob/player/A)
			A.CleanSky()
//	Thunder()
//		set category="Weather"
//		for(var/area/T)
//			T.Lightstorm()
//	Darkness_Level()
//		set category="Weather"
//		var/area/NightAlpha=input("Night level of darkness(150 default)")
//		var/area/MorningAlpha=input("Morning level of darkness(75 default)")


turf/var/tmp/HasSnow=0
turf/proc
	SnowGenerator()
		src.overlays=null
		overlays+='Icons/Areas/snow.dmi'
		sleep(100)
		overlays-='Icons/Areas/snow.dmi'
		return
//turf/verb
//	Snow()
//		SnowGenerator()





////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Seasons Change/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////









///////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Trash that might be useful////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
area/Earth/verb
	NightTime()
		set category = "Day/Night"
		overlays +='Icons/Areas/Negro.dmi'
		animate(src,alpha = 200, time = 10)
	DayTime()
		set category = "Day/Night"
		animate(src,alpha = 0, time = 10)


//		filters += filter(type = "alpha",'Icons/Areas/Negro.dmi','Icons/Areas/Negro.dmi')
//		filters += filter(type = "blur", size = 1)
//		overlays += 'Icons/Areas/VisionN.dmi'
//		filters += filter(type = "blur",'Icons/Areas/Visual.dmi')
//		filters += filter(type="alpha", icon='Icons/Areas/Vision.dmi',BLEND_MULTIPLY)
area/Earth/verb
	Blur1()
		set category = "Day/Night"
		filters += filter(type = "blur")

area/Earth/proc
	Night()
		var/icon/I=new(usr.icon)
		I.Blend('Icons/Areas/Visual.dmi',BLEND_OVERLAY)
		usr.overlays += I

area/proc/DayCycle()
	overlays += 'Icons/Areas/Rain.dmi'

	var/cycle
	A
	cycle ++
	overlays += 'Icons/Areas/Night.dmi'
	sleep(10)
	if (cycle == 10)
		goto B
	goto A
	B
	overlays -= 'Icons/Areas/Night.dmi'
	cycle --
	sleep(10)
	if (cycle == 0 )
		overlays -= 'Icons/Areas/Rain.dmi'
		return
	goto B
*/

//area/verb/LALALALALA()
//	set category = "Day/Night"
//	DayCycle()
//area/verb/LALALALALA2()
//	set category = "Day/Night"
//	Lightstorm()


/*
mob/verb/MobOverlay()
	set category = "Day/Night"
	var/icon/I=new(usr.icon)
	I.Blend('Icons/Areas/Visual.dmi',BLEND_OVERLAY)
	usr.overlays += I
	animate(src, overlays, alpha = 255, time = 5)

mob/verb/MobOverlay2()
	set category = "Day/Night"
	LightOverlay()


mob/verb/MobOverlay3()
	set category = "Day/Night"
	var/icon/I=new(usr.icon)
	I.icon = 'Icons/Areas/Visual.dmi'
	usr.overlays = I
	filters += filter(type = "blur")

mob/verb/MobOverlay4()
	set category = "Day/Night"
	Blur()

mob/verb/MobOverlay5()
	set category = "Day/Night"
	filters += filter(type = "bloom",threshold= "#000000" ,size = 0.5 , alpha = 225 )


mob/verb/MobOverlay6()
	set category = "Day/Night"
	src << gradient(0, "#f00", 3, "#0ff", 6, "#f00", "loop", space=COLORSPACE_HSL, index=10)

*/





//mob/verb/REMOVE_OVERLAYS()
//	set category = "Day/Night"
//	src.overlays --
///	src.filters --
//	src.alpha=255
//	icon = 'Icons/Mobs/players/player.dmi'

/*
obj
	Fire
		icon = 'Icons/Objects/Fire.dmi'
		density = 1
		overlays = list('Icons/Areas/Vision32x32.dmi')

icon
	aura
		icon='Icons/Areas/Vision2.dmi'


obj/Circle
	icon = 'Icons/Areas/Vision2.dmi'
	density = 1
	layer= 34
	alpha=50
	blend_mode= BLEND_ADD
	verb/ACA()
		set src in oview(1)
		Bloom()
		Blur()

atom/proc
	Blur()
		filters += filter(type = "blur", size = 10)
	Bloom()
		filters += filter(type = "bloom",threshold= "#000000" ,size = 1 , alpha = 225 )
	LightOverlay()
		overlays += 'Icons/Areas/Vision2.dmi'
		filters += filter(type = "blur",size = 1)
//		animate (src,alpha=110, overlays += 'Icons/Areas/Vision2.dmi')




obj/lighting_plane
    screen_loc = "1,1"
    plane = 2
    blend_mode = BLEND_MULTIPLY
    appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR
    // use 20% ambient lighting; be sure to add full alpha
    color = list(null,null,null,null,"#333f")
    mouse_opacity = 0    // nothing on this plane is mouse-visible


image/spotlight
    plane = 2
    blend_mode = BLEND_ADD
    icon = 'Icons/Areas/Vision.dmi'  // a 96x96 white circle
    pixel_x = -32
    pixel_y = -32

mob/Login()
    ..()
    client.screen += new/obj/lighting_plane
    overlays += /image/spotlight
mob/Logout()
	overlays -= /image/spotlight



particles
    fire
        width = 100
        height = 100
        count = 1000
        spawning = 4
        lifespan = 7
        fade = 10
        grow = -0.01
        velocity = list(0, 0)
        position = generator("circle", 0, 8, NORMAL_RAND)
        drift = generator("vector", list(0, -0.2), list(0, 0.2))
        gravity = list(0, 0.95)
        icon = 'assets/Particles/particles.dmi'
        scale       =   generator("vector", list(0.3, 0.3), list(1,1), NORMAL_RAND)
        rotation    =   30
        spin        =   generator("num", -20, 20)

        color = "yellow"

emitter
	fire
		alpha = 225
		plane = OBJECT_PLANE
		standing = TRUE
		particles = new/particles/fire
		filters = list( filter(type = "outline", size = 1, color = "#FF3300"),
						filter(type = "bloom", threshold = rgb(255, 128, 255), size = 6, offset = 4, alpha = 255))

effect
    parent_type = /atom/movable
    var/tmp/emitters[] // list of emitters, each with their own particle
    var/tmp/lifespan  // how long the effect lives for before dying out

    fire
        emitters = newlist(
                            /emitter/fire,
                            /emitter/smoke,
                            /emitter/sparks_daytime,
                            /emitter/sparks_nighttime,
                            /emitter/fire_nightglow)

proc
    Particle(effect/effect, atom/source, atom/movable/source_object,  offset[] = list(0,0), duration)
        set waitfor = FALSE
        var/effect/new_effect = new effect

        if(istype(source, /atom/movable))
            source:vis_contents += new_effect

        else // Only called on turfs
            new_effect.set_loc(source, offset[1], offset[2])
            if(source_object)
                new_effect.step_x = source_object.step_x
                new_effect.step_y = source_object.step_y

        if(offset && islist(offset))
            new_effect.step_x += offset[1]
            new_effect.step_y += offset[2]

        if(duration)
            spawn(duration)
            if(new_effect)
                del new_effect

        else if(new_effect.lifespan)
            spawn(new_effect.lifespan)
            if(new_effect)
                del new_effect

      return new_effect
*/