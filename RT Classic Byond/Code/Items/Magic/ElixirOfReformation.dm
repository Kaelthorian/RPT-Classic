obj/items/Elixir_Of_Reformation
	icon='enchantmenticons.dmi'
	icon_state="PoMM+"
	desc="Drinking this will allow you to redo stats and refunds all refundable MPs.  Be careful though, you can only gain the effects once and it potentially will remove any mutations that you might have. (Resets mutations too)"
	Flammable = 1

	verb
		Use()
			if(usr.Offspring)
				usr<<"Offspring may not use this."
				return
			if(usr.EnablementSlot)
				usr<<"You can not bring yourself to swallow this. (Already have an unique buff.)"
				return
			if(usr.HasUsedReform+3<=Year)
				if(usr.Confirm("Redo stats? (This will remove mutations)"))
					usr.HasUsedReform++
					usr.UBList=list()
					spawn(1)del(src)
					if(!usr.Offspring)
						logAndAlertAdmins("[key_name(usr)] started to redo stats",1)
						usr.Redo_Stats()
						usr.verbs += /mob/proc/donec
						usr.verbs += /mob/proc/bodyc
						usr.verbs += /mob/proc/Skill_Points
						winshow(usr.client,"CharacterCreator",1)
						usr.mind.store_memory("<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key])<hr> [key_name(usr)] started to redo stats<br><hr>")
						usr.CheckRedoneStats()
					if(usr.Race=="Makyo"&&usr.FBMAchieved)usr.Magic_Potential-=0.5
					if(usr.Race=="Tuffle"&&usr.FBMAchieved)usr.Int_Mod -=0.5
					usr.HasUsedReform=Year
					usr.MPPurgeRefund()
					usr.UBCheck()
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
					view(usr)<<"[usr] drinks a mysterious potion!"
			else usr<<"You may not use this until year [usr.HasUsedReform+3]."