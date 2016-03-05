###
# Win.js
# @namespeace Win
#
# @version 0.1
# @author Jhon Marroquin || @jhon3rick
# @author Jonatan Herran || @jonatan2874
#
###

"use strict"

do ($W = Win) ->

	CONTWIDGET = 0
	ELEMENT_ARRAY = {}
	CTXMENU = false

	# ---------------------------------------------------------------------------
	# Static Methods
	# Widgets ventana
	# ---------------------------------------------------------------------------
	$W.Window = (obj) ->
		width       = obj.width or 300
		height      = obj.height or 300
		id          = obj.id or ''
		title       = obj.title or ''
		titleStyle  = obj.titleStyle or ''
		modal       = obj.modal or ''
		autoDestroy = obj.autoDestroy or ''
		autoLoad    = obj.autoLoad or ''
		html        = obj.html or ''
		drag        = obj.drag or ''
		theme       = obj.theme or ''
		bodyStyle   = obj.bodyStyle or ''
		bodyColor   = obj.bodyColor or '#FFF'
		body        = $W('body')[0]
		win         = this
		clsBody     = if typeof(obj.type)!= 'undefined' and obj.type != '' then 'alert' else ''
		winModal    = document.createElement('div')

		bgBody   = if obj.bgBody then 'background-color:'+obj.bgBody+';' else ''
		bgTitle  = if obj.bgTitle then 'background-color:'+obj.bgTitle+';' else ''
		divClose = if obj.closable != false then "<div class=\"win-title-btn\" id=\"btn_close_ventana_#{id}\" onclick=\"#{id}.close()\"></div>" else ""

		if !isNaN width then width = width+'px'
		else if width is 'auto' then width='calc(100% - 20px)'

		if !isNaN height then height = height+'px'
		else if height == 'auto' then height='calc(100% - 20px)'

		if id==''
			CONTWIDGET++
			id==CONTWIDGET

		winModal.innerHTML += "<div id=\"win-modal-#{id}\" class=\"win-modal\">
									<div id=\"#{id}\" style=\"width:#{width}; height:#{height}; #{bgBody} #{bodyStyle}\" class=\"win-marco\">
										<div class=\"win-file-resize\" data-resize=\"top\" id=\"win-resize-top-#{id}\"></div>
										<div class=\"win-file-resize\" data-resize=\"bottom\" id=\"win-resize-bottom-#{id}\"></div>
										<div class=\"win-file-resize\" data-resize=\"left\" id=\"win-resize-left-#{id}\"></div>
										<div class=\"win-file-resize\" data-resize=\"right\" id=\"win-resize-right-#{id}\"></div>
										<div class=\"win-modal-parent\" id=\"win-modal-window_#{id}\">
											<div class=\"win-modal-content\">
												<div class=\"win-loader-default\" id=\"win-loader-#{id}\"></div>
												<div class=\"win-modal-label\" id=\"label-load-#{id}\"></div>
											</div>
										</div>
										<header id=\"win-header-#{id}\">
											<div class=\"win-title\" id=\"win-title-#{id}\" style=\"#{bgTitle} #{titleStyle}\">
												<div class=\"win-title-txt\">#{title}</div>
												#{divClose}
											</div>
										</header>
										<section id=\"win-section-#{id}\" style=\"height:calc(100% - 27px);\" data-role=\"win-section\"></section>
									</div>
								</div>"

		body.appendChild(winModal)

		widthVentana  = document.getElementById(id).offsetWidth
		heightVentana = document.getElementById(id).offsetHeight

		left = if body.offsetWidth < (widthVentana/2) then 0 else (body.offsetWidth - widthVentana)/2
		top  = if body.offsetHeight < (heightVentana/2) then 0 else (body.offsetHeight - heightVentana)/2

		$W("##{id}").css("left","#{left}px").css("top","#{top}px")

		$W("#win-title-#{id}")[0].onmousedown = () -> _draggStart(id, document.getElementById("win-modal-#{id}"), event);
		$W("#win-title-#{id}")[0].onmouseup   = () -> _draggStop(document.getElementById("win-modal-#{id}"));

		if obj.resize
			_resize($W("#win-resize-top-#{id}")[0])
			_resize($W("#win-resize-bottom-#{id}")[0])
			_resize($W("#win-resize-left-#{id}")[0])
			_resize($W("#win-resize-right-#{id}")[0])

		if obj.items then _router(obj.items, "win-section-#{id}")
		if obj.autoLoad then  _body(obj, "win-section-#{id}")

		close: () ->
			$W("\#win-modal-#{id}")[0].parentNode.removeChild($W("\#win-modal-#{id}")[0])


	# ---------------------------------------------------------------------------
	# Static Methods
	# Public Elements
	# ---------------------------------------------------------------------------

	# $W.aside = (obj) ->


	# $W.tabpanel = (obj) ->
	# 	console.log(obj);
	# 	html = "<div id=\"#{obj.id}\">"

	# 	(obj.items).forEach(json,index,element) ->
	# 		html += "<div id=\"#{json.id}\">#{json.title}</div>"

	# 	html += "</div>"

	$W.Add = (obj) ->
		# SI ES TBAR
		typeParent = document.getElementById(obj.idApply).getAttribute("data-role")
		if typeParent is "win-tbar"
			lastDiv = document.getElementById(obj.idApply).lastChild

			if lastDiv != null
				type = lastDiv.getAttribute("data-rol")
				if type is "div-empty" then  lastDiv.parentNode.removeChild(lastDiv)

		if obj.items then _router(obj.items, obj.idApply)
		if obj.autoLoad then _body(obj, obj.idApply)

	$W.Tbar = (obj) ->
		parent = document.getElementById("#{obj.idApply}")
		parent.className = "win-tbar"
		parent.setAttribute("data-rol","win-tbar")

		_router(obj.items, obj.idApply)

	$W.Element = (id) ->

		@.hidden = () ->
			$W('#'+id).style('display','none')
			_findResizeBody(id)
			ELEMENT_ARRAY[id].hidden = true

		@.show = () ->
			$W('#'+id).style('display','block')
			_findResizeBody(id)
			ELEMENT_ARRAY[id].hidden = false

		@.enable = () ->
			document.getElementById(id).setAttribute('data-state','enable')
			ELEMENT_ARRAY[id].state = "enable"

		@.disable = () ->
			document.getElementById(id).setAttribute('data-state','disable')
			ELEMENT_ARRAY[id].state = "disable"

		return this

	$W.BlockBtn = (id) ->
		if ELEMENT_ARRAY[id].state == "disable" then return

		$W.Element(id).disable()
		setTimeout(()->
			if document.getElementById(id) then $W.Element(id).enable()
		, 2000)

	$W.loading = (obj) ->

		if typeof(obj.id_ventana)=='undefined' or typeof(obj.estado)=='undefined'
			console.warn('Funcion: Loading (Mostrar ventana modal)\nFaltan parametros en el objeto\nParametro Obligatorios: id_ventana ,estado')
			return
		if !$W("#win-body-#{obj.id_ventana}")[0]
			console.warn('Funcion: Loading (Mostrar ventana modal)\nEl id de la ventana es incorrecto no se encuentra la ventana '+id_ventana)
			return

		mask   = $W("#win-modal-window_#{obj.id_ventana}")[0]
		text   = obj.text or 'Load...'
		loader = obj.loader or 'default'

		if obj.estado == 'on'
			$W("#win-modal-window_#{obj.id_ventana}")[0].innerHTML= "<div class=\"win-modal-content\">
																		<div class=\"win-loader-default\" id=\"win-loader-#{obj.id_ventana}\"></div>
																		<div class=\"win-modal-label\" id=\"label-load-#{obj.id_ventana}\"></div>
																	</div>"

			mask.style.visibility = 'visible'
			$W("#win-loader-#{obj.id_ventana}")[0].setAttribute('class','win-loader-'+loader)
			$W("#label-load-#{obj.id_ventana}")[0].innerHTML = text
		else if obj.estado == 'off'
			iconos =
				sucess : '',
				fail   : '',
				warm   : ''

			if obj
				icono        = iconos[obj.icono] or iconos['sucess']
				evento_icono = obj.evento_icono or ''
				texto        = obj.texto or 'Informacion Almacenada'
				duracion     = obj.duracion or '2000'
				estilo_texto = obj.estilo_texto or 'padding-top: 10px;font-size: 12px;color:#FFF;'
			else
				icono        = iconos.sucess
				evento_icono = ''
				texto        = 'Informacion Almacenada'
				duracion     = '2000'
				estilo_texto = 'padding-top:10px; font-size:12px; color:#FFF;'

			if duracion=='infinito'
				$W("#win-modal-window_#{obj.id_ventana}")[0].innerHTML = "<div class=\"win-modal-content\"><div class=\"win-modal-img-finish\">
																			<img src=\"#{icono}\" onclick=\"#{evento_icono}\"><br>
																			<div class=\"win-modal-label label-finish\">#{texto}</div>
																		</div>";
			else
				$W("#win-modal-window_#{obj.id_ventana}")[0].innerHTML = "<div class=\"win-modal-content\"><div class=\"win-modal-img-finish\">
																			<img src=\"#{icono}\" onclick=\"#{evento_icono}\"><br>
																			<div class=\"win-modal-label label-finish\">#{texto}</div>
																		</div>";
				setTimeout ( ->
					mask.style.visibility = 'hidden'
				), duracion

	$W.Alert = (obj) ->

		width  = 250
		height = 120
		title  = obj.title or 'Alert'
		text   = obj.text or ''
		text   += "<div class=\"content-btn\">
						<input type=\"button\" value=\"Aceptar\" onclick=\"$W('#Win_ventana_alert')[0].parentNode.parentNode.removeChild($W('#Win_ventana_alert')[0].parentNode)\">
					</div>"

		new $W.Window({
			width       : width,
			height      : height,
			id          : 'Win_ventana_alert',
			title       : title,
			html        : text,
			type        : 'alert',
			modal       : true,
			autoScroll  : true,
			closable    : false,
			autoDestroy : true,
			drag        : false,
			resize      : false
		});

	$W.Confirm = (obj) ->

		width  = 250
		height = 120
		title  = obj.title or 'Confirm'
		text   = obj.text or ''
		text   += "<div class=\"content-btn\">
						<input type=\"button\" value=\"Aceptar\" onclick=\"$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode); #{obj.functionOK};\">
						<input type=\"button\" value=\"Cancelar\" onclick=\"$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode); return false;\">
					</div>"

		new $W.Window(
			width       : width,
			height      : height,
			id          : 'Win_ventana_confirm',
			title       : title,
			html        : text,
			type        : 'alert',
			modal       : true,
			autoScroll  : true,
			closable    : false,
			autoDestroy : true,
			drag        : false,
			resize      : false
		);


	$W.CtxMenu = (obj) ->
		document.getElementById(obj.idApply).oncontextmenu = (e) -> # Use document as opposed to window for IE8 compatibility
			obj.objApply = e.srcElement
			obj.clientX = event.clientX
			obj.clientY = event.clientY

			$W.Menu(obj)

			false

	$W.Menu = (obj) ->
		html = ""
		_deleteCtxMenu()
		CTXMENU = true

		if obj.items
			for own key, arr of obj.items
				html += "<div data-option=\"top-#{key}\">
							<div>#{arr.text}</div>
						</div>"

		divHtml = if obj.objApply then obj.objApply else document.getElementById(obj.idElement)
		divHtml.innerHTML += "<div class=\"win-menu\" data-role=\"win-menu\" style=\"top:#{event.clientY}px; left:#{event.clientX}px;\">#{html}</div>"

		if obj.items
			setTimeout () ->
				for own key, arr of obj.items
					_menuOption obj.idApply,key,arr.handler

	_menuOption = (idApply,key,handler) ->
		document.getElementById(idApply).querySelector("[data-option=top-#{key}]").onclick = () ->
			_deleteCtxMenu()
			handler(this)

	# ---------------------------------------------------------------------------
	# Static Methods
	# Private Elements
	# ---------------------------------------------------------------------------
	###
	@method _deleteCtxMenu
	###
	_deleteCtxMenu = () ->
		if CTXMENU is true
			array = document.querySelectorAll("[data-role=win-menu]")

			[].forEach.call(array, (menu) ->
				menu.parentNode.removeChild(menu)
			)

		CTXMENU = false

	###
	@method _router
	@param  arr child
	@param  obj ObjetoDom idParent
	###
	_router = (obj, idParent) ->
		if typeof(obj) == 'object'
			float = 'left'

			obj.forEach (json,index,element) ->

				switch json.xtype
					when 'button' then _button(json, idParent)
					when 'buttongroup' then _buttonGroup(json, idParent)
					when 'tbar' then _tbar(json, idParent)
					when 'panel' then _panel(json, idParent)
					when 'tabPanel' then _tabPanel(json, idParent)
					when 'tab' then _tab(json, idParent)
					when 'tbtext' then _tbText(json, idParent)
					else
						if json == '-'
							_separator(idParent)

						else if json == '--'
							_separatorHeight(idParent)

						else if json == '->'
							float = 'right'
							document.getElementById(idParent).innerHTML += '<div data-rol="div-empty"></div>'

			if float == 'left'
				document.getElementById(idParent).innerHTML += '<div data-rol="div-empty"></div>'

	###
	@method _tabPanel
	@param  obj objectDom parent and config
	###
	_tabPanel = (obj, idParent) ->

		style  = obj.style or ''
		height = obj.height or '30'

		if !isNaN width then width = width+'px'
		if !isNaN height then height = height+'px'

		bodyHeight = "calc:(100% - #{height})"

		if obj.id
			id=obj.id
		else
			CONTWIDGET++
			id=CONTWIDGET

		html = "<div id=\"win-tabpanel-#{id}\" class=\"win-tabpanel\" style=\"width:100%; height:100%; #{style}\" data-role=\"win-tabpanel\">
					<div id=\"win-tabpanel-head-#{id}\" class=\"win-tabpanel-head\" style=\"width:100%; height:#{height}; #{style}\"></div>
					<div id=\"win-tabpanel-body-#{id}\" class=\"win-tabpanel-body\" style=\"height:#{bodyHeight};\"></div>
				</div>"
		document.getElementById(idParent).innerHTML += html

		if obj.items then _router(obj.items, "win-tabpanel-head-"+id)


	_tab = (obj, idParent) ->
		title  = obj.title or ''
		icon  = obj.icon or ''

		if obj.id
			id=obj.id
		else
			CONTWIDGET++
			id="win-tab-#{CONTWIDGET}"

		div = document.createElement("div")
		div.id = id
		# div.prototype.estate = 'enable'

		document.getElementById(idParent).appendChild(div)
		document.querySelectorAll('#'+id).__proto__.estate = 'enable'


		# html = "<div id=\"#{id}\" class=\"win-tab\">#{title}</div>";

		# document.getElementById(idParent).innerHTML += html

		setTimeout () ->
			console.log(document.querySelectorAll('#'+id).estate)
			# console.log(document.getElementById(id))
			# document.getElementById(id).estate
			# div.prototype.estate = 'enable'

			# document.getElementById(id).prototype.estate = 'enable'
			# document.getElementById(id).prototype.load = 'unload'

		# parentTabpanel = document.getElementById(idParent).parentNode

	###
	@method _panel
	@param  obj objectDom config
	@param  obj objectDom parent
	###
	_panel = (obj, idParent) ->
		width  = obj.width or '160'
		height = obj.height or '60'
		html   = obj.html or ''
		style  = obj.style or ''
		title  = obj.title or ''

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id=CONTWIDGET

		if title != ''
			height = height-20
			title = "<div id=\"win-panel-title-#{id}\" style=\"width:#{width}; height:20px; #{style}\" class=\"win-panel-title\">#{title}</div>"

		if !isNaN width then width = width+'px'
		if !isNaN height then height = height+'px'

		html = "<div id=\"win-panel-#{id}\" class=\"win-panel\" style=\"width:#{width}; height:#{height}; #{style}\" data-role=\"win-panel\">
					#{title}
					<div id=\"win-panel-load-#{id}\" class=\"win-panel-load\" style=\"width:#{width}; height:#{height}; #{style}\">
						#{html}
					</div>
				</div>"

		document.getElementById(idParent).innerHTML += html

		if obj.autoLoad
			setTimeout () ->
				obj.autoLoad.idApply = 'win-panel-load-'+id
				$W.Load(obj.autoLoad)
		else if obj.items then _router(obj.items, "win-panel-load-#{id}")

	###
	@method _tbar
	@param  obj objectDom parent and config
	###
	_tbar = (obj, idParent) ->

		if obj.id
			id=obj.id
		else
			CONTWIDGET++
			id="win-tbar-#{CONTWIDGET}"

		document.getElementById(idParent).innerHTML += "<div id=\"#{id}\" class=\"win-tbar\" data-role=\"win-tbar\"></div>"
		if obj.items then _router(obj.items, "#{id}")


	_buttonGroup = (obj, idParent) ->
		hidden = obj.hidden or ''
		width  = obj.width or 0
		style  = obj.style or ''
		title  = obj.title or ''

		if width is 0 and obj.items
			for item in obj.items
				if !item.hidden
					width += if item.width > 0 then item.width or 60

		if !isNaN width then width = width+'px'
		if hidden is true then hidden = "display:none;"

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id=CONTWIDGET

		ELEMENT_ARRAY[id] = { state:"enable", hidden:hidden }

		if title != ''
			title = "<div id=\"win-buttongroup-title-#{id}\" style=\"height:20px;\" class=\"win-buttongroup-title\">#{title}</div>"

		document.getElementById(idParent).innerHTML += "<div id=\"#{id}\" class=\"win-buttongroup\" style=\"width:#{width}; #{hidden} #{style}\" data-role=\"win-buttongroup\">
															#{title}
															<div id=\"win-buttongroup-body-#{id}\" class=\"win-buttongroup-body\" style=\"#{style}\"></div>
														</div>"
		if obj.items then _router(obj.items, "win-buttongroup-body-#{id}")


	###
	@method _button
	@param  obj objectDom parent and config
	###
	_button = (obj, idParent) ->

		text  = obj.text or ''
		cls   = obj.cls or ''
		width = obj.width or 50
		hidden = obj.hidden or false

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id="win-btn-#{CONTWIDGET}"

		ELEMENT_ARRAY[id] = { state:"enable", hidden:hidden }

		if !isNaN width then width = width+'px'

		document.getElementById(idParent).innerHTML += "<div id=\"#{id}\" class=\"win-btn\" style=\"width:#{width};\" data-role=\"win-btn\">
															<button class=\"#{cls}\">#{text}</button>
														</div>"
		if obj.handler
			setTimeout () ->
				document.querySelector("\##{idParent} > \##{id}").onclick = () ->
					if ELEMENT_ARRAY[id].state == "disable" then return
					obj.handler(this)

	###
	@method _tbText
	@param  obj objectDom parent and config
	###
	_tbText = (obj, idParent) ->
		text  = obj.text or ''
		width = obj.width or '120'
		style = obj.style or 'left'

		if obj.id
			id=obj.id
		else
			CONTWIDGET++
			id="win-tbtext-#{CONTWIDGET}"

		document.getElementById(idParent).innerHTML  += "<div id=\"#{id}\" class=\"win-tbtext\" style=\"width:#{width}; #{style}\" data-role=\"win-tbtext\">#{text}</div>"

	###
	@method _separator
	@param  obj objectDom parent
	###
	_separator = (idParent) -> document.getElementById(idParent).innerHTML += "<div class=\"win-separator\" data-role=\"win-separator\">|</div>"

	###
	@method _separatorHeight
	@param  obj objectDom parent
	###
	_separatorHeight = (idParent) -> document.getElementById(idParent).innerHTML += "<div class=\"win-separatorHeight\" data-role=\"win-separatorHeight\"></div>"

	###
	@method _body
	@param  obj objectDom parent and config
	###
	_body = (obj, idParent) ->
		items   = obj.items or ''
		html    = obj.html or ''
		clsBody = obj.clsBody or ''
		style   = 'overflow:hidden;'

		if obj.scrollY is true then style += 'overflow-y:auto;'
		else if obj.scrollX is true then style += 'overflow-x:auto;'
		if obj.scroll is true then style = 'overflow:auto;'

		if obj.idApply
			id=obj.idApply
		else
			CONTWIDGET++
			id="win-body-#{CONTWIDGET}"

		parent = document.getElementById(idParent)
		heightParent = parent.offsetHeight

		parent.innerHTML += "<div id=\"#{id}\" class=\"win-body #{clsBody}\" style=\"#{style}\" data-role=\"win-body\">#{html}</div>"
		_resizeBody = (idParent)

		if typeof(obj.autoLoad)
			setTimeout () ->
				obj.autoLoad.idApply = id
				$W.Load(obj.autoLoad)

	_findResizeBody = (id) ->
		if !document.getElementById(id) then return

		role = document.getElementById(id).getAttribute "data-role"
		if role = "win-btn" or role = "win-buttongroup"
			div1 = document.getElementById(id).parentNode
			div2 = document.getElementById(id).parentNode.parentNode
			div3 = document.getElementById(id).parentNode.parentNode.parentNode
			body = ''

			role1 = div1.getAttribute "data-role"
			role2 = div2.getAttribute "data-role"
			role3 = div3.getAttribute "data-role"

			if role1 is "win-body" or role1 is "win-section" then body = div1
			else if role2 is "win-body" or role2 is "win-section" then body = div2
			else if role3 is "win-body" or role3 is "win-section" then body = div3

			if body != ''
				_resizeBody(body.id)

	_resizeBody = (idParent) ->

		alto = 0
		body = ''
		arrayDiv = document.querySelectorAll('#'+idParent+' > div')

		[].forEach.call(arrayDiv,(element)->
			role = element.getAttribute "data-role"

			if body != '' then return
			else if role is "win-body"
				body = element
				return

			alto += element.offsetHeight
		)

		height = if alto == 0 then '100%' else 'calc(100% - '+alto+'px)'

		if body != ''
			setTimeout () ->
				body.style.height = height


	# ---------------------------------------------------------------------------
	# Private Method Drag and Drop
	# ---------------------------------------------------------------------------
	_draggStart = (id,divParent,evt) ->
		domMove = document.getElementById(id)

		evt     = evt || window.event
		posX    = evt.clientX
		posY    = evt.clientY
		divTop  = (domMove.style.top).replace('px','')
		divLeft = (domMove.style.left).replace('px','')
		eWi     = parseInt(domMove.offsetWidth)
		eHe     = parseInt(domMove.offsetHeight)
		cWi     = parseInt(divParent.offsetWidth)
		cHe     = parseInt(divParent.offsetHeight)

		divParent.style.cursor='move'
		diffX = posX - divLeft
		diffY = posY - divTop

		document.onmousemove = (evt) ->
			evt  = evt || window.event
			posX = evt.clientX
			posY = evt.clientY
			aX   = posX - diffX
			aY   = posY - diffY

			if aX < 0 then aX = 0
			if aY < 0 then aY = 0
			if (aX + eWi > cWi) then aX = cWi - eWi
			if (aY + eHe > cHe) then aY = cHe - eHe
			_draggMove(domMove,aX,aY)

	###
	@method _draggMove
	@param obj object DOM move
	@param int position x
	@param int position y
	###
	_draggMove = (objDom, xpos, ypos) ->
		objDom.style.left = xpos + 'px'
		objDom.style.top  = ypos + 'px'

	###
	@method _draggMove
	@param obj object parent DOM move
	###
	_draggStop = (objDom) ->
		objDom.style.cursor  = 'default'
		document.onmousemove = (e) -> e.preventDefault

	# ---------------------------------------------------------------------------
	# Private Method Resize
	# ---------------------------------------------------------------------------

	###
	@method _resize
	@param obj object DOM resize
	###
	_resize = (objDom) ->
		startX = 0
		startY = 0
		startWidth  = 0
		startHeight = 0
		positionY   = ((objDom.parentNode.style.top).replace('px','') * 1)
		positionX   = ((objDom.parentNode.style.left).replace('px','') * 1)
		objParent   = objDom.parentNode
		attrData    = objDom.getAttribute("data-resize")

		objDom.onmousedown = (e) -> _initDrag(e)

		_initDrag = (e) ->
			startX      = e.clientX
			startY      = e.clientY
			startWidth  = parseInt(document.defaultView.getComputedStyle(objParent).width, 10)
			startHeight = parseInt(document.defaultView.getComputedStyle(objParent).height, 10)

			document.documentElement.addEventListener('mousemove', _doDrag, false)
			document.documentElement.addEventListener('mouseup', _stopDrag, false)

		_doDrag = (e) ->

			if attrData == 'left' then _resizeXLeft(e)
			else if attrData == 'right' then _resizeXRight(e)
			else if attrData == 'top' then _resizeYTop(e)
			else if attrData == 'bottom' then _resizeYBottom(e)

		_stopDrag = (e) ->
			document.documentElement.removeEventListener('mousemove', _doDrag, false)
			document.documentElement.removeEventListener('mouseup', _stopDrag, false)

		_resizeXLeft = (e) ->
			objParent.style.left  = (positionX + e.clientX - startX) + 'px'
			objParent.style.width = (startWidth - e.clientX + startX) + 'px'

		_resizeYTop = (e) ->
			objParent.style.top  = (positionY + e.clientY - startY) + 'px'
			objParent.style.height = (startHeight - e.clientY + startY) + 'px'

		_resizeXRight = (e) ->
			if e.clientX >= 500
				objParent.style.width = (startWidth + e.clientX - startX) + 'px'

		_resizeYBottom = (e) ->
			if e.clientY >= 340
				objParent.style.height = (startHeight + e.clientY - startY) + 'px'