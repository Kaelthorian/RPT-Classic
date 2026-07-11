mob/Admin1/verb

	Bulldozer()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		switch(input("What you want to replace?") in list("Obj","Turf","Cancel"))
			if("Turf")
				var/list/list1=new
				list1+=typesof(/turf)
				var/turf/Choice=input("Replace all turfs with what?") in list1
				var/PlayerTarget=input("Exact name of the player (IC name , not Ckey , if not sure right click and look for the variable -Builder-")
				var/ZTarget=input("In what Z plane you want to delete the buildings?") as num
				for(var/turf/T in block(locate(1,1,ZTarget),locate(500,500,ZTarget)))
					if(T.Builder == PlayerTarget) new Choice(T)
				logAndAlertAdmins("[src.key] repalced all the turfs from [PlayerTarget] on the Z plane [ZTarget]",2)

			if("Obj")
				var/PlayerTarget=input("Exact name of the player (IC name , not Ckey , if not sure right click and look for the variable -Builder-")
				var/ZTarget=input("In what Z plane you want to delete the Obj?") as num
				for(var/obj/T)
					if(T.Builder == PlayerTarget && T.z == ZTarget) del(T)
				logAndAlertAdmins("[src.key] deleted all the objs from [PlayerTarget]",2)
			if("Cancel")
				return

mob/Admin1/verb

	Bulldozer_Area()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/list1=new
		list1+=typesof(/turf)
		var/turf/Choice=input("Replace all turfs with what?") in list1
		var/XToBullduze=input("X bottom left?") as num
		var/YToBullduze=input("Y bottom left?") as num
		var/XToBullduze2=input("X top right?") as num
		var/YToBullduze2=input("Y top right?") as num
		var/ZToBullduze=input("Z plane?") as num
		for(var/turf/T in block(locate(XToBullduze,YToBullduze,ZToBullduze),locate(XToBullduze2,YToBullduze2,ZToBullduze)))
			T.Builder = usr
			new Choice(T)
		logAndAlertAdmins("[src.key] Bulldozed the are between ([XToBullduze];[YToBullduze];[ZToBullduze]) to ([XToBullduze2];[YToBullduze2];[ZToBullduze])",2)

