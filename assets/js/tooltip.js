var escaper = encodeURIComponent || escape;
var decoder = decodeURIComponent || unescape;

function getParameterByName(name, params) {
	name = name.replace(/[\[\]]/g, "\\$&");
	var regex = new RegExp(name + "(=([^&;#]*)|&|#|$)");
	var results = regex.exec(params);
	if (!results) {
		return null;
	}
	if (!results[2]) {
		return '';
	}
	return decoder(results[2].replace(/\+/g, " "));
}

function htmlEntities(str) {
	return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

function htmlDecode(str) {
	return $('<textarea/>').html(str).text();
}

var tooltip = {
	loaded: false,
	mapControl: '',
	map: null,
	tileSize: 32,
	interface: '',
	params: {},
	options: {},
	pinned: false,
	clientView: 0,
	padding: 2,
	maxWidth: 0,
	$docBody: null,
	$wrap: null,
	$content: null,
	$title: null,
	$body: null,
	mapOffsets: {
		x: 0,
		y: 0,
		w: 0,
		h: 0
	},
	taskbarTop: 0,
	taskbarLeft: 0,
	focusSwitcher: 0,
	showDelay: 100,
	showDelayInt: 0,
	interrupt: false,

	init: function(tileSize, interface, map) {
		tooltip.tileSize = parseInt(tileSize);
		tooltip.interface = interface;
		tooltip.mapControl = map;
		tooltip.maxWidth = parseInt(tooltip.$wrap.css('max-width'));
	},

	removeDelays: function() {
		clearTimeout(tooltip.showDelayInt);
		clearTimeout(tooltip.focusSwitcher);
	},

	unInterrupt: function() {
		tooltip.interrupt = false;
		tooltip.removeDelays();
	},

	setInterrupt: function(which) {
		tooltip.interrupt = which === '1';
	},

	hide: function() {
		tooltip.removeDelays();
		window.location = '?src=' + window.tooltipRef + ';action=hide;force=1';
		if (tooltip.pinned) {
			window.location = 'byond://winset?'+tooltip.mapControl+'.focus=true';
		}
	},

	log: function(text) {
		window.location = '?src=' + window.tooltipRef + ';action=log&msg='+escaper(text);
	},

	debugLog: function(text) {
		if (window.tooltipDebug) {
			tooltip.log(text);
		}
	},

	show: function() {
		if (tooltip.interrupt) {
			return tooltip.unInterrupt();
		}

		//Show the thing
		window.location = 'byond://winset?'+tooltip.interface+'.alpha=255;'+tooltip.mapControl+'.focus=true';

		//On an appropriate keypress, move focus back to the map
		$(window).off('keypress').one('keypress', function(e) {
			if (!$(e.target).is('input, textarea, select, option, button')) {
				window.location = 'byond://winset?'+tooltip.mapControl+'.focus=true';
			}
		});

		if (tooltip.pinned) {
			var $closeTip = $('.close-tip');
			$closeTip.show().off('click').one('click', function(e) {
				e.preventDefault();
				tooltip.debugLog('tooltip hide called from click event');
				tooltip.hide();
			});

			//Clicking on stuff should switch focus back to the map so the player can move etc
			$(window).off('click').on('click', function(e) {
				if (!$(e.target).is('input, textarea, select, option, button')) {
					window.location = 'byond://winset?'+tooltip.mapControl+'.focus=true';
				}
			});
		} else {
			tooltip.$content.off('mouseover').one('mouseover', function() {
				tooltip.debugLog('tooltip hide called from mouseover event');
				tooltip.hide();
			});
		}
	},

	position: function(params) {
		if (typeof params !== undefined && params) {
			try {
				tooltip.params = $.parseJSON(params);
			} catch (e) {
				triggerError('JSON parse error for: ' + params + '. ' + e);
				return;
			}
		}

		//Get the real icon size according to the client view
		var mapWidth 		= tooltip.map['view-size'].x,
			mapHeight 		= tooltip.map['view-size'].y,
			tilesShown 		= (tooltip.clientView * 2) + 1,
			realIconSize 	= mapWidth / tilesShown,
			resizeRatio		= realIconSize / tooltip.tileSize,
			//Calculate letterboxing offsets
			leftOffset 		= (tooltip.map.size.x - mapWidth) / 2,
			topOffset 		= (tooltip.map.size.y - mapHeight) / 2;

		//Parse out the tile and cursor locations from params (e.g. "icon-x=32;icon-y=29;screen-loc=3:10,15:29")
		var cursor = tooltip.params.cursor;
		var iconX = parseInt(getParameterByName('icon-x', cursor));
		var iconY = parseInt(getParameterByName('icon-y', cursor));
		var screenLoc = getParameterByName('screen-loc', cursor);

		if (!iconX || !iconY || !screenLoc) {return false;} //Sometimes screen-loc is never sent ahaha fuck you byond

		//screen-loc has special byond formatting
		screenLoc = screenLoc.split(',');
		if (screenLoc.length < 2) {return false;}
		var left = screenLoc[0];
		var top = screenLoc[1];
		if (!left || !top) {return false;}
		screenLoc = left.split(':');
		left = parseInt(screenLoc[0]);
		var enteredX = parseInt(screenLoc[1]);
		screenLoc = top.split(':');
		top = parseInt(screenLoc[0]);
		var enteredY = parseInt(screenLoc[1]);

		//Screen loc offsets on objects (e.g. "WEST+0:6,NORTH-1:26") can royally mess with positioning depending on where the cursor enters
		//This is a giant bitch to parse. Note that it only expects screen_loc in the format <west>,<north>.
		if (tooltip.params.screenLoc) {
			var oScreenLoc = tooltip.params.screenLoc.split(','); //o for original ok

			var west = oScreenLoc[0].split(':');
			if (west.length > 1) { //Only if west has a pixel offset
				var westOffset = parseInt(west[1]);
				if (westOffset !== 0) {
					if ((iconX + westOffset) !== enteredX) { //Cursor entered on the offset tile
						left = left + (westOffset < 0 ? 1 : -1);
					}
					leftOffset = leftOffset + (westOffset * resizeRatio);
				}
			}

			if (oScreenLoc.length > 1) { //If north is given
				var north = oScreenLoc[1].split(':');
				if (north.length > 1) { //Only if north has a pixel offset
					var northOffset = parseInt(north[1]);
					if (northOffset !== 0) {
						if ((iconY + northOffset) === enteredY) { //Cursor entered on the original tile
							top--;
							topOffset = topOffset - ((tooltip.tileSize + northOffset) * resizeRatio);
						} else { //Cursor entered on the offset tile
							if (northOffset < 0) { //Offset southwards
								topOffset = topOffset - ((tooltip.tileSize + northOffset) * resizeRatio);
							} else { //Offset northwards
								top--;
								topOffset = topOffset - (northOffset * resizeRatio);
							}
						}
					}
				}
			}
		}

		//Clamp values
		left = (left < 0 ? 0 : (left > tilesShown ? tilesShown : left));
		top = (top < 0 ? 0 : (top > tilesShown ? tilesShown : top));

		//Calculate where on the screen the popup should appear (below the hovered tile)
		var posX = Math.round(((left - 1) * realIconSize) + leftOffset + tooltip.padding); //-1 to position at the left of the target tile
		var posY = Math.round(((tilesShown - top + 1) * realIconSize) + topOffset + tooltip.padding); //+1 to position at the bottom of the target tile

		var docWidth  = 0,
			docHeight = 0;

		tooltip.$wrap.attr('style', ''); //reset

		//We're forcing a certain size
		if (tooltip.options.hasOwnProperty('size') && typeof tooltip.options.size === 'string') {
			var size = tooltip.options.size.split('x');
			var widthString = size[0].toLowerCase();
			var heightString = size[1].toLowerCase();
			docWidth = widthString === 'auto' ? tooltip.$wrap.outerWidth() : parseInt(size[0]);
			docHeight = heightString === 'auto' ? tooltip.$wrap.outerHeight() : parseInt(size[1]);

			if (widthString !== 'auto') {
				tooltip.$wrap.css('min-width', docWidth);
			}

		//Otherwise, auto-size according to content
		} else {
			//the +2 is to fix some incredibly strange text wrapping bug that occurs AFTER sizing is complete
			docWidth  = tooltip.$wrap.outerWidth() + 2;
			docHeight = tooltip.$wrap.outerHeight();
		}

		//Apply our sizing
		tooltip.$wrap.attr('style', 'width: ' + docWidth + 'px; height: ' + docHeight + 'px;');

		//Handle special flags
		if (tooltip.params.hasOwnProperty('flags') && tooltip.params.flags.length > 0) {
			var alignment = 'bottom';
			if ($.inArray('top', tooltip.params.flags) !== -1) { //TOOLTIP_TOP
				alignment = 'top';
				posY = (posY - docHeight) - realIconSize - (tooltip.padding * 2);
			}
			if ($.inArray('right', tooltip.params.flags) !== -1) { //TOOLTIP_RIGHT
				alignment = 'right';
				posX = posX + realIconSize;
				posY = posY - realIconSize;
			}
			if ($.inArray('left', tooltip.params.flags) !== -1) { //TOOLTIP_LEFT
				alignment = 'left';
				posX = posX - docWidth - (tooltip.padding * 2);
				posY = posY - realIconSize;
			}
			if ($.inArray('center', tooltip.params.flags) !== -1) { //TOOLTIP_CENTER
				if (alignment === 'bottom' || alignment === 'top') { //Horizontal centering
					posX = (posX + (realIconSize / 2)) - (docWidth / 2);
					if (posX < tooltip.padding) {
						posX = tooltip.padding;
					}
				} else { //Vertical centering
					var gap = realIconSize - docHeight;
					if (gap > 0) {
						posY = posY + (gap / 2);
					}
				}
			}
		}

		//Handle window offsets
		posX = posX + tooltip.mapOffsets.x - tooltip.taskbarLeft;
		posY = posY + tooltip.mapOffsets.y - tooltip.taskbarTop;

		var boundaryY = tooltip.map.size.y + (tooltip.mapOffsets.y - tooltip.taskbarTop);
		if (posY + docHeight > boundaryY) { //Is the bottom edge below the window? Snap it up if so
			posY = (posY - docHeight) - realIconSize - tooltip.padding;
		}

		var boundaryX = tooltip.map.size.x + (tooltip.mapOffsets.x - tooltip.taskbarLeft);
		if (posX + docWidth > boundaryX) { //Is the right edge outside the map area? Snap it back left if so
			posX = posX - ((posX + docWidth) - boundaryX) - (tooltip.padding * 2);
		}

		tooltip.debugLog('Position called. Width: ' + docWidth + '. Height: ' + docHeight + '. PosX: ' + posX + '. PosY: ' + posY);

		window.location = 'byond://winset?id='+tooltip.interface+';size='+docWidth+'x'+docHeight+';pos='+posX+','+posY;
		tooltip.show();
	},

	changeContent: function(title, content) {
		title = htmlDecode(title);
		content = htmlDecode(content);
		tooltip.options.title = title;
		tooltip.options.content = content;

		tooltip.$content.empty();

		if (typeof title !== 'undefined') {
			tooltip.$title = $('<h1>', {'class': 'title', html: title});
			tooltip.$content.append(tooltip.$title);
		}

		if (typeof content !== 'undefined') {
			tooltip.$body = $('<div>', {html: content});
			tooltip.$content.append(tooltip.$body);
		}

		//Images affect sizing, so we have to wait until they all load first
		tooltip.$content.waitForImages(function() {
			tooltip.showDelayInt = setTimeout(function() {
				tooltip.position();
			}, tooltip.showDelay);
		});
	},

	updateCallback: function(map) {
		if (typeof map === 'undefined' || !map) {return false;}
		tooltip.map = {
			size: map[tooltip.mapControl + '.size'],
			'view-size': map[tooltip.mapControl + '.view-size']
		};

		try {
			tooltip.mapOffsets = $.parseJSON(map['mapwindow.mapSizeHelper.saved-params']);
		} catch (e) {
			triggerError('JSON parse error for: ' + map['mapwindow.mapSizeHelper.saved-params'] + '. ' + e);
			return;
		}

		tooltip.debugLog('updateCallback called. map: '+JSON.stringify(map)+'. params: '+JSON.stringify(tooltip.params)+'. clientView: '+tooltip.clientView+
				'. title: '+htmlEntities(tooltip.options.title)+'. theme: '+tooltip.options.theme + '. interrupt: ' + tooltip.interrupt);

		//Some reset stuff to avoid fringe issues with sizing
		window.location = 'byond://winset?id='+tooltip.interface+';pos=0,0;size=999x999';

		//While we're here, get the OS taskbar offsets
		tooltip.taskbarLeft = window.screenLeft;
		tooltip.taskbarTop = window.screenTop;

		tooltip.$docBody.attr('class', tooltip.options.theme + (tooltip.pinned ? ' pinned' : ''));
		tooltip.$wrap.attr('style', '');
		tooltip.changeContent(tooltip.options.title, tooltip.options.content); //calls position, which calls show
	},

	update: function(params, options, clientView, stuck) {
		try {
			tooltip.params = $.parseJSON(params);
		} catch (e) {
			triggerError('JSON parse error for: ' + params + '. ' + e);
			return;
		}

		if (tooltip.params.hasOwnProperty('init')) {
			tooltip.init(tooltip.params.init.iconSize, tooltip.params.init.window, tooltip.params.init.map);
		}

		try {
			tooltip.options = $.parseJSON(options);
		} catch (e) {
			triggerError('JSON parse error for: ' + params + '. ' + e);
			return;
		}

		tooltip.removeDelays();

		//go away while we do stuff
		window.location = 'byond://winset?id='+tooltip.interface+';alpha=0';

		tooltip.interrupt = false;
		tooltip.clientView = parseInt(clientView);
		tooltip.pinned = stuck === '1' ? true : false;

		//Go get the map details
		window.location = 'byond://winget?callback='+tooltip.interface+':tooltip.updateCallback;id='+tooltip.mapControl+',mapwindow.mapSizeHelper;property=size,view-size,saved-params';
	},
};

//WE READY YO
$(window).on('load', function() {
	if (tooltip.loaded === false) {
		tooltip.loaded = true;
		tooltip.debugLog('JS loaded, calling topic show');
		window.location = '?src=' + window.tooltipRef + ';action=show';

		tooltip.$docBody = $('body');
		tooltip.$wrap = $('#wrap');
		tooltip.$content = $('#content');
	}
});