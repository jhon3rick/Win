"use strict"

do ($W = Win) ->

	$W.Form = {}

	#############################################################
	# LOAD FORM INSERT OR UPDATE
	#############################################################
	$W.Form.ini = (obj,varPost) ->
		if obj is null then return

		indexClass = obj.indexClass or ''
		name = obj.name or ''
		url = obj.url or ''
		size = obj.size or {}
		field = obj.field or {}
		opcionClass = obj.opcionClass or ''
		idApply = "parent_form_#{name}"

		# SIZE BODY #
		fBodyAncho = size.fBodyAncho || ''
		if fBodyAncho > 0 then fBodyAncho += 'px'
		else if fBodyAncho == 'auto' or fBodyAncho==0 then fBodyAncho='auto'

		if !isNaN(size.fDivAncho) then size.fDivAncho = size.fDivAncho+'px'		# DIV ANCHO #
		if !isNaN(size.fDivAlto) then size.fDivAlto = size.fDivAlto+'px'		# DIV ALTO #
		if !isNaN(size.fLabelAncho) then size.fLabelAncho = size.fLabelAncho+'px'		# LABEL ANCHO #
		if !isNaN(size.fFieldAncho) then size.fFieldAncho = size.fFieldAncho+'px'		# FIELD ALTO #

		fTbar = obj.fTbar or false
		fPermisoInsert = obj.fPermisoInsert or false
		fPermisoUpdate = obj.fPermisoUpdate or false
		fPermisoDelete = obj.fPermisoDelete or false

		varPost = varPost or {}

		# VALIDATE PERMISSION INSERT
		if opcionClass=='vInsert' and fPermisoInsert isnt true and fPermisoInsert isnt "true" then return

		htmlForm = _routerForm opcionClass,name,field,size

		$W("##{idApply}").append("<div id=\"form_tbar_#{name}\"></div>
							<form name=\"form_#{name}\" id=\"form_#{name}\" onsubmit=\"return false;\" data-role=\"win-body\" style=\"overflow:auto;\">
								<div id=\"div_script_form_#{name}\" class=\"form_load\"></div>
								<div class=\"form_body\" style=\"width:#{fBodyAncho};\">#{htmlForm}</div>
							</form>")
		# CREATE TBAR
		if fTbar is true then _createBtnTbar name,opcionClass,url,indexClass,fPermisoInsert,fPermisoUpdate,fPermisoDelete,varPost

		# VALIDATE PERMISSION UPDATE
		if opcionClass=='vUpdate' and fPermisoUpdate isnt true and fPermisoUpdate isnt "true" then $W("#form_#{name} input, #form_#{name} select, #form_#{name} textarea").attr("disabled","true")

		# VALIDATE INPUT FORM
		$W.Form.validate idApply

	_createBtnTbar = (name,opcionClass,url,indexClass,fPermisoInsert,fPermisoUpdate,fPermisoDelete,varPost) ->
		arrayBtn = []

		if opcionClass=='vInsert' and fPermisoInsert isnt false  and fPermisoInsert isnt "false"
			arrayBtn.push
				xtype   : "button",
				id      : "fInsert_#{name}",
				cls     : "grilla_save",
				width   : 60,
				text    : "Guardar",
				handler : () -> $W.Form.fSave name,url,indexClass,varPost

		else if opcionClass=='vUpdate' and fPermisoUpdate isnt false  and fPermisoUpdate isnt "false"
			arrayBtn.push
				xtype   : "button",
				id      : "fUpdate_#{name}",
				cls     : "grilla_save",
				width   : 60,
				text    : "Actualizar",
				handler : () -> $W.Form.fSave name,url,indexClass,varPost

		if opcionClass=='vUpdate' and fPermisoDelete isnt false  and fPermisoDelete isnt "false"
			arrayBtn.push
				xtype   : "button",
				id      : "fDelete_#{name}",
				cls     : "grilla_delete",
				width   : 60,
				text    : "Eliminar",
				handler : () -> $W.Form.fDelete name,url,indexClass,varPost

		$W.Tbar {
			idApply : "form_tbar_#{name}",
			items   : arrayBtn
		}

	_routerForm = (opcionClass,name,obj,size) ->

		html = ""
		for own field, value of obj
			switch value.type
				when 'TextField' then html+=_createTextField name,field,value,size
				when 'ComboBox' then html+=_createComboBox name,field,value,size
				when 'TextArea' then html+=_createTextArea name,field,value,size
				when 'Separador' then html+=_createSeparador value
		html

	###
	# METHOD STATIC
	# CREATE FIELD INPUT
	###
	_createTextField = (name,field,obj,size) ->
		type    = 'text'
		display = 'block'
		validate = obj.validate or ''

		if validate != '' then validate = "data-validate=\"#{validate}\""

		if obj.hidden is true or obj.hidden == "true" or obj.hidden == "hidden"
			type    = 'hidden';
			display = 'none';

		style = if obj.required is true and obj.value == '' then 'empy' else 'none'

		"<div id=\"form_content_field_#{name}_#{field}\" class=\"form_content_field\" style=\"width:#{size.fDivAncho}; min-height:#{size.fDivAlto}; display:#{display}\">
			<div id=\"form_label_#{name}_#{field}\" class=\"form_label\" style=\"width:#{size.fLabelAncho};\">#{obj.label}</div>
			<div id=\"form_field_#{name}_#{field}\" class=\"form_field\" style=\"width:#{size.fFieldAncho};\">
				<input type=\"#{type}\" id=\"form_#{name}_#{field}\" value=\"#{obj.value}\" style=\"width:#{obj.width}px;\" data-value=\"#{obj.value}\" data-required=\"#{obj.required}\" data-style=\"#{style}\" data-label=\"#{obj.label}\" #{validate}/>
			</div>
		</div>"

	###
	# METHOD STATIC
	# CREATE FIELD SELECT
	###
	_createComboBox = (name,field,obj,size) ->
		style  = if obj.required is true and obj.value == '' then 'empy' else 'none'
		option = obj.option or {}
		htmlOption = _createOptionCombo obj.value,option

		"<div id=\"form_content_field_#{name}_#{field}\" class=\"form_content_field\" style=\"width:#{size.fDivAncho}; min-height:#{size.fDivAlto};\">
			<div id=\"form_label_#{name}_#{field}\" class=\"form_label\" style=\"width:#{size.fLabelAncho};\">#{obj.label}</div>
			<div id=\"form_field_#{name}_#{field}\" class=\"form_field\" style=\"width:#{size.fFieldAncho};\">
				<select id=\"form_#{name}_#{field}\" style=\"width:#{obj.width}px;\" data-value=\"#{obj.value}\" data-textdb=\"#{obj.textdb}\" data-required=\"#{obj.required}\" data-style=\"#{style}\" data-label=\"#{obj.label}\">#{htmlOption}</select>
			</div>
		</div>"

	_createOptionCombo = (value,obj) ->
		html  = "<option value=\"\">Seleccione...</option>"
		value = value.toString()

		for own key, option of obj
			index = option.index.toString()
			selected = if index == value then "selected" else ""
			html += "<option value=\"#{index}\" #{selected}>#{option.value}</option>"
		html

	###
	# METHOD STATIC
	# CREATE FIELD TEXTAREA
	###
	_createTextArea = (name,field,obj,size) ->
		style = if obj.required is true and obj.value == '' then 'empy' else 'none'
		value = (obj.value).replace /<br \/>/g,''

		"<div id=\"form_content_field_#{name}_#{field}\" class=\"form_content_field\" style=\"width:#{size.fDivAncho}; min-height:#{size.fDivAlto};\">
			<div id=\"form_label_#{name}_#{field}\" class=\"form_label\" style=\"width:#{size.fLabelAncho};\">#{obj.label}</div>
			<div id=\"form_field_#{name}_#{field}\" class=\"form_field\" style=\"width:#{size.fFieldAncho};\">
				<textarea id=\"form_#{name}_#{field}\" style=\"width:#{obj.width}px; height:#{obj.height}px;\" data-required=\"#{obj.required}\" data-style=\"#{style}\" data-label=\"#{obj.label}\">#{value}</textarea>
			</div>
		</div>"

	###
	# METHOD STATIC
	# CREATE SEPARATOR
	###
	_createSeparador = (obj) ->
		"<div class=\"form_separador\">
			<div style=\"width:80%; float:left\">#{obj.text}</div>
		</div>"

	#############################################################
	# VALIDATE INPUT
	#############################################################
	$W.Form.field = (obj) ->
		switch obj.type
			when 'integer'
				$W('#'+obj.idApply).addClass += " win-input-number";

				$W('#'+obj.idApply)[0].onkeypress = (event)->
					return _validateInteger({ event:event, eventType:'keypress', input:this })

				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validateInteger({ event:event, eventType:'change', input:this })

			when 'double'
				$W('#'+obj.idApply).addClass += " win-input-number";

				$W('#'+obj.idApply)[0].onkeypress = (event)->
					return _validateDouble({ event:event, eventType:'keypress', input:this })

				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validateDouble({ event:event, eventType:'change', input:this })

			when 'real'
				$W('#'+obj.idApply).addClass += " win-input-number";

				$W('#'+obj.idApply)[0].onkeypress = (event)->
					return _validateReal({ event:event, eventType:'keypress', input:this })

				$W('#'+obj.idApply).on('change', (event)->
					return _validateReal({ event:event, eventType:'change', input:this })
				)

			when 'text'
				$W('#'+obj.idApply)[0].onkeyup = (event)->
					return _validateText({ event:event, eventType:'keyup', input:this, option:obj.option })

				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validateText({ event:event, eventType:'change', input:this, option:obj.option })

			when 'email'
				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validateEmail({ event:event, input:this })

			when 'date'
				_validateDate(obj)

			when 'percent'
				# $W('#'+obj.idApply).addClass += " win-input-number";
				$W('#'+obj.idApply)[0].onkeydown = (event)->
					if event.keyCode==13
						return _validatePercent({ event:event, eventType:'keypress', input:this })

				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validatePercent({ event:event, input:this })

	###
	# VALIDATE INPUT FORM
	###
	$W.Form.validate = (id) ->
		campos = document.getElementById(id).querySelectorAll("input, textarea, select")

		[].forEach.call(campos, (input)->
			type = input.getAttribute('data-validate')

			switch type

				when 'integer'
					input.className += " win-input-number";

					input.onkeypress = (event)->
						_validateInteger({ event:event, eventType:'keypress', input:this })

					input.addEventListener "change", (event) ->
						_validateInteger({ event:event, eventType:'change', input:this })

				when 'double'
					input.className += " win-input-number"

					# input.onkeypress = (event)->
					# 	_validateDouble({ event:event, eventType:'keypress', input:this })

					input.addEventListener "change", (event) ->
						_validateDouble({ event:event, eventType:'change', input:this })

				when 'real'
					input.className += " win-input-number";

					input.onkeypress = (event)->
						return _validateReal({ event:event, eventType:'keypress', input:this })

					input.onchange = (event)->
						return _validateReal({ event:event, eventType:'change', input:this })

				when 'uppercase'
					input.className += " win-input-uppercase"

					input.addEventListener "change", (event) ->
						_validateUpperCase({ event:event, eventType:'change', input:this })


				when 'lowercase'
					input.className += " win-input-lowercase"

					input.addEventListener "change", (event) ->
						_validateLowerCase({ event:event, eventType:'change', input:this })

				when 'email'
					input.addEventListener "change", (event) ->
						_validateEmail({ event:event, input:this })

				when 'percent'
					input.addEventListener "change", (event) ->
						_validatePercent({ event:event, input:this })

				when 'date'
					_validateDate(input)

				else
					input.onkeyup = (event)->
						_validateText({ event:event, eventType:'keyup', input:this })

					input.onchange = (event)->
						_validateText({ event:event, eventType:'change', input:this })
		)

	###
	# METHOD STATIC VALIDATE
	###
	_validateInteger = (obj) ->
		key = if document.all then obj.event.keyCode else obj.event.which

		if _keyEnable(key) then return true
		else if obj.eventType == 'keypress' then return (/\d/).test(String.fromCharCode(key))
		else if obj.eventType == 'change' then obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')

	_validateDouble = (obj) ->
		key = if document.all then obj.event.keyCode else obj.event.which

		if _keyEnable(key) then return true
		else if obj.eventType == 'keypress' then return (/[\d.]/).test(String.fromCharCode(key))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')
			validate = !!(obj.input.value).toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/)
			if !validate
				arrayValue = (obj.input.value).split(".")
				obj.input.value = arrayValue[0]+'.'+arrayValue[1]

	_validateReal = (obj) ->
		key = if document.all then obj.event.keyCode else obj.event.which

		if _keyEnable(key) then return true
		else if obj.eventType == 'keypress' then return (/[\d.-]/).test(String.fromCharCode(key))
		else if obj.eventType == 'change'
			value = obj.input.value
			if value is '' then return
			value = value.replace(/[^\d.-]/g,'')
			if isNaN value then  obj.input.value = ''
			else obj.input.value = value

	_validateText = (obj) ->
		key = if document.all then obj.event.keyCode else obj.event.which

		if _keyEnable(key) then return true
		# else if obj.eventType == 'keypress' then return (/[^\#\-\"\']/).test(String.fromCharCode(key))
		else if obj.eventType == 'change' then obj.input.value = (obj.input.value).replace(/[\#\-\"\']/g,'')

	_validateUpperCase = (obj) ->
		key = if document.all then obj.event.keyCode else obj.event.which
		if _keyEnable(key) then return true
		else obj.input.value = ((obj.input.value).replace(/[\#\-\"\']/g,'')).toUpperCase()
		true

	_validateLowerCase = (obj) ->
		key = if document.all then obj.event.keyCode else obj.event.which
		if _keyEnable(key) then return true
		else obj.input.value = ((obj.input.value).replace(/[\#\-\"\']/g,'')).toUpperCase()
		true

	_validateEmail = (obj) ->
		validate = !!(obj.input.value).toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i)
		if !validate
			obj.input.value=""
			obj.input.focus()

	_validatePercent = (obj) ->
		max = obj.input.getAttribute('data-max') * 1
		min = obj.input.getAttribute('data-min') * 1
		result = obj.input.value * 1
		if result <= max
			if result >= min
				console.log  'valor aceptado'
			else
				alert 'no se aceptan  menores a ' + min
				obj.input.value = ''
				obj.input.focus()
		else
			alert 'no se aceptan muneros mayores a' + max
			obj.input.value = ''
			obj.input.focus()

		return true

	###
	# KEY CODE
	#
	# key==8 		// BACKSPACE
	# key==9 		// TAB
	# key==0 		// TAB
	# key==13 		// ENTER
	# key==37 		// CURSOR LEFT
	# key==39 		// CURSOR RIGHT
	# key==38 		// CURSOR TOP
	# key==40 		// CURSOR BOTTOM
	#
	###
	_keyEnable = (key) ->
		if key==8 or key==9 or key==0 or key==13 or key==37 or key==38 or key==39 or key==40 then return true
		return false

	###
	# Calendar
	###
	_validateDate = (obj) ->

		window.addEventListener "click", (event) ->
			if $W('.win-calendar-parent')[0]
				_removeCalendar $W('#date_'+id)[0]
				event.preventDefault
				event.stopPropagation()

		if obj is null then return

		separator    = '-'
		id           = obj.idApply or obj.id
		format       = obj.format or 'y-m-d'
		selected     = obj.selected or ''

		# monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
		monthNames   = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
		dayNames     = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

		# weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S']
		weekDays   = ['D', 'L', 'M', 'M', 'J', 'V', 'S']

		# ATRAPA EL ELEMENTO
		inputCalendar = if id != '' then document.getElementById(id) or obj
		inputCalendar.dataset.icon = 'date'

		if typeof(obj.value)!='undefined' then inputCalendar.value = obj.value

		arrayDate   = []
		separator   = (format.replace(/[a-zA-Z\d\s]/g ,''))[0]
		formatField = (format.replace(/[^a-zA-Z\d\s]/g ,''))
		valueField  = (inputCalendar.value.split(/[^\d]/))

		if inputCalendar.value == ''
			selectedYear  = new Date().getFullYear()	# 0-11
			selectedMonth = new Date().getMonth()
			selectedDay   = new Date().getDate()
		else
			arrayDate[formatField[0]] = valueField[0]*1
			arrayDate[formatField[1]] = valueField[1]*1
			arrayDate[formatField[2]] = valueField[2]*1

			selectedYear  = arrayDate['y']
			selectedMonth = arrayDate['m']-1
			selectedDay   = arrayDate['d']

		inputCalendar.readOnly = true

		inputCalendar.onclick = (e) ->
			if $W('.win-calendar-parent')[0]
				_removeCalendar $W('#date_'+id)[0]
				return

			_drawCalendar(this)
			_setupDays(this)

			e.preventDefault
			e.stopPropagation()

		###
		_drawCalendar
		@paran obj this
		###
		_drawCalendar = (inputObj) ->

			html = "<table id=\"win-calendar-year-#{id}\" cellpadding=\"0\" cellspacing=\"0\" class=\"win-calendar-year\" style=\"display:table;\"></table>
					<table id=\"win-calendar-#{id}\" cellpadding=\"0\" cellspacing=\"0\" class=\"win-calendar\">
						<tr class=\"calendar-controls\">
							<td id=\"prev-month-#{id}\" class=\"calendar-change previous\">  </td>
							<td id=\"title-date-#{id}\" colspan=\"5\" class=\"calendar-header\">"+_getMonthName(selectedMonth)+" "+selectedYear+"</td>
							<td id=\"next-month-#{id}\" class=\"calendar-change next\">  </td>
						</tr>
						<tr class=\"weekDaysTitleRow\">"

			# CALENDAR DAYS
			for day in weekDays
				html += "<td>#{day}</td>"

			daysInMonth = _getDaysInMonth(selectedYear, selectedMonth)
			startDay    = _getFirstDayofMonth(selectedYear, selectedMonth)
			numRows     = 0
			printDate   = 1

			if startDay != 7
				numRows = Math.ceil (startDay + 1 + daysInMonth) / 7
				noPrintDays = startDay + 1
			else
				noPrintDays = 0

			today     = new Date().getDate()
			thisMonth = new Date().getMonth()
			thisYear  = new Date().getFullYear()

			# CALENDAR ROWS
			for e in [0...numRows]
				html += "<tr class=\"weekDaysRow\">"

				for f in [0...7]
					if printDate == today and selectedYear == thisYear and selectedMonth == thisMonth and noPrintDays == 0
						html += "<td id=\"today\" class=\"weekDaysCell\">"
					else html += "<td class=\"weekDaysCell\">"

					if noPrintDays == 0
						if printDate <= daysInMonth then html += "<a>#{printDate}</a>"
						printDate++

					html += "</td>"
					if noPrintDays > 0 then noPrintDays--

				html += "</tr>"

			html += "</table>"

			# ADD CALENDAR TO ELEMENT TO CALENDAR DIV
			if $W('#date_'+id).length > 0
				$W('#date_'+id).html(html)
			else
				divCalendar = document.createElement("div")
				divCalendar.innerHTML = html

				divCalendar.setAttribute("id", "date_"+id)
				divCalendar.setAttribute("class","win-calendar-parent")
				$W('#'+id)[0].parentNode.insertBefore(divCalendar, $W('#'+id)[0].nextSibling)
				_setLocate(inputCalendar, divCalendar)

			$W('#title-date-'+id)[0].onclick = (e) ->
				year = (this.innerHTML).split(' ')[1] * 1
				_changeYear(year-5,inputObj)

				e.preventDefault
				e.stopPropagation()

			# NEXT AND PREVIOUS MONTH
			$W('#prev-month-'+id)[0].onclick = (e) ->
				selectedMonth--

				if selectedMonth < 0
					selectedMonth = 11
					selectedYear--

				_drawCalendar(inputObj)
				_setupDays(inputObj)

				e.preventDefault
				e.stopPropagation()

			$W('#next-month-'+id)[0].onclick = (e) ->
				selectedMonth++

				if selectedMonth > 11
					selectedMonth = 0
					selectedYear++

				_drawCalendar(inputObj)
				_setupDays(inputObj)

				e.preventDefault
				e.stopPropagation()

		###
		_changeYear
		@param str year
		###
		_changeYear = (year,inputObj) ->
			year1  = year
			year2  = year + 6
			option = ""

			for i in [0...6]
				j = i+6

				option += "<div>
								<div class=\"date-change-month\" data-value=\"#{i}\">#{monthNames[i].substr(0,3)}</div>
								<div class=\"date-change-month\" data-value=\"#{j}\">#{monthNames[j].substr(0,3)}</div>
							</div>"

			html  = "<tr>
						<td colspan=\"2\" rowspan=\"7\" class=\"content-month\">#{option}</td>
						<td colspan=\"2\" class=\"content-year\">
							<div id=\"change-year-down-#{id}\" class=\"calendar-change\" style=\"float:left;\"> < </div>
							<div id=\"change-year-top-#{id}\" class=\"calendar-change\" style=\"float:right;\"> > </div>
						</td>
					</tr>"
			for i in [0...6]
				html += "<tr>
							<td data-year=\"false\">#{year1++}</td>
							<td data-year=\"false\">#{year2++}</td>
						</tr>"

			html += "<tr style=\"border-top:1px solid #fff;\">
						<td colspan=2 style=\"padding:0px; border-right:1px solid #fff;\">
							<input type=\"button\" style=\"width:100%; padding:3px;\" id=\"boton-done-calendar-#{id}\" value=\"Aceptar\">
						</td>
						<td colspan=2 style=\"padding:0px;\">
							<input type=\"button\" style=\"width:100%; padding:3px;\" value=\"Volver\" id=\"boton-back-calendar-#{id}\">
						</td>
					</tr>"


			$W('#win-calendar-year-'+id).style('display','table')
			$W('#win-calendar-'+id).style('display','none')

			# $W('#win-calendar-'+id).hide()
			$W('#win-calendar-year-'+id).html(html)
			$W('#win-calendar-year-'+id+' td').onclick = (e) ->
				console.log(this);

			$W("#change-year-top-#{id}")[0].onclick = (e) ->
				_changeYear(year2,inputObj)
				e.preventDefault
				e.stopPropagation()

			$W("#change-year-down-#{id}")[0].onclick = (e) ->
				_changeYear(year-12,inputObj)
				e.preventDefault
				e.stopPropagation()

			$W("#boton-back-calendar-#{id}")[0].onclick = (e) ->
				_changeToCalendarDay()
				e.preventDefault
				e.stopPropagation()

			$W(".date-change-month").on('click',
				(e) ->
					_setMonth e,id
					e.preventDefault
					e.stopPropagation()
			)

			$W("#win-calendar-year-#{id} [data-year] ").on('click',
				(e) ->
					_setYear e,id
					e.preventDefault
					e.stopPropagation()
			)

			$W("#boton-done-calendar-#{id}")[0].onclick = (e) ->
				new_month = document.getElementById(id).getAttribute('data-month')
				new_year = selectedYear - document.getElementById(id).getAttribute('data-year')
				# console.log('selectedYear: '+selectedYear+' new_month: '+new_month+' new_year: '+new_year+' abs new_year: '+Math.abs(new_year)+' input-data: '+(selectedYear-document.getElementById(id).getAttribute('data-year')) )

				selectedMonth = new_month
				selectedYear  = if new_year<0 then selectedYear+Math.abs(new_year) else selectedYear-new_year

				if selectedMonth != null && selectedYear !=0
					_drawCalendar(inputObj)
					_setupDays(inputObj)

				e.preventDefault
				e.stopPropagation()

		###
		_removeCalendar
		###
		_changeToCalendarDay = () ->
			$W('#win-calendar-year-'+id).style('display','none')
			$W('#win-calendar-'+id).style('display','table')

			# $W('#win-calendar-year-'+id).hide()
			# $W('#win-calendar-'+id).show()

		###
		_removeCalendar
		@param obj calendar $W('#date_'+id)[0]
		###
		_removeCalendar = (obj) -> obj.parentNode.removeChild(obj);

		###
		_setupDays
		@param obj input date $W('#'+id)[0]
		###
		_setupDays = (inputObj) ->
			# set up link events on calendar table
			y = $W('#win-calendar-'+id)[0]
			x = y.getElementsByTagName('a')

			for i in x
				i.onclick = () ->

					selectedDay = this.innerHTML
					inputObj.value = _formatDate(selectedDay, selectedMonth, selectedYear)

					# inputCalendar.select = selected

					_removeCalendar($W('#date_'+id)[0])

		###
		_formatDate
		@param int dia
		@param int mes
		@param int año
		###
		_formatDate = (Day, Month, Year) ->
			Month++
			# adjust javascript month
			if (Month < 10) then Month = '0' + Month
			# add a zero if less than 10
			if (Day < 10) then Day = '0' + Day
			# add a zero if less than 10
			array = []
			array['y'] = Year
			array['m'] = Month
			array['d'] = Day

			dateString = array[formatField[0]] + separator + array[formatField[1]] + separator + array[formatField[2]]

		###
		_getMonthName
		@param  int month
		@return str name month
		###
		_getMonthName = (month) ->
			monthNames[month]

		###
		_getDayName
		@param  int dia
		@return str name day
		###
		_getDayName = (day) ->
			dayNames[day]

		_getDaysInMonth = (year, month) ->
			return 32 - new Date(year, month, 32).getDate()

		_getFirstDayofMonth = (year, month) ->
			day = new Date(year, month, 0).getDay()

		###
		_setLocate
		@param obj input date $W('#'+id)[0]
		@param obj calendar $W('#date_'+id)[0]
		###
		_setLocate = (targetObj, moveObj) ->
			coors = _findXY(targetObj)
			moveObj.style.top  = coors.top + 23 + 'px'
			moveObj.style.left = coors.left + 'px'

		###
		_findXY
		@param  obj dom XY Coord
		@return arr [left.px, top.px]
		###
		_findXY = (element) ->
			if typeof element == "string" then element = document.getElementById(element)
			else if !element then return { top:0,left:0 }

			y = 0
			x = 0

			if element.getBoundingClientRect()
				size = element.getBoundingClientRect()
				return { top:size.top, left:size.left }

			while element.offsetParent
				x += element.offsetLeft
				y += element.offsetTop
				element = element.offsetParent

			return { top:y, left:x }

		###
		_setYear
		@param obj dom input
		@param id id input
		###
		_setYear = (e,id) ->
			$W("#win-calendar-year-#{id} [data-year] ").style('background-color','');
			$W("#win-calendar-year-#{id} [data-year] ").style('color','');
			e.toElement.setAttribute('style','background-color:#ADADAD;color:#000;');
			document.getElementById(id).dataset.year = e.toElement.innerHTML

		###
		_setMonth
		@param obj dom input
		@param id id input
		###
		_setMonth = (e,id) ->
			$W(".date-change-month").style('background-color','');
			$W(".date-change-month").style('color','');
			e.toElement.setAttribute('style','background-color:#ADADAD;color:#000;');
			document.getElementById(id).dataset.month = e.toElement.getAttribute('data-value')