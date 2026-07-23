mob/Admin3/verb
	Strip_Admin()
		set category= "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/adminlist = new
		var/choicelevel
		src << "adminlist is [admins.len] long"
		for(var/i in admins)
			if(i=="Mumit") continue
			if(i=="Chewyy") continue
			if(i=="RTProduction") continue
			adminlist+=i
			src << "ADMIN: [i] = [admins[i]]"
		adminlist+="Cancel"
		var/choice = input("Remove which Admin?","Admin Removal") in adminlist
		switch(choice)
			if("Cancel")
				return
			else
				for(var/i in admins)
					if(i=="Mumit") continue
					if(i=="Chewyy") continue
					if(i=="RTProduction") continue
					if(i=="[choice]")
						switch(admins[i])
							if("Owner") choicelevel = 5
							if("SeniorAdministrator") choicelevel = 3
							if("Administrator") choicelevel = 2
							if("Moderator") choicelevel = 1
						break
				if(usr.client.holder.level > choicelevel)
					src << "You removed; [choice]"
					admins-=choice
				else
					src << "Their admin level exceeds or equals yours."