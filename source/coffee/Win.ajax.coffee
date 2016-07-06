###
# Request XHR
###

do ($W = Win) ->

	DEFAULT =
		METHOD : "POST"
		MIME   : "text"

	MIME_TYPES =
		script : "text/javascript, application/javascript"
		json   : "application/json"
		xml    : "application/xml, text/xml"
		html   : "text/html"
		text   : "text/plain"

	JSONP_ID = 0
	$W.ajaxSettings =
		async       : true
		method      : DEFAULT.METHOD
		success     : {}
		failure     : {}
		context     : null
		dataType    : DEFAULT.MIME
		headers     : {}
		xhr         : -> new window.XMLHttpRequest()
		crossDomain : false
		timeout     : 0

	$W.Ajax = (options) ->
		options.contentType = "application/x-www-form-urlencoded" if !options.contentType
		settings = $W.Mix($W.ajaxSettings, options)

		if settings.method is DEFAULT.METHOD then settings.params = $W.Serialize(settings.params)
		else settings.url += $W.Serialize(settings.params, "?")

		return _jsonp(settings) if _isJsonP(settings.url)

		xhr = settings.xhr()
		xhr.onreadystatechange = ->
			if xhr.readyState is 4
				clearTimeout abortTimeout
				_xhrStatus xhr, settings

		xhr.open settings.method, settings.url, settings.async
		_xhrHeaders xhr, settings

		if settings.timeout > 0 then abortTimeout = setTimeout((-> _xhrTimeout xhr, settings ), settings.timeout)

		try
			xhr.send settings.params
		catch error
			xhr = error
			_xhrError "Resource not found", xhr, settings
			xhr

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
	Load data from the server using a HTTP GET request.
	@method get
	@param  {string} A string containing the URL to which the request is sent.
	@param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
	@param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
	@param  {string} [OPTIONAL] The type of data expected from the server
	###
	$W.get = (url, params, success, dataType) ->
		$W.Ajax
			url      : url 
			method   : 'GET' 
			params   : params
			success  : success
			dataType : dataType

	###
	Load data from the server using a HTTP POST request.
	@method post
	@param  {string} A string containing the URL to which the request is sent.
	@param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
	@param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
	@param  {string} [OPTIONAL] The type of data expected from the server
	###
	$W.Post = (url, params, success, dataType) -> _xhrForm "POST", url, params, success, dataType


	###
	Load data from the server using a HTTP PPUTOST request.
	@method put
	@param  {string} A string containing the URL to which the request is sent.
	@param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
	@param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
	@param  {string} [OPTIONAL] The type of data expected from the server
	###
	$W.Put = (url, params, success, dataType) -> _xhrForm "PUT", url, params, success, dataType


	###
	Load data from the server using a HTTP DELETE request.
	@method delete
	@param  {string} A string containing the URL to which the request is sent.
	@param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
	@param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
	@param  {string} [OPTIONAL] The type of data expected from the server
	###
	$W.Delete = (url, params, success, dataType) -> _xhrForm "DELETE", url, params, success, dataType

	###
	Encode a set of form elements as a string for submission.
	@method serialize
	@param  {object}
	###
	$W.Serialize = (parameters, character="") ->
		serialize = character
		for parameter of parameters
			if parameters.hasOwnProperty(parameter)
				serialize += "&" if serialize isnt character
				serialize += "#{encodeURIComponent parameter}=#{encodeURIComponent parameters[parameter]}"
		(if (serialize is character) then "" else serialize)

	# ---------------------------------------------------------------------------
	# Private Methods
	# ---------------------------------------------------------------------------
	_jsonp = (settings) ->
		if settings.async
			callbackName = "jsonp" + (++JSONP_ID)
			script = document.createElement("script")
			xhr = abort: ->
				$$(script).remove()
				window[callbackName] = {} if callbackName of window

			abortTimeout = undefined
			window[callbackName] = (response) ->
				clearTimeout abortTimeout
				$$(script).remove()
				delete window[callbackName]

			_xhrSuccess response, xhr, settings

			script.src = settings.url.replace(RegExp("=\\?"), "=" + callbackName)
			$$("head").append script
			if settings.timeout > 0
				abortTimeout = setTimeout((-> _xhrTimeout xhr, settings), settings.timeout)
			xhr
		else console.error "Win.ajax: Unable to make jsonp synchronous call."

	_xhrStatus = (xhr, settings) ->
		if (xhr.status >= 200 and xhr.status < 300) or xhr.status is 0
			if settings.async
				_xhrSuccess _parseResponse(xhr, settings), xhr, settings
				return
		else
			_xhrError "Win.ajax: Unsuccesful request", xhr, settings
			return

	_xhrSuccess = (response, xhr, settings) ->
		settings.success.call settings.context, response, xhr
		return

	_xhrError = (method, xhr, settings) ->
		settings.failure.call settings.context, method, xhr, settings
		return

	_xhrHeaders = (xhr, settings) ->
		settings.headers["Content-Type"] = settings.contentType if settings.contentType
		settings.headers["Accept"] = MIME_TYPES[settings.dataType] if settings.dataType
		for header of settings.headers
			xhr.setRequestHeader header, settings.headers[header]
		return

	_xhrTimeout = (xhr, settings) ->
		xhr.onreadystatechange = {}
		xhr.abort()
		_xhrError "win.ajax: Timeout exceeded", xhr, settings
		return

	_xhrForm = (method, url, data, success, dataType) ->
		$W.Ajax
			url         : url
			method      : method
			params      : params
			success     : success
			dataType    : dataType
			contentType : "application/x-www-form-urlencoded"

	_isJsonP = (url) -> RegExp("=\\?").test url

	_parseResponse = (xhr, settings) ->
		response = xhr
		if xhr.responseText
			if settings.dataType is 'json'
				try
					response = JSON.parse xhr.responseText
				catch error
					response = error
					_xhrError "Win.ajax: Parse Error", xhr, settings
			response = xhr.responseXML if settings.dataType is "xml"
		response

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