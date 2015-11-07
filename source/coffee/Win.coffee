###
# Win.js
#
# @namespeace Win
#
# @version 0.1
# @author Jonatan Herran  || @jonatan2874
#
###


"use strict"

Win = do ->

	Window: (obj) ->
		width           = obj.width || 200
		height          = obj.height || 200
		id              = obj.id || ''
		title           = obj.title || ''
		titleStyle      = obj.titleStyle || ''
		modal           = obj.modal || ''
		autoScroll      = obj.autoScroll || ''
		closable        = obj.closable || ''
		autoDestroy     = obj.autoDestroy || ''
		autoLoad        = obj.autoLoad || ''
		drag            = obj.drag || ''
		resize          = obj.resize || ''
		theme           = obj.theme || ''
		bodyStyle       = obj.bodyStyle || ''
		bodyColor       = obj.bodyColor || '#FFF'
		backgroundTitle = obj.backgroundTitle || '#23232E'
		body            = document.querySelector('body')
		winModal        = document.createElement('div')
		win 			= this

		winModal.setAttribute("id","win_modal_#{id}")
		winModal.setAttribute("class","win-modal")
		# winModal.style.display='none'


		if body.offsetWidth < width
			width = body.offsetWidth
		if body.offsetHeight < height
			height = body.offsetHeight

		left = if body.offsetWidth < width then 0 else (body.offsetWidth - width)/2
		top  = if body.offsetHeight < height then 0 else (body.offsetHeight - height)/2


		winModal.innerHTML = """<div style="width:#{width}; height:#{height}; top:#{top}; left:#{left}; background-color:#{bodyColor}; #{bodyStyle};" id="#{id}">
									<div class="win-title" id="win_title_#{id}" style="background-color:#{backgroundTitle}; #{titleStyle}">
										<div class="win-title-txt">#{title}</div>
										<div class="win-title-btn" id="btn_close_ventana_#{id}" onclick="document.querySelector('body').removeChild(document.querySelector('#win_modal_#{id}'));"></div>
									</div>
									<div class="win-tbar" id="win_tbar_#{id}"></div>
									<div class="win-window-body" id="win_window_#{id}">Contenido</div>
									<div class="win-div-resize" id="win_div_resize_#{id}"></div>
								</div>
								<script onload>alert(1);</script>"""

		body.appendChild(winModal);

		obj.tbar.id = id
		tbar = Win.tbar(obj.tbar)

		obj.autoLoad.id = id
		console.log(Win)
		return
		# Win.autoLoad(obj.autoLoad)


	tbar: (obj) ->

		if(typeof(obj) == 'object')
			objDiv = document.getElementById('win_tbar_'+obj.id);

			obj.forEach((elemento,index,element)->

				if elemento.xtype == 'button'
					elemento.tbar = objDiv
					Win.button(elemento)
				else if elemento.xtype == 'buttongroup'
					elemento.tbar = objDiv
					Win.buttongroup(elemento)
				else if elemento == '-'
					Win.separator(objDiv)
			)
		return

	button: (obj) ->
		text = obj.text || ''
		id   = obj.id || ''

		boton = document.createElement('div')
		boton.setAttribute("id",id)
		boton.setAttribute("class","win-btn")

		boton.innerHTML = """<button>#{text}</button>"""
		boton.onclick   = obj.handler

		obj.tbar.appendChild(boton);

	getButton: (id) ->
		@hiden = (id) ->
			document.getElementById('id').style.display = 'none';
			return

		@show = (id) ->
			document.getElementById('id').style.display = 'block';

		return id

	separator: (tbar)->
		tbar.innerHTML += """<div class="win-separator">|</div>"""

	buttongroup: (obj) ->

	autoLoad: (obj) ->

		xhr     = new XMLHttpRequest
		bodyXhr = 'bd.php?nameFileUpload=prueba&opc=cancelUploadFile'

		xhr.open('POST',bodyXhr, true);
		xhr.onreadystatechange=() ->
			if xhr.readyState==4
				response = xhr.responseText;
				document.getElementById('win_window_'+obj.id).innerHTML = response
				if response=='true'
					# console.log('true')
					return
				else
					return

		xhr.send(null);

	Ajax: do ->
		request: (obj) ->
			if typeof(obj)=='undefined'
				console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.request(obj) \nConsulte la documentacion del proyecto");
				return;

			if typeof(obj.params)!='undefined'
				parametros = '';
				for value of obj.params
					#console.log(value+" : "+obj.params[value])
     				parametros+= if parametros=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

			xhr     = new XMLHttpRequest
			bodyXhr = obj.url+'?'+parametros;
			method  = obj.method || 'POST'


			xhr.open(method,bodyXhr, true);
			xhr.onreadystatechange=() ->
				if xhr.readyState==4
					response = xhr.responseText
					return obj.success(response,xhr)
				else
					return obj.failure(xhr)

			xhr.send(null);

		load: (dom_element,obj) ->

			tagScript = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)'
			if typeof(obj)=='undefined'
				console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.load(obj) \nConsulte la documentacion del proyecto");
				return;

			if typeof(obj.params)!='undefined'
				parametros = '';
				for value of obj.params
 					parametros+= if parametros=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]
 					# console.log(value+" : "+obj.params[value])

			xhr     = new XMLHttpRequest
			bodyXhr = obj.url+'?'+parametros;
			method  = obj.method || 'POST'


			xhr.open(method,bodyXhr, true);
			xhr.onreadystatechange=() ->
				if xhr.readyState==4
					response = xhr.responseText
					# return obj.success(response,xhr)
				# else
					# return obj.failure(xhr)

			xhr.send(null);

	get: (element_id) ->

		load: (obj) ->
			# console.log("in");
			dom_element = document.getElementById(element_id)
			Win.Ajax.load(dom_element,obj)
		element: ->
			return document.getElementById(element_id);


		# return dom_element

		# Ext.get('').load({
		# 	url     : '.php',
		# 	scripts : true,
		# 	nocache : true,
		# 	params  :
		# 	{
		# 		var1 : 'var1',
		# 		var2 : 'var2',
		# 	}
		# });


@Win = Win
# @Win.getButton = Win.getButton

# return

# module?.exports = Win

###
# Validacion campos formulario
#
# tecla==8 		//BACKSPACE
# tecla==9 		//TAB
# tecla==0 		//TAB
# tecla==13 	//ENTER
#
###
Win.form = do->
	intField: (obj) ->
		document.getElementById(obj.applyTo).className += " win-input-number";

		document.getElementById(obj.applyTo).onkeypress = (event)->
			return Win.form.validateIntField({ event:event, eventType:'keypress', input:this })

		document.getElementById(obj.applyTo).onchange = (event)->
			return Win.form.validateIntField({ event:event, eventType:'change', input:this })

	doubleField: (obj) ->
		document.getElementById(obj.applyTo).className += " win-input-number";

		document.getElementById(obj.applyTo).onkeypress = (event)->
			return Win.form.validateDoubleField({ event:event, eventType:'keypress', input:this })

		document.getElementById(obj.applyTo).onchange = (event)->
			return Win.form.validateDoubleField({ event:event, eventType:'change', input:this })

	textField: (obj) ->
		document.getElementById(obj.applyTo).onkeyup = (event)->
			return Win.form.validateTextField({ event:event, eventType:'keyup', input:this, type:obj.type })

		document.getElementById(obj.applyTo).onchange = (event)->
			return Win.form.validateTextField({ event:event, eventType:'change', input:this, type:obj.type })

	emailField: (obj) ->
		document.getElementById(obj.applyTo).onchange = (event)->
			return Win.form.validateEmailField({ event:event, input:this })

	globalField: (obj) ->

	validateIntField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keypress'
			return (/\d/).test(String.fromCharCode(tecla))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')

	validateDoubleField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keypress'
			return (/[\d.]/).test(String.fromCharCode(tecla))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')
			console.log(!!(obj.input.value).toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/))
			validate = !!(obj.input.value).toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/)
			if !validate
				arrayValue = (obj.input.value).split(".")
				obj.input.value = arrayValue[0]+'.'+arrayValue[1]

	validateTextField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keyup'
			if obj.type=='uppercase'
				obj.input.value =obj.input.value.toUpperCase()
			else if obj.type=='lowercase'
				obj.input.value = obj.input.value.toLowerCase()
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[\#\-\"\']/g,'')

	validateEmailField: (obj) ->
		validate = !!(obj.input.value).toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i)
		if !validate
			obj.input.value=""
			obj.input.focus()


