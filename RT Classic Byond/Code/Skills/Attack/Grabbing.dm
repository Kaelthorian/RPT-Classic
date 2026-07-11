mob/var/IsGRabbingFlag
mob/verb
	Grab()
		set category="Skills"
		if(IsGRabbingFlag ==100)
			usr<<"You already tried to grab someone or something. Take a break first"
			sleep(30)
			IsGRabbingFlag = 0
			return
		IsGRabbingFlag ++
		if(RPMode)
			return
		InventoryCheck()
		if(global.rebooting)
			usr << "Unable to pick up or drop items while a reboot is in progress."
			return
		for(var/area/Void/V in range(0,usr))
			usr<<"You may not grab here."
			return
		if(GrabbedMob && isGrabbing==1)
			if(ismob(GrabbedMob))
				GrabbedMob.grabberSTR=null
			usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] releases [GrabbedMob]\n")
			SaveItemATOM(GrabbedMob)
			src.GrabbedMob = null
			src.isGrabbing = null
			return
		if(KOd==0)
			var/Amount=0
			var/list/Choices=new
			for(var/obj/A in get_step(src,dir)) if(A.Grabbable)
				Choices+=A
				Amount++
			for(var/mob/A in get_step(src,dir))
				if(ghostDens_check(A)&&A.client) continue
				if(A.attacking!=3)
					if(!A.afk)
						Choices+=A
						Amount++
					else for(var/obj/Contact/C in A.Contacts) if(C.Signature==usr.Signature) if(C.familiarity>10&&C.positiverelation)
						Choices+=A
						Amount++
			var/obj/Resources/B
			for(var/atom/X in Choices)
				for(var/mob/Z in range(1,X))
					if(Z != src) if(Z.GrabbedMob == X)
						Choices -= X
			if(Amount==1) for(var/atom/A in Choices) B=A
			else B=input("Choose") in Choices
			if(!(locate(B) in view(1,usr))) return
			if(get_dist(usr,B) >1) return
			if(B&&isobj(B)&&B.Bolted)
				src<<"It is bolted. You cannot get it."
				return
			if(B)if(B.Burning)
				src << "It's on fire!"
				return
			if(istype(B,/obj/Ships/)) if(src.z == 12)
				src << "Unable to move that while in space."
				return
			if(istype(B,/obj/Resources))																							//If what we want to grab is mana
				for(var/obj/Resources/C in src) if((locate(B) in view(1,usr)))														//For the mana inside of me
					view(src)<<"[src] picks up [B]"																					//We tell the players what's going on
					usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)]  picks up [B]\n")								//We log it in the logs
					C.Value+=B.Value																								//We do the math and add it to the rest of their mana
					del(B)																											//Delete the thing that is infront of me
					break																											//Stop
				return																												//The grabbing


			if(istype(B,/obj/Mana))																									//If what we want to grab is mana
				for(var/obj/Mana/C in src) if((locate(B) in view(1,usr)))															//For the mana inside of me
					view(src)<<"[src] picks up [B]"																					//We tell the players what's going on
					usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)]  picks up [B]\n")								//We log it in the logs
					C.Value+=B.Value																								//We do the math and add it to the rest of their mana
					del(B)																											//Delete the thing that is infront of me
					break																											//Stop
				return																												//The grabbing


			if(istype(B,/obj/items/Magic_Ball)) if((locate(B) in view(1,usr)))														//DragonBalls shit start here
				for(var/obj/items/Magic_Ball/T in get_step(src,dir))																//For the item DB right in front of me
					if(T.DBGrabCD <= Year+(Month*0.01))																				//If the CD is ready
//						usr<<"You feel a strange power running inside your body as you grab the object."							//We grab it
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] grabbed a DB.\n")
						goto A																										//We go to A!
					if(T.LastDBOwner != usr.ckey)																					//If the last owner is not the same as the one who is trying to grab it
						usr<<"A strange force stop you from picking up this item.(Can't grab until year [T.DBGrabCD])"				//We tell the player why he can't grab it and when he can
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] attemped to grab a DB.\n")
						return																										//Stop the grab code
					A																												//Here is A!
					T.LastDBOwner = usr.ckey																						//We change the Last owner to the one who is holding it
					T.DBGrabCD = 0																									//We reset the CD


			if(istype(B,/obj/items/Artifact) && locate(/obj/items/Artifact) in usr)													//If the thing we want to grab is an artifact but there is already an artifact inside of you
				usr<<"[B.name] strange force is stoping you from picking up this item (Can't hold more than 1 artifact)"			//We tell the player the problem
				return																												//And don't let him grab it.
			if(istype(B,/obj/items/Artifact)) if((locate(B) in view(1,usr)))														//If the thing we want to grab is an artifact
				for(var/obj/items/Artifact/T in get_step(src,dir))																	//and the artifact is right in front of me
					if(T.ArtifactGrabCD <= Year+(Month*0.01))																		//If the artifact grab CD is ready
						usr<<"You feel a strange power running inside your body as you grab the object."							//We tell the player that he grabbed the item (Too much spam)
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] grabbed an artifact.\n")
						goto A																										//We go to A to continue with the grab code.
					if(T.LastOwner != usr.ckey)																						//If the last owner is not the same as the one who is trying to grab the item
						usr<<"A strange force stop you from picking up this item.(Can't grab until year [T.ArtifactGrabCD])"		//We tell the player what's going on and when he can grab it
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] attemped to grab a an artifact.\n")
						return																										//Stop the grabbing
					A																												//A is here!
					usr.ArtifactSkillAdd()																							//We run the Skill proc that give skills
//					SaveArtifact()																									//We save the artifact location and user
					T.LastOwner = usr.ckey																							//Set the artifact new owner
					T.ArtifactGrabCD = 0																							//Set the grab CD to 0



			if(istype(B,/obj/items)) if((locate(B) in view(1,usr)))
				var/obj/items/ZZ=B
				if(!istype(ZZ,/obj/items/Android_Chassis)) if(!istype(ZZ,/obj/items/Power_Armor)||ZZ.CapsuleTech) if(!istype(ZZ,/obj/items/Regenerator)||ZZ.CapsuleTech)
					if(istype(B,/obj/items/Gravity))
						var/obj/items/Gravity/C=B
						C.Deactivate()
					if(istype(B,/obj/items/Force_Field)) for(var/obj/items/Force_Field/FF in usr) return 0
					contents+=B
					view(src)<<"[src] picks up [B]"
//					InventoryCheck()
					usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] picks up [B]\n")
					SaveItemATOM(B)
					return
				SaveItemATOM(B)

			if(!attacking) if((locate(B) in view(1,usr)))
				if(isobj(B)&&!B.Grabbable) return
				GrabbedMob=B
				src.isGrabbing=1 //Check if failure occurs
				if(ismob(B))
					if(B in range(1,src)) //Make sure they're at most 1 tile away.
						var/mob/M=B
						if(M.Study)
							src << "[M] is studing. You cannot grab them."
							return
						M.grabberSTR=Str*BP
						if(usr.invisibility)
							usr.invisibility=0
							usr.see_invisible=0
							usr << "As you try to grab [B], you feel your body become tense and you turn visible again!"
							for(var/Skill/Support/Invisibility/A in usr) if(A.Using) spawn(45){A.Using=0;usr<<"You feel your body relax again."}
				usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] grabs [B]\n")
				spawn grab()
			SaveItemATOM(B)
//			usr.Save()																												//wtf , why this is even a thing ? rollback if something happens.
//			usr.InventoryCheck()


mob/proc/grab()
	while(GrabbedMob && src.isGrabbing==1)
		//step_towards(GrabbedMob,loc)	//:v
		GrabbedMob.loc = loc	//double :v
		if(ismob(GrabbedMob))
			GrabbedMob.grabberSTR=Str*BP
			GrabbedMob.Flight_Land()
			if(GrabbedMob.GrabbedMob)
				GrabbedMob.isGrabbing=null
				GrabbedMob.GrabbedMob.grabberSTR=null
				GrabbedMob.GrabbedMob=null
				view()<<"[GrabbedMob] is forced to release [GrabbedMob.GrabbedMob]!"
			if(GrabbedMob.IsFishing)
				GrabbedMob.IsFishing=0
				GrabbedMob<<"You stopped fishing."
			if(GrabbedMob.IsMining)
				GrabbedMob.IsMining=0
				GrabbedMob<<"You stopped mining."
			if(GrabbedMob.IsCooking)
				GrabbedMob.IsCooking=0
				GrabbedMob<<"You were interrupted."
		//	if(HasGrabMaster) GrabbedMob.grabberSTR*=1.5
			GrabbedMob.dir=turn(dir,180)
		if(KOd)
			view()<<"[usr] is forced to release [GrabbedMob]!"
			usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] is forced to release [GrabbedMob]\n")
			if(ismob(GrabbedMob)) GrabbedMob.grabberSTR=null
			attacking=0
			src.isGrabbing=null
		sleep(1)

