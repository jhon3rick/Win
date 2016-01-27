###
# Request XHR
###

do ($W = Win) ->
	$W.Ajax = do ->
		request: (obj) ->

			param = ''

			if typeof(obj.id_ventana)=='undefined'
				console.warn("Debe enviar el parametro id_ventana, para poder mostrar el loading")
				return

			if typeof(obj.params)!='undefined'
				for value of obj.params
					param += if param=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

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
			bodyXhr = obj.url+'?'+param
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

		load: (parent,obj) ->
			param = ''
			if typeof(obj.params)!='undefined'
				for value of obj.params
					param+= if param=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

			text = obj.text || 'cargando...'
			parent.innerHTML = "<div class=\"win-content-min-load\" >
									<div class=\"win-content-min-load-img\">
										<div class=\"win-min-load-ajax\"></div>
									</div>
									<div class=\"win-content-min-load-label\">#{text}</div>
								</div>"

			xhr     = new XMLHttpRequest
			bodyXhr = obj.url+'?'+param
			method  = obj.method || 'POST'

			xhr.open(method,bodyXhr, true)
			xhr.onreadystatechange = () ->
				if xhr.readyState == 4
					divScript = document.getElementById(parent.id)
					divScript.innerHTML = xhr.responseText
					_loadScript(divScript)

			xhr.send(null)

	###
	@method _loadScript
	@param  obj objectDom load script
	###
	_loadScript = (obj) ->
		tagsScript = obj.getElementsByTagName('script')
		for i in tagsScript
			tagScript = document.createElement('script')
			i.parentNode.replaceChild(tagScript,i)
			tagScript.innerHTML = i.innerHTML