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
		width           = obj.width or 300
		height          = obj.height or 300
		id              = obj.id or ''
		title           = obj.title or ''
		titleStyle      = obj.titleStyle or ''
		modal           = obj.modal or ''
		autoScroll      = obj.autoScroll or ''
		closable        = obj.closable or ''
		autoDestroy     = obj.autoDestroy or ''
		autoLoad        = obj.autoLoad or ''
		drag            = obj.drag or ''
		resize          = obj.resize or ''
		theme           = obj.theme or ''
		bodyStyle       = obj.bodyStyle or ''
		bodyColor       = obj.bodyColor or '#FFF'
		body            = document.querySelector('body')
		winModal        = document.createElement('div')
		win 			= this

		bgBody  = if obj.bgBody then 'background-color:'+obj.bgBody+';' else ''
		bgTitle = if obj.bgTitle then 'background-color:'+obj.bgTitle+';' else ''

		winModal.setAttribute("id","win_modal_#{id}")
		winModal.setAttribute("class","win-modal")

		left = if body.offsetWidth < width then 0 else (body.offsetWidth - width)/2
		top  = if body.offsetHeight < height then 0 else (body.offsetHeight - height)/2

		winModal.innerHTML = """<div style="width:#{width}; height:#{height}; top:#{top}; left:#{left}; #{bgBody} #{bodyStyle}" id="#{id}" class="win-marco">
									<div class="win-modal-parent" id="win_modal_window_#{id}"><div class="win-modal-content"><div class="win-loader-default" id="win_loader_#{id}"></div><div class="win-modal-label" id="label_cargando_#{id}"></div></div></div>
									<div class="win-title" id="win_title_#{id}" style="#{bgTitle} #{titleStyle}">
										<div class="win-title-txt">#{title}</div>
										<div class="win-title-btn" id="btn_close_ventana_#{id}" onclick="document.querySelector('body').removeChild(document.querySelector('#win_modal_#{id}'));"></div>
									</div>
									<div class="win-div-resize" id="win_div_resize_#{id}"></div>
									<div class="win-tbar" id="win_tbar_#{id}"></div>
									<div class="win-window-body" id="win_window_#{id}">Contenido</div>
								</div>
								<script onload>alert(1);</script>"""

		body.appendChild(winModal)

		obj.tbar.id = id
		Win.tbar(obj.tbar)
		obj.autoLoad.id_ventana = id
		Win.Ajax.load(document.querySelector('#win_window_'+id),obj.autoLoad)

	tbar: (obj) ->
		if typeof(obj) == 'object'
			align  = ''
			objDiv = document.getElementById('win_tbar_'+obj.id)

			obj.forEach (json,index,element)->
				if json.xtype == 'button'
					Win.button({ tbar:objDiv, align: align, json:json })

				else if json.xtype == 'buttongroup'
					json.tbar = objDiv
					Win.buttongroup(json)

				else if json.xtype == 'tbtext'
					Win.tbtext({ tbar:objDiv, align: align, json:json })

				else if json == '-'
					Win.separator({ tbar:objDiv, align: align })

				else if json == '->'
					align = 'right'

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

		text = obj.text or 'Cargando'
		loader = obj.loader or 'default'

		if obj.estado == 'on'
			mask.style.visibility = 'visible'
			document.getElementById('win_loader_'+obj.id_ventana).setAttribute('class','win-loader-'+loader)
			document.getElementById('label_cargando_'+obj.id_ventana).innerHTML = text
		else if obj.estado == 'off'
			mask.style.visibility = 'hidden'





# @Win = Win

# module?.exports = Win
# return
