//Study in minutes per level
#define STUDY	33

mob/var/tmp/SelectionScreen
mob/var/tmp/Study
mob/verb/Study()
	set category="Other"
	if(usr.Flying||usr.KOd||usr.icon_state=="KB"||usr.attacking||usr.afk||usr.isGrabbing||usr.IsBlocking||usr.DashAttacking||usr.Training||usr.Meditate) return
	if(usr.SelectionScreen == 1)
		usr<<"You can't do this while deciding what to study."
		return

	if(usr.Study)
		usr.Study=0
		usr<<"You stop studing."
		icon_state=""
		return

	usr.SelectionScreen = 1
	var/Selection=input("What would you like to study?") in list("Magic","Science")
	usr.SelectionScreen = 0

	if(usr.Study)
		usr.Study=0
		usr<<"You stop studing."
		icon_state=""
		return
	else
		usr.Study=1
		usr<<"You begin to study."
		dir=SOUTH
		icon_state="Meditate"

	if(Selection=="Magic")
		while(Study && icon_state=="Meditate" )
			//Magic Levels
			var/NI= usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
			var/NBC=1
			for(var/obj/items/Bookcase/C in range(2,usr))
				NBC = 50
			usr.Magic_XP+=(10+NBC)*Admin_Int_Setting*NI*usr.MagicCatchUp()
			if(usr.MagicLevelUpCheck(usr.Magic_XP))
				usr.MagicLevelUp()
			if(usr.HasPursuitOfKnowledge)
				var/NI2= usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
				var/NBC2=1
				for(var/obj/items/Bookcase/C in range(2,usr))
					NBC2 = 50
				usr.Int_XP+=(10+NBC2)*Admin_Int_Setting*NI2*usr.IntCatchUp()
				if(usr.IntLevelUpCheck(usr.Int_XP))
					usr.IntLevelUp()

			//Digging for mana
			var/DigPower = rand(5,10)
			var/obj/items/Spell_Book/Book
			if(locate(/obj/items/Spell_Book) in usr)Book=locate(/obj/items/Spell_Book) in usr// for(var/obj/items/Spell_Book/B in usr) Book = B
			if(locate(/obj/items/Magic_Circle) in usr) DigPower += 5
			if(Book) DigPower*=Book.ManaMult+Book.ExtraManaMult
			if(usr.HasManaExpert) DigPower*=1.5
			if(usr.Race=="Space Pirate") DigPower*=1.5
			DigPower = round(DigPower)

			if(usr.HasPursuitOfKnowledge)
				//Digging for res
				var/DigPower2 = rand(5,20)
				var/obj/items/Digging/DT
				for(var/obj/items/Digging/digging_tool in usr) if(digging_tool.suffix) DT=digging_tool//DigPower *= digging_tool.DigMult+digging_tool.ExtraDigMult
				if(DT) DigPower2*=DT.DigMult
				if(usr.HasMiningExpert) DigPower2*=1.5
				if(usr.Race=="Space Pirate") DigPower2*=1.5
				DigPower2 = round(DigPower2)

			//Taxes
			var/Taxes=0
			switch(usr.z)
				if(1)Taxes=(Z1Tax/100)*DigPower
				if(2)Taxes=(Z2Tax/100)*DigPower
				if(3)Taxes=(Z3Tax/100)*DigPower
				if(4)Taxes=(Z4Tax/100)*DigPower
				if(5)Taxes=(Z5Tax/100)*DigPower
				if(6)Taxes=(Z6Tax/100)*DigPower
				if(7)Taxes=(Z7Tax/100)*DigPower
			var/TPerc=round(Taxes/DigPower)*100
			Taxes=round(Taxes)
			for(var/obj/Mana/ManaBag in usr)
				if(Taxes)
					if(usr.IgnoreTaxes&&usr.Race!="Heran")
						switch(usr.z)
							if(1)
								Z1MTaxEvaders["[usr.name]"]+=Taxes
							if(2)
								Z2MTaxEvaders["[usr.name]"]+=Taxes
							if(3)
								Z3MTaxEvaders["[usr.name]"]+=Taxes
							if(4)
								Z4MTaxEvaders["[usr.name]"]+=Taxes
							if(5)
								Z5MTaxEvaders["[usr.name]"]+=Taxes
							if(6)
								Z6MTaxEvaders["[usr.name]"]+=Taxes
							if(7)
								Z7MTaxEvaders["[usr.name]"]+=Taxes
						Taxes=0
					else if(usr.Race=="Oni")
						usr.MTaxPaid=Taxes
					if(usr.IgnoreTaxes&&usr.Race=="Heran")
						Taxes=0
				ManaBag.Value+=DigPower-Taxes
				switch(usr.z)
					if(1)Z1ReserveMana+=Taxes
					if(2)Z2ReserveMana+=Taxes
					if(3)Z3ReserveMana+=Taxes
					if(4)Z4ReserveMana+=Taxes
					if(5)Z5ReserveMana+=Taxes
					if(6)Z6ReserveMana+=Taxes
					if(7)Z7ReserveMana+=Taxes
			if(usr.ToggleViewResMana)
				usr.CombatOut("Gained [DigPower-Taxes] Mana ([Taxes] Taxed, [TPerc] %)")
			if(!usr.Study)
				usr<<"You stop studing."
				return
			sleep(10)

	if(Selection=="Science")
		while(Study && icon_state=="Meditate")
			//Int Levels
			var/NI= usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
			var/NBC=1
			for(var/obj/items/Bookcase/C in range(2,usr))
				NBC = 50
			usr.Int_XP+=(10+NBC)*Admin_Int_Setting*NI*usr.IntCatchUp()
			if(usr.IntLevelUpCheck(usr.Int_XP))
				usr.IntLevelUp()
			if(usr.HasPursuitOfKnowledge)
				var/NI2= usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
				var/NBC2=1
				for(var/obj/items/Bookcase/C in range(2,usr))
					NBC2 = 50
				usr.Magic_XP+=(10+NBC2)*Admin_Int_Setting*NI2*usr.MagicCatchUp()
				if(usr.MagicLevelUpCheck(usr.Magic_XP))
					usr.MagicLevelUp()

			//Digging for res
			var/DigPower = rand(5,20)
			var/obj/items/Digging/DT
			for(var/obj/items/Digging/digging_tool in usr) if(digging_tool.suffix) DT=digging_tool//DigPower *= digging_tool.DigMult+digging_tool.ExtraDigMult
			if(DT) DigPower*=DT.DigMult
			if(usr.HasMiningExpert) DigPower*=1.5
			if(usr.Race=="Space Pirate") DigPower*=1.5
			DigPower = round(DigPower)

			if(usr.HasPursuitOfKnowledge)
				//Digging for mana
				var/DigPower2 = rand(5,10)
				var/obj/items/Spell_Book/Book
				if(locate(/obj/items/Spell_Book) in usr)Book=locate(/obj/items/Spell_Book) in usr// for(var/obj/items/Spell_Book/B in usr) Book = B
				if(locate(/obj/items/Magic_Circle) in usr) DigPower2 += 5
				if(Book) DigPower2*=Book.ManaMult+Book.ExtraManaMult
				if(usr.HasManaExpert) DigPower2*=1.5
				if(usr.Race=="Space Pirate") DigPower2*=1.5
				DigPower2 = round(DigPower2)

			//Taxes
			var/Taxes=0
			switch(usr.z)
				if(1)Taxes=(Z1Tax/100)*DigPower
				if(2)Taxes=(Z2Tax/100)*DigPower
				if(3)Taxes=(Z3Tax/100)*DigPower
				if(4)Taxes=(Z4Tax/100)*DigPower
				if(5)Taxes=(Z5Tax/100)*DigPower
				if(6)Taxes=(Z6Tax/100)*DigPower
				if(7)Taxes=(Z7Tax/100)*DigPower
			Taxes=round(Taxes)
			var/TPerc=round(Taxes/DigPower)*100
			for(var/obj/Resources/resource_bag in usr)
				if(Taxes)
					if(usr.IgnoreTaxes&&usr.Race!="Heran")
						switch(usr.z)
							if(1)
								Z1TaxEvaders["[usr.name]"]+=Taxes
							if(2)
								Z2TaxEvaders["[usr.name]"]+=Taxes
							if(3)
								Z3TaxEvaders["[usr.name]"]+=Taxes
							if(4)
								Z4TaxEvaders["[usr.name]"]+=Taxes
							if(5)
								Z5TaxEvaders["[usr.name]"]+=Taxes
							if(6)
								Z6TaxEvaders["[usr.name]"]+=Taxes
							if(7)
								Z7TaxEvaders["[usr.name]"]+=Taxes
						Taxes=0
					else if(usr.Race=="Oni")
						usr.TaxPaid+=Taxes
					if(usr.IgnoreTaxes&&usr.Race=="Heran")
						Taxes=0
				resource_bag.Value+=DigPower-Taxes
				switch(usr.z)
					if(1)Z1ReserveResources+=Taxes
					if(2)Z2ReserveResources+=Taxes
					if(3)Z3ReserveResources+=Taxes
					if(4)Z4ReserveResources+=Taxes
					if(5)Z5ReserveResources+=Taxes
					if(6)Z6ReserveResources+=Taxes
					if(7)Z7ReserveResources+=Taxes
			if(usr.ToggleViewResMana)
				usr.CombatOut("Gained [DigPower-Taxes] Resources ([Taxes] Taxed, [TPerc] %)")
			if(!usr.Study)
				usr<<"You stop studing."
				return
			sleep(10)





mob/proc/IntLevelUpCheck(IntXP) if(IntXP>40*(Int_Next/Int_Mod)) return 1
mob/proc/MagicLevelUpCheck(MagXP) if(MagXP>40*(Magic_Next/Magic_Potential)) return 1
mob/proc/IntLevelUp() //while(Int_Level_Up_Check(Int_XP)) // I've uncommented the while as it makes no sense to keep leveling while it returns 1. \
							They should just meditate for this and Meditate actively checks IF they've leveled up assuming they're focused on intelligence.
	var/ADD = src.Int_Mod
	if(src.Critical_Head) ADD = src.Int_Mod*2
	Int_XP-=40*(Int_Next/ADD)
	Int_Next=round(Int_Next*1.03)
	Int_Level++
mob/proc/MagicLevelUp() //while(Int_Level_Up_Check(Int_XP)) // I've uncommented the while as it makes no sense to keep leveling while it returns 1. \
							They should just meditate for this and Meditate actively checks IF they've leveled up assuming they're focused on intelligence.
	var/POTENT = src.Magic_Potential
	if(src.Critical_Head) POTENT = src.Magic_Potential*2
	Magic_XP-=40*(Magic_Next/POTENT)
	Magic_Next=round(Magic_Next*1.03)
	Magic_Level++