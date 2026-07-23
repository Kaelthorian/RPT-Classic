mob/animate_movement=2
mob/player //The player mob
var/first_player = FALSE

mob/Login()
	if(client.byond_version<world.byond_version)
		src<<"You are not on the same version as the server. You must change to BYOND version [client.byond_version] to connect. http://www.byond.com/download/"
		del(src)
	else src<<"You are on the same version as the server."
	if(client.byond_build!=world.byond_build) src<<"You are not on the same build as the server. You should be running the one located here http://www.byond.com/download/build/515/515.1621_byond.zip"
	else src<<"You are on the same build as the server."
	if(src.type==/mob)
		logAndAlertAdmins("[key_name(src)] logged in with the wrong mob type! They have been kicked off. This error has been logged.")
		log_errors("[key_name(src)] LOGGED IN WITH WRONG MOBTYPE IN mob/Login() !")
		alert("Something went wrong and you have the wrong mob type. Please relog or remake.")
		del(src)
		return

	if(src)
		if(src.client)
			if(!src.client.holder)
				if(!global.ItemsLoaded||!global.MapsLoaded)
					src << "This server has not yet finished loading its files. Please wait patiently for a few minutes."
					src << "You have been disconnected."
					del(src)
					return

	while(src && client && !src.HasCreated)	//We sit here until they select a file in load_character
		sleep(10)


	if(src.HasCreated)
		if(!src)
			return
		if(!real_name&&HasCreated)
			alert("A new 'realname' system has been implemented, please retype your PERMANENT name!")
			Name()

		//Allows storing of memories on a per mob basis

		if(!src.mind)
			src.mind = new /datum/mind
			src.mind.key = src.key
			src.mind.current = src
		src << sound(null)
		src.mind.current = src	//You might say this is backwards :3
		if(src) if(src.client)
			src.computer_id = src.client.computer_id
			src.lastKnownKey = src.key
		if(!Players.Find(src))
			if(src==null) return  //If this breaks the stuff below, alter the position of where it occurs in the code.  Added during the Deviant/Xirre/Arch code jam thing.
			if(!src.client) return
			//No duplicates
			Players += src
		var/tmp/list/AG=list()
		var/altsIDd=0
		for(var/mob/player/M in Players) if(M&&M.client&&M!=src)
			if(!locate(M in AG)) if(src.client)
				if(M == src) continue
				if(M.client && M.client.address == src.client.address&&M.client.computer_id!=src.client.computer_id) //if(!M.MultikeyApproved&&!src.MultikeyApproved)
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>IP address</B> as <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
					altsIDd++
				if(M.client && M.client.computer_id == src.client.computer_id) if(M.MultikeyApproved!=2&&src.MultikeyApproved!=2)
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>computer ID</B> as <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
					spawn() alert("You have logged in already with another key, please be sure to read/ask about the server rules regarding the use of multiple keys!")
					if(M.Rank||src.Rank)
						alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has logged in with an alt but currently has a rank. <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
						spawn() alert("Ranks may not have an alt.")
						del(src)
						return
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>computer ID</B> as <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
					altsIDd++
				else if (M.computer_id && M.computer_id == src.client.computer_id && M.ckey != src.ckey && M.key)
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>computer ID</B> as [key_name_admin(M)] did ([key_name_admin(M)] is no longer logged in).", 1)
				AG+=M

		if(altsIDd>=2)
			alertAdminsLogin("<font color='red'><B>Notice:</B> [key_name_admin(src)] tried to log in with a third client and was DCd.", 1)
			alert("You may only have one alt.")
			del(src)
			return

		if(src.client) src.client.show_verb_panel=1 // We want them to see the verb panel Skills and Other after they're logged in. Herp Derp.
		var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_y = 12
		_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
		src.overlays -= _overlay
		src.overlays -= 'tk.dmi'
		src.Update_Player()


		if(global.TestServerOn)
			src.verbs += typesof(/mob/TestServerOn/verb)
			src.verbs -= typesof(/mob/Tournament/verb)

		if(global.TournamentOn)
			src.verbs += typesof(/mob/Tournament/verb)
			src.verbs -= typesof(/mob/TestServerOn/verb)
			TournamentPreparation(src)

		src<<"<span class=\"announce\"><b>If you find bugs, report them. There's a link to the discord in the top left under Help.</b></span>"
		src.saveToLog("| ([src.x], [src.y], [src.z]) || [key_name(src)] logs in\n")
		adminObserve = 0

	src.LoginDate=(Year+(Month*0.01))
	src.HitterListOld = list()					//If the emote is of 30 words or more , reset the hitter old list for the anger system
	src.FailToAnger=0
	src.HitterListNew = list()
	src.LastHitter = 0


//Study stopper
	if(src.Study)
		src.Meditate=0
		src<<"You stop studing."
		icon_state=""
//Meditation stopper
	if(src.Meditate)
		src.Meditate=0
		src<<"You stop meditating."
		icon_state=""
//Self Train stopper
	if(src.Training)
		src.Training=0
		src<<"You stop training."
		icon_state=""

	if(src.CrystalClaimer == 1)
		for(var/obj/Crystal/A)
			if(A.ClaimedBy==src.ckey)
				src.CrystalPower ++
		if(src.CrystalPower==0)
			src.CrystalClaimer = 0
	if(src.AntiPowerGameKey == src.computer_id)
		src << "You can't be your own bio-android."
		src << "You will be disconnected if you try to log in."
		del(src)
		return


mob/Logout()
	if(adminDensity)
		adminDensity=0
		density=1
		immortal=0
		invisibility = 0
		icon=last_icon
		client.mob.see_invisible=client.mob.Old_Sight
	reset_view(src)
	RevertAll()
	Flight_Land()
	RemoveShadow(src)
	usr.ArtifactRemove()
	LogoutDate=(Year+(Month*0.01))
	if(RPMode)
		RPMode=0
		overlays-='RPMode.dmi'
	var/image/AA=image('RPMode.dmi',layer=25)
	src.overlays-=AA
	AFKRemove()
	var/image/AAA=image('StatusEffects.dmi',icon_state="Burning", layer =5)
	src.overlays-=AAA
	src.overlays-='Shield, Legendary.dmi'
	for(var/Skill/Misc/Icey_Grip/IG in src) overlays-=IG
	verbs -= /mob/proc/donec
	verbs -= /mob/proc/bodyc
	src.HitterListOld = list()									//If the emote is of 30 words or more , reset the hitter old list for the anger system
	src.FailToAnger=0
	src.HitterListNew = list()
	src.LastHitter = 0
	if(adminObserve||InFusion==1||IsFusion)
		Save()	//Just save, don't do anything else
		return

	else
		if(key)
			for(var/Skill/Attacks/SuperExplosiveWave/SEW in src) if(SEW.Using)
				src.move=1
				SEW.Using=0
			for(var/Skill/Attacks/T3/Self_Destruct/SD in src) if(SD.Using)
				src.move=1
				SD.Using=0
			Players-=src
			orange(12,src) << "[src.name] has logged out."
//			log_access("[key_name(src)]", type="LOGOUT")
			saveToLog("| [key_name(src)] logs out\n")

			if(usr.Study)
				usr.Study=0
				usr<<"You stop studing."
				icon_state=""

			if(usr.Training)
				usr.Training=0
				usr<<"You stop training."
				icon_state=""

			if(usr.Meditate)
				usr.Meditate=0
				usr<<"You stop meditating."
				icon_state=""


			for(var/obj/items/I in src)
				if(I.detections)
					I.detections = null
					I.detections = list()
			for(var/Skill/Misc/T2/KiBlade/KB in src) overlays-=KB
			for(var/obj/items/Magic_Ball/A in src)				//Check for the a DB inside the mob
				A.LastDBOwner=src.ckey							//Set the variable to the one who was hodling the artifact
				A.DBGrabCD= Year+(Month*0.01)+1					//Set the CD year for it
				if(isobj(src.loc))
					var/obj/O = src.loc							//Makes a new obj O on the user location
					A.loc=O.loc									//aka drop them
				else A.loc=loc
			for(var/obj/items/Artifact/A in src)				//Check for the an artifact inside the mob
				usr.ArtifactSkillRemove()						//Remove the extra skills the artifact gives.
				A.LastOwner=src.ckey							//Set the variable to the one who was hodling the artifact
				A.ArtifactGrabCD= Year+(Month*0.01)+1			//Set the CD year for it
				if(isobj(src.loc))
					var/obj/O = src.loc							//Makes a new obj O on the user location
					A.loc=O.loc									//aka drop them
				else A.loc=loc
				usr.RemoveBuffs()								//Remove every single buff from Artifacts and all
				usr.Reset_StatMultipliers()						//Reset stat multipliers


			//for(var/obj/Reward_Instance/R in Reward_List) if(R.Reward_Key == src.key) R.IsOnline="No"
			Save()
			if(KOd)
				view(src) << "Their body will disappear in 1 minute."
				alertAdmins("[key_name(src)] logged out while koed.")
				Logged_Out_Body=1
				spawn(600)
					if(src)
						Save()
						if(!client) del(src)
				return

		del(src)
	..()