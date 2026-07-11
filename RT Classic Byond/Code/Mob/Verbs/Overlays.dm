mob/verb/Overlays()
	set category=null//"Other"
	overlays  = null
	underlays = null
	src.alpha=initial(src.alpha)
	if(Dead)
		switch(Alignment)
			if("Very Pure") overlays += 'HaloVP.dmi'
			if("Pure") overlays += 'HaloP.dmi'
			if("Very Chaotic") overlays += 'HaloVC.dmi'
			if("Chaotic") overlays += 'HaloC.dmi'
			if("Neutral") overlays += 'HaloN.dmi'
		if(!KeepsBody)
			if(last_icon) icon = last_icon
			src.alpha=180
			/*var/icon/I=new(icon)
			I.Blend(rgb(0,0,0,195),ICON_ADD)
			icon=I*/
	overlays-=HealthBar
	overlays-=EnergyBar
	overlays+=HealthBar
	overlays+=EnergyBar