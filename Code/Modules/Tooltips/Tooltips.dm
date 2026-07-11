//Alignment around the turf. Any can be combined with center (top and bottom for horizontal centering, left and right for vertical).
#define TOOLTIP_BOTTOM 0
#define TOOLTIP_TOP 1
#define TOOLTIP_RIGHT 2
#define TOOLTIP_LEFT 4
#define TOOLTIP_CENTER 8




/**************************
This stuff is important
**************************/

client
	var/datum/tooltipHolder/tooltipHolder

	New()
		..()

		src.initSizeHelpers()
		src.tooltipHolder = new /datum/tooltipHolder(src)
		src.tooltipHolder.clearOld() //Clears tooltips stuck from a previous connection

	//I use a hidden browser element overlaying the map to get map size/positional data from JS without hitting the server
	proc/initSizeHelpers()
		src << browse(file2text("assets/html/mapSizeHelper.html"), "window=mapwindow.mapSizeHelper;titlebar=0;can_close=0;can_resize=0;can_scroll=0;border=0")

	proc/updateSizeHelpers()
		src << output("", "mapwindow.mapSizeHelper:sizeHelper.update")

	verb/windowResizeEvent()
		set hidden = 1
		set name = "window-resize-event"

		src.resizeTooltipEvent()
		src.updateSizeHelpers()


/*
Tooltips v2.0 - 21/05/17
Developed by Wire (#goonstation on irc.synirc.net)
- Final cleanup for public release

Configuration:
- Set the window, file and map vars on /datum/tooltipHolder below
- Attach the datum to the user client on login, e.g.
	/client/New()
		src.tooltipHolder = new /datum/tooltipHolder(src)
		src.tooltipHolder.clearOld() //Clears tooltips stuck from a previous connection

Usage:
- Define mouse event procs on your object and simply call the show and hide procs respectively:
	/obj/screen/hud
		MouseEntered(location, control, params)
			usr.client.tooltipHolder.showHover(src, list(
				"params" = params,
				"content" = (src.desc ? src.desc : null)
			))

		MouseExited()
			usr.client.tooltipHolder.hideHover()

- You may use flags defined below this comment block to tweak the tooltip. For example to align it centered:
	usr.client.tooltipHolder.showHover(src, list(
		"params" = params,
		"content" = (src.desc ? src.desc : null),
		"flags" = TOOLTIP_CENTERED
	))

Customization:
- Theming can be done by passing a "theme" key in the options list and using css in the html file to change the look

Options:
- Valid values for the options list are:
	- params (required)
	- title (required if no "content" key)
	- content (required if no "title" key)
	- theme (defaults to "default")
	- size (defaults to auto-sizing to content, is given in widthxheight e.g. 300x200 or 300xauto, auto does what it sounds like)
	- special (a string to tell the JS to do something ~special~ e.g. edge cases)
	- flags (bitwise property using tooltip alignment flags)

Notes:
- You may have noticed 90% of the work is done via javascript on the client. Gotta save those cycles man.
- This is all highly experimental! If it doesn't work for you I apologise but welp there ya go.
*/


//Prints a whole bunch of shit to the in-game chat
//#define TOOLTIP_DEBUG 1

#ifdef TOOLTIP_DEBUG
/proc/tooltipDebugOut(who, msg)
	who << "<span style='font-size: 0.85em'>\[[time2text(world.realtime, "hh:mm:ss")]\] <strong>(TOOLTIP DEBUG | DM)</strong> [msg]</span>"
#endif

var/global/list/atomTooltips = new()

/datum/tooltipHolder
	//Configurable vars
	var/window = "tooltip" //whatchu want the window to be called
	var/file = "assets/html/tooltip.html" //the browser content file
	var/map = "mapwindow.map" //the name/path of your MAP interface element

	//Internal use only, don't fuck with these
	var/client/owner
	var/list/tooltips = new()
	var/datum/tooltip/transient = null


	New(client/C)
		if (!C) return 0
		src.owner = C

		src.owner << browse_rsc(file("assets/css/tooltip.css"))
		src.owner << browse_rsc(file("assets/js/jquery.min.js"))
		src.owner << browse_rsc(file("assets/js/jquery.waitForImages.js"))
		src.owner << browse_rsc(file("assets/js/tooltip.js"))

		src.transient = src.add(clone = 0, stuck = 0)

		return 1


	//Get rid of any stuck orphaned tooltips (usually from reconnecting)
	proc/clearOld()
		var/windows = winget(src.owner, null, "windows")
		var/list/windowIDs = params2list(windows)
		for (var/windowID in windowIDs)
			if (copytext(windowID, 1, length(src.window)) == src.window)
				winshow(src.owner, windowID, 0)


	proc/add(atom/movable/thing = null, clone = 1, stuck = 1)
		var/datum/tooltip/tooltip = new(src.owner, src, clone, stuck, thing)
		src.tooltips.Add(tooltip)
		return tooltip


	proc/remove(datum/tooltip/tooltip)
		if (tooltip in src.tooltips)
			del(tooltip)
			return 1

		return 0


	proc/showHover(atom/movable/thing, list/options)
		src.transient.show(thing, options)


	proc/hideHover()
		src.transient.hide()


	proc/getTooltipFor(atom/movable/thing)
		if (!istype(thing)) return 0

		for (var/datum/tooltip/t in src.tooltips)
			if (t.A == thing)
				return t



/datum/tooltip
	//Internal use only, don't fuck with these
	var/datum/tooltipHolder/holder
	var/window
	var/file
	var/map
	var/client/owner
	var/atom/movable/A
	var/showing = 0
	var/init = 0
	var/uid = 0
	var/isClone = 0
	var/isStuck = 1
	var/creating = 0
	var/created = 0
	var/visible = 0
	var/list/savedOptions


	New(client/C, datum/tooltipHolder/tipHolder, clone = 1, stuck = 1, atom/movable/thing = null)
		if (!C) return 0
		src.owner = C
		src.holder = tipHolder
		src.isClone = clone
		src.isStuck = stuck
		src.A = thing

		src.window = tipHolder.window
		src.file = tipHolder.file
		src.map = tipHolder.map

		if (clone && thing)
			var/list/atomTipRefs = new()
			atomTipRefs.Add(src)
			atomTooltips[thing] = atomTipRefs

		#ifdef TOOLTIP_DEBUG
		tooltipDebugOut(src.owner, "New() called. clone: [clone]. stuck: [stuck]. thing: [thing] (\ref[thing])")
		#endif

		return 1


	Del()
		if (src.A && atomTooltips[src.A] && (src in atomTooltips[src.A]))
			var/list/atomTipRefs = atomTooltips[src.A]
			atomTipRefs.Remove(src)

		if (src.owner)
			if (src.holder && (src in holder.tooltips))
				src.holder.tooltips.Remove(src)

			src.owner << browse(null, "window=[src.window]")

		..()


	Topic(href, href_list[])
		switch (href_list["action"])
			if ("log")
				src.owner << "<span style='font-size: 0.85em'>\[[time2text(world.realtime, "hh:mm:ss")]\] <strong>(TOOLTIP DEBUG | JS)</strong> [href_list["msg"]]</span>"
			if ("show")
				src.show2(src.savedOptions)
			if ("hide")
				var/force = href_list["force"] ? text2num(href_list["force"]) : 0
				src.hide(force, 1)


	proc/create()
		if (!src.created && !src.creating)
			src.creating = 1

			if (src.isClone)
				src.uid = "[world.timeofday][rand(1,10000)]"
				var/newWindow = "[src.window][src.uid]"
				winclone(src.owner, newWindow, src.window)
				src.window = newWindow

			#ifdef TOOLTIP_DEBUG
			tooltipDebugOut(src.owner, "create() called")
			#endif

			var/fileText = replacetext(file2text(src.file), "TOOLTIPREFPLACE", "\ref[src]");
			#ifdef TOOLTIP_DEBUG
			fileText = replacetext(fileText, "var tooltipDebug = false;", "var tooltipDebug = true;")
			#endif
			src.owner << browse(fileText, "window=[src.window];titlebar=0;can_close=0;can_resize=0;can_scroll=0;border=0")
			winset(src.owner, src.window, "alpha=0;pos=0,0;size=1,1;background-color=#ff00e4;transparent-color=#ff00e4;")
			return 1
		return 0


	proc/show(atom/movable/thing, list/options)
		if (src.showing || !thing || !istype(thing) || !src.owner || !options || !options["params"] || (!options["title"] && !options["content"]) || (options["flags"] && !isnum(options["flags"])))
			return 0

		#ifdef TOOLTIP_DEBUG
		tooltipDebugOut(src.owner, "show() called. args: [html_encode(json_encode(args))]")
		#endif

		if (!options["theme"])
			options["theme"] = "default"

		src.showing = 1
		src.A = thing
		src.savedOptions = options

		if (src.created)
			src.show2(options)
		else
			src.create()


	proc/show2(options)
		if (!src.created || src.creating)
			src.created = 1
			src.creating = 0

		src.visible = 1
		var/list/params = new()

		if (!src.init)
			//Initialize some vars
			src.init = 1
			params["init"] = list(
				"iconSize" = world.icon_size,
				"window" = src.window,
				"map" = src.map
			)

		if (options["flags"])
			var/list/extra = new()
			if (options["flags"] & TOOLTIP_TOP)
				extra += "top"
			if (options["flags"] & TOOLTIP_RIGHT)
				extra += "right"
			if (options["flags"] & TOOLTIP_LEFT)
				extra += "left"
			if (options["flags"] & TOOLTIP_CENTER)
				extra += "center"

			params["flags"] = extra

		params["cursor"] = istype(options["params"], /list) ? list2params(options["params"]) : options["params"]
		params["screenLoc"] = src.A.screen_loc

		#ifdef TOOLTIP_DEBUG
		//Payload: { "cursor": "icon-x=11;icon-y=22;screen-loc=6:11,2:22", "screenLoc": "CENTER-2, SOUTH+1", "flags": [] }. Theme: item. Special: none
		tooltipDebugOut(src.owner, "show2() calling update. Params: [json_encode(params)]. Theme: [options["theme"]]. Size: [options["size"]]. Special: [options["special"]]")
		#endif

		//Send stuff to the tooltip
		src.owner << output(list2params(list(
				json_encode(params),
				json_encode(options),
				src.owner.view,
				src.isStuck
			)), "[src.window].browser:tooltip.update")

		src.showing = 0
		return 1


	proc/changeContent(title = "", content = "")
		if (!title && !content) return 0

		src.owner << output(list2params(list(title, content)), "[src.window].browser:tooltip.changeContent")

		return 1


	proc/hide(force = 0, fromJS = 0)
		if (!force && (!src.created || !src.owner || !src.visible)) return 0

		src.visible = 0

		#ifdef TOOLTIP_DEBUG
		tooltipDebugOut(src.owner, "hide() called. force: [force]. fromJS: [fromJS]. src.visible: [src.visible]. src.created: [src.created]. src.isStuck: [src.isStuck]")
		#endif

		if (!fromJS)
			src.owner << output(1, "[src.window].browser:tooltip.setInterrupt")

		winset(src.owner, src.window, "alpha=0;size=1x1;pos=0,0")
		return 1


	proc/position(params)
		src.owner << output(list2params(list(params)), "[src.window].browser:tooltip.position")


	proc/isVisible()
		var/visible = winget(src.owner, src.window, "alpha")
		return visible != "0"


/client/proc/resizeTooltipEvent()
	if (src.tooltipHolder)
		for (var/datum/tooltip/t in src.tooltipHolder.tooltips)
			t.hide()


/proc/clickTip(atom/movable/source, mob/user, list/options)
	if (!source || !user || !options) return 0

	if (user.client && user.client.tooltipHolder)
		var/datum/tooltip/clickTip = user.client.tooltipHolder.getTooltipFor(source)

		if (!clickTip)
			clickTip = user.client.tooltipHolder.add(thing = source)

		if (clickTip)
			if (clickTip.visible)
				clickTip.changeContent(options["title"], options["content"])
			else
				if (!options["params"])
					options["params"] = source.getScreenParams()
				clickTip.show(source, options)


//Mimics the params list given in Click() or MouseEntered().
//Useful if you don't have access to the params those supply (e.g. programmatically showing a tooltip)
/atom/movable/proc/getScreenParams()
	set src in view()

	if (!usr || !usr.client || !isnum(usr.client.view))
		return 0

	var/atom/screenCenter = usr.client.virtual_eye
	var/viewCenterX = usr.client.view
	var/viewCenterY = usr.client.view

	if (istext(usr.client.view))
		var/list/viewSizes = splittext(usr.client.view, "x")
		viewCenterX = text2num(viewSizes[1])
		viewCenterY = text2num(viewSizes[2])

	var/xDist = screenCenter.x - src.x
	var/yDist = screenCenter.y - src.y
	var/screenX = (viewCenterX + 1) - xDist
	var/screenY = (viewCenterY + 1) - yDist

	if (src.pixel_x || src.pixel_y)
		var/iconWidth = world.icon_size
		var/iconHeight = world.icon_size

		if (istext(world.icon_size))
			var/list/iconSizes = splittext(world.icon_size, "x")
			iconWidth = text2num(iconSizes[1])
			iconHeight = text2num(iconSizes[2])

		if (src.pixel_x)
			screenX += round(src.pixel_x / iconWidth)

		if (src.pixel_y)
			screenY += round(src.pixel_y / iconHeight)

	var/list/params = list(
		"icon-x" = 1,
		"icon-y" = 1,
		"screen-loc" = "[screenX]:1,[screenY]:1"
	)

	return params



//Hides click-toggle tooltips on player movement
/mob/Move()
	..()

	if (usr && src.client && src.client.tooltipHolder)
		for (var/datum/tooltip/t in src.client.tooltipHolder.tooltips)
			if (t.isStuck)
				t.hide()



//Look this just makes sense ok
/mob/Del()
	if (usr && src.client && src.client.tooltipHolder)
		for (var/datum/tooltip/t in src.client.tooltipHolder.tooltips)
			t.hide()

	..()


/atom/movable/Del()
	if ((src in atomTooltips) && istype(atomTooltips[src], /list))
		var/list/thingTooltips = atomTooltips[src]

		for (var/datum/tooltip/t in thingTooltips)
			del(t)

		atomTooltips.Remove(src)

	..()


// DEBUG
#ifdef TOOLTIP_DEBUG
/client/verb/debugTooltips()
	set name = "Debug Tooltips"
	set desc = "Returns the amount of tooltips in existence everywhere"

	var/holderCount = 0
	var/tooltipCount = 0
	for (var/client/C in world)
		if (C.tooltipHolder)
			holderCount++
			for (var/datum/tooltip/t in C.tooltipHolder.tooltips)
				tooltipCount++

	var/msg = {"----------
<strong>[holderCount]</strong> tooltip holder datums exist
<strong>[tooltipCount]</strong> tooltip datums exist
<strong>[length(atomTooltips)]</strong> atoms have tooltips
<strong>atomTooltips:</strong> [json_encode(atomTooltips)]
----------"}

	src << msg

/client/verb/reloadTooltip()
	set name = "Reload Tooltips"
	set desc = "Simply reloads your tooltips"

	for (var/datum/tooltip/t in src.tooltipHolder.tooltips)
		del(t)

	del(src.tooltipHolder)
	src.tooltipHolder = new /datum/tooltipHolder(src)

	src << "Reloaded tooltips"
#endif




/*

obj/items
	//A bog standard tooltip-on-hover
	hoverTest
		icon = 'Backpack.dmi'
		name = "Hover Test Item"
		desc = "This is a test description! The tooltip (hopefully) showed up on hover."

		MouseEntered(location, control, params)
			..()

			usr.client.tooltipHolder.showHover(src, list(
				"params" = params,
				"title" = src.name,
				"content" = src.desc
			))

		MouseExited()
			if (usr.client.tooltipHolder)
				usr.client.tooltipHolder.hideHover()

	//A tooltip opened via clicking
	clickTest
		icon = 'Backpack.dmi'
		name = "Click Test Item"
		desc = "This is also a test description! The tooltip (also hopefully) showed up on click."

		DblClick(location, control, params)
			..()
			usr<<"location [location] || control [control]"
			clickTip(src, usr, list(
				"params" = params,
				"title" = src.name,
				"content" = src.desc
			))*/