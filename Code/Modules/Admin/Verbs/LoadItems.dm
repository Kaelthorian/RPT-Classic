mob/Admin1/verb

	Remove_Drill_Pylon_from_the_void()
		set category="Debug"
		for(var/obj/Drill/A)
			if(A.x==0)
				if(A.y==0)
					if(A.z==0)
						A.x=1
						A.y=1
						A.z=1

		for(var/obj/Mana_Pylon/A)
			if(A.x==0)
				if(A.y==0)
					if(A.z==0)
						A.x=1
						A.y=1
						A.z=1

	What_is_in_the_void()
		set category="Debug"
		var/DrillInTheVoid
		var/PylonInTheVoid
		for(var/obj/Drill/A)
			if(A.x==0)
				if(A.y==0)
					if(A.z==0)
						DrillInTheVoid++

		for(var/obj/Mana_Pylon/A)
			if(A.x==0)
				if(A.y==0)
					if(A.z==0)
						PylonInTheVoid++

//		world<<"Drills in the void [PylonInTheVoid]"
//		world<<"Drills in the void [DrillInTheVoid]"

