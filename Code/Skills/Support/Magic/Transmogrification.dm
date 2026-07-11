Skill/Spell/Transmogrification
	Experience=100
	desc="This spell allows you to use the alchemi and change the ores from one kind to another with the help of mana."
	verb/Transmogrification()
		set category = "Other"
		if(usr.RPMode||usr.KOd)
			usr<<"You can't do that right now"
			return
		var/list/list1=new
		list1+=typesof(/obj/items/rawore in src)
		var/obj/items/rawore/Choice=input("Replace all turfs with what?") in list1
