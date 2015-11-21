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

Win = do ->

	CLASS_SELECTOR    = /^\.([\w-]+)$/
	ID_SELECTOR       = /^#[\w\d-]+$/
	TAG_SELECTOR      = /^[\w-]+$/

	TABLE     = document.createElement('table')
	TABLE_ROW = document.createElement('tr')

	HTML_CONTAINERS =
		"tr"    : document.createElement("tbody")
		"tbody" : TABLE
		"thead" : TABLE
		"tfoot" : TABLE
		"td"    : TABLE_ROW
		"th"    : TABLE_ROW
		"div"   : document.createElement("div")

	$W = (selector) ->
		if CLASS_SELECTOR.test(selector)
			elements = document.getElementsByClassName selector.replace(".", "")
		else if TAG_SELECTOR.test(selector)
			elements = document.getElementsByTagName(selector)
		else if ID_SELECTOR.test(selector)
			elements = document.getElementById selector.replace("#", "")
			# unless elements then elements = []
		else
			elements = document.querySelectorAll selector
		return elements
		# if elements.nodeType then [elements] else Array::slice.call(elements)


	###
	# Widges ventana
	###
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

		winModal.setAttribute("id","win_modal_#{id}")
		winModal.setAttribute("class","win-modal")

		left = if body.offsetWidth < width then 0 else (body.offsetWidth - width)/2
		top  = if body.offsetHeight < height then 0 else (body.offsetHeight - height)/2

		winModal.innerHTML = """<div style="width:#{width}; height:#{height}; top:#{top}; left:#{left}; #{bgBody} #{bodyStyle}" id="#{id}" class="win-marco">
									<div class="win-modal-parent" id="win_modal_window_#{id}"><div class="win-modal-content"><div class="win-loader-default" id="win_loader_#{id}"></div><div class="win-modal-label" id="label_cargando_#{id}"></div></div></div>
									<div class="win-title" id="win_title_#{id}" style="#{bgTitle} #{titleStyle}">
										<div class="win-title-txt">#{title}</div>
										#{divClose}
									</div>
									#{divResize}
									<div class="win-tbar" id="win_tbar_#{id}"></div>
									<div class="win-window-body #{clsBody}" id="win_window_#{id}">#{html}</div>
								</div>
								<script onload>alert(1);</script>"""

		body.appendChild(winModal)

		if typeof(obj.tbar) != 'undefined'
			obj.tbar.id = id
			$W.tbar(obj.tbar)
		else
			$W('#win_tbar_'+id).parentNode.removeChild($W('#win_tbar_'+id))

		if typeof(obj.autoLoad) != 'undefined'
			$W.Ajax.load($W('#win_window_'+id),obj.autoLoad)

		close: ()->
			document.getElementById("#{id}").parentNode.parentNode.removeChild(document.getElementById("#{id}").parentNode)

	$W.tbar = (obj) ->
		if typeof(obj) == 'object'
			align  = ''
			objDiv = $W('#win_tbar_'+obj.id)

			obj.forEach (json,index,element)->
				# console.log(json)
				if json.xtype == 'button'
					$W.button({ tbar:objDiv, align: align, json:json })

				else if json.xtype == 'buttongroup'
					json.tbar = objDiv
					$W.buttongroup(json)

				else if typeof(json.items) != 'undefined'
					json.items.tbar = objDiv
					$W.items(json.items)

				else if json.xtype == 'tbtext'
					$W.tbtext({ tbar:objDiv, align: align, json:json })

				else if json == '-'
					$W.separator({ tbar:objDiv, align: align })

				else if json == '->'
					align = 'right'

	$W.items = (obj) ->
		if typeof(obj) == 'object'

			obj.forEach (json,index,element)->
				# console.log(json)
				if json.xtype == 'panel'
					json.tbar = obj.tbar
					$W.panel(json)

	$W.buttongroup = (obj) ->

	$W.button = (obj) ->
		text     = obj.json.text or ''
		id       = obj.json.id or ''
		cls      = obj.json.cls or ''
		clsAling = if obj.align == 'right' then 'widge-right' else ''

		boton = document.createElement('div')
		boton.setAttribute("id",id)
		boton.setAttribute("class","win-btn "+clsAling)

		boton.innerHTML = """<button class="#{cls}">#{text}</button>"""
		boton.onclick   = obj.json.handler

		(obj.tbar).appendChild(boton)

	$W.panel = (obj) ->
		id        = obj.id or ''
		width     = obj.width or 'auto'
		height    = obj.height or '100%'
		bodyStyle = obj.bodyStyle or ''

		panel = document.createElement('div')
		panel.setAttribute("id",id)
		panel.setAttribute("class","win-panel ")
		panel.setAttribute("style",'width:'+width+';height:'+height+';'+bodyStyle)
		(obj.tbar).appendChild(panel)

		if typeof(obj.autoLoad) != 'undefined'
			$W.Ajax.load(panel,obj.autoLoad)

		else if typeof(obj.html) != 'undefined'
			panel.innerHTML = obj.html

	$W.tbtext = (obj) ->
		text     = document.createElement('div')
		clsAling = if obj.align == 'right' then 'widge-right' else ''

		text.setAttribute("id","win_tbtext_"+obj.json.id)
		text.setAttribute("class","win-tbtext "+clsAling)

		text.innerHTML = """<div>#{obj.json.text}</div>"""
		(obj.tbar).appendChild(text)

	$W.separator = (obj) ->
		div      = document.createElement('div')
		clsAling = if obj.align == 'right' then 'widge-right' else ''

		div.setAttribute("class","win-separator "+clsAling)
		div.innerHTML = "<div>|</div>"
		obj.tbar.appendChild(div)

	###
	# Get Elements
	###
	$W.getButton = (id) ->
		@hiden = (id) ->
			$W('#id').style.display = 'none'

		@show = (id) ->
			$W('#id').style.display = 'block';

		return id

	$W.get = (element_id) ->
		load: (obj) ->
			dom_element = $W(element_id)
			$W.Ajax.load(dom_element,obj)

		element: ->
			return $W(element_id)

	$W.loading = (obj) ->

		if typeof(obj.id_ventana)=='undefined' or typeof(obj.estado)=='undefined'
			console.warn('Funcion: Loading (Mostrar ventana modal)\nFaltan parametros en el objeto\nParametro Obligatorios: id_ventana ,estado')
			return
		if !$W('#win_window_'+obj.id_ventana)
			console.warn('Funcion: Loading (Mostrar ventana modal)\nEl id de la ventana es incorrecto no se encuentra la ventana '+id_ventana)
			return
		mask = $W('#win_modal_window_'+obj.id_ventana)

		text   = obj.text or 'Cargando...'
		loader = obj.loader or 'default'

		if obj.estado == 'on'
			$W('#win_modal_window_'+obj.id_ventana).innerHTML= '<div class="win-modal-content"><div class="win-loader-default" id="win_loader_'+obj.id_ventana+'"></div><div class="win-modal-label" id="label_cargando_'+obj.id_ventana+'"></div></div>'
			mask.style.visibility = 'visible'
			$W('#win_loader_'+obj.id_ventana).setAttribute('class','win-loader-'+loader)
			$W('#label_cargando_'+obj.id_ventana).innerHTML = text
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
				$W('#win_modal_window_'+obj.id_ventana).innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='"+icono+"' onclick='"+evento_icono+"'; ><br><div class='win-modal-label label-finish' >"+texto+"</div></div></div>";
			else
				$W('#win_modal_window_'+obj.id_ventana).innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='"+icono+"' onclick='"+evento_icono+"'; ><br><div class='win-modal-label label-finish' >"+texto+"</div></div></div>";
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
		text   += '<div class="content-btn"><input type="button" value="Aceptar" onclick="document.getElementById(\'Win_ventana_alert\').parentNode.parentNode.removeChild(document.getElementById(\'Win_ventana_alert\').parentNode)"></div>'

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

		if typeof(obj) == 'undefined'
			console.warn('Para utiliza la propiedad alert debe enviar el objeto con los parametros\nConsulte la documentacion')
			return

		width  = 250
		height = 120
		title  = obj.title or 'Confirm'
		text   = obj.text or ''
		text   += '<div class="content-btn"><input type="button" value="Aceptar" onclick="document.getElementById(\'Win_ventana_confirm\').parentNode.parentNode.removeChild(document.getElementById(\'Win_ventana_confirm\').parentNode);'+obj.functionOK+';"> <input type="button" value="Cancelar" onclick="document.getElementById(\'Win_ventana_confirm\').parentNode.parentNode.removeChild(document.getElementById(\'Win_ventana_confirm\').parentNode);return false;"></div>'

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



	$W.version = "0.0.1"

	$W


# @Win = Win

@Win = @$W = Win

# module?.exports = Win

# module?.exports = Win
# return
