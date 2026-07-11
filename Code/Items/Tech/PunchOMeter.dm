obj
	TrainingEq
		Punchometer
			BP=100
			Health=10000
			End=500
			icon='Punchometer.dmi'
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
					End=SoftStatCap
					BP=TrueBPCap*1.5
				desc="Health: [Health]"