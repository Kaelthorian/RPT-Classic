obj
	TrainingEq
		Magic_Goo
			icon='Magic Punching Bag.dmi'
			BP=100
			Health=100
			End=250000
			New()
				Health=100
				icon_state=""

			verb/Enhance()
				set src in oview(1)
				for(var/obj/Mana/A in usr)
					var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
					if(Amount>round(A.Value)) Amount=round(A.Value)
					if(Amount<0) Amount=0
					A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
					Amount*=usr.Magic_Potential
					//Un_KO()
					Health+=Amount
					view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
				desc="Health: [Health]"
				icon_state=""
				if(usr.Magic_Potential>=3)
					name="Tier 2 [initial(src.name)]"
					icon='MPB2.dmi'
				if(usr.Magic_Potential>=4)
					name="Tier 3 [initial(src.name)]"
					icon='MPB3.dmi'
				if(usr.Magic_Potential>=6)
					name="Tier 4 [initial(src.name)]"
					icon='MPB4.dmi'