Skill/Spell
	Create_Portal
		desc="Allows you to create a portal to another realm..."
		var/PortalID=0
		verb/Create_Portal()
			set category = "Other"
			if(usr.RPMode) return
			if(usr.Magic_Level >= 55)
				var/Cost = 100000000
				if(PortalID!=0)Cost/=10
				for(var/obj/Magical_Portal/P in range(4,usr))
					usr << "This is too close to another portal."
					return
				var/list/Options= list("Personal Realm")
				if(usr.Magic_Level>=80) Options.Add("Location")
				Options.Add("Cancel")
				switch(input("Do you want to create/revisit your personal realm or travel to a location? (Personal Realm is 10% of the normal cost after the first cast)") in Options)
					if("Personal Realm")
						if(usr.z==17||usr.z==13||usr.z==11)
							usr<<"You may not create a realm here."
							return
						var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
						usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
						switch(input("Are you very sure?") in list("No","Yes"))
							if("Yes")
								for(var/obj/Mana/M in usr)
									if(M.Value > Actual)
										if(PortalID==0)
											if(Portals)
												var/PID = pick(Portals)
												PortalID = PID
												Portals -= PID
										M.Value -= Actual
										var/obj/Magical_Portal/P = new
										P.loc = usr.loc
										P.Savable=1
										P.Portal_Number = PortalID
										P.Builder="[usr.real_name]"
										view(usr)<<"<font color=teal>[usr] uses their magic to create a portal!"
										usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a new magical realm.\n")
										var/turf/T = usr.loc
										T.Wave(5,100)
										CD=usr.Refire*10
										CDTick(usr)
										hearers(10,usr)<<sound('magic.ogg',volume=20)
										return
									else
										usr << "You do not have [Commas(Actual)] mana to spare in order to use create a new magical realm."
										return
							if("No")
								return
					if("Location")
//						Cost = 100000000
						var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
						usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
						alert(usr,"Choose the X,Y,Z of the location you want to travel to. Keep in mind that different dimensions from the one you create the portal on cost more to travel to. These portals only last 15 minutes real time before they shut.")
						var/x = input(usr,"x coordinate") as num
						var/y = input(usr,"y coordinate") as num
						var/z = input(usr,"z coordinate") as num
						if(!usr.Confirm("Create portal to [x] [y] [z]?")) return

						var/restricted = list(9,13,16,17)
						var/al = list(8,10,11)
						var/lr = list(1,2,3,4,5,6,7,12,14,15)
						var/travel_al = 0
						if(z in al) travel_al = 1
						if(z in restricted)
							usr << "Unable to teleport to that z coordinate, please choose another!"
							return
						if(usr.z in al) if(travel_al == 0) //if(!RealmTeleport)
							usr << "You're unable to pierce the veil between realms!"
							return
						if(usr.z in lr) if(travel_al) //if(!RealmTeleport)
							usr << "You're unable to pierce the veil between realms!"
							return
						if(usr.z in restricted)
							usr << "Unable to teleport from this z coordinate!"
							return
						for(var/obj/Mana/M in usr)
							if(M.Value > Actual)
								M.Value -= Actual
								var/obj/Magical_Portal/P = new
								P.tag = "Special"
								P.loc = usr.loc
								P.Portal_Number = rand(100000,1000000)
								var/turf/T = usr.loc
								if(T) T.Wave(5,100)
								var/obj/Magical_Portal/P2 = new
								P2.tag = "Special"
								P2.loc = locate(x,y,z)
								P2.Portal_Number = P.Portal_Number
								var/turf/T2 = P2.loc
								if(T2) T2.Wave(5,100)
								//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a portal to [x],[y],[z]...")
								usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a portal to [x],[y],[z]...\n")
								alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name_admin(usr)] created a portal to [x],[y],[z].", 1)
								CD=usr.Refire*10
								CDTick(usr)
								hearers(10,usr)<<sound('magic.ogg',volume=20)
								return
					if("Cancel") return