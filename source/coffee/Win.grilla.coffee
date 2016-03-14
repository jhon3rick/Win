do ($W = Win) ->
	$W.Grilla = {}
	PATH_GRILLA = {}

	$W.Grilla.ini = (obj) ->
		if obj is null then return

		name        = obj.name or ''
		style       = ''
		url         = obj.url or ''
		idApply     = obj.idApply or ''
		opcionClass = obj.opcionClass or ''
		items       = obj.items or {}
		titleItems  = obj.titleItems or {}
		widthGrilla = '100%'
		parentHtml  = idApply

		tbar       = obj.tbar or ''
		tbarHeight = obj.tbarHeight or ''

		toolbar      = obj.toolbar or false
		valueToolbar = obj.valueToolbar or ''
		advancedToolbar = obj.advancedToolbar or 'disable'

		filterAside  = obj.filterAside or ''

		pagina  = obj.pagina or ''
		maxPage = obj.maxPage or ''

		textBtnNuevo   = obj.textBtnNuevo or 'Nuevo'
		fPermisoInsert = obj.fPermisoInsert or false


		fTitle  = obj.fTitle or ''
		fAncho  = obj.fAncho or 'auto'
		fAlto   = obj.fAlto or 'auto'
		fUpdate = obj.fUpdate or ''

		grillaHeight = ""
		PATH_GRILLA[name] = url

		if tbar==true and opcionClass==''
			_createTbar name,url,idApply,fAncho,fAlto,fTitle,textBtnNuevo,fPermisoInsert

			tbarHeight   = document.getElementById("grilla_tbar_#{name}").offsetHeight
			grillaHeight = "height:calc(100% - #{tbarHeight}px)"

		else grillaHeight = 'height:100%';

		if toolbar != false
			style = 'style="height:calc(100% - 28px);"'
			htmlToolbar = _createToolbar name,url,advancedToolbar

		htmlAside   = _createAside name,filterAside
		htmlContent = _createContent name,url,opcionClass,pagina,maxPage,style,titleItems,items,fUpdate,fAncho,fAlto,fTitle

		if htmlAside != "" then widthGrilla = "calc(100% - 205px)"

		if opcionClass == ''
			htmlGrilla = "<div id=\"grilla_ventana_#{name}\" class=\"grilla_ventana\" style=\"#{grillaHeight};\">
								#{htmlAside}
								<div id=\"grilla_#{name}\" class=\"grilla_load\" style=\"width:#{widthGrilla};\">
									#{htmlToolbar}
									#{htmlContent}
								</div>
							</div>"
		else
			parentHtml = "grilla_#{name}"
			htmlGrilla = "#{htmlToolbar}#{htmlContent}"

		document.getElementById(parentHtml).innerHTML += htmlGrilla
		$W("\#grilla_toolbar_reload_#{name}").on("click",() -> $W.Grilla.buscar name,url )
		$W("\#grilla_content_page_#{name} .grilla_page").on("click",() -> $W.Grilla.pagination this,name,valueToolbar,pagina,maxPage,url )

		if opcionClass is "filterField"
			document.getElementById("field_buscar_#{name}").value = valueToolbar
			document.getElementById("field_buscar_#{name}").focus()

	$W.Grilla.fOpen = (name,url,id,width,height,title,autoScroll) ->
		if id>0
			state = document.getElementById("grilla_fila_#{name}_#{id}").getAttribute('data-state')
			if state == 'fDelete' then return

		opcionClass = if id>0 then 'vUpdate' else 'vInsert'
		params = {}

		params.indexClass = id
		params.opcionClass = opcionClass

		eval "window.Win_grilla_form_#{name} = $W.Window({
				id       : \"Win_grilla_form_#{name}\",
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

	$W.Grilla.fSave = (name,url,indexClass) ->
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

		$W.Ajax({
			url    : url,
			params :
				indexClass : indexClass,
				opcionClass   : opcionClass,
				jsonFormValue : jsonForm
			,
			success : (result,xhr) ->
				json = JSON.parse(result.responseText)

				if json.estado == 'true'
					items   = json.items or {}
					fTitle  = json.fTitle or ''
					fUpdate = json.fUpdate or ''
					fAncho  = json.fAncho or ''
					fAlto   = json.fAlto or ''

					if opcionClass == 'fInsert'
						body = document.getElementById("gilla_body_#{name}")

						# CONT > 1
						if body.lastChild
							contDiv = (body.lastChild).getAttribute("data-cont")
							contDiv++

						body.innerHTML += _createRow name,url,opcionClass,items,fUpdate,fAncho,fAlto

						if contDiv > 0
							document.getElementById("grilla_fila_cont_#{name}_"+json.indexClass).innerHTML = contDiv
							document.getElementById("grilla_content_fila_#{name}_"+json.indexClass).setAttribute("data-cont", contDiv)

					else if opcionClass == "fUpdate"
						contDiv = document.getElementById("grilla_fila_cont_#{name}_"+json.indexClass).innerHTML
						document.getElementById("grilla_content_fila_#{name}_"+json.indexClass).innerHTML = _createRow name,url,opcionClass,items,fUpdate,fAncho,fAlto,fTitle
						document.getElementById("grilla_fila_cont_#{name}_"+json.indexClass).innerHTML = contDiv

					eval "Win_grilla_form_#{name}.close();"
				else console.log "false"
			,
			failure : (xhr) -> console.log "fail"
		})

	$W.Grilla.fDelete = (name,url,indexClass) ->

		$W.Ajax({
			url    : url,
			params :
				indexClass : indexClass,
				opcionClass : 'fDelete'
			,
			success : (result,xhr) ->
				json = JSON.parse(result.responseText)

				if json.estado == 'true'
					document.getElementById("grilla_fila_#{name}_#{indexClass}").setAttribute('data-state','fDelete')
					document.getElementById("grilla_fila_image_#{name}_#{indexClass}").setAttribute('data-icon','fDelete')

					arrayDivHtml = document.querySelectorAll("#grilla_fila_#{name}_#{indexClass} [data-type=html]")
					[].forEach.call(arrayDivHtml,(input) ->
						input.innerHTML = ''
					)
					eval "Win_grilla_form_#{name}.close();"

				else console.log "false"
			,
			failure : (xhr) -> console.log "fail"
		})

	# grilla_field_buscar = (e, name, url) ->
	$W.Grilla.inputBuscar = (e, name, url) ->
		tecla = if document.all then e.keyCode else e.which
		if tecla == 13 then $W.Grilla.buscar name,url
		return true


	$W.Grilla.buscar = (name, url) ->
	# grilla_div_buscar = (name, url) ->
		valueToolbar    = document.getElementById("field_buscar_#{name}").value
		advancedToolbar = document.getElementById("grilla_type_search_#{name}").getAttribute("data-search")

		# var elid 				= \".$this->VariableInUpDe."\"
		$W.Load({
			idApply : "grilla_#{name}",
			url     : url,
			params  :
				opcionClass     : "filterField",
				advancedToolbar : advancedToolbar,
				valueToolbar    : valueToolbar,
				# elid       : elid
				# '.$this->VariablesPost.'
		})

	# event_menu_aside = (title,name)->
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

	$W.Grilla.pagination = (elementDom, name, valueToolbar, pag_actual, page_max, url) ->
		# var MyFiltroBusqueda = '.$this->MyFiltroBusqueda.';
		# var elid             = '.$this->VariableInUpDe.';
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

		$W.Load({
			idApply : parentDom.id,
			url     : url,
			params  :
				pagina : pagina,
				opcionClass  : 'paginacion',
				valueToolbar : valueToolbar,
				# elid       : elid,
				# '.$this->VariablesPost.'
		})

	$W.Grilla.updateRow = (name,id) ->
		opcionClass = 'updateRow'
		url  = PATH_GRILLA[name]
		cont = document.getElementById("grilla_fila_cont_#{name}_#{id}").innerHTML

		$W.Ajax({
			url    : url,
			params :
				indexClass : id,
				opcionClass : opcionClass
			,
			success : (result,xhr) ->
				json = JSON.parse(result.responseText)

				document.getElementById("grilla_content_fila_#{name}_#{id}").innerHTML = _createRow name,url,opcionClass,json.items,json.fUpdate,json.fAncho,json.fAlto,json.fTitle
				document.getElementById("grilla_fila_cont_#{name}_#{id}").innerHTML = cont
				document.getElementById("grilla_fila_image_#{name}_#{id}").setAttribute('data-icon','fUpdate')
			,
			failure : (xhr) -> console.log "fail"
		})

		# $W.Load({
		# 	idApply : "grilla_content_fila_#{name}_#{id}",
		# 	url     : PATH_GRILLA[name],
		# 	params  :
		# 		opcionClass : 'updateRow',
		# 		index : id,
		# })

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

	_createToolbar = (name,url,advancedToolbar) ->
		"<div id=\"grilla_toolbar_#{name}\" class=\"grilla_toolbar\">
			<div>
				<div class=\"grilla_toolbar_input\">
					<input type=\"text\" id=\"field_buscar_#{name}\" onKeyUp=\"$W.Grilla.inputBuscar(event,\'#{name}\',\'#{url}\')\"/>
				</div>
				<div data-search=\"#{advancedToolbar}\" title=\"Busquedas avanzada\" id=\"grilla_type_search_#{name}\" class=\"grilla_type_search\" onclick=\"$W.Grilla.typeSearch(this)\"></div>
				<div id=\"grilla_toolbar_reload_#{name}\" class=\"grilla_toolbar_reload\"></div>
			</div>
		</div>"

	_createContent = (name,url,opcionClass,pagina,maxPage,style,titleItems,items,fUpdate,fAncho,fAlto,fTitle) ->
		htmlItems = _createRow name,url,opcionClass,items,fUpdate,fAncho,fAlto,fTitle
		htmlPage  = _createPagination name,pagina,maxPage
		objTitle = _createTitle name,titleItems

		"<div id=\"grilla_content_#{name}\" class=\"grilla_content\" #{style}>
			<div id=\"grilla_title_#{name}\" class=\"grilla_title\" style=\"min-width:#{objTitle.width}px;\">#{objTitle.html}</div>
			<div id=\"gilla_body_#{name}\" class=\"grilla_body\" style=\"min-width:#{objTitle.width}px;\">#{htmlItems}</div>
			<div class=\"grilla_footer\">#{htmlPage}</div>
		</div>"

	_createTitle = (name, titleItems) ->
		width = 75
		html  = "<div class=\"grilla_title_label\" style=\"width:34px;\">No.</div>"

		for own key, value of titleItems
			width += value.width
			html += "<div class=\"grilla_title_label\" style=\"width:#{value.width}px;\">#{value.title}</div>"
		{html:html, width:width}

	_createRow = (name,url,opcionClass,items,fUpdate,fAncho,fAlto,fTitle) ->
		html = "";
		contRow = 0
		for own key, cols of items
			contRow++
			htmlCol = _createCol name,key,cols

			eventDbclick = ""
			if fUpdate is true then eventDbclick = "$W.Grilla.fOpen('#{name}', '#{url}', '#{key}', '#{fAncho}', '#{fAlto}', '#{fTitle}')"
			else if fUpdate == '' then eventDbclick = ''
			else eventDbclick = fUpdate+"('#{key}')"

			row = "<div id=\"grilla_fila_#{name}_#{key}\" class=\"grilla_fila\" ondblclick=\"#{eventDbclick}\" data-state=\"#{opcionClass}\">
						<div id=\"MuestraToltip_#{name}_#{key}\" class=\"grilla_col_first\">
							<div id=\"grilla_fila_cont_#{name}_#{key}\" class=\"grilla_fila_cont\">#{contRow}</div>
							<div id=\"grilla_fila_image_#{name}_#{key}\" class=\"grilla_fila_image\" data-icon=\"#{opcionClass}\"></div>
						</div>
						#{htmlCol}
					</div>"

			if opcionClass != 'fUpdate' and opcionClass != 'updateRow'
				html += "<div id=\"grilla_content_fila_#{name}_#{key}\" class=\"grilla_content_fila\" data-id=\"#{key}\" data-cont=\"#{contRow}\" style=\"float:left; width:100%;\">#{row}</div>"
			else html += row
		html

	_createCol = (name,row,cols) ->
		html = ""
		for own key, obj of cols
			html += "<div id=\"div_#{name}_#{key}_#{row}\" class=\"grilla_celdas\" style=\"float:left; width:#{obj.width}px; #{obj.style}\" data-type=\"#{obj.type}\">#{obj.html}</div>"
		html

	_createTbar = (name,url,idApply,fAncho,fAlto,fTitle,textBtnNuevo,fPermisoInsert) ->
		document.getElementById(idApply).innerHTML += "<div id=\"grilla_tbar_#{name}\" style=\"margin:0; padding:0;\"></div>";

		if fPermisoInsert is true or fPermisoInsert is "true"
			$W.Tbar({
				idApply : "grilla_tbar_#{name}",
				items   : [{
					xtype   : "button",
					id      : "btn_#{name}_new",
					cls     : "user_black_36",
					text    : textBtnNuevo,
					handler : () -> $W.Grilla.fOpen name,url,"",fAncho,fAlto,fTitle
					# handler : function(){ grilla_form_open(name, url, "", "'.$this->FAncho.'", "'.$this->FAlto.'", "'.$this->FTitle.'", '.$this->objScriptPost.'); }
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