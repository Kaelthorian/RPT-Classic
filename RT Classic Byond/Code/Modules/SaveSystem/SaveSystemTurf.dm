
var/list/CustomTurfs=new
//var/list/worldObjectList = new // Looped through during the saving of objects



proc/Save_Custom_Turfs()
	set background = 1
	world<<"<small>Server: Saving Custom Turfs..."
	var/Amount=0
	var/E=1
	var/savefile/F=new("Data/MapSaves/CustomTurfs[E]")
	var/list/Types=new
	var/list/Healths=new
	var/list/Levels=new
	var/list/Builders=new
	var/list/Xs=new
	var/list/Ys=new
	var/list/Zs=new
	var/list/Icons=new
	var/list/Icons_States=new
	var/list/Densitys=new
	var/list/isRoof=new
	var/list/Opacitys=new
	var/list/FlyOver=new
	var/list/isOutside=new


	for(var/turf/Upgradeable/CustomTurf/A in CustomTurfs)
		if(A)
			Types+=A.type
			Healths+="[num2text(round(A.Health),100)]"
			Levels+="[num2text(A.Level,100)]"
			Builders+=A.Builder
			Xs+=A.x
			Ys+=A.y
			Zs+=A.z
			Icons+=A.icon
			Icons_States+=A.icon_state
			Densitys+=A.density
			isRoof+=A.Roof
			Opacitys+=A.opacity
			FlyOver+=A.FlyOverAble
			isOutside+=A.Inside
			Amount+=1
			if(Amount % 20000 == 0)
				F["Types"]<<Types
				F["Healths"]<<Healths
				F["Levels"]<<Levels
				F["Builders"]<<Builders
				F["Xs"]<<Xs
				F["Ys"]<<Ys
				F["Zs"]<<Zs
				F["Icons"]<<Icons
				F["Icons_States"]<<Icons_States
				F["Densitys"]<<Densitys
				F["isRoof"]<<isRoof
				F["Opacitys"]<<Opacitys
				F["FlyOver"]<<FlyOver
				F["isOutside"]<<isOutside
				E ++
				F=new("Data/MapSaves/CustomTurfs[E]")
				Types=new
				Healths=new
				Levels=new
				Builders=new
				Xs=new
				Ys=new
				Zs=new
				Icons=new
				Icons_States=new
				Densitys=new
				isRoof=new
				Opacitys=new
				FlyOver=new
				isOutside=new

	if(Amount % 20000 != 0)
		F["Types"]<<Types
		F["Healths"]<<Healths
		F["Levels"]<<Levels
		F["Builders"]<<Builders
		F["Xs"]<<Xs
		F["Ys"]<<Ys
		F["Zs"]<<Zs
		F["Icons"]<<Icons
		F["Icons_States"]<<Icons_States
		F["Densitys"]<<Densitys
		F["isRoof"]<<isRoof
		F["Opacitys"]<<Opacitys
		F["FlyOver"]<<FlyOver
		F["isOutside"]<<isOutside
	world<<"<small>Server: Custom Turfs Saved([Amount])."

proc/Load_Custom_Turfs()
	set background = 1
	if(fexists("Data/MapSaves/CustomTurfs1"))
		world<<"<small>Server: Loading Custom Turfs..."
		var/Amount=0
		var/DebugAmount= 0
		var/E=1
		load
		if(!fexists("Data/MapSaves/CustomTurfs[E]"))
			goto end
		var/savefile/F=new("Data/MapSaves/CustomTurfs[E]")
		sleep(1)
		var/list/Types=F["Types"]
		var/list/Healths=F["Healths"]
		var/list/Levels=F["Levels"]
		var/list/Builders=F["Builders"]
		var/list/Xs=F["Xs"]
		var/list/Ys=F["Ys"]
		var/list/Zs=F["Zs"]
		var/list/Icons=F["Icons"]
		var/list/Icons_States=F["Icons_States"]
		var/list/Densitys=F["Densitys"]
		var/list/isRoof=F["isRoof"]
		var/list/Opacitys=F["Opacitys"]
		var/list/FlyOver=F["FlyOver"]
		var/list/isOutside=F["isOutside"]
		Amount = 0
		for(var/A in Types)
			Amount+=1
			DebugAmount += 1
			var/turf/Upgradeable/CustomTurf/T=new A(locate(text2num(list2params(Xs.Copy(Amount,Amount+1))),text2num(list2params(Ys.Copy(Amount,Amount+1))),text2num(list2params(Zs.Copy(Amount,Amount+1)))))
			T.icon= Icons[Amount]
			T.icon_state= Icons_States[Amount]
			T.density=text2num(list2params(Densitys.Copy(Amount,Amount+1)))
			T.opacity=text2num(list2params(Opacitys.Copy(Amount,Amount+1)))
			T.Roof=text2num(list2params(isRoof.Copy(Amount,Amount+1)))
			T.Health=text2num(list2params(Healths.Copy(Amount,Amount+1)))
			T.Level=text2num(list2params(Levels.Copy(Amount,Amount+1)))
			T.Builder=list2params(Builders.Copy(Amount,Amount+1))
			T.FlyOverAble=text2num(list2params(FlyOver.Copy(Amount,Amount+1)))
			T.Inside=text2num(list2params(isOutside.Copy(Amount,Amount+1)))
			CustomTurfs+=T // Turfs is the global list for all objects placed by players.
			for(var/obj/Turfs/Edges/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Surf/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Trees/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/B in T) if(!B.Builder) del(B)

			if(Amount == 20000)
				sleep(1)
				break

		if(Amount == 20000)
			E ++
			goto load

		end
		world<<"<small>Server: Custom Turfs Loaded ([DebugAmount] in [E] Files.)"
	global.MapsLoaded=1
	global.CanSave = 1

proc/Save_Turfs()
	set background = 1
	world<<"<small>Server: Saving Map..."
	var/Amount=0
	var/E=1
	var/savefile/F=new("Data/MapSaves/File[E]")
	var/list/Types=new
	var/list/Healths=new
	var/list/Levels=new
	var/list/Builders=new
	var/list/Xs=new
	var/list/Ys=new
	var/list/Zs=new
	var/list/FlyOver=new
	var/list/isOutside=new

//	debuglog << "[__FILE__]:[__LINE__] We got this far for mapfile[E]"

	for(var/turf/A in Turfs)
		if(A)
			Types+=A.type
			Healths+="[num2text(round(A.Health),100)]"
			Levels+="[num2text(A.Level,100)]"
			Builders+=A.Builder
			Xs+=A.x
			Ys+=A.y
			Zs+=A.z
			FlyOver+=A.FlyOverAble
			isOutside+=A.Inside

			Amount+=1
			if(Amount % 20000 == 0)
				F["Types"]<<Types
				F["Healths"]<<Healths
				F["Levels"]<<Levels
				F["Builders"]<<Builders
				F["Xs"]<<Xs
				F["Ys"]<<Ys
				F["Zs"]<<Zs
				F["FlyOver"]<<FlyOver
				F["isOutside"]<<isOutside

				E ++
				F=new("Data/MapSaves/File[E]")
				Types=new
				Healths=new
				Levels=new
				Builders=new
				Xs=new
				Ys=new
				Zs=new
				FlyOver=new
				isOutside=new

//	debuglog << "[__FILE__]:[__LINE__] We got this far for mapfile[E]"

	if(Amount % 20000 != 0)
		F["Types"]<<Types
		F["Healths"]<<Healths
		F["Levels"]<<Levels
		F["Builders"]<<Builders
		F["Xs"]<<Xs
		F["Ys"]<<Ys
		F["Zs"]<<Zs
		F["FlyOver"]<<FlyOver
		F["isOutside"]<<isOutside

//	debuglog << "[__FILE__]:[__LINE__] Map saved mapfile[E] :: Total amount of crap: [Amount]"

	world<<"<small>Server: Map Saved([Amount])."
	Save_Custom_Turfs()

proc/Load_Turfs()
	set background = 1
	if(fexists("Data/MapSaves/File1"))
		world<<"<small>Server: Loading Map..."
		var/Amount=0
		var/DebugAmount= 0
		var/E=1
		load
		if(!fexists("Data/MapSaves/File[E]"))
			goto end
		var/savefile/F=new("Data/MapSaves/File[E]")
		sleep(1)
		var/list/Types=F["Types"]
		var/list/Healths=F["Healths"]
		var/list/Levels=F["Levels"]
		var/list/Builders=F["Builders"]
		var/list/Xs=F["Xs"]
		var/list/Ys=F["Ys"]
		var/list/Zs=F["Zs"]
		var/list/FlyOver=F["FlyOver"]
		var/list/isOutside=F["isOutside"]

		Amount = 0
		for(var/A in Types)
			Amount+=1
			DebugAmount += 1
			var/turf/T=new A(locate(text2num(list2params(Xs.Copy(Amount,Amount+1))),text2num(list2params(Ys.Copy(Amount,Amount+1))),text2num(list2params(Zs.Copy(Amount,Amount+1)))))
			T.Health=text2num(list2params(Healths.Copy(Amount,Amount+1)))
			T.Level=text2num(list2params(Levels.Copy(Amount,Amount+1)))
			T.Builder=list2params(Builders.Copy(Amount,Amount+1))
			T.FlyOverAble=text2num(list2params(FlyOver.Copy(Amount,Amount+1)))
			T.Inside=text2num(list2params(isOutside.Copy(Amount,Amount+1)))

			Turfs+=T // Turfs is the global list for all objects placed by players.
			for(var/obj/Turfs/Edges/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Surf/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Trees/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/B in T) if(!B.Builder) del(B)

			if(Amount == 20000)
				sleep(1)
				break

		if(Amount == 20000)
			E ++
			goto load

		end
		world<<"<small>Server: Map Loaded ([DebugAmount] in [E] Files.)"
	else world<<"<small>Server: No Map Loaded"
	Load_Custom_Turfs()