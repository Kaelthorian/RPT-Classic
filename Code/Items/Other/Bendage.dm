obj/items/Bandages
	Health=100
	Flammable = 1
	icon = 'Torso Bandage.dmi'
	desc = "These are bandages. Equipping them gives you an increase to your regeneration for two minutes. Using them in battle makes them wear away."
	/*New()
		icon = pick('Torso Bandage.dmi','Arm Wraps.dmi')
		..()*/
	verb
		Use_on(mob/M in view(1))
			if(M.IsBandaged)
				usr<<"They already have bandages equipped."
				return
			M.overlays+='Torso Bandage.dmi'
			view(20,usr) << "[usr] puts [src] on [M]."
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src] on [M].\n")
			M.IsBandaged=100
			del(src)

mob/proc/Bandages()
	if(IsBandaged)
		overlays-='Torso Bandage.dmi'
		IsBandaged=0
		view(20,src) << "[src]'s bandages fall away."