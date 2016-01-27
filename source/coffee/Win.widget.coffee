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

	IDGLOBAL  = ''
	CONTPANEL = 0
	CONTBODY  = 0
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
		win         = this
		clsBody     = if typeof(obj.type)!= 'undefined' and obj.type != '' then 'alert' else ''
		winModal    = document.createElement('div')

		IDGLOBAL = id

		bgBody   = if obj.bgBody then 'background-color:'+obj.bgBody+';' else ''
		bgTitle  = if obj.bgTitle then 'background-color:'+obj.bgTitle+';' else ''
		divClose = if obj.closable != false then "<div class=\"win-title-btn\" id=\"btn_close_ventana_#{id}\" onclick=\"#{id}.close()\"></div>" else ""

		left = if body.offsetWidth < width then 0 else (body.offsetWidth - width)/2
		top  = if body.offsetHeight < height then 0 else (body.offsetHeight - height)/2

		winModal.setAttribute("id","win-modal-#{id}")
		winModal.setAttribute("class","win-modal")

		winModal.innerHTML += "<div style=\"width:#{width}; height:#{height}; top:#{top}; left:#{left}; #{bgBody} #{bodyStyle}\" id=\"#{id}\" class=\"win-marco\">
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
									<section id=\"win-window-section-#{id}\"></section>
								</div>"

		body.appendChild(winModal)

		section = document.getElementById("win-window-section-#{id}");
		if typeof(obj.items) != 'undefined'
			_router(obj.items, section)

		if typeof(obj.autoLoad) != 'undefined'
			_body(obj, section)

		close: () ->
			$W("\#win-modal-#{id}")[0].parentNode.removeChild($W("\#win-modal-#{id}")[0])


	$W.tbar = (obj) ->
		IDGLOBAL = obj.idApply
		parent = document.getElementById("#{obj.idApply}")
		parent.className = "win-tbar"

		_router(obj.items, parent)

	$W.get = (element_id) ->
		load: (obj) ->
			dom_element = $W(element_id)[0]
			$W.Ajax.load(dom_element,obj)

		element: ->
			return $W(element_id)

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
			float  = 'left'

			obj.forEach (json,index,element) ->

				switch json.xtype
					when 'button' then _button(json,parent)
					when 'tbar' then _tbar(json, parent)

			if float == 'left'
				parent.innerHTML += '<div></div>'


	###
	@method _button
	@param  obj objectDom parent and config
	###
	_button = (obj, parent) ->
		text  = obj.text or ''
		id    = obj.id or ''
		cls   = obj.cls or ''
		width = obj.width or 50

		# boton = document.createElement('div')
		# boton.setAttribute("id",id)
		# boton.setAttribute("class","win-btn")
		# boton.innerHTML = "<button class=\"#{cls}\">#{text}</button>"

		# if(obj.width > 0) then boton.setAttribute("style","width: #{obj.width}px;")

		# # boton.onclick   = obj.handler
		# parent.appendChild(boton)
		# console.log(boton.id)

		# document.getElementById('btn_1').onclick = () -> alert(3)


		parent.innerHTML += "<div id=\"#{id}\" class=\"win-btn\" style=\"width:#{width};\">
								<button class=\"#{cls}\">#{text}</button>
							</div>"
		boton = parent.lastChild;
		if obj.handler then boton.onclick = () -> console.log(3)#('onclidsck', console.log(3))#boton.click(alert(2))



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