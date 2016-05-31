###
# Request XHR
###

do ($W = Win) ->
	$W.Ajax = (obj) ->
		param = ''

		# if typeof(obj.id_ventana)=='undefined'
		# 	console.warn("Debe enviar el parametro id_ventana, para poder mostrar el loading")
		# 	return

		if typeof(obj.params)!='undefined'
			for value of obj.params
				param += if param=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

		# if obj.modal == true or obj.modal==''
		# 	obj_loading =
		# 		id_ventana : obj.id_ventana,
		# 		text       : obj.text,
		# 		loader     : obj.loader,
		# 		icono      : obj.iconFinish,
		# 		icono      : obj.iconFinish,
		# 		texto      : obj.textFinish,
		# 		duracion   : obj.duracionFinish,
		# 		estado     : 'on'

		# 	Win.loading(obj_loading)

		xhr     = new XMLHttpRequest
		bodyXhr = obj.url
		method  = obj.method or 'POST'

		xhr.open(method,bodyXhr, true)
		if method == 'POST' then xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded", true);
		xhr.onreadystatechange=() ->
			if xhr.readyState==4
				response = xhr
				# if (obj.modal == true or obj.modal=='') && (obj.autoClose == true || obj.autoClose == '')
				# 	obj_loading.estado = 'off'
				# 	Win.loading(obj_loading)
				return obj.success(response,xhr)
			else
				# if (obj.modal == true or obj.modal=='') && (obj.autoClose == true || obj.autoClose == '')
				# 	obj_loading.estado = 'off'
				# 	Win.loading(obj_loading)
				if(obj.failure) then return obj.failure(xhr)

		xhr.send(param)

	$W.Load = (obj) ->

		if !obj.idApply
			alert('idApply Obligatorio')
			return
		else if typeof document.getElementById(obj.idApply) == 'null'
			alert('No se encontro elemento en el arbol Dom')
			return

		param = ''
		if typeof(obj.params)!='undefined'
			for value of obj.params
				param+= if param=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

		text = obj.text || 'cargando...'

		document.getElementById(obj.idApply).innerHTML = "<div class=\"win-content-min-load\" >
															<div class=\"win-content-min-load-img\">
																<div class=\"win-min-load-ajax\"></div>
															</div>
															<div class=\"win-content-min-load-label\">#{text}</div>
														</div>"

		xhr     = new XMLHttpRequest
		bodyXhr = obj.url+'?'
		method  = obj.method or 'POST'

		xhr.open(method,bodyXhr, true)
		if method == 'POST' then xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded", true);
		xhr.onreadystatechange = () ->
			if xhr.readyState == 4
				divScript = document.getElementById(obj.idApply)
				if xhr.status == 404 then divScript.innerHTML = 'Not found'
				else
					divScript.innerHTML = xhr.responseText
					_loadScript(divScript)

		xhr.send(param)

	###
	@method _loadScript
	@param  obj objectDom load script
	###
	_loadScript = (obj) ->
		tagsScript = obj.getElementsByTagName('script')
		for i in tagsScript
			tagScript = document.createElement('script')
			tagScript.innerHTML = i.innerHTML
			i.parentNode.replaceChild(tagScript,i)