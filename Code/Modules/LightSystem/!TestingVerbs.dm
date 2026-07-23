mob/verb
	UpdateLights()
		update_light()

turf/atom/

	light_power = 5
	light_range = 5
	light_color = "#ffffff"

turf/atom/Underground

	light_power = 1
	light_range = 2
	light_color = "#313131"

turf/atom/Lava

	light_power = 2
	light_range = 2
	light_color = "#ff0000"

turf/atom/Sky

	light_power = 2
	light_range = 2
	light_color = "#ffffff"

turf/atom/Hole

	light_power = 0
	light_range = 0
	light_color = "#ffffff"

var
	ForceMakyoStar
	ForceNightAndDay
	ForceMoon

mob/Admin1/verb
	LightChange()
		set background=1
		var/N=InputWindow("LightPower")
		var/S=InputWindow("LightRange")
		for(var/turf/atom/T)
			if(T.z==2)
				T.light_power = N
				T.light_range = S
				T.update_light()

	ForceMakyoStar()
		set background=1
		if(!ForceMakyoStar)
			ForceMakyoStar=1
			world<<"The Makyo Star approach our planet..."
			for(var/turf/atom/T)
				if(T.z==2 || T.z==3)
					T.light_color = "#e27e7d"
					T.update_light()
		else
			world<<"The Makyo Star drift away from the firmament..."
			ForceMakyoStar=0
			for(var/turf/atom/T)
				if(T.z==2 || T.z==3)
					T.light_color = "#ffffff"
					T.update_light()

	ForceNightAndDay()
		set background=1
		if(!ForceNightAndDay)
			ForceNightAndDay=1
			world<<"The sun set"
			for(var/turf/atom/T)
				if(T.z==2 || T.z==3)
					T.light_color = "#313131"
					T.light_power = 1
					T.light_range = 2
					T.update_light()
		else
			ForceNightAndDay=0
			world<<"The sun came out"
			for(var/turf/atom/T)
				if(T.z==2 || T.z==3)
					T.light_color = "#ffffff"
					T.light_power = 5
					T.light_range = 5
					T.update_light()

	ForceMoon()
		set background=1
		if(!ForceMoon)
			ForceMoon=1
			world<<"The Moon came out..."
			for(var/turf/atom/T)
				if(T.z==2 || T.z==3)
					T.light_color = "#7393B3"
					T.update_light()
		else
			ForceMoon=0
			world<<"The Moon is gone..."
			for(var/turf/atom/T)
				if(T.z==2 || T.z==3)
					T.light_color = "#ffffff"
					T.update_light()


obj/items/BallGlowing
	icon        = 'BallGlow.dmi'
	light_range = 5
	light_power = 1
	light_color = "#FFFF00"

	verb/UpdateLights()
		update_light()

	verb/change_color2(var/new_color as color)
		set src in view()
		set_light(l_color = new_color)

	verb/change_range(var/new_range as num)
		set src in view()
		set_light(new_range)

	verb/change_power(var/new_power as num)
		set src in view()
		set_light(l_power = new_power)