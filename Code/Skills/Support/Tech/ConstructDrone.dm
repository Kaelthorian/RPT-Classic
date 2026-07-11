Skill/Technology/Construct_Robot

	var/LastUse=0
	desc="Craft a robot to command as you would a split form."
	verb/Construct_Robot()
		set category="Other"
		if(usr.RPMode) return
		if((usr.icon_state in list("KO","KB"))||usr.Frozen) return
		if(!usr.move|usr.attacking) return
		if(Year<LastUse+1)
			usr<<"You cannot use this until 1 years after you last used it"
			return
		if(!usr.Confirm("Spend [60000000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))] to make a Drone?")) return
		var/obj/Resources/A =locate(/obj/Resources) in usr
		var/Cost=6000000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(A.Value<Cost){usr << "You do not have enough resources.";return}
		A.Value-=Cost
		view(usr)<<"[usr] creates a Drone!"
		var/mob/Drone/D = new /mob/Drone		//Creates= new /mob/Drone/
		D.loc=usr.loc
		D.dronekey=usr.ckey
		D.Builder="[usr.real_name]"
		global.worldObjectList+=D
		LastUse=Year