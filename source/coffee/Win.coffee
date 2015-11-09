###
# Win.js
# @namespeace Win
#
# @version 0.1
# @author Jhon Marroquin  || @jhon3rick
# @author Jonatan Herran  || @jonatan2874
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

		obj.autoLoad.id = id
		Win.autoLoad(obj.autoLoad)

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

	###
	# Request XHR
	###
	autoLoad: (obj) ->
		xhr     = new XMLHttpRequest
		bodyXhr = 'bd.php?nameFileUpload=prueba&opc=cancelUploadFile'

		xhr.open('POST',bodyXhr, true)
		xhr.onreadystatechange=() ->
			if xhr.readyState==4
				response = xhr.responseText;
				document.getElementById('win_window_'+obj.id).innerHTML = response

				if response=='true'
				else

		xhr.send(null);

	Ajax: do ->
		request: (obj) ->

			parametros = ''

			if typeof(obj)=='undefined'
				console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.request(obj) \nConsulte la documentacion del proyecto");

			if typeof(obj.params)!='undefined'
				for value of obj.params
 					parametros += if parametros=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

			xhr     = new XMLHttpRequest
			bodyXhr = obj.url+'?'+parametros
			method  = obj.method or 'POST'

			xhr.open(method,bodyXhr, true)
			xhr.onreadystatechange=() ->
				if xhr.readyState==4
					response = xhr.responseText
					return obj.success(response,xhr)
				else
					return obj.failure(xhr)
			xhr.send(null)

		load: (dom_element,obj) ->
			parametros = ''
			tagScript  = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)'

			if typeof(obj)=='undefined'
				console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.load(obj) \nConsulte la documentacion del proyecto");

			if typeof(obj.params)!='undefined'
				for value of obj.params
     				parametros+= if parametros=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

			xhr     = new XMLHttpRequest
			bodyXhr = obj.url+'?'+parametros;
			method  = obj.method || 'POST'

			xhr.open(method,bodyXhr, true);
			xhr.onreadystatechange=() ->
				if xhr.readyState==4
					response = xhr.responseText
					html = extract_script(response)
					dom_element.innerHTML = html
					eval_script(response)

			xhr.send(null);

			extract_script = (string) ->
				SearchExp = new RegExp(tagScript, 'img')
				return string.replace(SearchExp, '')

			eval_script = (string) ->
				scripts = (string.match(new RegExp(tagScript, 'img')) || [])
				script = ''
				scripts.map (script_map) ->
					script+=(script_map.match(new RegExp(tagScript, 'im')) || ['', ''])[1];
				eval(script)

	get: (element_id) ->
		load: (obj) ->
			dom_element = document.getElementById(element_id)
			Win.Ajax.load(dom_element,obj)

		element: ->
			return document.getElementById(element_id)

# @Win = Win

# module?.exports = Win
# return
