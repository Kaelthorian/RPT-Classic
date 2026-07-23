proc/Build_Lay(obj/Build/O,mob/P) if(P.KOd==0 && !P.inertia_dir) //Type to build, player who is building it, location to put it, can't be floundering through space

	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] build_lay()"
	var/atom/D=P
	if(P.S) D=P.S
	var/obj/Resources/AA
	for(var/obj/Resources/B in P) AA=B
	if(!P.BuildIsFree&&!P.HasBuildingPermit)
		if(P.BuildWithMana)
			for(var/obj/Mana/B in P) AA=B
			if(AA.Value<100*(1-(0.15*P.HasDeepPockets)))
				P<<"You do not have enough mana. ([100*(1-(0.15*P.HasDeepPockets))] per tile)"
				return
			else AA.Value-=100*(1-(0.15*P.HasDeepPockets))
		else
			if(AA.Value<100*(1-(0.15*P.HasDeepPockets)))
				P<<"You do not have enough resources. ([100*(1-(0.15*P.HasDeepPockets))] per tile)"
				return
			else AA.Value-=100*(1-(0.15*P.HasDeepPockets))
	for(var/obj/Controls/N in view(1,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to ship controls"
		return
	for(var/obj/Controls/PodControls/N in view(3,locate(D.x,D.y,D.z)))
		P<<"You cannot build inside a pod"
		return
	for(var/obj/Magical_Portal/W in view(3,P)) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build here."
		return
	for(var/obj/Airlock/N in view(1,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to an airlock!"
		return
	for(var/turf/Special/N in view(2,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to special tiles."
		return
	for(var/obj/Warper/W in view(2,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to warpers."
		return
	for(var/area/PlanetWrapper/W in view(3,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to the map edge."
		return
	for(var/obj/Warper/W in view(3,P)) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build here."
		return
	if(P.z!=17) if(P.x<5||P.x>495||P.y<5||P.y>495)
		P<<"You cannot build this close to the edge."
		return
	for(var/area/UndergroundMine/W in view(3,P)) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build here."
		return
	for(var/turf/Special/W in view(3,P)) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to warpers."
		return
	for(var/turf/Other/Stars/S in view(1,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1) if(!usr.BuildInSpace)
		P<<"You cannot build in deep space."
		return
	if(P.z == SPACE_Z_LEVEL)
		if((P.x <= 3) || (P.x >= (world.maxx-3)) || (P.y <= 3) || (P.y >= (world.maxy-3))) if(!usr.client.holder||usr.client.holder.level<1)
			P << "You cannot build this close to the edge of space."
			return
	if(O.Creates==/obj/Door)
		for(var/obj/Door/DD in view(0,usr))
			P<<"You can not layer doors."
			return
	var/atom/C=new O.Creates(locate(D.x,D.y,D.z))
	C.Builder="[P.real_name]"
	C.SaveItemATOM(C)
	UnderVisContentCorrector(usr)
	if(isobj(C))
		var/Turf_Objects=0
		for(var/obj/K in get_turf(P))
			if(!(locate(K) in P))
				Turf_Objects++
			if(Turf_Objects>4)
				P<<"Nothing more can be placed here."
				DeleteSaveItem(C)
				del(C)
				return
			else
				global.worldObjectList+=C
				C.Savable=1
				if(P.BuildLayer) C.layer=P.BuildLayer
		if(P.ImmuneYear)
			P<<"Set with [P.ImmuneYear] as Immune Year"
			C.ImmuneYear=P.ImmuneYear
		if(istype(C,/obj/Door))
			C:Grabbable=0
			var/New_Password=input(P,"Enter a password or leave blank") as text
			if(!C) return
			C.Password=New_Password
			for(var/obj/Props/E in get_turf(P))
				DeleteSaveItem(E)
				del(E)
			for(var/obj/Turfs/EE in get_turf(P))
				DeleteSaveItem(EE)
				del(EE)
			C.SaveItemATOM(C)
		if(istype(C,/obj/Props/Sign))
			C.desc=input(P,"What do you want to write on the sign?") as text
			C.SaveItemATOM(C)
		if(istype(C,/obj/Turfs/CustomObj1))
			C.icon=P.CustomObj1Icon
			C.icon_state=P.CustomObj1State
			C.layer=P.CustomObj1Layer
			C.density=P.CustomObj1Density
			C.pixel_x=P.CustomObj1X
			C.pixel_y=P.CustomObj1Y
			C.SaveItemATOM(C)

	else
		for(var/obj/K in get_turf(P))
			DeleteSaveItem(K)
			del(K)
		var/ousside=0
		if(istype(C,/turf/Terrain/Water)) ousside=1
		if(istype(C,/turf/Terrain/Ground)) ousside=1
		if(istype(C,/turf/Terrain/Grass)) ousside=1
		for(var/obj/Props/E in view(0,locate(D.x,D.y,D.z)))
			DeleteSaveItem(E)
			del(E)
		for(var/obj/Turfs/EE in view(0,locate(D.x,D.y,D.z)))
			DeleteSaveItem(EE)
			del(EE)
		if(istype(C,/turf/Upgradeable/CustomTurf))
			var/turf/Upgradeable/CustomTurf/CT=C
			C.icon=usr.CustomTurfIcon
			C.icon_state=usr.CustomTurfState
			CT.Roof=usr.CustomTurfRoof
			C.density=usr.CustomTurfDensity
			C.opacity=usr.CustomTurfOpacity
		if(!P.OutsideBuild&&!ousside) if(istype(C,/turf))
			var/turf/TTT=C
			TTT.Inside=1
		if(!istype(C,/turf/Upgradeable/CustomTurf))
			Turfs+=C
		else
			CustomTurfs+=C
		if(P.ImmuneYear)
			P<<"Set with [P.ImmuneYear] as Immune Year"
			C.ImmuneYear=P.ImmuneYear













mob/var
	CustomObj1Icon='ArtificalObj.dmi'
	CustomObj1State="QuestionMark"
	CustomObj1X=0
	CustomObj1Y=0
	CustomObj1Density=0
	CustomObj1Opacity=0
	CustomObj1Layer=3
	CustomTurfIcon='ArtificalObj.dmi'
	CustomTurfState="QuestionMark"
	CustomTurfRoof=0
	CustomTurfDensity=0
	CustomTurfOpacity=0

mob/verb
	CustomTurf()
		set category=null//"Other"
		//set name="Custom Turf"
		var/customselect=input("Choose a command.") in list("Cancel","Change Icon","Change Icon State","Change Roof Setting","Change Density","Change Opacity")
		switch(customselect)
			if("Cancel")
				return
			if("Change Icon")
				var/icon/_iconchoose=input(usr,"Choose an icon for your custom build object!","ChangeIcon")as icon
				var/icon/Z= new /icon(_iconchoose)
				if((length(Z) > 102400))
					usr <<"This file exceeds the limit of 100KB. It cannot be used."
					return
				if( Z.Width()!=32 || Z.Height()!=32 )
					usr<<"Custom turfs can only be 32x32."
					return
				usr.CustomTurfIcon=Z
				usr.CustomTurfState=input("Enter the icon's state name here.") as text
			if("Change Icon State")
				usr.CustomTurfState=input("Enter the icon's state name here.") as text
			if("Change Density")
				if(usr.CustomTurfDensity==1)
					usr.CustomTurfDensity=0
					usr<<"Custom Turf density disabled."
				else if(usr.CustomTurfDensity==0)
					usr.CustomTurfDensity=1
					usr<<"Custom Turf density enabled."
			if("Change Opacity")
				if(usr.CustomTurfOpacity==1)
					usr.CustomTurfOpacity=0
					usr<<"Custom turf opacity disabled."
				else if(usr.CustomTurfOpacity==0)
					usr.CustomTurfOpacity=1
					usr<<"Custom Turf opacity enabled."
			if("Change Roof Setting")
				if(usr.CustomTurfRoof==1)
					usr.CustomTurfRoof=0
					usr<<"Custom turf roof disabled."
				else if(usr.CustomTurfRoof==0)
					usr.CustomTurfRoof=1
					usr<<"Custom Turf roof enabled."

	CustomObject()
		set category=null//="Other"
		//set name="Custom Object"
		var/customselect=input("Choose a command.") in list("Cancel","Change Icon","Change Icon State","Change X Offset","Change Y Offset","Change Density","Change Opacity","Change Layer")
		switch(customselect)
			if("Cancel")
				return
			if("Change Icon")
				var/Z=input(usr,"Choose an icon for your custom build object!","ChangeIcon")as icon
				if((length(Z) > 102400))
					usr <<"This file exceeds the limit of 100KB. It cannot be used."
					return
				usr.CustomObj1Icon=Z
				usr.CustomObj1State=input("Enter the icon's state name here.") as text
			if("Change Icon State")
				usr.CustomObj1State=input("Enter the icon's state name here.") as text
			if("Change X Offset")
				usr.CustomObj1X=input("Enter the icon's Pixel X offset.") as num
			if("Change Y Offset")
				usr.CustomObj1Y=input("Enter the icon's Pixel Y offset.") as num
			if("Change Density")
				if(usr.CustomObj1Density==1)
					usr.CustomObj1Density=0
					usr<<"Custom object density disabled."
				else if(usr.CustomObj1Density==0)
					usr.CustomObj1Density=1
					usr<<"Custom object density enabled."
			if("Change Opacity")
				if(usr.CustomObj1Opacity==1)
					usr.CustomObj1Opacity=0
					usr<<"Custom object opacity disabled."
				else if(usr.CustomObj1Opacity==0)
					usr.CustomObj1Opacity=1
					usr<<"Custom object opacity enabled."
			if("Change Layer")
				usr.CustomObj1Layer=input("Enter the layer for the object. A higher number will be drawn 'above' objects of a lower layer. Most objects by default are 3. Minimum 2, Maximum 6.") as num
				if(usr.CustomObj1Layer<2)
					usr.CustomObj1Layer=2
				else if(usr.CustomObj1Layer>6)
					usr.CustomObj1Layer=6
