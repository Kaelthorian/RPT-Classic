proc
	GetMapImage(zlevel=1,size=1)
		var x_size = size * world.maxx
		var y_size = size * world.maxy
		while(x_size>10096){size--;x_size = size * world.maxx}
		while(y_size>10096){size--;y_size = size * world.maxy}
		var/icon/img = new('A.dmi'),list/Tiles = list()
		img.Crop(1,1,world.maxx*size,world.maxy*size)
//		world<<"[world.maxx]x[world.maxy]"
		for(var/Y=1 to world.maxy)
			for(var/X=1 to world.maxx)
				var/turf/T = locate(X,Y,zlevel)
				if(!Tiles.Find("[T.icon][T.icon_state]"))
					var/icon/A = new(T.icon,T.icon_state,T.dir,1)
					A.Scale(size,size)
					img.Blend(A,ICON_OVERLAY,X*size,Y*size)
					Tiles["[T.icon][T.icon_state]"] += A
				else img.Blend(Tiles["[T.icon][T.icon_state]"],ICON_OVERLAY,X*size,Y*size)
				for(var/obj/O in T.contents)
					if(!Tiles.Find("[O.icon][O.icon_state]"))
						var/icon/B = new(O.icon,O.icon_state,1)
						B.Scale(size,size)
						img.Blend(B,ICON_OVERLAY,X*size,Y*size)
						Tiles["[O.icon][O.icon_state]"] += B
					else img.Blend(Tiles["[O.icon][O.icon_state]"],ICON_OVERLAY,X*size,Y*size)
		return img

mob/verb/Test(zlevel as num, n as num)
	src<<ftp(GetMapImage(zlevel,n),"MapOutput.png")