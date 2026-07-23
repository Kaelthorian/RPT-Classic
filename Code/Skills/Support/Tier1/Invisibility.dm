Skill/Support/Invisibility

	desc="You can use this to make yourself invisible. Some people with very good senses will still know you are there, or if they have visors capable of seeing invisible objects."
	verb/Invisibility()
		set category="Skills"
		if(usr.RPMode) return
		if(Using&&!usr.invisibility) // Using will be 1 but their invisiblity disabled if they've attacked while invisible.
			usr<<"Your body feels too tense and you are unable to turn invisible!"
			Using=0
			return
		else if(!usr.invisibility&&!Using)
			usr.invisibility=99
			usr.see_invisible=99
			Using=1
			usr<<"You are now invisible."
			//if(usr.SOverlayToggle == 1)
			winset(usr.client,"INVIS","is-visible=true")
		else if(usr.invisibility&&Using)
			usr.see_invisible=0
			usr.invisibility=0
			winset(usr.client,"INVIS","is-visible=false")
			usr<<"You are visible again."
			spawn(45){Using=0;src<<"You can now turn invisible again."}
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [usr.invisibility ? "is now invisible" : "is no longer invisible"].\n")

//mob/var/tmp/Observee=null