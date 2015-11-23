/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */

/*
 * Validacion campos formulario
 *
 * tecla==8 		//BACKSPACE
 * tecla==9 		//TAB
 * tecla==0 		//TAB
 * tecla==13 	//ENTER
 *
 */

(function() {
  "use strict";
  (function($W) {
    var _validateDoubleField, _validateEmailField, _validateIntField, _validateTextField;
    $W.form = {};
    $W.form.intField = function(obj) {
      $W('#' + obj.applyTo).addClass += " win-input-number";
      $W('#' + obj.applyTo)[0].onkeypress = function(event) {
        return _validateIntField({
          event: event,
          eventType: 'keypress',
          input: this
        });
      };
      return $W('#' + obj.applyTo)[0].onchange = function(event) {
        return _validateIntField({
          event: event,
          eventType: 'change',
          input: this
        });
      };
    };
    $W.form.doubleField = function(obj) {
      $W('#' + obj.applyTo).addClass += " win-input-number";
      $W('#' + obj.applyTo)[0].onkeypress = function(event) {
        return _validateDoubleField({
          event: event,
          eventType: 'keypress',
          input: this
        });
      };
      return $W('#' + obj.applyTo)[0].onchange = function(event) {
        return _validateDoubleField({
          event: event,
          eventType: 'change',
          input: this
        });
      };
    };
    $W.form.textField = function(obj) {
      $W('#' + obj.applyTo)[0].onkeyup = function(event) {
        return _validateTextField({
          event: event,
          eventType: 'keyup',
          input: this,
          type: obj.type
        });
      };
      return $W('#' + obj.applyTo)[0].onchange = function(event) {
        return _validateTextField({
          event: event,
          eventType: 'change',
          input: this,
          type: obj.type
        });
      };
    };
    $W.form.emailField = function(obj) {
      return $W('#' + obj.applyTo)[0].onchange = function(event) {
        return _validateEmailField({
          event: event,
          input: this
        });
      };
    };
    _validateIntField = function(obj) {
      var tecla;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keypress') {
        return /\d/.test(String.fromCharCode(tecla));
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[^\d.]/g, '');
      }
    };
    _validateDoubleField = function(obj) {
      var arrayValue, tecla, validate;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keypress') {
        return /[\d.]/.test(String.fromCharCode(tecla));
      } else if (obj.eventType === 'change') {
        obj.input.value = obj.input.value.replace(/[^\d.]/g, '');
        validate = !!obj.input.value.toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/);
        if (!validate) {
          arrayValue = obj.input.value.split(".");
          return obj.input.value = arrayValue[0] + '.' + arrayValue[1];
        }
      }
    };
    _validateTextField = function(obj) {
      var tecla;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keyup') {
        if (obj.type === 'uppercase') {
          return obj.input.value = obj.input.value.toUpperCase();
        } else if (obj.type === 'lowercase') {
          return obj.input.value = obj.input.value.toLowerCase();
        }
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[\#\-\"\']/g, '');
      }
    };
    _validateEmailField = function(obj) {
      var validate;
      validate = !!obj.input.value.toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i);
      if (!validate) {
        obj.input.value = "";
        return obj.input.focus();
      }
    };

    /*
    	 * Calendar
     */
    return $W.form.dateField = function(obj) {
      var arrayDate, calendarId, drawCalendar, findPos, format, formatDate, formatField, getDayName, getDaysInMonth, getFirstDayofMonth, getMonthName, inputCalendar, removeCalendar, selected, selectedDay, selectedMonth, selectedYear, separator, setPos, setupLinks, valueField;
      separator = '-';
      calendarId = obj.applyTo;
      format = obj.format || 'y-m-d';
      selected = obj.listeners.select || '';
      inputCalendar = $W('#' + calendarId)[0];
      inputCalendar.dataset.icon = 'date';
      if (typeof obj.value !== 'undefined') {
        inputCalendar.value = obj.value;
      }
      arrayDate = [];
      separator = (format.replace(/[a-zA-Z\d\s]/g, ''))[0];
      formatField = format.replace(/[^a-zA-Z\d\s]/g, '');
      valueField = inputCalendar.value.replace(/[^\d]/g, '');
      if (inputCalendar.value === '') {
        selectedYear = new Date().getFullYear();
        selectedMonth = new Date().getMonth();
        selectedDay = new Date().getDate();
      } else {
        arrayDate[formatField[0]] = valueField[0];
        arrayDate[formatField[1]] = valueField[1];
        arrayDate[formatField[2]] = valueField[2];
        selectedYear = new Date(arrayDate.y).getFullYear();
        selectedMonth = new Date(arrayDate.m).getMonth();
        selectedDay = new Date(arrayDate.d).getDate();
      }
      inputCalendar.readOnly = true;
      inputCalendar.onclick = function() {
        if ($W('#date_' + calendarId)[0]) {
          removeCalendar($W('#date_' + calendarId)[0]);
          return;
        }
        drawCalendar(this);
        return setupLinks(this);
      };
      drawCalendar = function(inputObj) {
        var calendarDiv, day, daysInMonth, e, f, html, j, k, l, len, noPrintDays, numRows, printDate, ref, startDay, thisMonth, thisYear, today, weekDays;
        html = "<a id=\"closeCalendar\">Close Calendar</a>\n<table cellpadding=\"0\" cellspacing=\"0\" id=\"linksTable\">\n	<tr>\n\n\n	</tr>\n</table>\n<table id=\"calendar\" cellpadding=\"0\" cellspacing=\"0\"`class=\"win-calendar\">\n	<tr>\n		<td id=\"prevMonth\"> < </td> <th colspan=\"5\" class=\"calendarHeader\">" + getMonthName(selectedMonth) + ' ' + selectedYear + "</th><td id=\"nextMonth\">> </td>\n</tr>\n<tr class=\"weekDaysTitleRow\">";
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
        calendarDiv = document.createElement("div");
        calendarDiv.innerHTML = html;
        calendarDiv.setAttribute("id", "date_" + calendarId);
        $W('#' + calendarId)[0].parentNode.insertBefore(calendarDiv, $W('#' + calendarId)[0].nextSibling);
        setPos(inputCalendar, calendarDiv);
        $W('#closeCalendar')[0].onclick = function() {
          return removeCalendar(calendarDiv);
        };
        $W('#prevMonth')[0].onclick = function() {
          selectedMonth--;
          if (selectedMonth < 0) {
            selectedMonth = 11;
            selectedYear--;
          }
          drawCalendar(inputObj);
          return setupLinks(inputObj);
        };
        return $W('#nextMonth')[0].onclick = function() {
          selectedMonth++;
          if (selectedMonth > 11) {
            selectedMonth = 0;
            selectedYear++;
          }
          drawCalendar(inputObj);
          return setupLinks(inputObj);
        };
      };
      removeCalendar = function(obj) {
        return obj.parentNode.removeChild(obj);
      };
      setupLinks = function(inputObj) {
        var i, j, len, results, x, y;
        y = $W('#calendar')[0];
        x = y.getElementsByTagName('a');
        results = [];
        for (j = 0, len = x.length; j < len; j++) {
          i = x[j];
          results.push(i.onclick = function() {
            selectedDay = this.innerHTML;
            inputObj.value = formatDate(selectedDay, selectedMonth, selectedYear);
            inputCalendar.selected = selected;
            inputCalendar.selected();
            return removeCalendar($W('#date_' + calendarId)[0]);
          });
        }
        return results;
      };
      formatDate = function(Day, Month, Year) {
        var array, dateString;
        Month++;
        if (Month < 10) {
          Month = '0' + Month;
        }
        if (Day < 10) {
          Day = '0' + Day;
        }
        array = [];
        array['y'] = Year;
        array['m'] = Month;
        array['d'] = Day;
        return dateString = array[formatField[0]] + separator + array[formatField[1]] + separator + array[formatField[2]];
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
  })(Win);

}).call(this);
