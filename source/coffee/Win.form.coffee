###
# Validacion campos formulario
#
# tecla==8 		//BACKSPACE
# tecla==9 		//TAB
# tecla==0 		//TAB
# tecla==13 	//ENTER
#
###

$W.form = do->
	intField: (obj) ->
		$W('#'+obj.applyTo).className += " win-input-number";

		$W('#'+obj.applyTo).onkeypress = (event)->
			return Win.form.validateIntField({ event:event, eventType:'keypress', input:this })

		$W('#'+obj.applyTo).onchange = (event)->
			return Win.form.validateIntField({ event:event, eventType:'change', input:this })

	doubleField: (obj) ->
		$W('#'+obj.applyTo).className += " win-input-number";

		$W('#'+obj.applyTo).onkeypress = (event)->
			return Win.form.validateDoubleField({ event:event, eventType:'keypress', input:this })

		$W('#'+obj.applyTo).onchange = (event)->
			return Win.form.validateDoubleField({ event:event, eventType:'change', input:this })

	textField: (obj) ->
		$W('#'+obj.applyTo).onkeyup = (event)->
			return Win.form.validateTextField({ event:event, eventType:'keyup', input:this, type:obj.type })

		$W('#'+obj.applyTo).onchange = (event)->
			return Win.form.validateTextField({ event:event, eventType:'change', input:this, type:obj.type })

	emailField: (obj) ->
		$W('#'+obj.applyTo).onchange = (event)->
			return Win.form.validateEmailField({ event:event, input:this })

	globalField: (obj) ->

	validateIntField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keypress'
			return (/\d/).test(String.fromCharCode(tecla))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')

	validateDoubleField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keypress'
			return (/[\d.]/).test(String.fromCharCode(tecla))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')
			console.log(!!(obj.input.value).toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/))
			validate = !!(obj.input.value).toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/)
			if !validate
				arrayValue = (obj.input.value).split(".")
				obj.input.value = arrayValue[0]+'.'+arrayValue[1]

	validateTextField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keyup'
			if obj.type=='uppercase'
				obj.input.value =obj.input.value.toUpperCase()
			else if obj.type=='lowercase'
				obj.input.value = obj.input.value.toLowerCase()
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[\#\-\"\']/g,'')

	validateEmailField: (obj) ->
		validate = !!(obj.input.value).toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i)
		if !validate
			obj.input.value=""
			obj.input.focus()

	###
	# Calendar
	###
	dateField: (obj) ->
		separator  = '-'
		calendarId = obj.applyTo
		inputClass = 'calendarSelectDate'
		format     = obj.format or 'y-m-d'
		selected   = obj.listeners.select or ''

		# console.log(HTML_CONTAINERS)


		# ATRAPA EL ELEMENTO
		inputCalendar = $W('#'+calendarId)
		calendarDiv   = $W('#calendarDiv')

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

		inputCalendar.onfocus = () ->
			setPos(this, calendarDiv)
			calendarDiv.style.display = 'block'
			drawCalendar(this)
			setupLinks(this)

		# FUNCTION DRAW
		drawCalendar= (inputObj) ->

			html = """<a id="closeCalendar">Close Calendar</a>
					<table cellpadding="0" cellspacing="0" id="linksTable">
						<tr>
							<td><a id="prevMonth"><</a></td>
							<td><a id="nextMonth">></a></td>
						</tr>
					</table>
					<table id="calendar" cellpadding="0" cellspacing="0"`class="win-calendar">
						<tr>
							<th colspan="7" class="calendarHeader">"""+getMonthName(selectedMonth)+' ' +selectedYear+"""</th>
						</tr>
						<tr class="weekDaysTitleRow">"""

			# CALENDAR DAYS
			# weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S']
			weekDays = ['D', 'L', 'M', 'M', 'J', 'V', 'S']

			for day in weekDays
				html += """<td>#{day}</td>"""

			daysInMonth = getDaysInMonth(selectedYear, selectedMonth)
			startDay    = getFirstDayofMonth(selectedYear, selectedMonth)
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

			# add calendar to element to calendar Div
			calendarDiv.innerHTML = html

			# close button link
			$W('#closeCalendar').onclick = () -> calendarDiv.style.display = 'none'

			# setup next and previous links
			$W('#prevMonth').onclick = () ->
				selectedMonth--

				if selectedMonth < 0
					selectedMonth = 11
					selectedYear--

				drawCalendar(inputObj)
				setupLinks(inputObj)

			$W('#nextMonth').onclick = () ->
				selectedMonth++

				if selectedMonth > 11
					selectedMonth = 0
					selectedYear++

				drawCalendar(inputObj)
				setupLinks(inputObj)

		setupLinks= (inputObj) ->
			# set up link events on calendar table
			y = $W('#calendar')
			x = y.getElementsByTagName('a')

			for i in x
				i.onclick = () ->

					inputCalendar.selected = selected
					inputCalendar.selected()

					$W('#calendarDiv').style.display = 'none'
					selectedDay = this.innerHTML
					inputObj.value = formatDate(selectedDay, selectedMonth, selectedYear)

		# Functions Dealing with Dates
		formatDate = (Day, Month, Year) ->
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

		getMonthName = (month) ->
			monthNames = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
			# monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
			monthNames[month]

		getDayName = (day) ->
			dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
			dayNames[day]

		getDaysInMonth = (year, month) ->
			return 32 - new Date(year, month, 32).getDate()

		getFirstDayofMonth = (year, month) ->
			day = new Date(year, month, 0).getDay()

		# Position Functions
		setPos = (targetObj, moveObj) ->
			coors = findPos(targetObj)
			moveObj.style.position = 'absolute'
			moveObj.style.top      = coors[1] + 18 + 'px'
			moveObj.style.left     = coors[0] + 'px'

		findPos = (obj) ->
			curleft = curtop = 0
			if obj.offsetParent
				curleft = obj.offsetLeft
				curtop  = obj.offsetTop
				while (obj = obj.offsetParent)
					curleft += obj.offsetLeft
					curtop  += obj.offsetTop

			return [curleft, curtop]