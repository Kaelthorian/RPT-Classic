/*

######### Turf Saving/Loading #########

*/


proc
	MapSave()
		var/amount=0
		fdel("MapSave")
		var/savefile/F=new("MapSave")
		var/list/L=new/list
		for(var/area/A) //for(var/AA in A)//if(A.Builder)
			var/list/ML=list()
			for(var/mob/player/M in A) ML+=M
			L.Add(A.contents-ML)
			L.Add(A)
			amount+=1
		F<<L
		world<<"Map Saved ([amount])"
	MapLoad()
		if(fexists("MapSave"))
			var/savefile/F=new("MapSave")
			var/list/L=new/list
			F>>L
		world<<"<font size=1>Map Loaded."
		global.MapsLoaded=1
		global.CanSave = 1

/*
proc/Save_Turfs()
	set background = 1
	world<<"<small>Server: Saving Map..."
	var/Amount=0
	var/E=1
	var/savefile/F=new("Saves/Map/File[E]")
	var/list/Types=new
	var/list/Healths=new
	var/list/Levels=new
	var/list/Builders=new
	var/list/Xs=new
	var/list/Ys=new
	var/list/Zs=new
	var/list/FlyOver=new
	var/list/isOutside=new
	var/list/isUnderwater=new
	var/list/LogPEndurance=new
	var/list/Destructable=new

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
			isOutside+=A.isOutside
			isUnderwater+=A.isUnderwater
			LogPEndurance+=A.LogPEndurance
			Destructable+=A.Destructable
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
				F["isUnderwater"]<<isUnderwater
				F["LogPEndurance"]<<LogPEndurance
				F["Destructable"]<<Destructable
				E ++
				F=new("Saves/Map/File[E]")
				Types=new
				Healths=new
				Levels=new
				Builders=new
				Xs=new
				Ys=new
				Zs=new
				FlyOver=new
				isOutside=new
				isUnderwater=new
				LogPEndurance=new
				Destructable=new

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
		F["isUnderwater"]<<isUnderwater
		F["LogPEndurance"]<<LogPEndurance
		F["Destructable"]<<Destructable

//	debuglog << "[__FILE__]:[__LINE__] Map saved mapfile[E] :: Total amount of crap: [Amount]"

	world<<"<small>Server: Map Saved([Amount])."

proc/Load_Turfs()
	set background = 1
	if(fexists("Saves/Map/File1"))
		world<<"<small>Server: Loading Map..."
		var/Amount=0
		var/DebugAmount= 0
		var/E=1
		load
		if(!fexists("Saves/Map/File[E]"))
			goto end
		var/savefile/F=new("Saves/Map/File[E]")
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
		var/list/isUnderwater=F["isUnderwater"]
		var/list/LogPEndurance=F["LogPEndurance"]
		var/list/Destructable=F["Destructable"]
		Amount = 0
		for(var/A in Types)
			Amount+=1
			DebugAmount += 1
			var/turf/T=new A(locate(text2num(list2params(Xs.Copy(Amount,Amount+1))),text2num(list2params(Ys.Copy(Amount,Amount+1))),text2num(list2params(Zs.Copy(Amount,Amount+1)))))
			T.Health=text2num(list2params(Healths.Copy(Amount,Amount+1)))
			T.Level=text2num(list2params(Levels.Copy(Amount,Amount+1)))
			T.Builder=list2params(Builders.Copy(Amount,Amount+1))
			T.FlyOverAble=text2num(list2params(FlyOver.Copy(Amount,Amount+1)))
			T.isOutside=text2num(list2params(isOutside.Copy(Amount,Amount+1)))
			T.isUnderwater=text2num(list2params(isUnderwater.Copy(Amount,Amount+1)))
			T.LogPEndurance=text2num(list2params(LogPEndurance.Copy(Amount,Amount+1)))
			T.Destructable=text2num(list2params(Destructable.Copy(Amount,Amount+1)))
			if(istype(T,/turf/Special/EventStars))
				T.icon_state="[rand(1,2500)]"
			Turfs+=T // Turfs is the global list for all objects placed by players.
			if(T.Builder)
				if(T.isOutside)
					switch(T.z)
						if(6)
							new/area/Outside/Planet/Earth(T)
						if(3)
							new/area/Outside/Planet/Namek(T)
						if(5)
							new/area/Outside/Planet/Vegeta(T)
						if(4)
							new/area/Outside/Planet/Ice(T)
						if(7)
							new/area/Outside/Planet/Arconia(T)
						if(2)
							new/area/Outside/Planet/Heaven(T)
						if(9)
							new/area/Outside/Planet/Hell(T)
						if(8)
							new/area/Outside/Planet/Afterlife(T)
						if(14)
							if(T.isUnderwater)
								new/area/Outside/Planet/Earth/Underwater(T)
							else
								new/area/Outside/Planet/Earth/EarthUnderground(T)
						if(15)
							if(T.isUnderwater)
								new/area/Outside/Planet/Earth/Underwater(T)
							else
								new/area/Outside/Planet/Earth/EarthUnderground(T)
						if(18)
							new/area/Outside/Planet/Sanctuary(T)
						if(20)
							if(T.isUnderwater)
								new/area/Outside/Planet/Sanctuary/SanctuaryUnderwater(T)
							else
								new/area/Outside/Planet/Sanctuary/SanctuaryUnderground(T)
						if(22)
							if(T.isUnderwater)
								new/area/Outside/Planet/Vegeta/VegetaUnderwater(T)
							else
								new/area/Outside/Planet/Vegeta/VegetaUnderground(T)
						if(23)
							if(T.isUnderwater)
								new/area/Outside/Planet/Namek/NamekUnderwater(T)
							else
								new/area/Outside/Planet/Namek/NamekUnderground(T)
						if(24)
							if(T.isUnderwater)
								new/area/Outside/Planet/Ice/IceUnderwater(T)
							else
								new/area/Outside/Planet/Ice/IceUnderground(T)
						if(25)
							if(T.isUnderwater)
								new/area/Outside/Planet/Arconia/ArconiaUnderwater(T)
							else
								new/area/Outside/Planet/Arconia/ArconiaUnderground(T)
						else
							new/area/Outside(T)
				else
					new/area/Inside(T)

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
		world<<"<small>Server: Map Loaded ([DebugAmount] in [E] Files.)"*/

/*


proc/Save_Turfs()
	if(global.CanSave)
		var/Amount=0
		var/E=1
		var/savefile/F=new("Data/Maps/Map[E]")
		world << "Creating Map[E].sav"
		var/list/Types=new
		var/list/Healths=new
		var/list/Levels=new
		var/list/Builders=new
		var/list/Xs=new
		var/list/Ys=new
		var/list/Zs=new
		var/list/FlyOver=new
		for(var/turf/A in Turfs) //if(A.Builder||A.Savable)
			Types+=A.type
			Healths+="[num2text(round(A.Health),100)]"
			Levels+="[num2text(A.Level,100)]"
			Builders+=A.Builder
			Xs+=A.x
			Ys+=A.y
			Zs+=A.z
			FlyOver+=A.FlyOverAble
			Amount++
			if(Amount >= 20000)
				F["Types"]<<Types
				F["Healths"]<<Healths
				F["Levels"]<<Levels
				F["Builders"]<<Builders
				F["Xs"]<<Xs
				F["Ys"]<<Ys
				F["Zs"]<<Zs
				F["FlyOver"]<<FlyOver
				E ++
				F=new("Data/Maps/Map[E]")
				world << "Creating Map[E].sav"
				Types=new
				Healths=new
				Levels=new
				Builders=new
				Xs=new
				Ys=new
				Zs=new
				FlyOver=new
				Amount = 0
		if(Amount <= 19999)
			F["Types"]<<Types
			F["Healths"]<<Healths
			F["Levels"]<<Levels
			F["Builders"]<<Builders
			F["Xs"]<<Xs
			F["Ys"]<<Ys
			F["Zs"]<<Zs
			F["FlyOver"]<<FlyOver
		world<<"Maps Saved ([Amount])"

proc/Load_Turfs()
/*

	world << "Starting map load."
	if(fexists("New Map Save"))
		world << "Map file found."

	else
		world << "No more files found. Done loading turfs."
		return
	world << "Starting map load. 2"
	var/savefile/F=new("New Map Save")
	for(var/atom/L in F)
		if(istype(L,/turf))
			var/turf/T=L
			if(!T.Savable) continue
		if(istype(L,/obj))
			var/obj/O=L
			if(!O.Savable) continue
		if(istype(L,/obj))
			var/obj/O=L
			if(!O.Savable) continue
		if(!istype(L,/turf))
			var/atom/movable/M=L
			M.loc = locate(L.savedX,L.savedY,L.savedZ)
		else
			var/turf/T=new L.type
			T.name=L.name
			T.Health=L.Health
			T.Level=L.Level
			T.Builder=L.Builder
			T.FlyOverAble=L.FlyOverAble
			Turfs+=T
	world << "Finishing map load."
*/

//	var/list/MapSave = F[]
//	F << MapSave



	var/Amount=0
	var/DebugAmount= 0
	var/E=1
	//if(fexists("Map[E]"))
	load
	if(E>1)
		world << "Successfully jumped to next file."

	if(fexists("Data/Maps/Map[E]"))
		world << "File found. (Map File [E])"

	else
		world << "No more files found. Done loading turfs."
		goto end

	var/savefile/F=new("Data/Maps/Map[E]")
	//if(length(F["success"])) global.startRuin = 1

	//sleep(1)
	var/list/Types=F["Types"]
	diary << "Types loaded."
	var/list/Healths=F["Healths"]
	diary << "Healths loaded."
	var/list/Levels=F["Levels"]
	diary << "Levels loaded."
	var/list/Builders=F["Builders"]
	diary << "Builders loaded."
	var/list/Xs=F["Xs"]
	diary << "Xs loaded."
	var/list/Ys=F["Ys"]
	diary << "Ys loaded."
	var/list/Zs=F["Zs"]
	diary << "Zs loaded."
	var/list/FlyOver=F["FlyOver"]
	diary << "Fly Over loaded."
	Amount = 0
	//sleep(1)

	world << "Done loading Map File [E]"
	//sleep(1)
	for(var/A in Types)
		Amount++
	//	if(text2num(list2params(Zs.Copy(Amount,Amount+1)))==11||text2num(list2params(Zs.Copy(Amount,Amount+1)))==10) continue
		DebugAmount ++
		var/turf/T=new A(locate(text2num(list2params(Xs.Copy(Amount,Amount+1))),text2num(list2params(Ys.Copy(Amount,Amount+1))),text2num(list2params(Zs.Copy(Amount,Amount+1)))))
		T.Health=text2num(list2params(Healths.Copy(Amount,Amount+1)))
		T.Level=text2num(list2params(Levels.Copy(Amount,Amount+1)))
		T.Builder=list2params(Builders.Copy(Amount,Amount+1))//
		T.FlyOverAble=text2num(list2params(FlyOver.Copy(Amount,Amount+1)))
		Turfs+=T
		T.overlays = null
		for(var/obj/Props/P in view(0,T)) del(P)
//		sleep(-1)
		//if(T.Builder) new/area/Inside(T)
		for(var/obj/Door/B in T)
			if(!B.Builder)
				del(B)
		if(Amount >= 20000)
			diary << "End of Map File [E] reached. Preparing to load next file."
			sleep(1)
			break
	if(Amount >= 20000)
		diary << "Moving to Map File [E+1]"
		E ++
		goto load

	end

	world << "All Maps Loaded ([DebugAmount])"
	world << "Allowing normal players to log in again."

	global.MapsLoaded=1
	global.CanSave = 1


*/


/*

OLD

*/


/*turf/Write(savefile/F)
	var/list/Contents=new
	for(var/atom/A in contents) if(ismob(A)|isobj(A))
		A.saved_x=x
		A.saved_y=y
		A.saved_z=z
		Contents+=A
	contents=null
	..()
	for(var/mob/A in Contents) A.loc=locate(A.saved_x,A.saved_y,A.saved_z)
	for(var/obj/A in Contents) A.loc=locate(A.saved_x,A.saved_y,A.saved_z)
proc/MapSave()
	if(fexists("MapSave")) fcopy("MapSave","MapSave Backup")
	var/amount=0
	var/savefile/F=new("MapSave")
	for(var/turf/A in Turfs)
		amount++
		if(!A.z) Turfs-=A
	for(var/mob/A in Turfs) Turfs-=A
	world<<"Map Saved ([amount])"
	F<<Turfs
	fdel("MapSave Backup")
proc/MapLoad()
	if(fexists("MapSave Backup"))
		fcopy("MapSave Backup","MapSave")
		fdel("MapSave Backup")
	if(fexists("MapSave"))
		var/amount=0
		var/savefile/F=new("MapSave")
		F>>Turfs
		for(var/turf/A in Turfs)
			amount++
			new/area/Inside(locate(A.x,A.y,A.z))
			for(var/obj/Props/Edges/B in A) if(!B.Builder) del(B)
			for(var/obj/Props/Surf/B in A) if(!B.Builder) del(B)
			for(var/obj/Props/Trees/B in A) if(!B.Builder) del(B)
			for(var/obj/Turfs/B in A) if(!B.Builder) del(B)
		world<<"<font size=1>Map Loaded ([amount])"*/
