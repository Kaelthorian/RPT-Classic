mob/BlueMageTestServer
	name		="Blue Mage"
	icon		='BlueMage.dmi'
	icon_state 	="Meditate"
	desc		="The all mighty and powerful Blue Mage#3444 , legends say that if you ask nicely you can get all the powers in the game."
	Savable 	=1
	AdminMode	=1

	verb
		AskForPower()
			set src in oview(1)
			usr.MilestonePoints	=1000
			usr.EXP				=100000
			usr.EXPLifetime		=100000
			usr.Int_Level		=200
			usr.Magic_Level		=200
			usr.SwordSkill		=3000
			usr.KiManipulation	=3000
			usr.UnarmedSkill	=3000
			usr.Athleticism		=3000
			usr.GravMastered	=300
			for(var/obj/Mana/MM in usr)
				MM.Value 		=10000000000000000
			for(var/obj/Resources/MM in usr)
				MM.Value 		=10000000000000000
			usr.Willpower		=100
			usr.Health			=100
			for(var/BodyPart/MM in usr)
				MM.Health		=100
				MM.Status		="Healthy"
			usr.Base			=10000000*WipeDay
			usr<<"Your power is now MAXIMUM!!!"
