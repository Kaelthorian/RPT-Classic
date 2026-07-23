client/proc
	Give_Other(mob/M as mob in Players)
		set category="Admin"
		set name="Give Menu"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/Choices=list("Cancel","Warning","Remove Power Mate","Remove Combat Flag","Alter Willpower","Give Infection","Remove Infection", "Admin Revive", "Give Build","Give Nitro Booster","Give Starter Boost","Give Skill Mastery","Give Object","Give Anger","Force Reincarnate","Give Redo Stats","Give Martial Arts","Alter Stats","Give Capped Stats","Allow Multikeys")
		if(usr.client.holder.level >= 2) Choices.Add("Make Basic EC","Give Vampire","Remove Vampire","Give God Ki","Give Rank","Give Rare Access","Give Transformation","Assign Control Point")
		var/PP=input("Give [M] what?","Give Other") in Choices
		switch(PP)
			if("Give Build") usr.Give_Build(M)
			if("Give Capped Stats")usr.Grant_Capped_Stats(M)
			if("Give Anger") usr.Grant_Anger(M)
			if("Give Object") usr.client.Give_Object_Menu(M)
			if("Force Reincarnate") usr.Force_Reincarnate(M)
			if("Give Redo Stats") usr.Give_RedoStats(M)
			if("Give Rare Access") usr.client.allow_rares(M)
			if("Give Transformation") usr.client.Grant_Transformation(M)
			if("Alter Stats") usr.client.Reward(M)
			if("Allow Multikeys") usr.ApproveMultikey(M)
			if("Assign Control Point")usr.Assign_Control_Point(M)
			if("Remove Combat Flag") usr.RemoveCombat(M)
			if("Alter Willpower") usr.AlterWP(M)
			if("Admin Heal Injury") usr.Get_Injury_Healed(M)
			if("Admin Revive") usr.ARevive(M)
			if("Make Basic EC") usr.Grant_Basic_EC_Stuff(M)
			if("Warning") usr.Warn(M)
			if("Remove Vampire") M.RemoveVampire_Skills()
			if("Remove Infection") M.Infection=0
			if("Give Infection") M.Infection=1
			if("Remove Power Mate") usr.Remove_Power_Mate(M)