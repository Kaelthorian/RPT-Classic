obj/items/Stun_Chip
	icon='Control Chip.dmi'

	desc="You can install this on someone and use the Stun Remote to stun them temporarily. To use the \
	remote to stun them your remote must share the same remote access code as the installed chip. \
	You can also use this to remove chips from somebody using the Remove command, both chips will be \
	destroyed in the process."
	New()
		name=initial(name)

	verb/Use(mob/A in view(1,usr))
		if(A==usr||A.KOd)
			if(A!=usr) if(A.Willpower>=1)
				usr<<"They must be at 0 Willpower."
				return
			view(usr)<<"[usr] installs a stun chip in [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] installs a stun chip in [A].\n")
			var/obj/Stun_Chip/B=new
			B.Password=input("Input a remote access code to activate the chip") as text
			A.contents+=B
			del(src)
	verb/Remove(mob/A in view(1,usr))
		for(var/obj/Stun_Chip/B in A)if(B.CanRemove)
			view(usr)<<"[usr] removes a Stun Chip from [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes a Stun Chip from [A].\n")
			del(B)
			del(src)
			break

obj/Stun_Chip
	var/CanRemove=1
	desc="You can install this on someone and use the Stun Remote to stun them temporarily. To use the \
	remote to stun them your remote must share the same remote access code as the installed chip. \
	You can also use this to remove chips from somebody using the Remove command, both chips will be \
	destroyed in the process."
	icon='Control Chip.dmi'