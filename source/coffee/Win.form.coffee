###
# Validacion campos formulario
#
# tecla==8 		//BACKSPACE
# tecla==9 		//TAB
# tecla==0 		//TAB
# tecla==13 	//ENTER
#
###

"use strict"

do ($W = Win) ->

	$W.form = {}

	$W.form.field = (obj) ->
		switch obj.type
			when 'integer'
				$W('#'+obj.idApply).addClass += " win-input-number";

				$W('#'+obj.idApply)[0].onkeypress = (event)->
					return _validateIntField({ event:event, eventType:'keypress', input:this })

				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validateIntField({ event:event, eventType:'change', input:this })

			when 'double'
				$W('#'+obj.idApply).addClass += " win-input-number";

				$W('#'+obj.idApply)[0].onkeypress = (event)->
					return _validateDoubleField({ event:event, eventType:'keypress', input:this })

				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validateDoubleField({ event:event, eventType:'change', input:this })

			when 'text'
				$W('#'+obj.idApply)[0].onkeyup = (event)->
					return _validateTextField({ event:event, eventType:'keyup', input:this, option:obj.option })

				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validateTextField({ event:event, eventType:'change', input:this, option:obj.option })

			when 'email'
				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validateEmailField({ event:event, input:this })

			when 'date'
				_validateDateField(obj)

			when 'percent'
				# $W('#'+obj.idApply).addClass += " win-input-number";
				$W('#'+obj.idApply)[0].onkeyup = (event)->
					return _validatePercentField({ event:event, eventType:'keyup', input:this, option:obj.option })

				$W('#'+obj.idApply)[0].onchange = (event)->
					return _validatePercentField({ event:event, eventType:'change', input:this })

	$W.form.validate = (id) ->
		campos = document.getElementById(id).querySelectorAll("input, textarea, select")

		[].forEach.call(arrayinput, (input)->
			type = input.getAttribute('data-validate');

			switch type
				when 'integer'
					input.addClass += " win-input-number";

					input.onkeypress = (event)->
						_validateIntField({ event:event, eventType:'keypress', input:this })

					input.onchange = (event)->
						_validateIntField({ event:event, eventType:'change', input:this })

				when 'double'
					input.addClass += " win-input-number";

					input.onkeypress = (event)->
						_validateDoubleField({ event:event, eventType:'keypress', input:this })

					input.onchange = (event)->
						_validateDoubleField({ event:event, eventType:'change', input:this })

				when 'text'
					input.onkeyup = (event)->
						_validateTextField({ event:event, eventType:'keyup', input:this, option:obj.option })

					input.onchange = (event)->
						_validateTextField({ event:event, eventType:'change', input:this, option:obj.option })

				when 'email'
					input.onchange = (event)->
						_validateEmailField({ event:event, input:this })

				when 'percent'
					input.onchange = (event)->
						_validatePercentField({ event:event, input:this })

				when 'date'
					_validateDateField(obj)
		)


	_validateIntField = (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keypress'
			return (/\d/).test(String.fromCharCode(tecla))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')

	_validateDoubleField = (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keypress'
			return (/[\d.]/).test(String.fromCharCode(tecla))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')
			validate = !!(obj.input.value).toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/)
			if !validate
				arrayValue = (obj.input.value).split(".")
				obj.input.value = arrayValue[0]+'.'+arrayValue[1]

	_validateTextField = (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keyup'
			if obj.option=='uppercase'
				obj.input.value = obj.input.value.toUpperCase()
			else if obj.option=='lowercase'
				obj.input.value = obj.input.value.toLowerCase()
		else if obj.eventType == 'change'
			console.log('-'+obj.input.value+'-')
			obj.input.value = (obj.input.value).replace(/[\#\-\"\'|^\s+|\s+$]/g,'')


	_validateEmailField = (obj) ->
		validate = !!(obj.input.value).toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i)
		if !validate
			obj.input.value=""
			obj.input.focus()

	_validatePercentField = (obj) ->

		min = obj.input.getAttribute('data-min')
		max = obj.input.getAttribute('data-max')

		# if obj.input.value < '' then obj.input.value  = 0
		if obj.input.value < min then obj.input.value = obj.input.value
		# if obj.input.value > max then obj.input.value = 100



	###
	# Calendar
	###
	_validateDateField = (obj) ->
		separator    = '-'
		id           = obj.idApply
		format       = obj.format or 'y-m-d'
		selected     = obj.selected or ''

		# monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
		monthNames   = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
		dayNames     = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

		# weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S']
		weekDays   = ['D', 'L', 'M', 'M', 'J', 'V', 'S']

		# ATRAPA EL ELEMENTO
		inputCalendar = $W('#'+id)[0]
		inputCalendar.dataset.icon = 'date'

		if typeof(obj.value)!='undefined' then inputCalendar.value = obj.value

		arrayDate   = []
		separator   = (format.replace(/[a-zA-Z\d\s]/g ,''))[0]
		formatField = (format.replace(/[^a-zA-Z\d\s]/g ,''))
		valueField  = (inputCalendar.value.replace(/[^\d]/g ,''))

		if inputCalendar.value == ''
			selectedYear  = new Date().getFullYear()	# 0-11
			selectedMonth = new Date().getMonth()
			selectedDay   = new Date().getDate()	# 4-digit year
		else
			arrayDate[formatField[0]] = valueField[0]
			arrayDate[formatField[1]] = valueField[1]
			arrayDate[formatField[2]] = valueField[2]

			selectedYear  = new Date(arrayDate.y).getFullYear()
			selectedMonth = new Date(arrayDate.m).getMonth()
			selectedDay   = new Date(arrayDate.d).getDate()	# 4-digit year

		inputCalendar.readOnly = true

		inputCalendar.onclick = () ->

			if $W('#date_'+id)[0]
				_removeCalendar $W('#date_'+id)[0]
				return;

			_drawCalendar(this)
			_setupDays(this)

		###
		_drawCalendar
		@paran obj this
		###
		_drawCalendar = (inputObj) ->

			html = """<table id="win-calendar-year-#{id}" cellpadding="0" cellspacing="0" class="win-calendar-year" style="display:block;"></table>
					<table id="win-calendar-#{id}" cellpadding="0" cellspacing="0" class="win-calendar">
						<tr>
							<td id="prev-month-#{id}" class="calendar-change"> < </td>
							<td id="title-date-#{id}" colspan="5" class="calendar-header">"""+_getMonthName(selectedMonth)+' ' +selectedYear+"""</td>
							<td id="next-month-#{id}" class="calendar-change"> > </td>
						</tr>
						<tr class="weekDaysTitleRow">"""

			# CALENDAR DAYS
			for day in weekDays
				html += """<td>#{day}</td>"""

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
				html += '<tr class="weekDaysRow">'

				for f in [0...7]
					if printDate == today and selectedYear == thisYear and selectedMonth == thisMonth and noPrintDays == 0
						html += '<td id="today" class="weekDaysCell">'
					else html += '<td class="weekDaysCell">'

					if noPrintDays == 0
						if printDate <= daysInMonth then html += "<a>#{printDate}</a>"
						printDate++

					html += '</td>'
					if noPrintDays > 0 then noPrintDays--

				html += '</tr>'

			html += '</table>'

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

			$W('#title-date-'+id)[0].onclick = () ->
				year  = (this.innerHTML).split(' ')[1] * 1
				_changeYear(year-5)

			# NEXT AND PREVIOUS MONTH
			$W('#prev-month-'+id)[0].onclick = () ->
				selectedMonth--

				if selectedMonth < 0
					selectedMonth = 11
					selectedYear--

				_drawCalendar(inputObj)
				_setupDays(inputObj)

			$W('#next-month-'+id)[0].onclick = () ->
				selectedMonth++

				if selectedMonth > 11
					selectedMonth = 0
					selectedYear++

				_drawCalendar(inputObj)
				_setupDays(inputObj)

		###
		_changeYear
		@param str year
		###
		_changeYear = (year) ->
			year1  = year
			year2  = year + 6
			option = ""

			for i in [0...6]
				j = i+6

				option += """<div>
								<div class="date-change-month">#{monthNames[i].substr(0,3)}</div>
								<div class="date-change-month">#{monthNames[j].substr(0,3)}</div>
							</div>"""

			html  = """<tr>
							<td colspan="2" rowspan="7" class="content-month">#{option}</td>
							<td colspan="2" class="content-year">
								<div id="change-year-down-#{id}" class="calendar-change" style="float:left;"> < </div>
								<div id="change-year-top-#{id}" class="calendar-change" style="float:right;"> > </div>
							</td>
						</tr>"""
			for i in [0...6]
				html += """<tr>
								<td>#{year1++}</td>
								<td>#{year2++}</td>
							</tr>"""

			html += """<tr style="border-top:1px solid #fff;">
							<td colspan=2 style="padding:0px; border-right:1px solid #fff;">
								<input type="button" style="width:100%; padding:3px;" value="Aceptar">
							</td>
							<td colspan=2 style="padding:0px;">
								<input type="button" style="width:100%; padding:3px;" value="Volver" id="boton-back-calendar-#{id}">
							</td>
						</tr>"""


			$W('#win-calendar-'+id).hide()
			$W('#win-calendar-year-'+id).show().html(html)

			$W("#change-year-top-#{id}")[0].onclick = () ->
				_changeYear(year2)

			$W("#change-year-down-#{id}")[0].onclick = () ->
				_changeYear(year-12)

			$W("#boton-back-calendar-#{id}")[0].onclick = () ->
				_changeToCalendarDay()

		###
		_removeCalendar
		###
		_changeToCalendarDay = () ->
			$W('#win-calendar-year-'+id).hide().html('')
			$W('#win-calendar-'+id).show()

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
			console.log(targetObj)
			coors = _findXY(targetObj)
			console.log(coors)
			moveObj.getAttribute("style","position:absolute; z-index:8000;")
			# moveObj.style.position = 'absolute'
			# moveObj.style.top      = coors[1] + 23 + 'px'
			# moveObj.style.left     = coors[0] + 'px'

		###
		_findXY
		@param  obj dom XY Coord
		@return arr [left.px, top.px]
		###
		_findXY = (obj) ->
			curleft = curtop = 0
			if obj.offsetParent
				curleft = obj.offsetLeft
				curtop  = obj.offsetTop
				while (obj = obj.offsetParent)
					curleft += obj.offsetLeft
					curtop  += obj.offsetTop

			return [curleft, curtop]