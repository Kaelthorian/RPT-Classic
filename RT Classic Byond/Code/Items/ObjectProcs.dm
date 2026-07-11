#define DRILLS

var/list/DrillList = new()

proc/loopThroughDrills()
	set background=1
	set waitfor=0
	var/count = 0
	if(!global.DrillList.len || !global.DrillList)
		spawn(600) // Pause 1 minute
			.() // Then call itself again

	for(var/obj/Drill/drillObj in global.DrillList)
		count++
		sleep(0)
		if(drillObj.Resources<(2800*drillObj.DrillRate))
			var/Taxes=0
			switch(drillObj.z)
				if(1)Taxes=(Z1Tax/100)*10*drillObj.DrillRate
				if(2)Taxes=(Z2Tax/100)*10*drillObj.DrillRate
				if(3)Taxes=(Z3Tax/100)*10*drillObj.DrillRate
				if(4)Taxes=(Z4Tax/100)*10*drillObj.DrillRate
				if(5)Taxes=(Z5Tax/100)*10*drillObj.DrillRate
				if(6)Taxes=(Z6Tax/100)*10*drillObj.DrillRate
				if(7)Taxes=(Z7Tax/100)*10*drillObj.DrillRate
			Taxes=round(Taxes)
			switch(drillObj.z)
				if(1)Z1ReserveResources+=Taxes
				if(2)Z2ReserveResources+=Taxes
				if(3)Z3ReserveResources+=Taxes
				if(4)Z4ReserveResources+=Taxes
				if(5)Z5ReserveResources+=Taxes
				if(6)Z6ReserveResources+=Taxes
				if(7)Z7ReserveResources+=Taxes
			drillObj.Resources+=(10*drillObj.DrillRate)-Taxes

		if(count >= 500) // pause every 500 drills
			count=0
			sleep(10) // for a full minute
	for(var/obj/Mana_Pylon/drillObj in global.DrillList)
		count++
		sleep(0)

		if(drillObj.Resources<(2800*drillObj.DrillRate))
			var/Taxes=0
			switch(drillObj.z)
				if(1)Taxes=(Z1Tax/100)*10*drillObj.DrillRate
				if(2)Taxes=(Z2Tax/100)*10*drillObj.DrillRate
				if(3)Taxes=(Z3Tax/100)*10*drillObj.DrillRate
				if(4)Taxes=(Z4Tax/100)*10*drillObj.DrillRate
				if(5)Taxes=(Z5Tax/100)*10*drillObj.DrillRate
				if(6)Taxes=(Z6Tax/100)*10*drillObj.DrillRate
				if(7)Taxes=(Z7Tax/100)*10*drillObj.DrillRate
			Taxes=round(Taxes)
			switch(drillObj.z)
				if(1)Z1ReserveMana+=Taxes
				if(2)Z2ReserveMana+=Taxes
				if(3)Z3ReserveMana+=Taxes
				if(4)Z4ReserveMana+=Taxes
				if(5)Z5ReserveMana+=Taxes
				if(6)Z6ReserveMana+=Taxes
				if(7)Z7ReserveMana+=Taxes
			drillObj.Resources+=(10*drillObj.DrillRate)-Taxes


		if(count >= 500) // pause every 500 drills
			count=0
			sleep(10) // for a full minute
	spawn(3000) // Pause 5 minutes
		.() // Then call itself again

obj
	var
		link_used = 0
	proc
		Move_Resources(var/turf/t,var/mob/M)
			if(src.loc == t)
				for(var/obj/Mana/Y in view(0,src))
					if(Y == src)
						for(var/mob/X in range(1,src))
							if(M) if(X == M)
								for(var/obj/Mana/magic in M)
									magic.Value += Y.Value
									del(src)
				for(var/obj/Resources/Y in view(0,src))
					if(Y == src)
						for(var/mob/X in range(1,src))
							if(M) if(X == M)
								for(var/obj/Resources/magic in M)
									magic.Value += Y.Value
									del(src)
				return
			if(t) if(M) if(src.loc != t)
				step_towards(src,t)
				spawn(5)
					if(t) if(M) src.Move_Resources(t,M)
		Pylon_Link(var/mob/clicker)
			for(var/obj/Mana_Pylon/X in view(0,src))
				SaveItemATOM(X)
				if(X == src)
					if(X.Resources > 0)
						var/obj/Mana/A = new
						A.Value+=X.Resources
						A.loc = X.loc
						A.name = "[Commas(X.Resources)] Mana"
						var/turf/t = clicker.loc
						A.Move_Resources(t,clicker)
					view(src)<<"[clicker] withdraws [Commas(X.Resources)] mana from [src]"
					clicker<<"This is a level [X.DrillRate] mana pylon."
					usr.saveToLog("([clicker.x], [clicker.y], [clicker.z]) | [key_name(clicker)] withdraws [Commas(X.Resources)] mana from [src] (built by: [src.Builder]).\n")
					src.link_used = 1
					spawn(33)
						if(src) src.link_used = 0
					for(var/obj/Mana_Pylon/P in oview(2,src))
						if(P.Builder == src.Builder) if(P.link_used == 0)
							P.Pylon_Link(clicker)
						var/Step = get_step_towards(X,P)
						var/Dir = get_dir(X,P)
						if(Dir == SOUTH || Dir == EAST || Dir == WEST || Dir == NORTH)
							var/Icon_Obj/Customization/Auras/Sparks/E = new
							E.loc = Step
							E.pixel_y = 14
							E.icon = 'blue elec.dmi'
							E.layer = 100
							spawn(20)
								if(E) del(E)
					X.Resources=0
		Drill_Link(var/mob/clicker)
			for(var/obj/Drill/X in view(0,src))
				SaveItemATOM(X)
				if(X == src)
					if(X.Resources > 0)
						var/obj/Resources/A = new
						A.Value+=X.Resources
						A.loc = X.loc
						A.name = "[Commas(X.Resources)] Resources"
						var/turf/t = clicker.loc
						A.Move_Resources(t,clicker)
					view(src)<<"[clicker] withdraws [Commas(X.Resources)] resources from [src]"
					clicker<<"This is a level [X.DrillRate] drill."
					usr.saveToLog("([clicker.x], [clicker.y], [clicker.z]) | [key_name(clicker)] withdraws [Commas(X.Resources)] Resources from [src] (built by: [src.Builder]).\n")
					src.link_used = 1
					spawn(33)
						if(src) src.link_used = 0
					for(var/obj/Drill/P in oview(2,src))
						if(P.Builder == src.Builder) if(P.link_used == 0)
							P.Drill_Link(clicker)
						var/Step = get_step_towards(X,P)
						var/Dir = get_dir(X,P)
						if(Dir == SOUTH || Dir == EAST || Dir == WEST || Dir == NORTH)
							var/Icon_Obj/Customization/Auras/Sparks/E = new
							E.loc = Step
							E.pixel_y = 14
							E.icon = 'blue elec.dmi'
							E.layer = 100
							spawn(20)
								if(E) del(E)
					X.Resources=0