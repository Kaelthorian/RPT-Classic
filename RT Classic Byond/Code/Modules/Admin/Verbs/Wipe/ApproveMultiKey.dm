mob/proc/
	ApproveMultikey(mob/M as mob in Players)
		set hidden=1//set category="Admin"
		M.MultikeyApproved=input("Choose which multikey access to grant [M] 0 = None 1 = same IP 2 = same PC") as num
		M.MultikeyApproved=round(M.MultikeyApproved)
		if(M.MultikeyApproved<0)M.MultikeyApproved=0
		if(M.MultikeyApproved>3)M.MultikeyApproved=3
		logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] [M.MultikeyApproved] multikey access.",2)