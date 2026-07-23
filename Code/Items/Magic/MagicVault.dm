obj/items/Magic_Vault
	desc       = "A magic vault allows for the safe storage of valuable mana.  Right click the vault and choose either 'deposit' or 'withdraw' to place or remove mana from storage."
	icon       = 'Magic Items.dmi'
	icon_state = "magic vault"
	Stealable = 1
	Savable = 1
	var/SafeResources = 0
	//var/SafePassword  = ""
	Shockwaveable=0
	verb/Set_Password()
		set src in oview(1)
		if(Password == null)
			Password = input("Entering a password will help keep this vault private.") as text
			usr << "Password set!"
			return
		else
			usr << "The password has already been set!"
			return
	verb/Deposit()
		set src in oview(1)
		var/passwd = input("What is this safe's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/putRSC = input("How much mana would you like to place in the vault?") as num
			if(putRSC<1) return
			putRSC=round(putRSC)
			for(var/obj/Mana/A in usr)
				if(A.Value < 1) return
				if(A.Value < putRSC)
					usr << "You do not have that much mana!"
					return
				else
					A.Value       -= putRSC
					SafeResources += putRSC
					return

	verb/Withdraw()
		set src in view(1)
		var/passwd = input("What is this vault's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/getRSC = input("How much mana would you like to withdraw from the vault?") as num
			if(getRSC < 1) return
			getRSC=round(getRSC)

			if(getRSC > SafeResources)
				usr << "You do not have that much mana inside of the vault!"
				return
			else
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					SafeResources -= getRSC
				return

	verb/Check_Storage()
		set src in view(1)
		var/passwd = input ("What is this vault's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			usr << "You have [Commas(SafeResources)] in the vault."
			return
	verb/Upgrade()
		set src in view(1)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			usr<<"Upgraded [src] to security level [Level]."