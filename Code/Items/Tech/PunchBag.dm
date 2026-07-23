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

			verb/Turn_Around()
				set src in oview(1)
				switch(input("Where you want it to look at?") in list("North","South","West","East"))
					if("North")
						dir=1
					if("South")
						dir=2
					if("West")
						dir=8
					if("East")
						dir=4


