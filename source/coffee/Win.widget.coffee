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
		closable      = if typeof(obj.closable)!= 'undefined' then obj.closable else true
		autoDestroy = obj.autoDestroy or ''
		autoLoad    = obj.autoLoad or ''
		html        = obj.html or ''
		drag        = obj.drag or ''
		resize      = if typeof(obj.resize)!= 'undefined' then obj.resize else true
		theme       = obj.theme or ''
		bodyStyle   = obj.bodyStyle or ''
		bodyColor   = obj.bodyColor or '#FFF'
		body        = $W('body')[0]
		winModal    = document.createElement('div')
		win         = this
		clsBody     = if typeof(obj.type)!= 'undefined' and obj.type != '' then 'alert' else ''

		bgBody    = if obj.bgBody then 'background-color:'+obj.bgBody+';' else ''
		bgTitle   = if obj.bgTitle then 'background-color:'+obj.bgTitle+';' else ''
		divClose  = if resize==true or resize == '' then """<div class="win-title-btn" id="btn_close_ventana_#{id}" onclick="#{id}.close()"></div>""" else ''
		divResize = if resize==true or resize == '' then """<div class="win-div-resize" id="win_div_resize_#{id}"></div>""" else ''

		winModal.setAttribute("id","win-modal-#{id}")
		winModal.setAttribute("class","win-modal")

		left = if body.offsetWidth < width then 0 else (body.offsetWidth - width)/2
		top  = if body.offsetHeight < height then 0 else (body.offsetHeight - height)/2

		winModal.innerHTML = """<div style="width:#{width}; height:#{height}; top:#{top}; left:#{left}; #{bgBody} #{bodyStyle}" id="#{id}" class="win-marco">
									<div class="win-modal-parent" id="win-modal-window_#{id}">
										<div class="win-modal-content">
											<div class="win-loader-default" id="win_loader_#{id}"></div>
											<div class="win-modal-label" id="label_cargando_#{id}"></div>
										</div>
									</div>
									<header class="win-title" id="win_title_#{id}" style="#{bgTitle} #{titleStyle}">
										<div class="win-title-txt">#{title}</div>
										#{divClose}
									</header>
									#{divResize}
									<div class="win-tbar" id="win_tbar_#{id}"></div>
									<div class="win-window-body #{clsBody}" id="win_window_#{id}">#{html}</div>
								</div>"""

		body.appendChild(winModal)

		if typeof(obj.tbar) != 'undefined'
			obj.tbar.applyTo = id
			$W.tbar(obj.tbar)
		# else
		# 	$W('#'+id)[0].removeChild($W('#win_tbar_'+id)[0])

		if typeof(obj.autoLoad) != 'undefined'
			$W.Ajax.load($W('#win_window_'+id)[0],obj.autoLoad)

		close: ()->
			$W("\#win-modal-#{id}")[0].parentNode.removeChild($W("\#win-modal-#{id}")[0])

	$W.aside = (obj) ->


	$W.tabpanel = (obj) ->

	$W.tbar = (obj) ->
		tbar = $W('#win_tbar_'+obj.applyTo)[0]
		_router(obj, tbar)


	# ---------------------------------------------------------------------------
	# Static Methods
	# Get Elements
	# ---------------------------------------------------------------------------
	$W.getButton = (id) ->
		@hiden = (id) ->
			$W('#id').style('display','none')

		@show = (id) ->
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
		if !$W('#win_window_'+obj.id_ventana)[0]
			console.warn('Funcion: Loading (Mostrar ventana modal)\nEl id de la ventana es incorrecto no se encuentra la ventana '+id_ventana)
			return
		mask = $W('#win-modal-window_'+obj.id_ventana)[0]

		text   = obj.text or 'Cargando...'
		loader = obj.loader or 'default'

		if obj.estado == 'on'
			$W('#win-modal-window_'+obj.id_ventana)[0].innerHTML= '<div class="win-modal-content"><div class="win-loader-default" id="win_loader_'+obj.id_ventana+'"></div><div class="win-modal-label" id="label_cargando_'+obj.id_ventana+'"></div></div>'
			mask.style.visibility = 'visible'
			$W('#win_loader_'+obj.id_ventana)[0].setAttribute('class','win-loader-'+loader)
			$W('#label_cargando_'+obj.id_ventana)[0].innerHTML = text
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
				estilo_texto = 'padding-top: 10px;font-size: 12px;color:#FFF;'

			if duracion=='infinito'
				$W('#win-modal-window_'+obj.id_ventana)[0].innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='"+icono+"' onclick='"+evento_icono+"'; ><br><div class='win-modal-label label-finish' >"+texto+"</div></div></div>";
			else
				$W('#win-modal-window_'+obj.id_ventana)[0].innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='"+icono+"' onclick='"+evento_icono+"'; ><br><div class='win-modal-label label-finish' >"+texto+"</div></div></div>";
				setTimeout ( ->
				  mask.style.visibility = 'hidden'
				), duracion

	$W.Alert = (obj) ->

		if typeof(obj) == 'undefined'
			console.warn('Para utiliza la propiedad alert debe enviar el objeto con los parametros\nConsulte la documentacion')
			return

		width  = 250
		height = 120
		title  = obj.title or 'Alert'
		text   = obj.text or ''
		text   += """<div class="content-btn"><input type="button" value="Aceptar" onclick="$W('#Win_ventana_alert')[0].parentNode.parentNode.removeChild($W('#Win_ventana_alert')[0].parentNode)"></div>"""

		Win_ventana_alert = new $W.Window({
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
		text   += """<div class="content-btn">
						<input type="button" value="Aceptar" onclick="$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode);'+obj.functionOK+';">
						<input type="button" value="Cancelar" onclick="$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode);return false;">
					</div>"""

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

				if json.xtype == 'button'
					json.parent = parent
					_button(json)

				else if json.xtype == 'buttongroup'
					json.parent = parent
					$W.buttongroup(json)

				else if json.xtype == 'panel'
					json.parent = parent
					_panel(json)

				else if json.xtype == 'tbtext'
					json.align  = align
					json.parent = parent
					_tbtext(json)

				else if json == '-'
					_separator(parent)

				else if json == '--'
					_separatorHeight(parent)

				else if json == '->'
					align = 'right'
					div = document.createElement('div')
					(parent).appendChild(div)

			if align == ''
				div = document.createElement('div')
				(parent).appendChild(div)

	###
		@method _separator
		@param  obj objectDom parent
	###
	_separator = (obj) ->
		div = document.createElement('div')
		div.setAttribute("class","win-separator")
		div.innerHTML = "|"
		obj.appendChild(div)

	###
		@method _separatorHeight
		@param  obj objectDom parent
	###
	_separatorHeight = (obj) ->
		div = document.createElement('div')
		div.setAttribute("class","win-separatorHeight")
		obj.appendChild(div)

		$W.buttongroup = (obj) ->

	###
		@method _button
		@param  obj objectDom parent and config
	###
	_button = (obj) ->
		text = obj.text or ''
		id   = obj.id or ''
		cls  = obj.cls or ''

		boton = document.createElement('div')
		boton.setAttribute("id",id)
		boton.setAttribute("class","win-btn")

		if(obj.width > 0) then boton.setAttribute("style","width: #{obj.width}px;")

		boton.innerHTML = """<button class="#{cls}">#{text}</button>"""
		boton.onclick   = obj.handler

		obj.parent.appendChild(boton)

	###
		@method _panel
		@param  obj objectDom parent and config
	###
	_panel = (obj) ->
		id        = obj.id or ''
		width     = obj.width or 'auto'
		height    = obj.height or 'auto'
		bodyStyle = obj.bodyStyle or ''

		panel = document.createElement('div')
		panel.setAttribute("id",id)
		panel.setAttribute("class","win-panel ")
		panel.setAttribute("style",'width:'+width+';height:'+height+';'+bodyStyle)
		(obj.parent).appendChild(panel)

		if typeof(obj.autoLoad) != 'undefined'
			$W.Ajax.load(panel,obj.autoLoad)

		else if typeof(obj.html) != 'undefined'
			panel.innerHTML = obj.html

	###
		@method _tbtext
		@param  obj objectDom parent and config
	###
	_tbtext = (obj) ->
		text = document.createElement('div')

		text.setAttribute("id","win_tbtext_"+obj.id)
		text.setAttribute("class","win-tbtext ")

		if(obj.align == 'right') then text.setAttribute("style","text-align:right;")

		text.innerHTML = obj.text
		(obj.parent).appendChild(text)

