obj/items/Elixir_Of_Respec
	icon='enchantmenticons.dmi'
	icon_state="BPEND"
	Level=1
	desc="This will allow you to reduce a stat by 50%. (Reduces a stat to a minimum of 25% of the stat cap.)"
	verb/Use()
		if(usr.Confirm("Use [src]?"))
			view(usr)<<"[usr] drinks a mysterious potion!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses an Elixer of Respec!\n")
			var/RC=input(usr,"Choose a stat to reduce","Potion of Respec") in list("Might","Endurance","Speed","Offense","Defense")
			switch(RC)
				if("Might")
					if(usr.StrMod/usr.StrMod>=SoftStatCap*0.25)
						usr.StrMod/=2
						if(usr.StrMod/usr.StrMod>=SoftStatCap*0.25) usr.StrMod=SoftStatCap*0.25*usr.StrMod
					else
						usr<<"This will have no effect."
						return
				if("Endurance")
					if(usr.EndMod/usr.EndMod>=SoftStatCap*0.25)
						usr.EndMod/=2
						if(usr.EndMod/usr.EndMod>=SoftStatCap*0.25) usr.EndMod=SoftStatCap*0.25*usr.EndMod
					else
						usr<<"This will have no effect."
						return
				if("Speed")
					if(usr.SpdMod/usr.SpdMod>=SoftStatCap*0.25)
						usr.SpdMod/=2
						if(usr.SpdMod/usr.SpdMod>=SoftStatCap*0.25) usr.SpdMod=SoftStatCap*0.25*usr.SpdMod
					else
						usr<<"This will have no effect."
						return
				if("Offense")
					if(usr.OffMod/usr.OffMod>=SoftStatCap*0.25)
						usr.OffMod/=2
						if(usr.OffMod/usr.OffMod>=SoftStatCap*0.25) usr.OffMod=SoftStatCap*0.25*usr.OffMod
					else
						usr<<"This will have no effect."
						return
				if("Defense")
					if(usr.DefMod/usr.DefMod>=SoftStatCap*0.25)
						usr.DefMod/=2
						if(usr.DefMod/usr.DefMod>=SoftStatCap*0.25) usr.DefMod=SoftStatCap*0.25*usr.DefMod
					else
						usr<<"This will have no effect."
						return
			del(src)