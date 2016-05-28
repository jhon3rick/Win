
# "use strict"

do ($W = Win) ->
	$W.Grilla = {}
	GRILLA = {}

	$W.Grilla.ini = (obj,varPost) ->
		if obj is null then return

		name        = obj.name or ''
		style       = ''
		url         = obj.url or ''
		idApply     = obj.idApply or ''
		opcionClass = obj.opcionClass or ''
		rows        = obj.rows or {}
		titleItems  = obj.titleItems or {}
		widthGrilla = '100%'
		parentHtml  = idApply

		tbar       = obj.tbar or ''
		tbarHeight = obj.tbarHeight or ''

		toolbar      = obj.toolbar or false
		valueToolbar = obj.valueToolbar or ''
		advancedToolbar = obj.advancedToolbar or 'disable'

		ctxMenu     = obj.ctxMenu or []
		filterAside = obj.filterAside or ''

		pagina  = obj.pagina or ''
		maxPage = obj.maxPage or ''
		varPost = varPost or {}

		textBtnNuevo   = obj.textBtnNuevo or 'Nuevo'
		fPermisoInsert = obj.fPermisoInsert or false

		fTitle      = obj.fTitle or ''
		fAncho      = obj.fAncho or 'auto'
		fAlto       = obj.fAlto or 'auto'
		fNameWindow = obj.fNameWindow or ''

		eventInsert = obj.eventInsert or ''
		eventUpdate = obj.eventUpdate or ''


		grillaHeight = ""
		GRILLA[name] = { url:url, varPost:varPost }

		if tbar==true and opcionClass==''
			_createTbar name,idApply,fNameWindow,fAncho,fAlto,fTitle,textBtnNuevo,fPermisoInsert,eventInsert

			tbarHeight   = document.getElementById("grilla_tbar_#{name}").offsetHeight
			grillaHeight = "height:calc(100% - #{tbarHeight}px)"

		else grillaHeight = 'height:100%';

		if toolbar != false
			style = 'style="height:calc(100% - 28px);"'
			htmlToolbar = _createToolbar name,advancedToolbar

		htmlAside   = _createAside name,filterAside
		htmlContent = _createContent name,opcionClass,pagina,maxPage,style,titleItems,rows,eventUpdate,fNameWindow,fAncho,fAlto,fTitle

		if htmlAside != "" then widthGrilla = "calc(100% - 205px)"

		if opcionClass == ''
			htmlGrilla = "<div id=\"grilla_ventana_#{name}\" class=\"grilla_ventana\" style=\"#{grillaHeight};\" data-role=\"win-body\">
								<div id=\"grilla_#{name}\" class=\"grilla_load\" style=\"width:#{widthGrilla};\">
									#{htmlToolbar}
									#{htmlContent}
								</div>
							</div>"
		else
			parentHtml = "grilla_#{name}"
			htmlGrilla = "#{htmlToolbar}#{htmlContent}"

		document.getElementById(parentHtml).innerHTML += htmlGrilla
		$W("\#grilla_toolbar_reload_#{name}").on("click",() -> $W.Grilla.buscar name )
		$W("\#grilla_content_page_#{name} .grilla_page").on("click",() -> $W.Grilla.pagination this,name,valueToolbar,pagina,maxPage )

		if opcionClass is "filterField"
			document.getElementById("field_buscar_#{name}").value = valueToolbar
			document.getElementById("field_buscar_#{name}").focus()

	$W.Grilla.fOpen = (name, id, fNameWindow, width, height, title, autoScroll) ->
		url = GRILLA[name]["url"]

		if id>0
			state = document.getElementById("grilla_fila_#{name}_#{id}").getAttribute('data-state')
			if state == 'fDelete' then return

		opcionClass = if id>0 then 'vUpdate' else 'vInsert'
		params = GRILLA[name]["varPost"]

		params.indexClass = id
		params.opcionClass = opcionClass

		eval "window.#{fNameWindow} = $W.Window({
				id       : \"#{fNameWindow}\",
				width    : width,
				height   : height,
				title    : title,
				modal    : true,
				closable : true,
				drag     : true,
				resize   : true,
				scroll   : false,
				autoLoad : {
					url    : url,
					params : params
				}
			})"

	$W.Grilla.inputBuscar = (e, name) ->
		tecla = if document.all then e.keyCode else e.which
		if tecla == 13 then $W.Grilla.buscar name
		return true

	_jsonParams = (name)->
		params = GRILLA[name]["varPost"]

		params.activeOrder     = ""				# Field Order
		params.valueToolbar    = ""				# Campo de busqueda
		params.advancedToolbar = "disable"		# Busquedas avanzadas

		if document.getElementById("field_buscar_#{name}")
			params.valueToolbar = document.getElementById("field_buscar_#{name}").value
			params.advancedToolbar = document.getElementById("grilla_type_search_#{name}").getAttribute("data-search")

		# Order by
		arrayOrder = document.querySelectorAll("#grilla_title_#{name} [data-order=upOn], #grilla_title_#{name} [data-order=downOn]")
		if arrayOrder[0]
			divOrder = arrayOrder[0]
			field = divOrder.getAttribute "data-field"
			state = divOrder.getAttribute "data-order"

			params.activeOrder = JSON.stringify({ field:field, state:state })

		params

	$W.Grilla.eventAside = (title,name)->
		state  = title.getAttribute('data-state')
		grilla = document.getElementById("grilla_#{name}")
		aside  = document.getElementById("grilla_aside_#{name}")

		if state is 'open'
			aside.style.width = '16px'
			grilla.style.width = 'calc(100% - 21px)'
			title.setAttribute 'data-state', 'close'
		else
			aside.style.width = '200px'
			grilla.style.width = 'calc(100% - 205px)'
			title.setAttribute 'data-state','open'

	$W.Grilla.buscar = (name) ->
		url = GRILLA[name]["url"]
		params = _jsonParams name
		params.opcionClass = "filterField"

		$W.Load({
			idApply : "grilla_#{name}",
			url     : url,
			params  : params
		})

	$W.Grilla.pagination = (elementDom, name, valueToolbar, pag_actual, page_max) ->
		url        = GRILLA[name]["url"]
		pagina     = 0
		page_max   = page_max * 1
		pag_actual = pag_actual * 1
		action     = elementDom.getAttribute("data-type")
		parentDom  = document.getElementById("grilla_content_#{name}").parentNode

		if action == 'next' && pag_actual == page_max then return
		else if action == 'prev' && pag_actual == 1 then return
		else if action == 'last' && pag_actual == page_max then return
		else if action == 'first' && pag_actual == 1 then return
		else if action == 'next' then pagina = pag_actual + 1
		else if action == 'prev' then pagina = pag_actual - 1
		else if action == 'last' then pagina = page_max
		else if action == 'first' then pagina = 1

		params = GRILLA[name]["varPost"]
		params.pagina = pagina
		params.opcionClass  = 'paginacion'
		params.valueToolbar = valueToolbar

		$W.Load({
			idApply : parentDom.id,
			url     : url,
			params  : params
		})

	$W.Grilla.updateRow = (name,id) ->
		url = GRILLA[name]["url"]
		opcionClass = 'updateRow'

		params = GRILLA[name]["varPost"]
		params.indexClass = id
		params.opcionClass = opcionClass

		if !document.getElementById("grilla_fila_cont_#{name}_#{id}") then return

		cont = document.getElementById("grilla_fila_cont_#{name}_#{id}").innerHTML

		$W.Ajax({
			url    : url,
			params : params,
			success : (result,xhr) ->

				if !$W.Script.isJSON result.responseText
					console.log result.responseText
					return

				json = JSON.parse(result.responseText)

				document.getElementById("grilla_content_fila_#{name}_#{id}").innerHTML = _createRows name,opcionClass,json.rows,json.eventUpdate,json.fNameWindow,json.fAncho,json.fAlto,json.fTitle
				document.getElementById("grilla_fila_cont_#{name}_#{id}").innerHTML = cont
				document.getElementById("grilla_fila_image_#{name}_#{id}").setAttribute('data-icon','fUpdate')
			,
			failure : (xhr) -> console.log "fail"
		})

	###
	@method _execScript
	@param  str separate json and script for objectDom load script
	###
	_execScript = (name,response) ->

		arrayData = (response).split('<script>')
		txtJson = arrayData[0];

		if arrayData.length > 1
			arrayData[0] = '';
			script = arrayData.join('<script>')

			divScript = document.getElementById("div_script_form_#{name}")
			divScript.innerHTML = script

			tagsScript = divScript.getElementsByTagName('script')
			for i in tagsScript
				tagScript = document.createElement('script')
				tagScript.innerHTML = i.innerHTML
				i.parentNode.replaceChild(tagScript,i)

		# SI NO ES JSON RETURN
		if !$W.Script.isJSON txtJson
			console.log txtJson
			return false

		txtJson

	_insertUpdateRow = (name,url,xhrResponse,opcionClass) ->

		txtJson = _execScript name,xhrResponse.responseText
		if !txtJson then return

		json = JSON.parse(txtJson)

		if json.estado == 'true'
			type = json.type or ''

			if type == 'form'
				eval "#{json.name}.close();"
				return

			rows   = json.rows or {}
			fTitle = json.fTitle or ''
			fAncho = json.fAncho or ''
			fAlto  = json.fAlto or ''
			fNameWindow = json.fNameWindow or ''
			eventUpdate = json.eventUpdate or ''

			if opcionClass == 'fInsert' or  opcionClass == 'insertRow'
				body = document.getElementById("grilla_body_#{name}")

				# if CONT > 1
				if body.lastChild
					contDiv = (body.lastChild).getAttribute("data-cont")
					contDiv++

				body.innerHTML += _createRows name,opcionClass,rows,eventUpdate,fNameWindow,fAncho,fAlto,fTitle

				if contDiv > 0
					document.getElementById("grilla_fila_cont_#{name}_"+json.idRow).innerHTML = contDiv
					document.getElementById("grilla_content_fila_#{name}_"+json.idRow).setAttribute("data-cont", contDiv)

			else if opcionClass == "fUpdate"
				contDiv = document.getElementById("grilla_fila_cont_#{name}_"+json.idRow).innerHTML
				document.getElementById("grilla_content_fila_#{name}_"+json.idRow).innerHTML = _createRows name,opcionClass,rows,eventUpdate,fNameWindow,fAncho,fAlto,fTitle
				document.getElementById("grilla_fila_cont_#{name}_"+json.idRow).innerHTML = contDiv

			if opcionClass == 'fInsert' or  opcionClass == 'fUpdate' then eval "#{fNameWindow}.close();"

		else console.log json.msj


	$W.Grilla.insertRow = (name,id) ->
		url  = GRILLA[name]["url"]
		opcionClass = 'insertRow'

		params = GRILLA[name]["varPost"]
		params.indexClass = id
		params.opcionClass = opcionClass

		$W.Ajax({
			url    : url,
			params : params,
			success : (xhrResponse,xhr) -> _insertUpdateRow(name,url,xhrResponse,opcionClass),
			failure : (xhr) -> console.log "fail"
		})

	$W.Form.fSave = (name,url,indexClass,varPost) ->
		objForm      = {}
		arrayInput   = []
		msjRequired  = ''
		contRequired = 0

		opcionClass  = if indexClass > 0 then 'fUpdate' else 'fInsert'
		arrayInput[0] = document.querySelectorAll("#form_#{name} input")
		arrayInput[1] = document.querySelectorAll("#form_#{name} select")
		arrayInput[2] = document.querySelectorAll("#form_#{name} textarea")

		for i in arrayInput
			[].forEach.call(i, (objDom) ->
				id       = objDom.id
				value    = objDom.value
				label    = objDom.getAttribute('data-label')
				required = objDom.getAttribute('data-required')

				if value=='' && required=='true'
					contRequired++
					msjRequired += '\n* '+label

				field = id.replace("form_#{name}_", '')
				objForm[field] = value

				if objDom.tagName is "select" or objDom.tagName is "SELECT"
					data = objDom.getAttribute "data-textdb"
					if  data != "" then objForm[data] = objDom.options[objDom.selectedIndex].text
			)


		jsonForm = JSON.stringify(objForm)

		if contRequired == 1 then alert('El siguiente campo es obligatorio'+msjRequired); return
		else if contRequired > 1 then alert('Los siguientes campos son obligatorios'+msjRequired); return

		params = varPost
		params.indexClass = indexClass
		params.opcionClass = opcionClass
		params.jsonFormValue = jsonForm

		$W.Ajax({
			url    : url,
			params : params,
			success : (xhrResponse,xhr) -> _insertUpdateRow(name,url,xhrResponse,opcionClass),
			failure : (xhr) -> console.log "fail"
		})

	$W.Form.fDelete = (name,url,indexClass,varPost) ->
		params = varPost
		params.indexClass = indexClass
		params.opcionClass = 'fDelete'

		$W.Ajax({
			url    : url,
			params : params,
			success : (xhrResponse,xhr) ->

				txtJson = _execScript name,xhrResponse.responseText
				if !txtJson then return

				json = JSON.parse(txtJson)

				if json.estado == 'true'

					if json.type=='grilla'
						document.getElementById("grilla_fila_#{name}_#{indexClass}").setAttribute('data-state','fDelete')
						document.getElementById("grilla_fila_image_#{name}_#{indexClass}").setAttribute('data-icon','fDelete')

						arrayDivHtml = document.querySelectorAll("#grilla_fila_#{name}_#{indexClass} [data-type=html]")
						[].forEach.call(arrayDivHtml,(input) ->
							input.innerHTML = ''
						)

					eval json.fNameWindow+".close();"

				else console.log "false"
			,
			failure : (xhr) -> console.log "fail"
		})


	$W.Grilla.typeSearch = (input) ->
		type = input.getAttribute("data-search")

		if type is "disable"
			if !confirm "Desea habilitar la busqueda avanzada?" then return
			input.setAttribute("data-search","enable")
		else input.setAttribute("data-search","disable")

	_createAside = (name,filterAside) ->
		html = ""
		for own key, value of filterAside
			html += "<div class=\"grilla-aside-title\">#{value.title}</div>"

		if html != ""
			html = "<aside id=\"grilla_aside_#{name}\" style=\"width:200px;\">
						<div class=\"grilla-aside-head\" data-state=\"open\" onclick=\"$W.Grilla.eventAside(this, '#{name}')\">TITLE OR ICON</div>
						#{html}
					</aside>"
		html

	_createToolbar = (name,advancedToolbar) ->
		"<div id=\"grilla_toolbar_#{name}\" class=\"grilla_toolbar\">
			<div>
				<div class=\"grilla_toolbar_input\">
					<input type=\"text\" id=\"field_buscar_#{name}\" onKeyUp=\"$W.Grilla.inputBuscar(event,\'#{name}\')\" placeholder=\"Buscar...\"/>
				</div>
				<div data-search=\"#{advancedToolbar}\" title=\"Busquedas avanzada\" id=\"grilla_type_search_#{name}\" class=\"grilla_type_search\" onclick=\"$W.Grilla.typeSearch(this)\"></div>
				<div id=\"grilla_toolbar_reload_#{name}\" class=\"grilla_toolbar_reload\"></div>
			</div>
		</div>"

	_createContent = (name,opcionClass,pagina,maxPage,style,titleItems,rows,eventUpdate,fNameWindow,fAncho,fAlto,fTitle) ->
		htmlItems = _createRows name,opcionClass,rows,eventUpdate,fNameWindow,fAncho,fAlto,fTitle
		htmlPage  = _createPagination name,pagina,maxPage
		objTitle  = _createTitle name,titleItems

		"<div id=\"grilla_content_#{name}\" class=\"grilla_content\" #{style}>
			<div id=\"grilla_title_#{name}\" class=\"grilla_title\" style=\"min-width:#{objTitle.width}px;\">#{objTitle.html}</div>
			<div id=\"grilla_body_#{name}\" class=\"grilla_body\" style=\"min-width:#{objTitle.width}px;\">#{htmlItems}</div>
			<div class=\"grilla_footer\" style=\"min-width:#{objTitle.width}px;\">#{htmlPage}</div>
		</div>"

	_createTitle = (name, titleItems) ->
		width = 75
		html  = "<div class=\"grilla_title_label\">No.</div>"

		for own key, item of titleItems
			htmlOrder = "";


			if item.order == "true"
				dataUp   = "upOff"
				dataDown = "downOff"

				if item.state == "upOn" then dataUp="upOn"
				else if item.state == "downOn" then dataDown="downOn"

				htmlOrder = "<div class=\"grilla_title_order\">
								<div data-order=\"#{dataUp}\" data-field=\"#{item.field}\" onclick=\"$W.Grilla.orderUser('#{name}',this)\"></div>
								<div data-order=\"#{dataDown}\" data-field=\"#{item.field}\" onclick=\"$W.Grilla.orderUser('#{name}',this)\"></div>
							</div>"

			width += item.width
			html += "<div class=\"grilla_title_label\" style=\"width:#{item.width}px;\">
						<div style=\"float:left; width:100%; height:100%;\">#{item.title}</div>
						#{htmlOrder}
					</div>"
		{html:html, width:width}

	$W.Grilla.orderUser = (name,divOrder)->
		order = divOrder.getAttribute "data-order"

		$W(".grilla_title_order [data-order=upOn]").attr "data-order","upOff"
		$W(".grilla_title_order [data-order=downOn]").attr "data-order","downOff"

		switch order
			when 'upOff' then divOrder.setAttribute "data-order","upOn"
			when 'downOff' then divOrder.setAttribute "data-order","downOn"
			when 'upOn' then divOrder.setAttribute "data-order","upOff"
			when 'downOn' then divOrder.setAttribute "data-order","downOff"

		$W.Grilla.buscar(name)

	_createRows = (name,opcionClass,rows,eventUpdate,fNameWindow,fAncho,fAlto,fTitle) ->
		url     = GRILLA[name]["url"]
		html    = ""
		contRow = 0

		for own index, row of rows
			contRow++
			htmlCol = _createCol name,row.idRow,row.cols

			eventDbclick = ""
			if eventUpdate is true then eventDbclick = "$W.Grilla.fOpen('#{name}', '#{row.idRow}', '#{fNameWindow}', '#{fAncho}', '#{fAlto}', '#{fTitle}',true)"
			else if eventUpdate == '' then eventDbclick = ''
			else eventDbclick = "#{eventUpdate}(#{row.idRow}, this, this.id)"

			eventCtxMenu = if row.ctxmenu != '[]' then "oncontextmenu='$W.CtxMenuDom({objApply:this, items:#{row.ctxmenu}},event); return false;'" else ""

			rowHtml = "<div id=\"grilla_fila_#{name}_#{row.idRow}\" class=\"grilla_fila\" ondblclick=\"#{eventDbclick}\" #{eventCtxMenu} data-state=\"#{opcionClass}\" data-index=\"#{row.idRow}\">
							<div id=\"MuestraToltip_#{name}_#{row.idRow}\" class=\"grilla_col_first\">
								<div id=\"grilla_fila_image_#{name}_#{row.idRow}\" class=\"grilla_fila_image\" data-icon=\"#{opcionClass}\"></div>
								<div id=\"grilla_fila_cont_#{name}_#{row.idRow}\" class=\"grilla_fila_cont\">#{contRow}</div>
							</div>
							#{htmlCol}
						</div>"

			if opcionClass != 'fUpdate' and opcionClass != 'updateRow'
				html += "<div id=\"grilla_content_fila_#{name}_#{row.idRow}\" class=\"grilla_content_fila\" data-index=\"#{row.idRow}\" data-cont=\"#{contRow}\" style=\"float:left; width:100%;\">#{rowHtml}</div>"
			else html += rowHtml
		html

	_createCol = (name,idRow,cols) ->
		html = ""
		for own idCol, obj of cols
			html += "<div id=\"div_#{name}_#{idCol}_#{idRow}\" class=\"grilla_celdas\" style=\"width:#{obj.width}px; #{obj.style}\" data-type=\"#{obj.type}\">#{obj.html}</div>"
		html

	_createTbar = (name,idApply,fNameWindow,fAncho,fAlto,fTitle,textBtnNuevo,fPermisoInsert,eventInsert) ->
		url = GRILLA[name]["url"]
		document.getElementById(idApply).innerHTML += "<div id=\"grilla_tbar_#{name}\"></div>";

		if fPermisoInsert is true or fPermisoInsert is "true"
			$W.Tbar({
				idApply : "grilla_tbar_#{name}",
				items   : [{
					xtype   : "button",
					id      : "btn_#{name}_new",
					cls     : "grilla_add",
					text    : textBtnNuevo,
					handler : () ->

						if eventInsert is true then $W.Grilla.fOpen name,"",fNameWindow,fAncho,fAlto,fTitle,true
						else if eventInsert != "" then eval "#{eventInsert}()"
				}]
			})

	_createPagination = (name,page,maxPage) ->
		html = ""
		if maxPage > 1
			html = "<div id=\"grilla_content_page_#{name}\" class=\"grilla_content_page\">
						<div>Pagina #{page} de #{maxPage}</div>
						<div data-type=\"first\" class=\"grilla_page\"></div>
						<div data-type=\"prev\" class=\"grilla_page\"></div>
						<div data-type=\"next\" class=\"grilla_page\"></div>
						<div data-type=\"last\" class=\"grilla_page\"></div>
					</div>"
		html