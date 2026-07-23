mob/TestServerOn/verb
	Grant_CappedStats(mob/M in Players)
		set category="TestServer"
		if(usr.Confirm("Cap all [M]'s stats?"))
			M.CapStats()
			log_admin("[key_name(usr)] capped [M]'s stats.")
			alertAdmins("[key_name_admin(usr)] capped [M]'s stats.", 1)
	Summon_BlueMage()
		set category="TestServer"
		var/mob/BlueMageTestServer/S = new()
		S.loc=(locate(usr.x,usr.y,usr.z))
		view() << "[src] creates \an [S] from thin air!"

	Learn_Skill()
		set category="TestServer"
		var/Skill/Ob = input(src,"List","Pick what you want to learn") as null|anything in (typesof(/Skill/)-/Skill)
		if(!Ob)return
		new Ob(src)

	Spawn_Item()
		set category="TestServer"
		var/obj/items/Ob = input(src,"List","Pick what you want to create") as null|anything in (typesof(/obj/items/)-/obj/items)
		if(!Ob)return
		new Ob(loc)
	Heal()
		set category="TestServer"
		usr.Willpower		=100
		usr.Health			=100
		for(var/BodyPart/MM in usr)
			MM.Health		=100
			MM.Status		="Healthy"

	RobingHood()
		set category="TestServer"
		for(var/obj/Mana/MM in usr)
			MM.Value 		=10000000000000000
		for(var/obj/Resources/MM in usr)
			MM.Value 		=10000000000000000


