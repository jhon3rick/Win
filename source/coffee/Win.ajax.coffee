###
# Request XHR
###

$W.Ajax = do ->
	request: (obj) ->

		parametros = ''

		if typeof(obj.id_ventana)=='undefined'
			console.warn("Debe enviar el parametro id_ventana, para poder mostrar el loading")
			return

		if typeof(obj.params)!='undefined'
			for value of obj.params
				parametros += if parametros=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

		if obj.modal == true or obj.modal==''
			obj_loading =
				id_ventana : obj.id_ventana,
				text       : obj.text,
				loader     : obj.loader,
				icono      : obj.iconFinish,
				icono      : obj.iconFinish,
				texto      : obj.textFinish,
				duracion   : obj.duracionFinish,
				estado     : 'on'

			Win.loading(obj_loading)

		xhr     = new XMLHttpRequest
		bodyXhr = obj.url+'?'+parametros
		method  = obj.method or 'POST'

		xhr.open(method,bodyXhr, true)
		xhr.onreadystatechange=() ->
			if xhr.readyState==4
				response = xhr.responseText
				if (obj.modal == true or obj.modal=='') && (obj.autoClose == true || obj.autoClose == '')
					obj_loading.estado = 'off'
					Win.loading(obj_loading)
				return obj.success(response,xhr)
			else
				if (obj.modal == true or obj.modal=='') && (obj.autoClose == true || obj.autoClose == '')
					obj_loading.estado = 'off'
					Win.loading(obj_loading)
				return obj.failure(xhr)

		xhr.send(null)

	load: (dom_element,obj) ->
		parametros = ''
		tagScript  = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)'

		if typeof(obj.params)!='undefined'
			for value of obj.params
 				parametros+= if parametros=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]


		text = obj.text || 'cargando...'
		dom_element.innerHTML = "<div class=\"win-content-min-load\" >
										<div class=\"win-content-min-load-img\">
											<div class=\"win-min-load-ajax\"></div>
										</div>
										<div class=\"win-content-min-load-label\">#{text}</div>
									</div>"

		xhr     = new XMLHttpRequest
		bodyXhr = obj.url+'?'+parametros
		method  = obj.method || 'POST'

		xhr.open(method,bodyXhr, true)
		xhr.onreadystatechange=() ->
			if xhr.readyState==4
				responseHtml = xhr.responseText
				# html = extract_script(response)
				dom_element.innerHTML = responseHtml
				script = dom_element.getElementsByTagName('script');

				for i in script
					tagScript = document.createElement('script');
					i.parentNode.replaceChild(tagScript,i);
					tagScript.innerHTML = i.innerHTML;

		xhr.send(null)

		extract_script = (string) ->
			SearchExp = new RegExp(tagScript, 'img')
			return string.replace(SearchExp, '')

		eval_script = (string) ->
			scripts = (string.match(new RegExp(tagScript, 'img')) || [])
			script  = ''
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

