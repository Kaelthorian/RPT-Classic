obj/items/Elixir_Of_Empowerment
	icon='enchantmenticons.dmi'
	icon_state="BPSTR++"
	desc="Drinking this will automatically cap all of your stats."

	Flammable = 1

	verb
		Use()
			if(Year<usr.HasUsedEmpowerment+3)
				usr<<"You cannot use this until year [usr.HasUsedEmpowerment+3]."
				return
			if(usr.KOd==0)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				usr.Calm()
				usr.HasUsedEmpowerment=Year
				usr.CapStats()
				del(src)