###
# Request XHR
###

Win.Ajax = do ->
	request: (obj) ->

		parametros = ''

		if typeof(obj)=='undefined'
			console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.request(obj) \nConsulte la documentacion del proyecto")
			return

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
		if typeof(obj)=='undefined'
			console.warn("Para hacer uso del ajax load debe enviar el objeto con los paramteros Win.Ajax.load(DOM_ELEMENT,obj) \nConsulte la documentacion del proyecto")
			return

		if typeof(obj.id_ventana)=='undefined'
			console.warn("Debe enviar el paramtro id_ventana, para poder mostrar el loading")
			return


		parametros = ''
		tagScript  = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)'

		if typeof(obj.params)!='undefined'
			for value of obj.params
 				parametros+= if parametros=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

		obj_loading = {
						id_ventana : obj.id_ventana,
						estado     : 'on'
					}

		Win.loading(obj_loading)

		xhr     = new XMLHttpRequest
		bodyXhr = obj.url+'?'+parametros
		method  = obj.method || 'POST'

		xhr.open(method,bodyXhr, true)
		xhr.onreadystatechange=() ->
			if xhr.readyState==4
				response = xhr.responseText
				html = extract_script(response)
				dom_element.innerHTML = html
				eval_script(response)
				obj_loading.estado = 'off'
				Win.loading(obj_loading)


		xhr.send(null)

		extract_script = (string) ->
			SearchExp = new RegExp(tagScript, 'img')
			return string.replace(SearchExp, '')

		eval_script = (string) ->
			scripts = (string.match(new RegExp(tagScript, 'img')) || [])
			script = ''
			scripts.map (script_map) ->
				script+=(script_map.match(new RegExp(tagScript, 'im')) || ['', ''])[1]
			eval(script)



	# 	contenido = 'cargando...'
	# 	parentModal = document.createElement("div")
	# 	parentModal.innerHTML = '<div id="contenido_modal_load" class="win-contenido-modal-load">'+contenido+'</div>'
	# 	parentModal.setAttribute("id", "div_contenedor_modal")
	# 	document.body.appendChild(parentModal)
	# 	document.getElementById("div_contenedor_modal").className = "win-modal"
	# 	document.getElementById('div_contenedor_modal').parentNode.style.display = 'table'

