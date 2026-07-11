Skill/Buff/MachineForce
	BP=1.5
	Recov=1.25
	buffon="'s power suddenly increases greatly!"
	buffoff="'s power returns to normal."
	/*GetDescription()
		return"[BP]x BP at the cost of 30% of your recovery ticks. Also reduces the impact low energy has on your BP. (100-70% instead of 100-0% scaling based on current energy)"
		..()*/
	verb/Machine_Force()
		set category="Skills"
		for(var/T in SkillBanned)
			if(src.name == T)
				usr.CombatOut("This skill is temporaly banned.")
				return
		use(usr, /Icon_Obj/Cloak/DefaultCloak, 2)