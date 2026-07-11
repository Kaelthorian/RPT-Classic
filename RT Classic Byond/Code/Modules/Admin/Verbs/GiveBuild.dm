mob/proc/
	Give_Build(mob/M as mob in Players)
		set hidden=1//set category="Admin"
		/*if(!usr.client.holder || usr.client.holder.level < 1)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		M.HasBuildingPermit=1
		if(usr.Confirm("Give them the ability to build in space too?")) M.BuildInSpace=1