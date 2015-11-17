/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */

/*
 * Calendar
 */
Win.form.Calendar = function(obj) {
  var calendarDiv, calendarId, drawCalendar, findPos, formatDate, getDayName, getDaysInMonth, getFirstDayofMonth, getMonthName, inputCalendar, inputClass, selectedDay, selectedMonth, selectedYear, setPos, setupLinks;
  calendarId = obj.applyTo;
  selectedMonth = new Date().getMonth();
  selectedYear = new Date().getFullYear();
  selectedDay = new Date().getDate();
  inputClass = 'calendarSelectDate';
  inputCalendar = document.getElementById(calendarId);
  calendarDiv = document.getElementById('calendarDiv');
  inputCalendar.readOnly = true;
  inputCalendar.onfocus = function() {
    selectedMonth = new Date().getMonth();
    setPos(this, calendarDiv);
    calendarDiv.style.display = 'block';
    drawCalendar(this);
    return setupLinks(this);
  };
  drawCalendar = function(inputObj) {
    var day, daysInMonth, e, f, html, j, k, l, len, noPrintDays, numRows, printDate, ref, startDay, thisMonth, thisYear, today, weekDays;
    html = "<a id=\"closeCalendar\">Close Calendar</a>\n<table cellpadding=\"0\" cellspacing=\"0\" id=\"linksTable\">\n	<tr>\n		<td><a id=\"prevMonth\"><<</a></td>\n		<td><a id=\"nextMonth\">>></a></td>\n	</tr>\n</table>\n<table id=\"calendar\" cellpadding=\"0\" cellspacing=\"0\"`class=\"win-calendar\">\n	<tr>\n		<th colspan=\"7\" class=\"calendarHeader\">" + getMonthName(selectedMonth) + ' ' + selectedYear + "</th>\n</tr>\n<tr class=\"weekDaysTitleRow\">";
    weekDays = ['D', 'L', 'M', 'M', 'J', 'V', 'S'];
    for (j = 0, len = weekDays.length; j < len; j++) {
      day = weekDays[j];
      html += "<td>" + day + "</td>";
    }
    daysInMonth = getDaysInMonth(selectedYear, selectedMonth);
    startDay = getFirstDayofMonth(selectedYear, selectedMonth);
    numRows = 0;
    printDate = 1;
    if (startDay !== 7) {
      numRows = Math.ceil((startDay + 1 + daysInMonth) / 7);
    }
    if (startDay !== 7) {
      noPrintDays = startDay + 1;
    } else {
      noPrintDays = 0;
    }
    today = new Date().getDate();
    thisMonth = new Date().getMonth();
    thisYear = new Date().getFullYear();
    for (e = k = 0, ref = numRows; 0 <= ref ? k < ref : k > ref; e = 0 <= ref ? ++k : --k) {
      html += '<tr class="weekDaysRow">';
      for (f = l = 0; l < 7; f = ++l) {
        if (printDate === today && selectedYear === thisYear && selectedMonth === thisMonth && noPrintDays === 0) {
          html += '<td id="today" class="weekDaysCell">';
        } else {
          html += '<td class="weekDaysCell">';
        }
        if (noPrintDays === 0) {
          if (printDate <= daysInMonth) {
            html += "<a>" + printDate + "</a>";
          }
          printDate++;
        }
        html += '</td>';
        if (noPrintDays > 0) {
          noPrintDays--;
        }
      }
      html += '</tr>';
    }
    html += '</table>';
    calendarDiv.innerHTML = html;
    document.getElementById('closeCalendar').onclick = function() {
      return calendarDiv.style.display = 'none';
    };
    document.getElementById('prevMonth').onclick = function() {
      selectedMonth--;
      if (selectedMonth < 0) {
        selectedMonth = 11;
        selectedYear--;
      }
      drawCalendar(inputObj);
      return setupLinks(inputObj);
    };
    return document.getElementById('nextMonth').onclick = function() {
      selectedMonth++;
      if (selectedMonth > 11) {
        selectedMonth = 0;
        selectedYear++;
      }
      drawCalendar(inputObj);
      return setupLinks(inputObj);
    };
  };
  setupLinks = function(inputObj) {
    var i, j, len, results, x, y;
    y = document.getElementById('calendar');
    x = y.getElementsByTagName('a');
    results = [];
    for (j = 0, len = x.length; j < len; j++) {
      i = x[j];
      i.onmouseover = function() {
        return this.parentNode.className = 'weekDaysCellOver';
      };
      i.onmouseout = function() {
        return this.parentNode.className = 'weekDaysCell';
      };
      results.push(i.onclick = function() {
        document.getElementById('calendarDiv').style.display = 'none';
        selectedDay = this.innerHTML;
        return inputObj.value = formatDate(selectedDay, selectedMonth, selectedYear);
      });
    }
    return results;
  };
  formatDate = function(Day, Month, Year) {
    var dateString;
    Month++;
    if (Month < 10) {
      Month = '0' + Month;
    }
    if (Day < 10) {
      Day = '0' + Day;
    }
    return dateString = Month + '/' + Day + '/' + Year;
  };
  getMonthName = function(month) {
    var monthNames;
    monthNames = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
    return monthNames[month];
  };
  getDayName = function(day) {
    var dayNames;
    dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return dayNames[day];
  };
  getDaysInMonth = function(year, month) {
    return 32 - new Date(year, month, 32).getDate();
  };
  getFirstDayofMonth = function(year, month) {
    var day;
    return day = new Date(year, month, 0).getDay();
  };
  setPos = function(targetObj, moveObj) {
    var coors;
    coors = findPos(targetObj);
    moveObj.style.position = 'absolute';
    moveObj.style.top = coors[1] + 18 + 'px';
    return moveObj.style.left = coors[0] + 'px';
  };
  return findPos = function(obj) {
    var curleft, curtop;
    curleft = curtop = 0;
    if (obj.offsetParent) {
      curleft = obj.offsetLeft;
      curtop = obj.offsetTop;
      while ((obj = obj.offsetParent)) {
        curleft += obj.offsetLeft;
        curtop += obj.offsetTop;
      }
    }
    return [curleft, curtop];
  };
};
