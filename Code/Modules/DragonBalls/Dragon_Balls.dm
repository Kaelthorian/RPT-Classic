////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////Dragon Balls Verbs//////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

mob/Admin1/verb/Locate_All_Dragonballs()
	set category="Admin Other"
	for(var/obj/items/Magic_Ball/A in world)																//For all the dragon balls in the server
		usr << "Dragon Ball [A.name] at [A.x],[A.y],[A.z], [A.loc]."										//Tell me their name , coords and turf (or person who holds them)

var/list/DragonBalls = new

mob/Admin1/verb/Active_Dragonballs()
	for(var/obj/items/Magic_Ball/A in world)
		A.Active()

mob/Admin1/verb/Deactivate_Dragonballs()
	for(var/obj/items/Magic_Ball/A in world)
		A.Inert()

mob/Admin1/verb/Allow_Wishing()
	for(var/obj/items/Magic_Ball/A in world)
		A.WishInProcess=0
		if(A.DBCD==1)
			A.DBCD=0
			A.WishInProcess=1
			logAndAlertAdmins("[key_name(usr)] Denied the dragonballs to wish")
			return
		A.DBCD=1
		logAndAlertAdmins("[key_name(usr)] Allowed the dragonballs to wish")

mob/Admin1/verb/Scatter_Dragonballs()
	set category="Admin Other"
	for(var/obj/items/Magic_Ball/A in world)																//For all the dragonballs in the server
		A.Scatter()																							//Run the scatter proc
		logAndAlertAdmins("[key_name(usr)] scattered the Drabonball [A.BallNumber] on z[usr.z]")			//Log this action for the admins and show it.

mob/Admin1/verb/Create_Dragonballs()
	set category="Admin Other"
	if(usr.RPMode) return
	var/DB1
	var/DB2
	var/DB3
	var/DB4
	var/DB5
	var/DB6
	var/DB7
	if(usr.Confirm("Want to create the Dragonballs?"))
		logAndAlertAdmins("[key_name(usr)] made the Dragonballs on z[usr.z]")								//Log this action for the admins and show it.
		for(var/obj/items/Magic_Ball/A in DragonBalls) if(A.Creator==usr.key)
			if(A.name=="Earth Orb") DB1=1
			if(A.name=="Namek Orb") DB2=1
			if(A.name=="Vegeta Orb") DB3=1
			if(A.name=="Icer Orb") DB4=1
			if(A.name=="Arconia Orb") DB5=1
			if(A.name=="Alien Orb") DB6=1
			if(A.name=="Afterlife Orb") DB7=1
		if(!DB1)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Earth Orb"
			A.BallNumber=1
			A.Creator=usr.key
			DragonBalls+=A
		if(!DB2)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Namek Orb"
			A.BallNumber=2
			A.Creator=usr.key
			DragonBalls+=A
		if(!DB3)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Vegeta Orb"
			A.BallNumber=3
			A.Creator=usr.key
			DragonBalls+=A
		if(!DB4)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Icer Orb"
			A.BallNumber=4
			A.Creator=usr.key
			DragonBalls+=A
		if(!DB5)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Arconia Orb"
			A.BallNumber=5
			A.Creator=usr.key
			DragonBalls+=A
		if(!DB6)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Alien Orb"
			A.BallNumber=6
			A.Creator=usr.key
			DragonBalls+=A
		if(!DB7)
			var/obj/items/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Afterlife Orb"
			A.BallNumber=7
			A.Creator=usr.key
			DragonBalls+=A
		var/DB_Icon
		for(var/obj/items/Magic_Ball/A in DragonBalls) if(A.Creator==usr.key)
			if(A.icon!=initial(A.icon)) DB_Icon=A.icon
			if(DB_Icon) A.icon=DB_Icon


mob/Admin1/verb/Delete_Dragon_Balls()
	set category = "Admin Other"
	if(usr.Confirm("Delete all Dragon Balls?"))																//You sure dude?
		for(var/obj/items/Magic_Ball/G in world)															//Alright then ,for all the DBs in the server
			del(G)																							//"*Thanos snap*
		alertAdmins("[key_name_admin(usr)] deleted all Dragon Balls.", 1)									//Report to the admins
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////Dragon Balls Object&Procs///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
proc/SaveDragonballs()
	for(var/mob/player/M)																					//For all the players in the server
		for(var/obj/items/Magic_Ball/A in M)																//If there is a Magic_Ball inside of you
			if(A.x==0 && A.y==0 && A.z==0)																	//And if there coords of them are 0 0 0 , aka is inside of someone (Or in the void)
				for(A in M)																					//For that Magic_Ball inside the player
					M<<"<font color=red>DRAGONBALL DROPPED AT [M.x];[M.y];[M.z]"
					A.LastDBOwner=M.ckey																	//Set the variable to the one who was hodling the Magic_Ball
					A.DBGrabCD= Year+(Month*0.01)+1															//Set the CD year for it
					if(isobj(M.loc))																		//If the obj is inside the player
						var/obj/O = M.loc																	//Makes a new obj O on the user location
						A.loc=O.loc																			//We make the old obj to have the same loc as the new obj
					else A.loc=M.loc																		//The old obj location is the same as the player loc

proc/SaveDragonballs2()
	var/foundobjects=0																						//I have no idea how this work 100% but it save the position of whatever you put :D
	var/savedobjs = list()
	var/E = 1
	var/savefile/F=new("Data/ItemSaves/ItemSave[E].bdb")
	var/list/L=new
	for(var/obj/items/Magic_Ball/A)
		A.savedX = A.x
		A.savedY = A.y
		A.savedZ = A.z
		A.Save_Loc = A.loc
		L += A
		savedobjs += A
	if(foundobjects % 1000 == 0)
		F["SavedItems"] << L
		E ++
		F=new("Data/ItemSaves/ItemSave[E].bdb")
		L=new


obj/items/Magic_Ball
	icon='New DBalls.dmi'
	desc="A strange orb with the exact form of a planet , you feel an strange energy comming from it."
	Health=1.#INF
	Savable=1
	var/LastDBOwner
	var/DBGrabCD
	var/Creator="God"
	var/BallNumber
	var/DBCD=0
	var/BallsAreInert=0
	var/WishInProcess=0
	New()
		if(!BallsAreInert) spawn(10) Active()
//	Del()
//		DragonBalls-=src
//		..()


	proc/Scatter()
//		var/image/Dragon = image('Shenron.dmi', pixel_x= -1186, pixel_y= -32)								//
		for(var/obj/items/Magic_Ball/A in world)															//For all the dragon balls in the server
			A.overlays+='Dragon Ball Aura.dmi'																//We add the yellow glowing aura
			walk_rand(A)																					//We make it walk/fly around the Z plane they are on
			if(A.BallNumber==1 && A.z!=1)																	//If they are the DB1 and they are not in the Z1
				A.z=1																						//Change the variable to Z1
			if(A.BallNumber==2 && A.z!=2)																	//If they are the DB1 and they are not in the Z2
				A.z=2																						//Change the variable to Z2
			if(A.BallNumber==3 && A.z!=3)																	//If they are the DB1 and they are not in the Z3
				A.z=3																						//Change the variable to Z3
			if(A.BallNumber==4 && A.z!=4)																	//If they are the DB1 and they are not in the Z4
				A.z=4																						//Change the variable to Z4
			if(A.BallNumber==5 && A.z!=5)																	//If they are the DB1 and they are not in the Z5
				A.z=5																						//Change the variable to Z5
			if(A.BallNumber==6 && A.z!=6)																	//If they are the DB1 and they are not in the Z6
				A.z=6																						//Change the variable to Z6
			if(A.BallNumber==7 && A.z!=7)																	//If they are the DB1 and they are not in the Z7
				A.z=7																						//Change the variable to Z7
			spawn(3000)																						//But for only 300 seconds
				walk(A,0)																					//Then we make them stop
				A.overlays-='Dragon Ball Aura.dmi'															//And we make the glow aura removal
				A.Inert()
		alertAdmins("[key_name_admin(usr)] Scattered all Dragon Balls.", 1)									//Report

	proc/Inert()
		for(var/obj/items/Magic_Ball/A in world)
			A.icon_state=null
			A.BallsAreInert=1


	proc/Active()
		for(var/obj/items/Magic_Ball/A in world)
			A.overlays-='Dragon Ball Aura.dmi'
			A.BallsAreInert=0
			if(A.BallNumber==1)
				A.name="Earth Orb"
				A.icon_state="1"
				A.pixel_x=0
				A.pixel_y=0
			if(A.BallNumber==2)
				A.name="Namek Orb"
				A.icon_state="2"
				A.pixel_x=-16
				A.pixel_y=0
			if(A.BallNumber==3)
				A.name="Vegeta Orb"
				A.icon_state="3"
				A.pixel_x=16
				A.pixel_y=0
			if(A.BallNumber==4)
				A.name="Icer Orb"
				A.icon_state="4"
				A.pixel_x=-8
				A.pixel_y=16
			if(A.BallNumber==5)
				A.name="Arconia Orb"
				A.icon_state="5"
				A.pixel_x=8
				A.pixel_y=16
			if(A.BallNumber==6)
				A.name="Alien Orb"
				A.icon_state="6"
				A.pixel_x=-8
				A.pixel_y=-16
			if(A.BallNumber==7)
				A.name="Afterlife Orb"
				A.icon_state="7"
				A.pixel_x=8
				A.pixel_y=-16


	verb/Wish()
		set src in oview(1)
		var/image/Dragon = image('Shenron.dmi', pixel_x= -1186, pixel_y= -32)
		var/Magic_Balls=0
		if(BallsAreInert)
			usr<<"You send some of your ki to the balls , nothing happens."
			return
		if(usr.RPMode) return
		for(var/obj/items/Magic_Ball/A in range(0,src)) if(A.Creator==Creator) Magic_Balls++
		if(Magic_Balls<7)
			usr<<"You send some of your ki to the balls , they glow and vibrate for a moment but they stop after a few seconds, something is missing."
			return
		if(!icon_state)
			usr<<"You send some of your ki to the balls , nothing happens."
			return
		if(WishInProcess==1)
			usr<<"Wish in process"
			return
		if(!DBCD)
			for(var/obj/items/Magic_Ball/A)
				WishInProcess=1
			usr<<"In order to wish you need to defend the dragonballs , if someone want to stop you you must fight.Wait for the admins to come to start the wish"
			for(var/mob/A)
				if(A.z == usr.z)
					A<<"<span class=\"narrate\">The skies turn black and the wind blows stronger, in the distance a dragon could be seen.</span>"
					logAndAlertAdmins("[key_name(usr)] started the wishing process at [src.x];[src.y];[src.z]")
					return
		logAndAlertAdmins("[key_name(usr)] is wishing at [src.x];[src.y];[src.z]")
		overlays+=Dragon
		var/list/Choices=new
		Choices+="Admin Wish (Bargain with us)"
		Choices+="Nothing"
		Choices+="Mana"
		Choices+="Resources"
		Choices+="Revive"
		switch(input("What is your wish?") in Choices)
			if("Nothing")
				view(usr)<<"[usr] cancelled their wish"
				overlays-=Dragon
				return
			if("Admin Wish")
				view(usr)<<"[usr] wishes for admin stuff!"
				for(var/mob/M in Players) if(M.client && M.client.holder) M.AllOut("<b><font color=red>(DRAGON BALL WISH)</font color> <A HREF='?src=\ref[M.client.holder];privatemessage=\ref[usr]'>[usr.key]</a href>(<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>) : Dragonball Admin Wish</b>")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] wished with the Magic Balls.\n")
				usr<<"<b>[usr], please wait for an Admin to arrive.  If you make another wish and the Dragonballs are not present, then your admin wish will be nullified.</b>"
				overlays-=Dragon
				view(src)<<"[usr] is making a wish!"
			if("Mana")
				for(var/obj/Mana/C in usr)
					C.Value+=20000000*Year
				view(usr)<<"[usr] wishes to have a lot of mana!"
				logAndAlertAdmins("[key_name(usr)] Wish for mana")
				overlays-=Dragon
				for(var/obj/items/Magic_Ball/A in world)																//For all the dragonballs in the server
					A.Scatter()																							//Run the scatter proc
					A.DBCD=0
			if("Resources")
				for(var/obj/Resources/C in usr)
					C.Value+=20000000*Year
				view(usr)<<"[usr] wishes to have a lot of resources!"
				logAndAlertAdmins("[key_name(usr)] wish for Resources")
				overlays-=Dragon
				for(var/obj/items/Magic_Ball/A in world)																//For all the dragonballs in the server
					A.Scatter()																							//Run the scatter proc
					A.DBCD=0
			if("Revive")
				var/list/ReviveOptions=list()
				for(var/mob/T in Players)
					if(T.Dead==1)
						ReviveOptions+=T
						var/mob/M=input("Choose who to Revive") in ReviveOptions
						M.Revive()
						M.x=src.x
						M.y=src.y
						M.z=src.z
						logAndAlertAdmins("[key_name(usr)] revived [M] with the Dragonballs")
				view(usr)<<"[usr] wishes to revive someone!"
				overlays-=Dragon
				for(var/obj/items/Magic_Ball/A in world)																//For all the dragonballs in the server
					A.Scatter()																							//Run the scatter proc
					A.DBCD=0