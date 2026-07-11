mob/Admin1/verb

	Remove_Fires()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/obj/A in world)
			if(A.Burning ==1)
				A.Burning=0
				A.overlays -= 'fire obj.dmi'
				A.overlays -= 'large fire.dmi'
				A.overlays -= 'fire turf.dmi'
				if(usr.Confirm("Want to delete them as well?"))
					spawn(10)
						del(A)
		src<<"Fire no more"
		logAndAlertAdmins("[src] removed all the fires in the universe.")