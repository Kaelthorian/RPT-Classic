mob/Admin1/verb

	Ghost_Form()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.adminDensity)
			usr.adminDensity=0
			usr.density=1
			usr.immortal=0
			usr.invisibility = 0
			usr.icon=usr.last_icon
			usr.client.mob.see_invisible=usr.client.mob.Old_Sight
		//	view(usr) << "([usr.key])[usr] disables their admin ghost form."
			log_admin("[key_name(usr)] exits ghost form.")
		else
			usr.adminDensity=1
			usr.density=0
			usr.immortal=1
			usr.invisibility = 1000
			usr.client.mob.Old_Sight=usr.client.mob.see_invisible
			usr.client.mob.see_invisible=5000
			usr.last_icon=usr.icon
			var/icon/I=new(usr.icon)
			I.Blend(rgb(0,0,0,100),ICON_ADD)
			usr.icon=I
		//	view(usr) << "([usr.key])[usr] activates their admin ghost form."
			log_admin("[key_name(usr)] enters ghost form.")