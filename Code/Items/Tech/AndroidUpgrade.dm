obj/items/Android_Upgrade
	icon='android tech.dmi'
	name = "Android Upgrade Component"
	icon_state = "component"
	desc="This is an Android Upgrade Component, a special device capable of enhancing an artifical being. Use it on an Android and you can select which mod \
	to upgrade. Each upgrade will increase the mod you choose by 0.2x. Once a mod reaches 3, you can no longer upgrade that mod. There is a limit of 25 installed total."

	Savable = 1
	verb/Use(mob/M in range(1,usr))
		if(src in usr)
			if(M.Race == "Android")
				if(M.Critical_Left_Arm || M.Critical_Right_Arm || M.Critical_Right_Leg || M.Critical_Left_Leg || M.Critical_Torso)
					usr << "Unable to use this until your systems are repaired."
					return
				if(M.Upgrade_Components>=25)
					usr<<"They are fully upgraded already."
					return
				for(var/obj/X in M)
					if(X.Using)
						if(M != usr)
							usr << "[M] must not be using any buffs before they are upgraded!"
						M << "You can't use buffs while being upgraded, please disable them so [usr] can try upgrading you again."
						return
				usr << "<font color = teal>Select a mod to upgrade. Each Android Upgrade Component will increase the selected mod by 0.1 for all but Energy and BP, up to a cap of 2. Energy will increase by 0.5 per component up to a cap of 5, BP and Speed at 2.5.<p>"
				var/T = "[M] Power - [M.BPMod]<br>[M] Energy - [M.KiMod]<br>[M] Might - [M.StrMod]<br>[M] Durability - [M.EndMod]<br>[M] Speed - [M.SpdMod]<br>[M] Offense - [M.OffMod]<br>[M] Defense - [M.DefMod]<br>[M] Regeneration - [M.BaseRegeneration]<br>[M] Recovery - [M.BaseRecovery]<br>"
				M << "[T]"
				if(M != usr)
					usr << "[T]"
				var/list/Choices=new
				Choices.Add("Might","Durability","Speed","Offense","Defense","Cancel")
				switch(input("Choose Option") in Choices)
					if("Cancel")
						return
					if("Speed")
						if(M in range(1,usr))
							if(round(M.SpdMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							M.SpdMod += 0.2
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for speed has been increased! Their speed mod went up by 0.2.     It is now [M.SpdMod].<p>"
							M << "<font color = teal>Your potential for speed has increased! Your speed mod went up by 0.2.     It is now [M.SpdMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s speed mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s speed mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
					if("Might")
						if(M in range(1,usr))
							if(round(M.StrMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							var/N = M.StrMod / M.StrMod
							M.StrMod += 0.2
							M.StrMod = N * M.StrMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for Might has been increased! Their Might mod went up by 0.2.     It is now [M.StrMod].<p>"
							M << "<font color = teal>Your potential for Might has increased! Your Might mod went up by 0.2.     It is now [M.StrMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s Might mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s Might mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
					if("Durability")
						if(M in range(1,usr))
							if(round(M.EndMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							var/N = M.EndMod / M.EndMod
							M.EndMod += 0.2
							M.EndMod = N * M.EndMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for durability has been increased! Their durability mod went up by 0.2.     It is now [M.EndMod].<p>"
							M << "<font color = teal>Your potential for durability has increased! Your durability mod went up by 0.2.     It is now [M.EndMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s durability mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s durability mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
					if("Offense")
						if(M in range(1,usr))
							if(round(M.OffMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							var/N = M.OffMod / M.OffMod
							M.OffMod += 0.2
							M.OffMod = N * M.OffMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for offense has been increased! Their offense mod went up by 0.2.     It is now [M.OffMod].<p>"
							M << "<font color = teal>Your potential for offense has increased! Your offense mod went up by 0.2.     It is now [M.OffMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s offense mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s offense mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
					if("Defense")
						if(M in range(1,usr))
							if(round(M.DefMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							var/N = M.DefMod / M.DefMod
							M.DefMod += 0.2
							M.DefMod = N * M.DefMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for defense has been increased! Their defense mod went up by 0.2.     It is now [M.DefMod].<p>"
							M << "<font color = teal>Your potential for defense has increased! Your defense mod went up by 0.2.     It is now [M.DefMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s defense mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s defense mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
			else
				usr << "This can only be used on an Android."
				return
		else
			return