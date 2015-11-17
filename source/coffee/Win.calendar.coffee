###
# Calendar
###

Win.form.Calendar = (obj) ->
	calendarId    = obj.applyTo
	selectedMonth = new Date().getMonth()
	selectedYear  = new Date().getFullYear()	# 0-11
	selectedDay   = new Date().getDate()	# 4-digit year
	inputClass    = 'calendarSelectDate'

	# ATRAPA EL ELEMENTO
	inputCalendar = document.getElementById(calendarId)
	calendarDiv   = document.getElementById('calendarDiv')

	inputCalendar.readOnly = true

	inputCalendar.onfocus = () ->
		selectedMonth = new Date().getMonth()
		setPos(this, calendarDiv)
		calendarDiv.style.display = 'block'
		drawCalendar(this)
		setupLinks(this)

	# FUNCTION DRAW
	drawCalendar= (inputObj) ->

		html = """<a id="closeCalendar">Close Calendar</a>
				<table cellpadding="0" cellspacing="0" id="linksTable">
					<tr>
						<td><a id="prevMonth"><<</a></td>
						<td><a id="nextMonth">>></a></td>
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

		if startDay != 7
			noPrintDays = startDay + 1
		else
			noPrintDays = 0

		today     = new Date().getDate()
		thisMonth = new Date().getMonth()
		thisYear  = new Date().getFullYear()

		# CALENDAR ROWS
		for e in [0...numRows]
		# for e = 0 e < numRows e++
			html += '<tr class="weekDaysRow">'

			for f in [0...7]
			# for (f = 0 f < 7 f++) {
				if printDate == today and selectedYear == thisYear and selectedMonth == thisMonth and noPrintDays == 0
					html += '<td id="today" class="weekDaysCell">'

				else
					html += '<td class="weekDaysCell">'

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
		document.getElementById('closeCalendar').onclick = () -> calendarDiv.style.display = 'none'

		# setup next and previous links
		document.getElementById('prevMonth').onclick = () ->
			selectedMonth--

			if selectedMonth < 0
				selectedMonth = 11
				selectedYear--

			drawCalendar(inputObj)
			setupLinks(inputObj)

		document.getElementById('nextMonth').onclick = () ->
			selectedMonth++

			if selectedMonth > 11
				selectedMonth = 0
				selectedYear++

			drawCalendar(inputObj)
			setupLinks(inputObj)

	setupLinks= (inputObj) ->
		# set up link events on calendar table
		y = document.getElementById('calendar')
		x = y.getElementsByTagName('a')

		# console.log(x[0]) return
		for i in x
			i.onmouseover = () -> this.parentNode.className = 'weekDaysCellOver'
			i.onmouseout  = () -> this.parentNode.className = 'weekDaysCell'
			i.onclick     = () ->
				document.getElementById('calendarDiv').style.display = 'none'
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
		dateString = Month + '/' + Day + '/' + Year

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