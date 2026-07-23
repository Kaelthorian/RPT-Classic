mob/Admin1/verb

	Count_Drills()
		set category="Debug"
		var/Drills=0
		var/Pylons=0
		for(var/obj/Drill/D in global.DrillList)Drills++
		for(var/obj/Mana_Pylon/P in global.DrillList)Pylons++
		usr<<"There are [Drills] Drills, and [Pylons] Pylons."