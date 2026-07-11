Skill/Support/Heal
	UB1="Channel"
	UB2="Machine Force"

	desc="You can heal anyone in front of you by giving up some of your own health and energy. If they \
	have certain status problems they can be further alleviated by healing them, with multiple heals \
	they may be cured."

	verb/Heal()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.KOd||usr.Ki<usr.MaxKi/usr.KiMod) return
		if(usr.LethalCombatTracker)
			usr<<"Your body is too wounded to use this right now.(Combat tracker)"
			return
		for(var/mob/A in get_step(usr,usr.dir))
			if(!A.client) return


			CD=usr.Refire
			CDTick(usr)
//			usr.TakeDamage((usr, 50), "Healing [A]")
			usr.DrainKi(src,1,(usr.MaxKi/usr.KiMod))//usr.Ki=max(0,usr.Ki-)
			if(A.Willpower<=0) A.WillpowerRestore()
			if(A.Willpower<100&&A.Willpower>0&&usr.Willpower>10)
				A.Willpower+=0.1
				usr.Willpower-=0.05
				if(usr.Willpower<1) usr.Willpower=1
			A.Un_KO()
			A.HealDamage("Heal ([usr])", round(25,0.5))
			for(var/BodyPart/P in A)
				if(usr.RPPower>1.1) if(P.Health<=P.MaxHealth) A.Injure_Heal(20,P,1)
				else if(P.Health<=P.MaxHealth) A.Injure_Heal(10,P)
//			A.Heal_Zenkai()
			if((A.Health/A.MaxHealth)*100>(A.Willpower/A.MaxWillpower)*100) A.Health=(A.Willpower/A.MaxWillpower)*100
			view(usr)<<"<font color=#FFFF00>[usr] heals [A]"
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] healed [key_name(A)]")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] healed [key_name(A)].\n")
			A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was healed by [key_name(usr)].\n")
			break

