Skill/Spell/Construct_Doll

	var/LastUse=0
	desc="Craft a spirit doll to command as you would a split form."
	verb/Construct_Doll()
		set category="Other"
		if(usr.RPMode) return
		if((usr.icon_state in list("KO","KB"))||usr.Frozen) return
		if(!usr.move|usr.attacking) return
		if(Year<LastUse+1)
			usr<<"You cannot use this until 1 years after you last used it"
			return
		if(!usr.Confirm("Spend [60000000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))] to make a doll?")) return
		var/obj/Mana/A =locate(/obj/Mana) in usr
		var/Cost=6000000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
		if(A.Value<Cost){usr << "You do not have enough mana.";return}
		A.Value-=Cost
		view(usr)<<"[usr] creates a Drone!"
		var/mob/Doll/D = new /mob/Doll		//Creates= new /mob/Drone/
		D.loc=usr.loc
		D.dronekey=usr.ckey
		D.Builder="[usr.real_name]"
		global.worldObjectList+=D
		LastUse=Year