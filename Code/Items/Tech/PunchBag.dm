obj
	TrainingEq
		Punching_Bag
			icon='Punching Bag.dmi'
			BP=100
			Health=100
			End=250000
			New()
				Health=100
				icon_state=""

			verb/Upgrade()
				set src in oview(1)
				for(var/obj/Resources/A in usr)
					var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value*(1-(0.15*usr.HasDeepPockets)))])") as num
					if(Amount>round(A.Value*(1-(0.15*usr.HasDeepPockets)))) Amount=round(A.Value*(1-(0.15*usr.HasDeepPockets)))
					if(Amount<0) Amount=0
					A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
					Amount*=usr.Int_Mod
					//Un_KO()
					Health+=Amount
					view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
				desc="Health: [Health]"
				icon_state=""
				if(usr.Int_Mod>=2)
					name="Tier 2 [initial(src.name)]"
					icon='Punching Bag2.dmi'
				if(usr.Int_Mod>=3)
					name="Tier 3 [initial(src.name)]"
					icon='Punching Bag3.dmi'
				if(usr.Int_Mod>=4)
					name="Tier 4 [initial(src.name)]"
					icon='Punching Bag4.dmi'
				if(usr.Int_Mod>=5)
					name="Tier 5 [initial(src.name)]"
					icon='Punching Bag5.dmi'
				if(usr.Int_Mod>=6)
					name="Tier 6 [initial(src.name)]"
					icon='Punching Bag6.dmi'