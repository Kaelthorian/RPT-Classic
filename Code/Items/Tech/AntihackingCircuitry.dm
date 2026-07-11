obj/items/Antihacking_Circuitry
	icon='Lab.dmi'
	icon_state="Computer 3"
	desc="This will make it +5 levels harder to hack your door."
	verb/Install()
		var/Choices=list()
		for(var/obj/Door/D in view(1,usr)) if(!D.AntiHack) Choices+=D
		Choices+="Cancel"
		var/obj/Door/C=input("Install [src] into which door?") in Choices
		if(C=="Cancel") return
		range(20,C) << "[usr] enchances their [C] to AntiHack level [C.AntiHack]."
		usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchances their door [C].\n")
		C.AntiHack += 5
		del(src)