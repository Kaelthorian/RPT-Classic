Skill/Support/Make_Fruit
	Experience=100
	desc="With this you can make fruits that will increase the power and energy of those who eat them, \
	along with a temporary boost to regeneration and recovery. The more of them you eat however, the \
	less of an effect they will have each time."
	var/tmp/Making=0
	var/LastUse=0
	verb/Make_Fruit()
		set category="Other"
		if(Making)
			usr<<"You are already making one"
			return
		if(Year<LastUse+2)
			usr<<"You must wait before making another one. (Year [LastUse+2])"
			return
		/*
		if(CD>0)
			usr<<"You must wait before making another one."
			return
		CD=9000*/
		Making=1
		view(usr)<<"[usr] begins planting something"
		LastUse=Year
		sleep(750)
		Making=0
		view(usr)<<"A strange fruit appears in front of [usr]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] makes a Fruit.\n")
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] made a Fruit")
		var/obj/items/Fruit/A=new(get_step(usr,usr.dir))
		A.name="[usr] Fruit"
		A.EXP = usr.GainMultiplier
		hearers(10,usr) << sound('Pop.wav',volume=20)