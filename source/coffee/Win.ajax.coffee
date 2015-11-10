###
# Request XHR
###

Win.Ajax = do ->
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

	load: (div,obj) ->
		parametros = ''
		tagScript  = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)'

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
				div.innerHTML = html
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
