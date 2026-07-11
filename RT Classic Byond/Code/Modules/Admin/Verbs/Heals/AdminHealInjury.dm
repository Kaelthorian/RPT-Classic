mob/proc/
	Get_Injury_Healed(mob/M in Players)
		set category = "Admin"
		set name = "Admin Heal Injury"
		/*if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(!M)
			alert("Mob doesn't exist!")
			return
		for(var/BodyPart/P in M) M.Injure_Heal(200,P,1)
		/*var/list/Parts=list()
		for(var/BodyPart/P in M) Parts+=P
		Parts+="Cancel"
		Parts+="All"
		var/BodyPart/Cho=input(usr,"Heal which part?") in Parts
		if(Cho=="Cancel") return
		if(Cho=="All") for(var/BodyPart/P in M) M.Injure_Heal(200,Cho,1)
		else M.Injure_Heal(200,Cho,1)*/
		log_admin("[key_name(usr)] used AdminHeal Injury on [key_name(M)]")
		alertAdmins("[key_name(usr)] used AdminHeal Injury on [key_name(M)]")