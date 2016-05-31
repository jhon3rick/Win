"use strict"

do ( window, document, Math ) ->
	###
	# CustomEvent polyfill for IE9
	# By MDN
	# https:#developer.mozilla.org/en-US/docs/Web/API/CustomEvent
	# MIT LICENSE
	###

	typeof window.CustomEvent == 'function' || (window) ->

		CustomEvent = ( event, params ) ->
			params = params || { bubbles: false, cancelable: false, detail: undefined }
			evt = document.createEvent( 'CustomEvent' )
			evt.initCustomEvent( event, params.bubbles, params.cancelable, params.detail )
			evt

		CustomEvent.prototype = window.Event.prototype
		window.CustomEvent    = CustomEvent



Optiscroll = do ->

	###
	# Variables fijas
	###
	# Optiscroll = {}

	# GS = Optiscroll.globalSettings = {
	# 	scrollMinUpdateInterval: 1000 / 40, # 40 FPS
	# 	checkFrequency: 1000,
	# 	pauseCheck: false
	# };

	# Optiscroll.defaults = {
	# 	preventParentScroll: false,
	# 	forceScrollbars: false,
	# 	scrollStopDelay: 300,
	# 	maxTrackSize: 95,
	# 	minTrackSize: 5,
	# 	draggableTracks: true,
	# 	autoUpdate: true,
	# 	classPrefix: 'optiscroll'
	# };

	# Optiscroll.Instance(element, options || {});
	# new Optiscroll.Instance(element, options || {});

	Optiscroll = ( element, options = {} ) ->

		me = @
		me.cache = {};
		me.element  = element
		me.scrollEl = element.children[0]

		# instance variables
		me.settings =  _extend( _extend({}, Optiscroll.defaults), options || {});
		# init()

		init = () ->
			# console.log(2)
			settings = me.settings

			# initialize scrollbars
			me.scrollbars = {
				v: new Scrollbar('v', me),
				h: new Scrollbar('h', me)
			};

			# console.log(me.scrollbars);

			# Stop initialization if old IE
			if(!document.addEventListener) then return

			# add instance to global array for timed check
			if(settings.autoUpdate) then G.instances.push( me )

			# disable forced scrollbars if Firefox
			# because we cannot hide native scrollbars yet
			if(G.nativeScrollbarSize == 0 && 'mozRequestAnimationFrame' in window) then settings.forceScrollbars = false

			# create DOM scrollbars only if they have size or if it's forced
			if(G.nativeScrollbarSize || settings.forceScrollbars)
				Utils.hideNativeScrollbars(me.scrollEl);
				_invoke(me.scrollbars, 'create');

			if(G.isTouch && settings.preventParentScroll)
				toggleClass(me.element, settings.classPrefix+'-prevent', true);

			# calculate scrollbars
			me.update();

			# bind container events
			me.bind();

			# start the timed check if it is not already running
			if(settings.autoUpdate && !G.checkTimer) then Utils.checkLoop()

		me.bind = () ->
			scrollEl   = me.scrollEl
			listeners  = me.listeners = {}
			varfuncion = (ev) -> Events.scroll(ev, me)

			# scroll event binding
			listeners.scroll = _throttle(varfuncion, GS.scrollMinUpdateInterval)

			# overflow events bindings (non standard, moz + webkit)
			# to update scrollbars immediately
			listeners.overflow = listeners.underflow = listeners.overflowchanged = () -> me.update()

			if(G.isTouch)
				listeners.touchstart = (ev) -> Events.touchstart(ev, me)
				listeners.touchend = (ev) -> Events.touchend(ev, me)

			if(me.settings.preventParentScroll)
				 # Safari does not support wheel event
				listeners.mousewheel = listeners.wheel = (ev) -> Events.wheel(ev, me)

			for ev in listeners
				scrollEl.addEventListener(ev, listeners[ev])

		me.update = () ->
			# console.log('update')
			oldcH = me.cache.clientH
			scrollEl = me.scrollEl
			cache = me.cache
			sH = scrollEl.scrollHeight
			cH = scrollEl.clientHeight
			sW = scrollEl.scrollWidth
			cW = scrollEl.clientWidth

			if( sH != cache.scrollH || cH != cache.clientH || sW != cache.scrollW || cW != cache.clientW )

				cache.scrollH = sH;
				cache.clientH = cH;
				cache.scrollW = sW;
				cache.clientW = cW;
				# console.log(oldcH)

				# only fire if cache was defined
				if( oldcH != undefined )

					# if the element is no more in the DOM
					if(sH == 0 && cH == 0 && !Utils.containsNode(document.body, me.element))
						me.destroy()
						false
#
					# console.log(2222)
					me.fireCustomEvent('sizechange')

				# this will update the scrollbar
				# and check if bottom is reached
				_invoke(me.scrollbars, 'update')

		init()


		###
		# Animate scrollTo
		###
		scrollTo = (destX, destY, duration) ->
			cache = me.cache
			G.pauseCheck = true;
			# force update
			me.update();

			startX = me.scrollEl.scrollLeft;
			startY = me.scrollEl.scrollTop;

			endX = +destX;
			if(destX == 'left') then endX = 0;
			if(destX == 'right') then endX = cache.scrollW - cache.clientW;
			if(destX == false) then endX = startX;

			endY = +destY;
			if(destY == 'top') then endY = 0;
			if(destY == 'bottom') then endY = cache.scrollH - cache.clientH;
			if(destY == false) then endY = startY;

			# animate
			me.animateScroll(startX, endX, startY, endY, +duration);



		scrollIntoView: (elem, duration, delta) ->
			scrollEl = me.scrollEl
			G.pauseCheck = true
			# force update
			me.update();

			if(typeof elem == 'string')  # selector
				elem = scrollEl.querySelector(elem)
			else if(elem.length && elem.jquery)  # jquery element
				elem = elem[0]


			if(typeof delta == 'number')  # same delta for all
				delta = { top:delta, right:delta, bottom:delta, left:delta };

			delta = delta || {};
			eDim = elem.getBoundingClientRect();
			sDim = scrollEl.getBoundingClientRect();

			startX = endX = scrollEl.scrollLeft;
			startY = endY = scrollEl.scrollTop;
			offsetX = startX + eDim.left - sDim.left;
			offsetY = startY + eDim.top - sDim.top;

			leftEdge = offsetX - (delta.left || 0);
			topEdge = offsetY - (delta.top || 0);
			rightEdge = offsetX + eDim.width - me.cache.clientW + (delta.right || 0);
			bottomEdge = offsetY + eDim.height - me.cache.clientH + (delta.bottom || 0);

			if(leftEdge < startX) then endX = leftEdge
			if(rightEdge > startX) then endX = rightEdge

			if(topEdge < startY) then endY = topEdge
			if(bottomEdge > startY) then endY = bottomEdge

			# animate
			me.animateScroll(startX, endX, startY, endY, +duration);

		animateScroll: (startX, endX, startY, endY, duration) ->
			scrollEl = me.scrollEl
			startTime = Date.now()

			if(endX == startX && endY == startY) then return

			if(duration == 0)
				scrollEl.scrollLeft = endX
				scrollEl.scrollTop = endY
				return;

			if(isNaN(duration)) # undefined or auto
				# 500px in 430ms, 1000px in 625ms, 2000px in 910ms
				duration = Math.pow( Math.max( Math.abs(endX - startX), Math.abs(endY - startY) ), 0.54) * 15

			scrollAnimation = () ->
				time = Math.min(1, ((Date.now() - startTime) / duration))
				easedTime = Utils.easingFunction(time);

				if( endY != startY ) then scrollEl.scrollTop = ~~(easedTime * (endY - startY)) + startY
				if( endX != startX ) then scrollEl.scrollLeft = ~~(easedTime * (endX - startX)) + startX
				if(time < 1) then animationTimeout(scrollAnimation)

			animationTimeout(scrollAnimation);

		destroy: () ->
			scrollEl = me.scrollEl
			listeners = me.listeners
			index = G.instances.indexOf( me )

			# unbind events
			for ev in listeners
				scrollEl.removeEventListener(ev, listeners[ev])

			# remove scrollbars elements
			_invoke(me.scrollbars, 'remove');

			# restore style
			scrollEl.removeAttribute('style');
			scrollEl.removeAttribute('data-scroll');

			# remove classes
			toggleClass(me.element, me.settings.classPrefix+'-prevent', false);

			# defer instance removal from global array
			# to not affect checkLoop _invoke
			if (index > -1)
				animationTimeout(() ->
					G.instances.splice(index, 1);
				);

		fireCustomEvent: (eventName) ->
			cache = me.cache
			sH = cache.scrollH
			sW = cache.scrollW

			eventData = {
				# scrollbars data
				scrollbarV: _extend({}, cache.v),
				scrollbarH: _extend({}, cache.h),

				# scroll position
				scrollTop: cache.v.position * sH,
				scrollLeft: cache.h.position * sW,
				scrollBottom: (1 - cache.v.position - cache.v.size) * sH,
				scrollRight: (1 - cache.h.position - cache.h.size) * sW,

				# element size
				scrollWidth: sW,
				scrollHeight: sH,
				clientWidth: cache.clientW,
				clientHeight: cache.clientH
			};

			me.element.dispatchEvent( new CustomEvent(eventName, { detail: eventData }) );

	Events = {

		scroll: (ev, me) ->
			if (!G.pauseCheck) then me.fireCustomEvent('scrollstart')
			G.pauseCheck = true;

			me.scrollbars.v.update();
			me.scrollbars.h.update();

			me.fireCustomEvent('scroll');

			clearTimeout(me.cache.timerStop);
			me.cache.timerStop = setTimeout((() -> Events.scrollStop(me)), me.settings.scrollStopDelay);

		touchstart: (ev, me) ->
			G.pauseCheck = false;
			me.scrollbars.v.update();
			me.scrollbars.h.update();

			if(me.settings.preventParentScroll) then Events.wheel(ev, me)

		touchend: (ev, me) ->
			# prevents touchmove generate scroll event to call
			# scrollstop  while the page is still momentum scrolling
			clearTimeout(me.cache.timerStop);

		scrollStop: (me) ->
			# fire custom event
			me.fireCustomEvent('scrollstop');

			# restore check loop
			G.pauseCheck = false;


		wheel: (ev, me) ->
			cache  = me.cache
			cacheV = cache.v
			cacheH = cache.h

			if(cacheV.enabled && cacheV.percent % 100 == 0) then me.scrollEl.scrollTop = if cacheV.percent then (cache.scrollH - cache.clientH - 1) else 1
			if(cacheH.enabled && cacheH.percent % 100 == 0) then me.scrollEl.scrollLeft = if cacheH.percent then (cache.scrollW - cache.clientW - 1) else 1
	}


	Scrollbar = (which, instance) ->
		# console.log(instance)
		# console.log('scroll'+which)
		isVertical = (which == 'v')
		parentEl = instance.element
		scrollEl = instance.scrollEl
		settings = instance.settings
		cache = instance.cache
		scrollbarCache = cache[which] = {}

		sizeProp = isVertical ? 'H' : 'W'
		clientSize = 'client'+sizeProp
		scrollSize = 'scroll'+sizeProp
		scrollProp = if isVertical then 'scrollTop' else 'scrollLeft'
		evNames = if isVertical then ['top','bottom'] else ['left','right']
		trackTransition = 'height 0.2s ease 0s, width 0.2s ease 0s, opacity 0.2s ease 0s'

		enabled = false
		scrollbarEl = null
		trackEl = null
		animated = false

		events = {
			dragData: null,

			dragStart: (ev) ->
				evData = if ev.touches then ev.touches[0] else ev;
				events.dragData = { x: evData.pageX, y: evData.pageY, scroll: scrollEl[scrollProp] };

			dragMove: (ev) ->
				evData = if ev.touches then ev.touches[0] else ev
				delta
				deltaRatio

				if(!events.dragData) then return

				ev.preventDefault();
				delta = if isVertical then evData.pageY - events.dragData.y else evData.pageX - events.dragData.x;
				deltaRatio = delta / cache[clientSize];

				scrollEl[scrollProp] = events.dragData.scroll + deltaRatio * cache[scrollSize];

			dragEnd: () ->
				events.dragData = null;
		};

		return {
			toggle: (bool) ->
				enabled = bool;

				if(trackEl)
					toggleClass(parentEl, which+'track-on', enabled)

					if(enabled)
						trackEl.style[G.cssTransition] = trackTransition

				# expose enabled
				scrollbarCache.enabled = enabled;


			create: () ->
				scrollbarEl = document.createElement('div');
				trackEl = document.createElement('b');

				scrollbarEl.className = settings.classPrefix+'-'+which;
				trackEl.className = settings.classPrefix+'-'+which+'track';
				scrollbarEl.appendChild(trackEl);
				parentEl.appendChild(scrollbarEl);

				if(settings.draggableTracks) then this.bind(true)

			update: () ->
				# newSize, oldSize,
				# newDim, newRelPos, deltaPos;

				# if scrollbar is disabled and no scroll
				if(!enabled && cache[clientSize] == cache[scrollSize]) then return

				newDim = this.calc();
				newSize = newDim.size;
				oldSize = scrollbarCache.size;
				newRelPos = (1 / newSize) * newDim.position * 100;
				deltaPos = Math.abs(newDim.position - (scrollbarCache.position || 0)) * cache[clientSize];

				if(newSize == 1 && enabled) then me.toggle(false)
				if(newSize < 1 && !enabled) then me.toggle(true)
				if(trackEl && enabled) then me.style(newRelPos, deltaPos, newSize, oldSize) # animationTimeout(() ->

				# update cache values
				scrollbarCache = _extend(scrollbarCache, newDim);

				if(enabled) then me.fireEdgeEv()

			style: (newRelPos, deltaPos, newSize, oldSize) ->

				if(newSize != oldSize) then trackEl.style[ if isVertical then 'height' else 'width' ] = newSize * 100 + '%'

				if(deltaPos) # only if position has changed
					me.animateTrack( G.isTouch && deltaPos > 20 );
					trackEl.style[G.cssTransform] = 'translate(' + (if isVertical then  '0%,'+newRelPos+'%' else newRelPos+'%'+',0%') +')';


			animateTrack: (animatePos) ->
				if(animatePos || animated) then trackEl.style[G.cssTransition] = trackTransition + (if animatePos then ', '+ G.cssTransformDashed + ' 0.2s linear 0s' else '')
				animated = animatePos

			bind: () ->
				# method = (if on then 'add' else 'remove') + 'EventListener'
				# type = if G.isTouch then ['touchstart', 'touchmove', 'touchend'] else ['mousedown', 'mousemove', 'mouseup']

				if (trackEl) then trackEl[method](type[0], events.dragStart)
				document[method](type[1], events.dragMove);
				document[method](type[2], events.dragEnd);

			calc: () ->
				position = scrollEl[scrollProp]
				viewS = cache[clientSize]
				scrollS = cache[scrollSize]
				sizeRatio = viewS / scrollS
				sizeDiff = scrollS - viewS
				# positionRatio
				# percent

				if(sizeRatio >= 1 || !scrollS) then return { position: 0, size: 1, percent: 0 } # no scrollbars needed

				percent = 100 * position / sizeDiff;

				# prevent overscroll effetcs (negative percent)
				# and keep 1px tolerance near the edges
				if(position <= 1) then percent = 0
				if(position >= sizeDiff - 1) then percent = 100

				# Capped size based on min/max track percentage
				sizeRatio = Math.max(sizeRatio, settings.minTrackSize / 100);
				sizeRatio = Math.min(sizeRatio, settings.maxTrackSize / 100);

				positionRatio = (1 - sizeRatio) * (percent / 100);

				return { position: positionRatio, size: sizeRatio, percent: percent }

			fireEdgeEv: () ->
				percent = scrollbarCache.percent

				if(scrollbarCache.was != percent && percent % 100 == 0)
					instance.fireCustomEvent('scrollreachedge');
					instance.fireCustomEvent('scrollreach'+ evNames[percent/100] );

				scrollbarCache.was = percent;


			remove: () ->
				# remove parent custom classes
				this.toggle(false);
				# unbind drag events
				this.bind(false);
				# remove elements
				if(scrollbarEl && scrollbarEl.parentNode) then scrollbarEl.parentNode.removeChild(scrollbarEl)
		}

	Utils = {

		hideNativeScrollbars: (scrollEl) ->
			# console.log(scrollEl)
			size = G.nativeScrollbarSize
			scrollElStyle = scrollEl.style
			if size == 0
				# hide Webkit/touch scrollbars
				time = Date.now();
				scrollEl.setAttribute('data-scroll', time);

				# force scrollbars update on Webkit
				scrollElStyle.display = 'none';

				if G.isTouch
					Utils.addCssRule('[data-scroll="'+time+'"]::-webkit-scrollbar', 'display: none;');
				else
					Utils.addCssRule('[data-scroll="'+time+'"]::-webkit-scrollbar', 'width: 0; height: 0;');

				animationTimeout(() -> scrollElStyle.display = 'block' );

			else
				# force scrollbars and hide them
				scrollElStyle.overflow = 'scroll';
				scrollElStyle.right    = -size + 'px';
				scrollElStyle.bottom   = -size + 'px';

		addCssRule: (selector, rules) ->
			styleSheet = document.getElementById('scroll-sheet');

			if !styleSheet
				styleSheet = document.createElement("style")
				styleSheet.id = 'scroll-sheet'
				document.head.appendChild(styleSheet)

			# do not use sheet.insertRule because FF throws an error
			# if the selector is not supported
			styleSheet.innerHTML += selector + "{" + rules + "} ";


		containsNode: (parent, node) ->
			if parent.contains
				# console.log('true')
				return parent != node && parent.contains(node)
			else
				# console.log('false')
				return !!(parent.compareDocumentPosition(node) & 16);


		# Global height checker
		# looped to listen element changes
		checkLoop: () ->

			if !G.instances.length
				G.checkTimer = null;
				return;

			if !G.pauseCheck then _invoke(G.instances, 'update') # check size only if not scrolling

			if GS.checkFrequency
				G.checkTimer = setTimeout((() -> Utils.checkLoop() ), GS.checkFrequency);


		# easeOutCubic function
		easingFunction: (t) -> return (--t) * t * t + 1
	};

	animationTimeout = do () ->
		return window.requestAnimationFrame ||
			window.webkitRequestAnimationFrame ||
			window.mozRequestAnimationFrame ||
			window.msRequestAnimationFrame ||
			(callback) -> window.setTimeout(callback, 1000/60)



	# Get scrollbars width, thanks Google Closure Library
	getScrollbarWidth = () ->
		htmlEl = document.documentElement
		width = 0

		outerEl = document.createElement('div');
		outerEl.style.cssText = 'overflow:scroll;width:50px;height:50px;' + 'position:absolute;left:-100px';

		innerEl = document.createElement('div');
		innerEl.style.cssText = 'width:100px;height:100px';

		outerEl.appendChild(innerEl);
		htmlEl.appendChild(outerEl);
		width = outerEl.offsetWidth - outerEl.clientWidth;
		htmlEl.removeChild(outerEl);

		width;


	# Detect css3 support, thanks Modernizr
	cssTest = (prop) ->
		el = document.createElement( 'test' )
		ucProp = prop.charAt(0).toUpperCase() + prop.slice(1)
		props  = (prop + ' ' + ['Webkit','Moz','O','ms'].join(ucProp + ' ') + ucProp).split(' ')

		for i in props
			if el.style[ props[i] ] != undefined  then return props[i]

		false

	toggleClass = (el, value, bool) ->
		classes = el.className.split(/\s+/)
		index = classes.indexOf(value)

		if(bool)
			~index || classes.push(value)
		else
			~index && classes.splice(index, 1)

		el.className = classes.join(" ")

	_extend = (dest, src, merge) ->
		for i in src
			if(!src.hasOwnProperty(i) || dest[i] != undefined && merge) then continue
			dest[i] = src[i]

		dest


	_invoke = (collection, fn, args) ->
		console.log('dsadsadsad')
		console.log(collection.length)
		if(collection.length)
			for i in collection.length
				console.log(i)
				collection[i][fn].apply(collection[i], args)

		else
			collection['h'][fn].apply(collection['h'], args)
			collection['v'][fn].apply(collection['v'], args)
			for i in collection
				console.log('ghfgfgdfgdf')
				collection[i][fn].apply(collection[i], args)

		true

	_throttle = (fn, threshhold) ->
		# last,
		# deferTimer;
		return () ->
			context = this
			now = Date.now()
			args = arguments

			if (last && now < last + threshhold)
				# hold on to it
				clearTimeout(deferTimer)

				deferTimer = setTimeout((() ->
					last = now;
					fn.apply(context, args);
				), threshhold);
			else
				last = now;
				fn.apply(context, args);

	GS = Optiscroll.globalSettings = {
		scrollMinUpdateInterval: 1000 / 40, # 40 FPS
		checkFrequency: 1000,
		pauseCheck: false
	};

	Optiscroll.defaults = {
		preventParentScroll: false,
		forceScrollbars: false,
		scrollStopDelay: 300,
		maxTrackSize: 95,
		minTrackSize: 5,
		draggableTracks: true,
		autoUpdate: true,
		classPrefix: 'optiscroll'
	};

	 # Global variables
	G = Optiscroll.G = {
		isTouch: 'ontouchstart' in window,
		cssTransition: cssTest('transition'),
		cssTransform: cssTest('transform') || '',
		nativeScrollbarSize: getScrollbarWidth(),

		instances: [],
		checkTimer: null,
		pauseCheck: false
	};

	G.cssTransformDashed = if (G.cssTransform == 'transform') then G.cssTransform else '-'+G.cssTransform.replace('T','-t').toLowerCase()

	Optiscroll

@Optiscroll = Optiscroll

module?.exports = Optiscroll