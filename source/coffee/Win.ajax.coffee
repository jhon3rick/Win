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

	load : (parent_s,obj) ->
		parametros = ''


		if typeof(obj.params)!='undefined'
			for value of obj.params
				parametros+= if parametros=='' then value+"="+obj.params[value] else "&"+value+"="+obj.params[value]

		div =  document.createElement('div')
		div.className = "win-content-min-load"
		div.innerHTML = "load..."
		parent_s.appendChild(div)
		
		# text = obj.text || 'cargando...'
		# parent_s.innerHTML = "<div class=\"win-content-min-load\" >
		# 						<div class=\"win-content-min-load-img\">
		# 							<div class=\"win-min-load-ajax\"></div>
		# 						</div>
		# 						<div class=\"win-content-min-load-label\">#{text}</div>
		# 					</div>"

		console.log(parent_s)
		# return;
		_parentHtml = () ->
			div.parentNode.innerHTML = 2
			# a = document.querySelectorAll('.win-panel > div')
			console.log(div.parentNode)

		xhr     = new XMLHttpRequest 
		bodyXhr = obj.url+'?'+parametros
		method  = obj.method || 'POST'

		xhr.open(method,bodyXhr, true)
		# parent_s.innerHTML = 3
		xhr.onreadystatechange = () ->
			if xhr.readyState==4
				parent_s.innerHTML = 2
				console.log(parent_s.innerHTML)


				# console.log(parent_s)
				# parent_s.innerHTML = xhr.responseText
				# parent_s.innerHTML = 2
				# document.getElementById(parent_s.id).innerHTML = 2
				# _parentHtml()
				# script = parent_s.getElementsByTagName('script');

				# for i in script
				# 	tagScript = document.createElement('script');
				# 	i.parentNode.replaceChild(tagScript,i);
				# 	tagScript.innerHTML = i.innerHTML;

		xhr.send(null)

		
