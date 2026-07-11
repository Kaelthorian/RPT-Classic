mob/verb/ChangeMacro()
	set hidden=1
	MacroType++
	if(MacroType>3) MacroType=1
	if(MacroType==1)
		usr<<"Arrow Keys used for movement."
		winset(client, "mainwindow", "macro = macro")
	if(MacroType==2)
		usr<<"WASD used for movement."
		winset(client, "mainwindow", "macro = macro2")
	if(MacroType==3)
		usr<<"Arrow Keys AND WASD used for movement."
		winset(client, "mainwindow", "macro = macro3")

client
	var
		north = 0				//Keep track of movement key presses. See also movement_macros.dms.
		east = 0
		south = 0
		west = 0
		tmp/applying_movement_keys = 0

	proc/ApplyMovementKeys()
		var/movement_direction = 0
		if(north != south)
			movement_direction += north ? NORTH : SOUTH
		if(east != west)
			movement_direction += east ? EAST : WEST

		//Opposite keys cancel their axis. A key release must immediately apply
		//the direction that remains instead of waiting for the next +REP event.
		if(!movement_direction) return
		applying_movement_keys = 1
		switch(movement_direction)
			if(NORTH) North()
			if(SOUTH) South()
			if(EAST) East()
			if(WEST) West()
			if(NORTHEAST) Northeast()
			if(NORTHWEST) Northwest()
			if(SOUTHEAST) Southeast()
			if(SOUTHWEST) Southwest()
		applying_movement_keys = 0


	North()	//Player is trying to go northward.
		if(applying_movement_keys) return ..()
		north = 1					//North was activated. Keep track of this.
		ApplyMovementKeys()
	East()
		if(applying_movement_keys) return ..()
		east = 1
		ApplyMovementKeys()
	South()
		if(applying_movement_keys) return ..()
		south = 1
		ApplyMovementKeys()
	West()
		if(applying_movement_keys) return ..()
		west = 1
		ApplyMovementKeys()

	verb
		NorthReleased()
			set hidden = 1
			set instant=1
			north = 0
			ApplyMovementKeys()
		EastReleased()
			set hidden = 1
			set instant=1
			east = 0
			ApplyMovementKeys()
		SouthReleased()
			set hidden = 1
			set instant=1
			south = 0
			ApplyMovementKeys()
		WestReleased()
			set hidden = 1
			set instant=1
			west = 0
			ApplyMovementKeys()
