mob/Admin2/verb
	Toggle_Realm_Teleport()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!usr.Confirm("Toggle Global Realm Teleport? Current is [RealmTeleport ? "On" : "Off"]")) return
		else RealmTeleport=!RealmTeleport
		logAndAlertAdmins("[src.key] set Global Realm Teleport to [RealmTeleport ? "On" : "Off"]",2)