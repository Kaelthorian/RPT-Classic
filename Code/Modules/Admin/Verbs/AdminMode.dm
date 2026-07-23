/client/proc/stealth()
	set category = "Admin"
	set name = "Admin Mode"
	if(ghostDens_check())
		src << "You're currently in Ghost Form. Disable it first."
		return
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	//src.stealth = !src.stealth
	if(src.stealth)
		src.stealth = 0
		src.mob.AdminMode=0
		src.mob.name=src.mob.OldName
		src.mob.icon=src.mob.oicon
		src.mob.overlays=null
		src.mob.overlays+=src.mob.Overlays
		src.mob.Overlays=list()
	else
		src.stealth = 1
		src.mob.AdminMode=1
		src.mob.OldName=src.mob.name
		src.mob.name="[src.holder.rank]"
		src.mob.oicon=src.mob.icon
		src.mob.Overlays=list()
		src.mob.Overlays+=src.mob.overlays
		src.mob.overlays=null
		src.mob.icon='xeno test.dmi'
		//src.mob.overlays+='admintag.dmi'
//		var/image/AA=image('admintag.dmi', layer =MOB_LAYER+EFFECTS_LAYER+1,pixel_x=-16,pixel_y=-16)
//		src.mob.overlays+=AA

		src.fakekey = null
		usr<<"You must disable this before relogging."
	log_admin({"[key_name(usr)] has turned admin mode [src.stealth ? "ON" : "OFF"]"})
	alertAdmins("[key_name_admin(usr)] has turned admin mode [src.stealth ? "ON" : "OFF"]", 1)

mob/var/OldName=""
mob/var/AdminMode=0