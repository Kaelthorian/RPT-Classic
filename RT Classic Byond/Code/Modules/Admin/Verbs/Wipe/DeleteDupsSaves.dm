mob/Admin1/verb

	DeleteDupsSaves()
		set category="Debug"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

		var/Suma	=0
		var/Limpio	=0
		var/list/Cleaning = new

		for(var/A in ItemSerialList)
			if(A in Cleaning)
				Suma++
				ItemSerialList.Remove("[A]")
			else
				Limpio++
				Cleaning.Add("[A]")

		usr<<"Dups: [Suma]"
		usr<<"Total: [Limpio]"