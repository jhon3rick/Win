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

	###
	# Widges ventana
	###
	Window: (obj) ->
		if typeof(obj) == 'undefined'
			console.warn('Para utiliza la propiedad Window debe enviar el objeto con los parametros\nConsulte la documentacion')
			return

		width       = obj.width or 300
		height      = obj.height or 300
		id          = obj.id or ''
		title       = obj.title or ''
		titleStyle  = obj.titleStyle or ''
		modal       = obj.modal or ''
		autoScroll  = obj.autoScroll or ''
		closable    = obj.closable or ''
		autoDestroy = obj.autoDestroy or ''
		autoLoad    = obj.autoLoad or ''
		html        = obj.html or ''
		drag        = obj.drag or ''
		resize      = if typeof(obj.resize)!= 'undefined' then obj.resize else true
		theme       = obj.theme or ''
		bodyStyle   = obj.bodyStyle or ''
		bodyColor   = obj.bodyColor or '#FFF'
		body        = document.querySelector('body')
		winModal    = document.createElement('div')
		win         = this
		clsBody     = if typeof(obj.type)!= 'undefined' and obj.type != '' then 'alert' else ''

		bgBody  = if obj.bgBody then 'background-color:'+obj.bgBody+';' else ''
		bgTitle = if obj.bgTitle then 'background-color:'+obj.bgTitle+';' else ''
		divResize = if resize==true or resize == '' then """<div class="win-div-resize" id="win_div_resize_#{id}"></div>""" else ''

		winModal.setAttribute("id","win_modal_#{id}")
		winModal.setAttribute("class","win-modal")

		left = if body.offsetWidth < width then 0 else (body.offsetWidth - width)/2
		top  = if body.offsetHeight < height then 0 else (body.offsetHeight - height)/2

		winModal.innerHTML = """<div style="width:#{width}; height:#{height}; top:#{top}; left:#{left}; #{bgBody} #{bodyStyle}" id="#{id}" class="win-marco">
									<div class="win-modal-parent" id="win_modal_window_#{id}"><div class="win-modal-content"><div class="win-loader-default" id="win_loader_#{id}"></div><div class="win-modal-label" id="label_cargando_#{id}"></div></div></div>
									<div class="win-title" id="win_title_#{id}" style="#{bgTitle} #{titleStyle}">
										<div class="win-title-txt">#{title}</div>
										<div class="win-title-btn" id="btn_close_ventana_#{id}" onclick="#{id}.close()"></div>
									</div>
									#{divResize}
									<div class="win-tbar" id="win_tbar_#{id}"></div>
									<div class="win-window-body #{clsBody}" id="win_window_#{id}">Contenido #{html}</div>
								</div>
								<script onload>alert(1);</script>"""

		body.appendChild(winModal)

		if typeof(obj.tbar) != 'undefined'
			obj.tbar.id = id
			Win.tbar(obj.tbar)
		else
			document.getElementById('win_tbar_'+id).parentNode.removeChild(document.getElementById('win_tbar_'+id))

		if typeof(obj.autoLoad) != 'undefined'
			Win.Ajax.load(document.querySelector('#win_window_'+id),obj.autoLoad)

		close: ()->
			document.getElementById("#{id}").parentNode.parentNode.removeChild(document.getElementById("#{id}").parentNode)

	tbar: (obj) ->
		if typeof(obj) == 'object'
			align  = ''
			objDiv = document.getElementById('win_tbar_'+obj.id)

			obj.forEach (json,index,element)->
				# console.log(json)
				if json.xtype == 'button'
					Win.button({ tbar:objDiv, align: align, json:json })

				else if json.xtype == 'buttongroup'
					json.tbar = objDiv
					Win.buttongroup(json)

				else if typeof(json.items) != 'undefined'
					json.items.tbar = objDiv
					Win.items(json.items)

				else if json.xtype == 'tbtext'
					Win.tbtext({ tbar:objDiv, align: align, json:json })

				else if json == '-'
					Win.separator({ tbar:objDiv, align: align })

				else if json == '->'
					align = 'right'

	items: (obj) ->
		if typeof(obj) == 'object'

			obj.forEach (json,index,element)->
				# console.log(json)
				if json.xtype == 'panel'
					json.tbar = obj.tbar
					Win.panel(json)

	buttongroup: (obj) ->

	button: (obj) ->
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

	panel: (obj) ->
		id = obj.id or ''
		width = obj.width or 'auto'
		height = obj.height or '100%'
		bodyStyle = obj.bodyStyle or ''


		panel = document.createElement('div')
		panel.setAttribute("id",id)
		panel.setAttribute("class","win-panel ")
		panel.setAttribute("style",'width:'+width+';height:'+height+';'+bodyStyle)
		(obj.tbar).appendChild(panel)

		if typeof(obj.autoLoad) != 'undefined'
			Win.Ajax.load(panel,obj.autoLoad)

		else if typeof(obj.html) != 'undefined'
			panel.innerHTML = obj.html


	tbtext: (obj) ->
		text     = document.createElement('div')
		clsAling = if obj.align == 'right' then 'widge-right' else ''

		text.setAttribute("id","win_tbtext_"+obj.json.id)
		text.setAttribute("class","win-tbtext "+clsAling)

		text.innerHTML = """<div>#{obj.json.text}</div>"""
		(obj.tbar).appendChild(text)

	separator: (obj) ->
		div      = document.createElement('div')
		clsAling = if obj.align == 'right' then 'widge-right' else ''

		div.setAttribute("class","win-separator "+clsAling)
		div.innerHTML = "<div>|</div>"
		obj.tbar.appendChild(div)

	###
	# Get Elements
	###
	getButton: (id) ->
		@hiden = (id) ->
			document.getElementById('id').style.display = 'none'

		@show = (id) ->
			document.getElementById('id').style.display = 'block';

		return id

	get: (element_id) ->
		load: (obj) ->
			dom_element = document.getElementById(element_id)
			Win.Ajax.load(dom_element,obj)

		element: ->
			return document.getElementById(element_id)

	loading: (obj) ->
		if typeof(obj)=='undefined'
			console.warn("Para hacer uso de la ventana modal debe enviar el objeto con los paramteros Win.loading(obj) \nParametro Obligatorios: id_ventana ,estado")
			return
		if typeof(obj.id_ventana)=='undefined' or typeof(obj.estado)=='undefined'
			console.warn('Funcion: Loading (Mostrar ventana modal)\nFaltan parametros en el objeto\nParametro Obligatorios: id_ventana ,estado')
			return
		if !document.getElementById('win_window_'+obj.id_ventana)
			console.warn('Funcion: Loading (Mostrar ventana modal)\nEl id de la ventana es incorrecto no se encuentra la ventana '+id_ventana)
			return
		mask = document.getElementById('win_modal_window_'+obj.id_ventana)

		text   = obj.text or 'Cargando...'
		loader = obj.loader or 'default'

		if obj.estado == 'on'
			document.getElementById('win_modal_window_'+obj.id_ventana).innerHTML= '<div class="win-modal-content"><div class="win-loader-default" id="win_loader_'+obj.id_ventana+'"></div><div class="win-modal-label" id="label_cargando_'+obj.id_ventana+'"></div></div>'
			mask.style.visibility = 'visible'
			document.getElementById('win_loader_'+obj.id_ventana).setAttribute('class','win-loader-'+loader)
			document.getElementById('label_cargando_'+obj.id_ventana).innerHTML = text
		else if obj.estado == 'off'
			iconos           = [];
			iconos['sucess'] = "data:image/png;base64,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";
			iconos['fail']   = "data:image/png;base64,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";
			iconos['warn']   = "data:image/png;base64,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";

			if obj
				icono        = iconos[obj.icono] || iconos['sucess']
				evento_icono = obj.evento_icono || ''
				texto        = obj.texto || 'Informacion Almacenada'
				duracion     = obj.duracion || '2000'
				estilo_texto = obj.estilo_texto || 'padding-top: 10px;font-size: 12px;color:#FFF;'
			else
				icono        = iconos.sucess
				evento_icono = ''
				texto        = 'Informacion Almacenada'
				duracion     = '2000'
				estilo_texto = 'padding-top: 10px;font-size: 12px;color:#FFF;'

			if duracion=='infinito'
				document.getElementById('win_modal_window_'+obj.id_ventana).innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='"+icono+"' onclick='"+evento_icono+"'; ><br><div class='win-modal-label label-finish' >"+texto+"</div></div></div>";
			else
				document.getElementById('win_modal_window_'+obj.id_ventana).innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='"+icono+"' onclick='"+evento_icono+"'; ><br><div class='win-modal-label label-finish' >"+texto+"</div></div></div>";
				setTimeout ( ->
				  mask.style.visibility = 'hidden'
				), duracion

	Alert: (obj) ->

		if typeof(obj) == 'undefined'
			console.warn('Para utiliza la propiedad alert debe enviar el objeto con los parametros\nConsulte la documentacion')
			return

		width     = 250
		height    = 140
		title = obj.title or 'Alert'
		text  = obj.text or 'ventana de alerta de win'
		text += '<div class="content-btn"><input type="button" value="Aceptar" onclick="Win_ventana_alert.close()"></div>'

		Win_ventana_alert = new Win.Window({
											width       : width,
											height      : height,
											id          : 'Win_ventana_alert',
											title       : title,
											html        : text,
											type        : 'alert',
											modal       : true,
											autoScroll  : true,
											closable    : true,
											autoDestroy : true,
											drag        : false,
											resize      : false
										});

	Confirm: (obj) ->

		if typeof(obj) == 'undefined'
			console.warn('Para utiliza el objeto alert debe enviar el objeto con los parametros\nConsulte la documentacion')
			return

		width     = 250
		height    = 140
		title = obj.title or 'Alert'
		text  = obj.text or 'ventana de alerta de win'

		Win.Window({
						width       : width,
						height      : height,
						id          : 'Win_ventana_msgbox',
						title       : title,
						modal       : true,
						autoScroll  : true,
						closable    : true,
						autoDestroy : true,
						html        : text
						drag        : false,
						resize      : false
					});





# @Win = Win

# module?.exports = Win
# return
