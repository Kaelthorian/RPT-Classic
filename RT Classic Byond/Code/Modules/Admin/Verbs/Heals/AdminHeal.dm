mob/Admin1/verb

	ARestore(mob/M in Players)
		//set category = "Admin"
		set name = "Admin Restore"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!M)
			alert("Mob doesn't exist!")
			return
		if(M.KOd) M.Un_KO()
		M.Health = M.MaxHealth
		M.Frozen=0
		M.attacking=0
		if(usr.Confirm("Restore their Willpower?")) M.Willpower=M.MaxWillpower
		if(usr.Confirm("Heal Injuries?"))  for(var/BodyPart/P in M) if(P.Health<=P.MaxHealth) M.Injure_Heal(200,P,1)
		if(M.KOd) M.Un_KO()
		M.Health = M.MaxHealth
		M.Ki = M.MaxKi
		M.Calm()
		M.Ki = M.MaxKi
		M.HitterListOld = list()
		M.FailToAnger=0
		M.HitterListNew = list()
		M.LastHitter = 0
		log_admin("[key_name(usr)] used AdminHeal on [key_name(M)]")
		alertAdmins("[key_name(usr)] used AdminHeal on [key_name(M)]")