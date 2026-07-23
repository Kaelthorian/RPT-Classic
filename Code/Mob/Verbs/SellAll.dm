mob/verb/Sell_All()
	set category = "Other"
	var/tmp/SpamStop
	if(SpamStop==1)
		usr<<"Please wait to sell more"
		return
	SpamStop=1
	for(var/obj/items/rawfood/L in usr)																									//Sellable update here
		switch(input(usr ,"What you want to sell it for?") in list("Mana","Resources","Cancel"))
			if("Resources")
				for(var/obj/Resources/M in usr)
					var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
					M.Value += Selling
					usr<<"You sell it for $[Selling] Resources."
					del(L)
					SpamStop=0
					return
			if("Mana")
				for(var/obj/Mana/M in usr)
					var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
					M.Value += Selling
					usr<<"You sell it for $[Selling] Mana."
					del(L)
					SpamStop=0
					return
	for(var/obj/items/rawore/L in usr)																									//Sellable update here
		switch(input(usr ,"What you want to sell it for?") in list("Mana","Resources","Cancel"))
			if("Resources")
				for(var/obj/Resources/M in usr)
					var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
					M.Value += Selling
					usr<<"You sell it for $[Selling] Resources."
					del(L)
					SpamStop=0
					return
			if("Mana")
				for(var/obj/Mana/M in usr)
					var/tmp/Selling=rand(1000,50000)*max(1,Year)/20
					M.Value += Selling
					usr<<"You sell it for $[Selling] Mana."
					del(L)
					SpamStop=0
					return
	return