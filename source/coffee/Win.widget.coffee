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
	ELEMENTS = {}

	# ---------------------------------------------------------------------------
	# Static Methods
	# Widgets ventana
	# ---------------------------------------------------------------------------
	$W.Window = (obj) ->
		_$          = @
		title       = obj.title or ''
		width       = obj.width or 300
		height      = obj.height or 300

		scroll      = if obj.scroll  is undefined then true else obj.scroll
		scrollX     = if obj.scrollX is undefined then true else obj.scrollX
		scrollY     = if obj.scrollY is undefined then true else obj.scrollY

		body        = $W('body')[0]
		html        = obj.html or ''
		drag        = obj.drag or ''
		theme       = obj.theme or ''
		style       = obj.style or ''
		modal       = obj.modal or ''
		autoLoad    = obj.autoLoad or ''
		bodyStyle   = obj.bodyStyle or ''
		bodyColor   = obj.bodyColor or '#FFF'
		titleStyle  = obj.titleStyle or ''
		autoDestroy = obj.autoDestroy or ''
		clsBody     = if typeof(obj.type)!= 'undefined' and obj.type != '' then 'alert' else ''

		if obj.id then id = obj.id
		else
			CONTWIDGET++
			id = "window-#{CONTWIDGET}"

		bgBody   = if obj.bgBody then 'background-color:'+obj.bgBody+';' else ''
		bgTitle  = if obj.bgTitle then 'background-color:'+obj.bgTitle+';' else ''
		divClose = if obj.closable != false then "<div class=\"win-title-btn\" id=\"btn_close_ventana_#{id}\"></div>" else ""

		if !isNaN width then width = width+'px'
		else if width is 'auto' then width='calc(100% - 20px)'

		if !isNaN height then height = height+'px'
		else if height == 'auto' then height='calc(100% - 20px)'

		if id==''
			CONTWIDGET++
			id==CONTWIDGET

		$W("body").append("<div id=\"win-modal-#{id}\" class=\"win-modal\">
								<div id=\"#{id}\" style=\"width:#{width}; height:#{height}; #{bgBody} #{style}\" class=\"win-marco\">
									<div class=\"win-file-resize\" data-resize=\"top\" id=\"win-resize-top-#{id}\"></div>
									<div class=\"win-file-resize\" data-resize=\"bottom\" id=\"win-resize-bottom-#{id}\"></div>
									<div class=\"win-file-resize\" data-resize=\"left\" id=\"win-resize-left-#{id}\"></div>
									<div class=\"win-file-resize\" data-resize=\"right\" id=\"win-resize-right-#{id}\"></div>
									<header id=\"win-header-#{id}\">
										<div class=\"win-title\" id=\"win-title-#{id}\" style=\"#{bgTitle} #{titleStyle}\">
											<div class=\"win-title-txt\">#{title}</div>
											#{divClose}
										</div>
									</header>
									<section id=\"win-section-#{id}\" style=\"height:calc(100% - 27px);\" data-role=\"win-section\">#{html}</section>
								</div>
							</div>")


		if obj.closable != false then $W("#btn_close_ventana_#{id}").on('click',() -> _$.close() )

		widthVentana  = document.getElementById(id).offsetWidth
		heightVentana = document.getElementById(id).offsetHeight

		left = if body.offsetWidth < (widthVentana/2) then 0 else (body.offsetWidth - widthVentana)/2
		top  = if body.offsetHeight < (heightVentana/2) then 0 else (body.offsetHeight - heightVentana)/2

		$W("##{id}").css("left","#{left}px").css("top","#{top}px")

		# $W("#win-title-#{id}")[0].onmousedown = () -> _draggStart(id, document.getElementById("win-modal-#{id}"), event);
		# $W("#win-title-#{id}")[0].onmouseup   = () -> _draggStop(document.getElementById("win-modal-#{id}"));

		if obj.resize
			_resize($W("#win-resize-top-#{id}")[0])
			_resize($W("#win-resize-bottom-#{id}")[0])
			_resize($W("#win-resize-left-#{id}")[0])
			_resize($W("#win-resize-right-#{id}")[0])

		objAdd = []
		if obj.items then objAdd = obj.items
		if obj.autoLoad then objAdd.push({xtype:'body', scroll:scroll, scrollX:scrollX, scrollY:scrollY, autoLoad : obj.autoLoad})
		if obj.tabpanel then objAdd.unshift({xtype:'tabpanel', items:obj.tabpanel})
		if obj.tbar then objAdd.unshift({xtype:'tbar', items:obj.tbar})

		_router(objAdd, "win-section-#{id}")

		_$.close = () ->
			$W("\#win-modal-#{id}")[0].parentNode.removeChild($W("\#win-modal-#{id}")[0])

		_$

	# ---------------------------------------------------------------------------
	# Static Methods
	# Public Elements
	# ---------------------------------------------------------------------------

	# $W.aside = (obj) ->


	$W.TabPanel = (obj) ->

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id="win-tab-#{CONTWIDGET}"

		html = ""
		(obj.items).forEach(json,index,element) ->
			html += "<div id=\"#{id}\">#{json.title}</div>"

		"<div id=\"#{obj.id}\">#{html}</div>"

	$W.Add = (obj) ->
		# SI ES TBAR
		typeParent = document.getElementById(obj.idApply).getAttribute("data-role")
		if typeParent is "win-tbar"
			lastDiv = document.getElementById(obj.idApply).lastChild

			if lastDiv != null
				type = lastDiv.getAttribute("data-role")
				if type is "div-empty" then  lastDiv.parentNode.removeChild(lastDiv)

		objAdd = []
		if obj.items then objAdd = obj.items
		if obj.autoLoad then objAdd.push({xtype:'body', autoLoad:obj.autoLoad})
		if obj.tabpanel then objAdd.unshift({xtype:'tabpanel', items:obj.tabpanel})
		if obj.tbar then objAdd.unshift({xtype:'tbar', items:obj.tbar})

		_router(objAdd, obj.idApply)

	$W.Tbar = (obj) ->
		parent = document.getElementById("#{obj.idApply}")
		parent.className = "win-tbar"
		parent.setAttribute("data-role","win-tbar")

		_router(obj.items, obj.idApply)
		setTimeout () ->
			_resizeBody(document.getElementById(obj.idApply).parentNode.id)

	$W.Element = (id) ->

		@.hidden = () ->
			if ELEMENTS[id] == undefined then return

			$W('#'+id).style('display','none')
			_findResizeBody(id)
			ELEMENTS[id].hidden = true

		@.show = () ->
			if ELEMENTS[id] == undefined then return

			$W('#'+id).style('display','block')
			_findResizeBody(id)
			ELEMENTS[id].hidden = false

		@.enable = (index) ->
			if ELEMENTS[id] == undefined then return
			else if index == undefined and ELEMENTS[id].type == 'tabpanel'
				return document.querySelectorAll("##{id} [data-state=enable]") || {}

			else if ELEMENTS[id].type == 'tabpanel'
				if index>=0 then id = document.querySelector("##{id} [data-index=index-#{index}]").id
				else id = index

			document.getElementById(id).setAttribute('data-state','enable')
			ELEMENTS[id].disable = false

		@.disable = (index) ->
			if ELEMENTS[id] == undefined then return
			else if ELEMENTS[id].type == 'tab' then _disableTab(id)
			else if index == undefined and ELEMENTS[id].type == 'tabpanel'
				return document.querySelectorAll("##{id} [data-state=disable]") || {}

			else if ELEMENTS[id].type == 'tabpanel'
				if index>=0 then id = document.querySelector("##{id} [data-index=index-#{index}]").id
				else id = index

				_disableTab(id)

			document.getElementById(id).setAttribute('data-state','disable')
			ELEMENTS[id].disable = true

		@state = (index) ->
			state = undefined
			if ELEMENTS[id] == undefined then return state
			if ELEMENTS[id].type == 'tabpanel'
				if index>=0
					id = document.querySelector("##{id} [data-index=index-#{index}]").id
					state = ELEMENTS[id].disable
				else state = ELEMENTS[index].disable
			else state = ELEMENTS[id].disable

			return if state then 'disable' else 'enable'

		@.selected = (index) ->
			if ELEMENTS[id] == undefined then return
			else if ELEMENTS[id].type == 'tab' then _selectedTab(id)
			else if index == undefined
				return document.querySelector("##{id} [data-selected=true]") || undefined

			else if ELEMENTS[id].type == 'tabpanel'
				if index>=0
					idSelected = document.querySelector("##{id} [data-index=index-#{index}]").id
					_selectedTab(idSelected)
				else
					_selectedTab(index)
		this

	_disableTab = (id) ->
		document.getElementById("win-tab-body-#{id}").innerHTML = '';
		document.getElementById(id).setAttribute('data-load','false')
		document.getElementById(id).setAttribute('data-selected','false')

	$W.BlockBtn = (id) ->
		if ELEMENTS[id].disable then return

		$W.Element(id).disable()
		setTimeout(() ->
			if document.getElementById(id) then $W.Element(id).enable()
		, 1500)

	$W.Loading = (obj) ->
		if obj != 'off'

			if typeof obj is 'string'
				str = obj
				obj = {}
				if obj != 'on' then obj.text = str

			obj = obj or {}
			obj.type = 'loading'
			$W.Notify obj
		else
			_closeNotify()
			return

		@.close = () -> _closeNotify()

		true

	$W.Alert = (obj) ->
		_$    = @
		state = false
		if $W('[data-role=win-notify]')[0] then state = true

		# VALIDATE UNIC LOADING
		_closeNotify()
		if state and (!obj or obj == 'off') then  return false
		if typeof obj == 'string' then obj = { text: obj }

		obj        = obj or {}
		text       = obj.text or ''
		title      = obj.title or 'Aviso!'
		timeout    = obj.timeout or ''
		closable   = obj.closable or true
		elementDom = 'body'

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id="win-notify-#{CONTWIDGET}"

		objNotify =
			text     : text,
			title    : title,
			closable : closable,
			timeout  : timeout,

		_openNotify elementDom,id,'alert',objNotify

		_$.close = () -> _closeNotify()

		true

	$W.Notify = (obj) ->
		state    = false
		type     = 'notify'
		icon     = 'warning'
		text     = 'Aviso'
		loader   = ''
		timeout  = 1000
		iconSize = 100
		closable = false

		if $W('[data-role=win-notify]')[0] then state = true

		# VALIDATE UNIC LOADING
		_closeNotify()
		if state and (!obj or obj == 'off' or obj.type == 'loading') then  return false

		obj = obj or {}
		if obj.type == 'loading' or obj == 'loading'
			type     = 'loading'
			icon     = 'loading'
			text     = 'Load'
			loader   = 'default'
			timeout  = 0
			iconSize = 100
			closable = false
		else if obj.type == 'success' or obj == 'success'
			type     = 'success'
			icon     = 'success'
			text     = 'Ok!'
			loader   = ''
			timeout  = 1000
			iconSize = 100
			closable = false
		else if obj.type == 'fail' or obj == 'fail'
			type     = 'fail'
			icon     = 'fail'
			text     = 'Error'
			loader   = ''
			timeout  = 1000
			iconSize = 100
			closable = false

		icon       = obj.icon or icon
		text       = obj.text or text
		loader     = obj.loader or loader
		idApply    = obj.idApply or ''
		timeout    = obj.timeout or timeout
		iconSize   = obj.iconSize or iconSize
		closable   = obj.closable or closable
		elementDom = 'body'

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id="win-notify-#{CONTWIDGET}"

		if idApply != '' and document.getElementById(idApply) then elementDom = "##{idApply}"
		objNotify =
			icon     : icon,
			text     : text,
			timeout  : timeout,
			iconSize : iconSize,
			closable : closable,

		_openNotify elementDom, id, type, objNotify


	_closeNotify = () ->
		if $W('[data-role=win-notify]')[0]
			nodo = $W('[data-role=win-notify]')[0]
			nodo.parentNode.removeChild(nodo)

	_openNotify = (elementDom, id, type, obj) ->
		html = '';
		if type=='alert'
			if obj.closable then html += "<div class=\"win-notify-close\" style=\"position: absolute; right:0; width:50px;\">Close X</div>"
			html += "<div class=\"win-notify-label\" id=\"label-load-#{id}\">#{obj.title}<br><br>#{obj.text}</div>"

		else
			html = "<div class=\"win-notify-icon\" id=\"win-notify-icon-#{id}\" data-icon=\"#{obj.icon}\" style=\"#{obj.iconSize}\"></div>
					<div class=\"win-notify-label\" id=\"label-load-#{id}\">#{obj.text}</div>"



		$W(elementDom).append "<div class=\"win-modal\" id=\"#{id}\" data-role=\"win-notify\">
									<div class=\"win-modal-parent\" id=\"win-modal-parent-#{id}\">
										<div class=\"win-modal-content\">
											<div class=\"win-notify-ribete\" id=\"win-ribete-#{id}\">#{html}<div>
										</div>
									</div>
								</div>"

		if obj.closable then document.getElementById("win-ribete-#{id}").addEventListener('click',() -> _closeNotify() )
		if obj.timeout > 0 and obj.timeout != '' then setTimeout ( -> _closeNotify() ), obj.timeout

	$W.Confirm = (obj) ->
		width  = 250
		height = 120
		title  = obj.title or 'Confirm'
		text   = obj.text or ''
		text   += "<div class=\"content-btn\">
						<input type=\"button\" value=\"Aceptar\" onclick=\"$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode); #{obj.functionOK};\">
						<input type=\"button\" value=\"Cancelar\" onclick=\"$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode); return false;\">
					</div>"

		new $W.Window({
			width       : width,
			height      : height,
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


	$W.CtxMenu = (obj) ->
		document.getElementById(obj.idApply).oncontextmenu = (event) -> # Use document as opposed to window for IE8 compatibility
			$W.CtxMenuDom(obj,event)
			false

	$W.CtxMenuDom = (obj,event) ->
		event.preventDefault
		event.stopPropagation()

		if $W('[data-role=win-ctxmenu]')[0]
			_deleteCtxMenu()
			return false;

		window.addEventListener "contextmenu", (e) ->
			if $W('[data-role=win-ctxmenu]')[0]
				_deleteCtxMenu()
				e.preventDefault
				e.stopPropagation()
				return false

		window.addEventListener "click", (e) ->
			if $W('[data-role=win-ctxmenu]')[0]
				_deleteCtxMenu()
				e.preventDefault
				e.stopPropagation()
				return false

		html = ""
		if obj.items
			for own key, arr of obj.items
				html += "<div data-option=\"top-#{key}\">
							<div>#{arr.text}</div>
						</div>"

		event.target.innerHTML += "<div class=\"win-ctxmenu\" data-role=\"win-ctxmenu\" style=\"top:#{event.clientY}px; left:#{event.clientX}px;\">#{html}</div>"

		if obj.items
			setTimeout () ->
				for own key, arr of obj.items
					_menuOption event.target, key, arr.handler

	_menuOption = (element,key,handler) ->
		if element.querySelector("[data-option=top-#{key}]") && handler
			element.querySelector("[data-option=top-#{key}]").onclick = () ->
				if typeof(handler) == 'string' then eval(handler)
				else handler(this)

	# ---------------------------------------------------------------------------
	# Static Methods
	# Private Elements
	# ---------------------------------------------------------------------------
	###
	@method _deleteCtxMenu
	###
	_deleteCtxMenu = () ->
		array = document.querySelectorAll("[data-role=win-ctxmenu]")

		[].forEach.call array, (menu) ->
			menu.parentNode.removeChild(menu)


	###
	@method _router
	@param  arr child
	@param  obj ObjetoDom idParent
	###
	_router = (obj, idParent) ->

		if typeof(obj) == 'object'
			float = 'left'
			cont  = 0

			obj.forEach (json,index,element) ->

				switch json.xtype
					when 'button' then _button(json, idParent)
					when 'buttongroup' then _buttonGroup(json, idParent)
					when 'tbar' then _tbar(json, idParent)
					when 'panel' then _panel(json, idParent)
					when 'tabpanel' then _tabPanel(json, idParent)
					when 'tab' then _tab(json, idParent, cont)
					when 'tbtext' then _tbText(json, idParent)
					when 'body' then _body(json, idParent, 'router')
					else
						if json == '-'
							_separator(idParent)

						else if json == '--'
							_separatorHeight(idParent)

						else if json == '->'
							float = 'right'
							$W("##{idParent}").append('<div data-role="div-empty"></div>')
				cont++

			if float == 'left'
				$W("##{idParent}").append('<div data-role="div-empty"></div>')

	###
	@method _tabPanel
	@param  obj objectDom parent and config
	###
	_tabPanel = (obj, idParent) ->
		style  = obj.style or ''
		height = obj.height or 35
		bodyStyle = obj.bodyStyle or ""
		bodyHeight = obj.bodyHeight or "calc(100% - #{height})"

		if !isNaN width then width = width+'px'
		if !isNaN height then height = height+'px'

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id="win-tabpanel-#{CONTWIDGET}"

		$W("##{idParent}").append("<div id=\"#{id}\" class=\"win-tabpanel\" style=\"height:#{height}; #{style}\" data-role=\"win-tabpanel\"></div>
				<div id=\"win-tabpanel-body-#{id}\" class=\"win-tabpanel-body\" style=\"height:#{bodyHeight}; #{bodyStyle}\"></div>")

		ELEMENTS[id] = {idParent:idParent, items:obj.items, disable:false, type:'tabpanel'}

		if obj.items then _router(obj.items, id)

		heightTabPanel = document.getElementById(id).offsetHeight
		document.getElementById("win-tabpanel-body-#{id}").style.height = "calc(100% - #{heightTabPanel}px)"

		setTimeout () ->
			if $W.Element(id).selected() == undefined then $W.Element(id).selected(0)

	_tab = (obj, idParent, cont) ->
		style     = obj.style or ''
		title     = obj.title or ''
		hidden    = obj.hidden or false
		disable   = obj.disable or false
		iconCls   = obj.iconCls or ''
		scrollX   = obj.scrollX or false
		scrollY   = obj.scrollY or false
		selected  = obj.selected or false
		bodyStyle = obj.bodyStyle or ''

		dataState = if disable then 'disable' else 'enable'
		dataSelected = if selected then 'true' else 'false'

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id="win-tab-#{CONTWIDGET}"

		$W("##{idParent}").append("<div id=\"#{id}\"class=\"win-tab\" data-selected=\"#{dataSelected}\" data-state=\"#{dataState}\" data-index=\"index-#{cont}\" data-load=\"false\" style=\"#{style}\">
										<span class=\"icon-tab form\"></span>
										<span>#{title}</span>
									</div>")
		$W("#win-tabpanel-body-#{idParent}").append("<div id=\"win-tab-body-#{id}\" class=\"win-tab-body\" style=\"height:100%; overflow:auto; #{bodyStyle}\" data-selected=\"false\" data-index=\"index-#{cont}\"></div>")

		setTimeout () ->
			objAdd = []
			if obj.items then objAdd = obj.items
			if obj.autoLoad then objAdd.push({xtype:'body', scrollY:scrollY, scrollX:scrollX, autoLoad : obj.autoLoad})
			if obj.tbar then objAdd.unshift({xtype:'tbar', items : obj.tbar})

			ELEMENTS[id] = {idParent:idParent, items:objAdd, disable:disable, type:'tab'}

			document.getElementById(id).onclick = () ->
				_selectedTab(id)

			if selected is true then _selectedTab(id)

	_selectedTab = (id) ->

		if ELEMENTS[id].disable then return

		tab      = document.getElementById(id)
		items    = ELEMENTS[id].items
		idParent = ELEMENTS[id].idParent

		$W("##{idParent} > [data-selected=true]").attr "data-selected","false"
		tab.setAttribute "data-selected","true"

		$W("#win-tabpanel-body-#{idParent} > [data-selected=true]").attr "data-selected","false"
		$W("#win-tab-body-#{id}").attr "data-selected","true"

		# tab enable
		load = tab.getAttribute "data-load"
		if load is "false"
			tab.setAttribute "data-load","true"
			if items then _router(items, "win-tab-body-#{id}")

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
			title = "<div id=\"win-panel-title-#{id}\" style=\"height:20px; #{style}\" class=\"win-panel-title\">#{title}</div>"

		if !isNaN width then width = width+'px'
		if !isNaN height then height = height+'px'

		$W("##{idParent}").append("<div id=\"win-panel-#{id}\" class=\"win-panel\" style=\"width:#{width}; height:#{height}; #{style}\" data-role=\"win-panel\">
										#{title}
										<div id=\"win-panel-load-#{id}\" class=\"win-panel-load\" style=\"width:#{width}; height:#{height}; #{style}\">
											#{html}
										</div>
									</div>")

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

		$W("##{idParent}").append("<div id=\"#{id}\" class=\"win-tbar\" data-role=\"win-tbar\"></div>")
		if obj.items then _router(obj.items, "#{id}")

		setTimeout () ->
			_resizeBody(document.getElementById(id).parentNode.id)


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

		ELEMENTS[id] = { disable:false, hidden:hidden, type:'buttonGroup' }

		if title != ''
			title = "<div id=\"win-buttongroup-title-#{id}\" style=\"height:20px;\" class=\"win-buttongroup-title\">#{title}</div>"

		$W("##{idParent}").append("<div id=\"#{id}\" class=\"win-buttongroup\" style=\"width:#{width}; #{hidden} #{style}\" data-role=\"win-buttongroup\">
										#{title}
										<div id=\"win-buttongroup-body-#{id}\" class=\"win-buttongroup-body\" style=\"#{style}\"></div>
									</div>")
		if obj.items then _router(obj.items, "win-buttongroup-body-#{id}")


	###
	@method _button
	@param  obj objectDom parent and config
	###
	_button = (obj, idParent) ->

		text    = obj.text or ''
		cls     = obj.cls or 'save'
		align   = obj.align or 'top'
		width   = obj.width or 50
		disable = obj.disable or false
		hidden  = obj.hidden or false

		dataState   = if disable then 'disable' else 'enable'
		styleHidden = if hidden then 'display:none;' else ''

		if obj.id then id=obj.id
		else
			CONTWIDGET++
			id="win-btn-#{CONTWIDGET}"

		ELEMENTS[id] = { disable:disable, hidden:hidden, type:'button'}

		if !isNaN width then width = width+'px'

		$W("##{idParent}").append("<div id=\"#{id}\" class=\"win-btn\" style=\"width:#{width};\" data-role=\"win-btn\" data-state=\"#{dataState}\" style=\"#{styleHidden}\">
										<button class=\"#{cls}\">#{text}</button>
									</div>")
		_findResizeBody(id)

		if obj.handler
			setTimeout () ->
				document.querySelector("\##{idParent} > \##{id}").onclick = () ->
					if ELEMENTS[id].disable or ELEMENTS[id].hidden then return

					$W.BlockBtn id
					obj.handler this

	###
	@method _tbText
	@param  obj objectDom parent and config
	###
	_tbText = (obj, idParent) ->
		text  = obj.text or ''
		width = obj.width or 120
		style = obj.style or 'left'

		if width > 0 then width = width+'px'

		if obj.id
			id=obj.id
		else
			CONTWIDGET++
			id="win-tbtext-#{CONTWIDGET}"

		$W("##{idParent}").append("<div id=\"#{id}\" class=\"win-tbtext\" style=\"width:#{width}; #{style}\" data-role=\"win-tbtext\">#{text}</div>")

	###
	@method _separator
	@param  obj objectDom parent
	###
	_separator = (idParent) -> $W("##{idParent}").append("<div class=\"win-separator\" data-role=\"win-separator\">|</div>")

	###
	@method _separatorHeight
	@param  obj objectDom parent
	###
	_separatorHeight = (idParent) -> $W("##{idParent}").append("<div class=\"win-separatorHeight\" data-role=\"win-separatorHeight\"></div>")

	###
	@method _body
	@param  obj objectDom parent and config
	###
	_body = (obj, idParent, exec) ->
		items     = obj.items or ''
		html      = obj.html or ''
		style     = 'overflow:auto;'
		exec      = exec or 'json'
		clsBody   = obj.clsBody or ''
		bodyStyle = obj.bodyStyle or ''

		scroll    = if obj.scroll  is undefined then true else obj.scroll
		scrollX   = if obj.scrollX is undefined then true else obj.scrollX
		scrollY   = if obj.scrollY is undefined then true else obj.scrollY

		if !scrollY then style += 'overflow-y:hidden;'
		else if !scrollX then style += 'overflow-x:hidden;'

		if !scroll then style = 'overflow:hidden;'

		if obj.idApply then id=obj.idApply
		else if obj.id and exec=='router' then id=obj.id
		else
			CONTWIDGET++
			id="win-body-#{CONTWIDGET}"

		$W("##{idParent}").append("<div id=\"#{id}\" class=\"win-body #{clsBody}\" style=\"#{style} #{bodyStyle}\" data-role=\"win-body\">#{html}</div>")

		setTimeout () ->
			_resizeBody(idParent)

			if obj.autoLoad
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
				setTimeout () ->
					_resizeBody(body.id)

	_resizeBody = (idParent) ->

		if(!document.getElementById(idParent)) then return

		alto = 0
		body = ''
		arrayDiv = document.querySelectorAll('#'+idParent+' > [data-role]')

		[].forEach.call(arrayDiv,(element) ->
			role = element.getAttribute "data-role"


			if body != '' then return
			else if role is "win-body"
				body = element
				return

			alto += element.offsetHeight
		)

		height = if alto == 0 then '100%' else 'calc(100% - '+(alto+1)+'px)'

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