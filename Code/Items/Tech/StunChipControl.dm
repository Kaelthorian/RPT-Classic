obj/items/Stun_Controls
	icon='Stun Controls.dmi'
	desc="You can use this to activate a stun chip you have installed on somebody. It only works \
	within your visual range."

	verb/Set() Password=input("Input a remote access code for activating nearby stun chips") as text
	verb/Use()
		view(usr)<<"[usr] activates their stun controls"
		for(var/mob/A in view(usr))
			A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their stun controls.\n")
			for(var/obj/Stun_Chip/B in A) if(B.Password==Password) A.KO("by stun chip!")