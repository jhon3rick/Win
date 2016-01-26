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
		autoScroll  = obj.autoScroll or ''
		autoDestroy = obj.autoDestroy or ''
		autoLoad    = obj.autoLoad or ''
		html        = obj.html or ''
		drag        = obj.drag or ''
		theme       = obj.theme or ''
		bodyStyle   = obj.bodyStyle or ''
		bodyColor   = obj.bodyColor or '#FFF'
		body        = $W('body')[0]
		winModal    = document.createElement('div')
		win         = this
		clsBody     = if typeof(obj.type)!= 'undefined' and obj.type != '' then 'alert' else ''

		bgBody   = if obj.bgBody then 'background-color:'+obj.bgBody+';' else ''
		bgTitle  = if obj.bgTitle then 'background-color:'+obj.bgTitle+';' else ''
		divClose = if obj.closable != false then "<div class=\"win-title-btn\" id=\"btn_close_ventana_#{id}\" onclick=\"#{id}.close()\"></div>" else ""

		winModal.setAttribute("id","win-modal-#{id}")
		winModal.setAttribute("class","win-modal")

		left = if body.offsetWidth < width then 0 else (body.offsetWidth - width)/2
		top  = if body.offsetHeight < height then 0 else (body.offsetHeight - height)/2

		winModal.innerHTML = "<div style=\"width:#{width}; height:#{height}; top:#{top}; left:#{left}; #{bgBody} #{bodyStyle}\" id=\"#{id}\" class=\"win-marco\">
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
									<header>
										<div class=\"win-title\" id=\"win-title-#{id}\" style=\"#{bgTitle} #{titleStyle}\">
											<div class=\"win-title-txt\">#{title}</div>
											#{divClose}
										</div>
									</header>
									<nav></nav>
									<div class=\"win-window-body #{clsBody}\" id=\"win_window_#{id}\">#{html}</div>
								</div>"

		
		body.appendChild(winModal)

		parent = winModal.querySelector('nav');
		if typeof(obj.items) != 'undefined'
			_router(obj.items, parent)


		_loadScript(winModal)

		$W("#win-title-#{id}")[0].onmousedown = () -> _draggStart(id,winModal,event);
		$W("#win-title-#{id}")[0].onmouseup   = () -> _draggStop(winModal);

		if obj.resize != false
			_resize($W("#win-resize-top-#{id}")[0])
			_resize($W("#win-resize-bottom-#{id}")[0])
			_resize($W("#win-resize-left-#{id}")[0])
			_resize($W("#win-resize-right-#{id}")[0])
			# _resize($W("#win-div-resize-#{id}")[0])

		if typeof(obj.autoLoad) != 'undefined'
			$W.Ajax.load($W("#win_window_#{id}")[0],obj.autoLoad)

		close: () ->
			$W("\#win-modal-#{id}")[0].parentNode.removeChild($W("\#win-modal-#{id}")[0])

	# $W.aside = (obj) ->


	# $W.tabpanel = (obj) ->
	# 	console.log(obj);
	# 	html = "<div id=\"#{obj.id}\">"

	# 	(obj.items).forEach(json,index,element) ->
	# 		html += "<div id=\"#{json.id}\">#{json.title}</div>"

	# 	html += "</div>" 

	$W.tbar = (obj) ->
		parent = document.getElementById("#{obj.idApply}")
		parent.className = "win-tbar"
		_router(obj.items, parent)
		


	# ---------------------------------------------------------------------------
	# Static Methods
	# Get Elements
	# --------------------------------------------------------------------------- 
	$W.getButton = (id) ->
		@hiden = (id) ->
			$W('#id').style('display','none')

		@show = (id) ->
			$W('#id').style('display','block')

		@enable = (id) ->
			$W('#id').style('display','none')

		@disable = (id) ->
			$W('#id').style('display','block')

		return id

	$W.get = (element_id) ->
		load: (obj) ->
			dom_element = $W(element_id)[0]
			$W.Ajax.load(dom_element,obj)

		element: ->
			return $W(element_id)

	$W.loading = (obj) ->

		if typeof(obj.id_ventana)=='undefined' or typeof(obj.estado)=='undefined'
			console.warn('Funcion: Loading (Mostrar ventana modal)\nFaltan parametros en el objeto\nParametro Obligatorios: id_ventana ,estado')
			return
		if !$W("#win_window_#{obj.id_ventana}")[0]
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


	# ---------------------------------------------------------------------------
	# Static Methods
	# Private Elements
	# ---------------------------------------------------------------------------
	
	###
	@method _router
	@param  arr child
	@param  obj ObjetoDom parent
	###
	_router = (obj, parent) ->
		if typeof(obj) == 'object'
			align  = 'left'

			obj.forEach (json,index,element) ->

				switch json.xtype
					when 'button' then _button(json,parent)
					# when 'buttongroup' then $W.buttongroup(json)
					when 'tbar' then _tbar(json, parent)
					when 'panel' then _panel(json, parent)
					# when 'tabpanel' then $W.tabpanel(json)
					when 'tbtext' 
						json.align = align
						_tbtext(json, parent)
					else 
						if json == '-'
							_separator(parent) 

						else if json == '--'
							_separatorHeight(parent)

						else if json == '->'
							align = 'right'
							parent.innerHTML += '<div></div>'


			if align == 'left'
				parent.innerHTML += '<div></div>'

	###
	@method _separator
	@param  obj objectDom parent
	###
	_separator = (parent) -> parent.innerHTML += "<div class=\"win-separator\">|</div>"

	###
	@method _separatorHeight
	@param  obj objectDom parent
	###
	_separatorHeight = (parent) -> parent.innerHTML += "<div class=\"win-separatorHeight\"></div>"

	$W.buttongroup = (obj) ->

	###
	@method _button
	@param  obj objectDom parent and config
	###
	_button = (obj,parent) ->
		text  = obj.text or ''
		id    = obj.id or ''
		cls   = obj.cls or ''
		width = obj.width or 50
		click = obj.handler or ''

		parent.innerHTML += "<div id=\"#{id}\" class=\"win-btn\" style=\"width: #{width}px;\" onclick=\"#{click}\">
								<button class=\"#{cls}\">#{text}</button>
							</div>"

	###
	@method _panel
	@param  obj objectDom config
	@param  obj objectDom parent
	###
	_panel = (obj, parent) ->
		id     = obj.id or ''
		width  = obj.width or 'auto'
		height = obj.height or 'auto'
		html   = obj.html or ''
		style  = obj.style or ''

		# console.log('panel')
		parent.innerHTML += "<div id=\"#{id}\" class=\"win-panel\" style=\"width:#{width}; height:#{height}; #{style}\"></div>"
		panel = parent.lastChild

		if typeof(obj.autoLoad)
			$W.Ajax.load(panel,obj.autoLoad);
			
	###
	@method _tabpanel
	@param  obj objectDom parent and config
	###
	_tabpanel = (obj) ->

	###
	@method _tbtext
	@param  obj objectDom parent and config
	###
	_tbtext = (obj, parent) ->
		id    = obj.id or ''
		text  = obj.text or ''
		align = obj.align or 'left'
		width = obj.width or '120'
		style = obj.style or 'left'
		parent.innerHTML  += "<div id=\"win-tbtext-#{id}\" class=\"win-tbtext\" style=\"width:#{width}px; #{style}\">#{text}</div>"

	###
	@method _tbar
	@param  obj objectDom parent and config
	###
	_tbar = (obj, parent) ->
		id    = obj.id or parent.id or ''
		items = obj.items or ''

		parent.innerHTML += "<div class=\"win-tbar\" id=\"win-tbar-#{id}\"></div>"
		tbar = document.getElementById("win-tbar-#{id}") 

		_router(obj.items, tbar)

	###
	@method _loadScript
	@param  obj objectDom load script
	###
	_loadScript = (obj) ->
		tagsScript = obj.getElementsByTagName('script')
		for i in tagsScript
			tagScript = document.createElement('script')
			i.parentNode.replaceChild(tagScript,i)
			tagScript.innerHTML = i.innerHTML

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
			# console.log(positionX)
			# console.log(e.clientX)
			console.log((positionX + (e.clientX - startX)))
			objParent.style.left  = (positionX + e.clientX - startX) + 'px'
			objParent.style.width = (startWidth - e.clientX + startX) + 'px'

		_resizeYTop = (e) ->
			console.log(attrData)
			objParent.style.top  = (positionY + e.clientY - startY) + 'px'
			objParent.style.height = (startHeight - e.clientY + startY) + 'px'

		_resizeXRight = (e) ->
			if e.clientX >= 500
				objParent.style.width = (startWidth + e.clientX - startX) + 'px'

		_resizeYBottom = (e) ->
			if e.clientY >= 340
				objParent.style.height = (startHeight + e.clientY - startY) + 'px'

