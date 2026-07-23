obj/items/Door_Pass
	name="Key"
	icon='Door Pass.dmi'

	desc="Click this to set it's password. Door's will check if it is correct and only let you in if it is."
	Password = null
	Click()
		if(Password)
			usr<<"It has already been programmed and cannot be reprogrammed."
			return
		Password=input("Enter a password for the doors to check if it is correct") as text
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

obj/items/Advanced_Door_Pass
	name="Key"
	icon='Door Pass.dmi'

	desc="Click this to set it's password. Door's will check if it is correct and only let you in if it is. This will store up to 3 different passwords."
	Password = null
	var/Password2 = null
	var/Password3 = null
	Click()
		if(Password&&Password2&&Password3)
			usr<<"It has already been programmed and cannot be reprogrammed."
			return
		if(!Password)
			Password=input("Enter a password for the doors to check if it is correct") as text
			return
		if(!Password2)
			Password2=input("Enter a password for the doors to check if it is correct (Password 2)") as text
			return
		if(!Password3)
			Password3=input("Enter a password for the doors to check if it is correct (Password 3)") as text
			return
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src