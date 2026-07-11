obj/items/Safe
	desc       = "A safe allows for the safe storage of valuable resources.  Right click the safe and choose either 'deposit' or 'withdraw' to place or remove materials from storage."
	icon       = 'Safe.dmi'
	icon_state = ""
	Stealable = 1
	Savable = 1
	var/SafeResources = 0
	//var/SafePassword  = ""

	Shockwaveable=0
	verb/Set_Password()
		set src in oview(1)
		if(Password == null)
			Password = input("Entering a password will help keep this safe private.") as text
			usr << "Password set!"
			return
		else
			usr << "The password has already been set!"
			return
	verb/Deposit()
		set src in oview(1)
		if(SafeResources <= 0)
			SafeResources = 0
		var/passwd = input("What is this safe's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/putRSC = input("How many resources would you like to place in the safe?") as num
			if(putRSC<1) return
			putRSC=round(putRSC)
			for(var/obj/Resources/A in usr)
				if(A.Value < 1) return
				if(A.Value < putRSC)
					usr << "You do not have that many resources!"
					return
				else
					A.Value       -= putRSC
					SafeResources += putRSC
					return

	verb/Withdraw()
		set src in view(1)
		var/passwd = input("What is this safe's password?")
		if(SafeResources <= 0)
			SafeResources = 0
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/getRSC = input("How many resources would you like to withdraw from the safe?") as num
			if(getRSC < 1) return
			getRSC=round(getRSC)

			if(getRSC > SafeResources)
				usr << "You do not have that many resources inside of the safe!"
				return
			else
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					SafeResources -= getRSC
				return

	verb/Check_Storage()
		set src in view(1)
		if(SafeResources <= 0)
			SafeResources = 0
		var/passwd = input ("What is this safe's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			usr << "You have [Commas(SafeResources)] in the safe."
			return
	verb/Upgrade()
		set src in view(1)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			usr<<"Upgraded [src] to security level [Level]."