mob/Tournament/verb
	LookAround()
		set category="Tournament"
		set src=usr.contents
		var/mob/A=input(usr,"Choose someone to observe.") as mob in Players
		if(A=="Cancel") return
		usr << "You are now watching [A]."
		usr.Get_Observe(A)

	CappedStats()
		set category="Tournament"
		if(usr.Confirm("Cap all [usr]'s stats?"))
			usr.CapStats2(1.2)
			usr.Base=(TrueBPCap*usr.BPMod)

	Spawn_Item()
		set category="Tournament"
		var/obj/items/Ob = input(src,"List","Pick what you want to create") as null|anything in (typesof(/obj/items/)-/obj/items)
		if(!Ob)return
		new Ob(loc)

	Heal()
		set category="Tournament"
		usr.Willpower		=100
		usr.Health			=100
		for(var/BodyPart/MM in usr)
			MM.Health		=100
			MM.Status		="Healthy"

	RobingHood()
		set category="Tournament"
		for(var/obj/Mana/MM in usr)
			MM.Value 		=10000000000000000
		for(var/obj/Resources/MM in usr)
			MM.Value 		=10000000000000000


proc/TournamentPreparation(mob/S)
	S.x=50
	S.y=80
	S.z=2

	if(S.TotalMilestonePoints <= 38)
		S.TotalMilestonePoints  =38
		S.MilestonePoints		=38

	if(usr.EXPLifetime != 3630)
		usr.EXP			= 3630
		usr.EXPLifetime	= 3630

	usr.CapStats2(1.2)
	usr.Base=(TrueBPCap*usr.BPMod)
















