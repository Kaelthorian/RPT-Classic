obj/items/Elixir_Of_Health
	icon='Health Potion.dmi'
	desc="Drinking this will temporarily increase Regeneration ticks by 3x.  It will decrease over time."
	var/Increase=3
	Flammable = 1

	verb
		Use()
			for(var/BodyPart/Throat/A in usr)
				if(A.Status == "Broken"||A.Status =="Missing"||A.Status =="Maimed")
					usr<<"You can't eat with your throat like that!"
					return
			if(usr.KOd==0) if(usr.Race!="Android")
				if(usr.HealthPotion<6) usr.HealthPotion+=Increase
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				usr.Calm()
				del(src)